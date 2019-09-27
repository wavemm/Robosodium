#!/bin/sh

if [ -z "$JAVA_HOME" ]; then
    echo "ERROR You should set JAVA_HOME"
    echo "Exiting!"
    exit 1
fi


C_INCLUDE_PATH="${JAVA_HOME}/include:${JAVA_HOME}/include/linux:/System/Library/Frameworks/JavaVM.framework/Headers"
export C_INCLUDE_PATH

rm -f *.java
rm -f *.c
rm -f *.so

#swig -java sodium.i
swig -java -package org.abstractj.kalium -outdir ../src/main/java/org/abstractj/kalium sodium.i

if [ -n "$1" ] && [ $1 = "linux" ]; then

    jnilib=libkaliumjni.so
    destlib=`pwd`/../linux_lib
    #if uname -a | grep -q -i darwin; then
    #    jnilib=libkaliumjni.jnilib
    #    destlib=/usr/lib/java
    #    if [ ! -d $destlib ]; then
    #        sudo mkdir $destlib
    #    fi
    #fi
    echo $jnilib
    echo $destlib
    echo $destlib/$jnilib 

    #sudo cp /usr/local/lib/libsodium.* /usr/lib

#In order to compile for arm/armv7/x86/mips you should build your own standalone android-toolchain as in libsodium:android-build.sh
#https://github.com/jedisct1/libsodium/blob/master/dist-build/android-build.sh
#And then use gcc binary from there. 
#Example(arm):
#/installs/libsodium/android-toolchain-arm/arm-linux-androideabi/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-arm/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-arm/lib -lsodium -o $jnilib
#Example(arm7):
#/installs/libsodium/android-toolchain-armv7/arm-linux-androideabi/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-armv7/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-armv7/lib -lsodium -o $jnilib
#Example(mips):
#/installs/libsodium/android-toolchain-mips/mipsel-linux-android/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-mips/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-mips/lib -lsodium -o $jnilib
#Example(x86):
#/installs/libsodium/android-toolchain-x86/i686-linux-android/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-x86/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-x86/lib -lsodium -o $jnilib
    gcc -v -w -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux sodium_wrap.c -I`pwd`/../linux_lib/include -shared -fPIC -L`pwd`/../linux_lib -lsodium -o $jnilib
    rm -f $destlib/$jnilib  
    cp $jnilib $destlib

fi

#jnilib=libkaliumjni.so
#destlib=/usr/lib
#if uname -a | grep -q -i darwin; then
#  jnilib=libkaliumjni.jnilib
#  destlib=/usr/lib/java
#fi
#echo $jnilib
#echo $destlib

#sudo cp /usr/local/lib/libsodium.* /usr/lib

#In order to compile for arm/armv7/x86/mips you should build your own standalone android-toolchain as in libsodium:android-build.sh
#https://github.com/jedisct1/libsodium/blob/master/dist-build/android-build.sh
#And then use gcc binary from there. 
#Example(arm):
#/installs/libsodium/android-toolchain-arm/arm-linux-androideabi/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-arm/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-arm/lib -lsodium -o $jnilib
#Example(arm7):
#/installs/libsodium/android-toolchain-armv7/arm-linux-androideabi/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-armv7/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-armv7/lib -lsodium -o $jnilib
#Example(mips):
#/installs/libsodium/android-toolchain-mips/mipsel-linux-android/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-mips/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-mips/lib -lsodium -o $jnilib
#Example(x86):
#/installs/libsodium/android-toolchain-x86/i686-linux-android/bin/gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I/installs/libsodium/libsodium-android-x86/include sodium_wrap.c -shared -fPIC -L/installs/libsodium/libsodium-android-x86/lib -lsodium -o $jnilib
#gcc -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux sodium_wrap.c -shared -fPIC -L/usr/lib -lsodium -o $jnilib
#sudo rm -f /usr/lib/libkaliumjni.so 
#sudo cp libkaliumjni.so $destlib

