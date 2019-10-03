FROM tensorflow/tensorflow:1.14.0
RUN apt-get update
RUN apt-get install -y git python-setuptools curl lsb-release

#Clone ctrl (GPT-2 Salesforce)
WORKDIR /home
RUN git clone https://github.com/salesforce/ctrl.git

#Patch keras estimator
WORKDIR /home/ctrl
RUN patch -b /usr/local/lib/python2.7/dist-packages/tensorflow_estimator/python/estimator/keras.py estimator.patch

# Install fastBPE
WORKDIR /home
RUN git clone https://github.com/glample/fastBPE.git
WORKDIR /home/fastBPE
RUN pip install cython
RUN g++ -std=c++11 -pthread -O3 fastBPE/main.cc -IfastBPE -o fast
RUN python setup.py install