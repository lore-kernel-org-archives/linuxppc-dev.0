Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC0618E@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: CROSS COMPILE: so close just nee a little help.... 
Date: Fri, 7 Feb 2003 12:55:04 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am still chugging away on how to get this a cross compiler built ... if I
get this build script working (and cleaned up) hopefully I can post it
somewhere for other embedded ppc Linux users ... your advice would be
greatly appreciated...

I am having some trouble building libstdc++2.90.8 into gcc only ... I can
build gcc with glibc 2.2.5.

In general what I am doing is

1.) build binutils 2.13
2.) build gcc with newlib
3.) build glibc
4.) build gcc with glibc
5.) unzip/tar g++ to gcc-2.95.3 dir
6.) overwite libstdc++ with files from libstdc++-2.90.8 (with patch from
libstdc++ site for 2.95.3)
7.) configure gcc build in a new directory with language c++ enabled ... and
compile ...
8.) is this correct?


MY BUILD DIES WITH ... No rule to "make all" in libstdc++ ... weird part is
libio builds fine ...

My build script is below ...

Jim

-=-=-=-=-=-=-=-=-=-=-=-=-=-

#!/bin/bash

#
# Get, build and install the latest cross-development tools and libraries
#

#
# Specify the architectures for which the tools are to be built
# To build for multiple targets: ARCHS="m68k ppc i386"
#
ARCHS="powerpc-linux"

#
# Where to install
#
PREFIX=$HOME/ppcgcc3/

#
# My kernel includes
#
KERNEL=$HOME/ppclinux/include/

#
# Where to get the GNU tools
#
RTEMS_BINUTILS_URL=ftp://ftp.gnu.org/gnu/binutils/
RTEMS_GCC_URL=ftp://ftp.gnu.org/gnu/gcc/gcc-2.95.3/
RTEMS_NEWLIB_URL=ftp://sources.redhat.com/pub/newlib/
GLIBC_URL=ftp://ftp.gnu.org/gnu/glibc
LIBSTDC_URL=ftp://ftp.gnu.org/gnu/libstdc++

#
# Specify the versions
#
GCC_VER=2.95.3
GCC=gcc-core-$GCC_VER
BINUTILS=binutils-2.13.2.1
NEWLIB=newlib-1.10.0
GLIBC_VER=2.2.5

#
# Get the source
#
getSource() {
    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_BINUTILS_URL/$BINUTILS.tar.gz
    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_BINUTILS_URL/$BINUTILS*.diff

    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_GCC_URL/$GCC.tar.gz
    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_GCC_URL/$GCC*.diff

    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_NEWLIB_URL/$NEWLIB.tar.gz
    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_NEWLIB_URL/$NEWLIB*.diff
}

getSourceGLIBC() {
    wget --passive-ftp --no-directories --retr-symlinks
$GLIBC_URL/glibc-$GLIBC_VER.tar.gz
    wget --passive-ftp --no-directories --retr-symlinks
$GLIBC_URL/glibc-$GLIBC_VER*.diff
    wget --passive-ftp --no-directories --retr-symlinks
$GLIBC_URL/glibc-linuxthreads-$GLIBC_VER.tar.gz



}

#
# Unpack the source
#
unpackSource() {
    rm -rf $BINUTILS
    tar xvfz $BINUTILS.tar.gz
    for d in $BINUTILS*.diff
    do
        if [ -r "$d" ]
        then
            cat "$d" | (cd $BINUTILS ; patch -p1)
        fi
    done


    rm -rf gcc-$GCC_VER
    tar xvfz $GCC.tar.gz
    for d in $GCC*.diff
    do
        if [ -r "$d" ]
        then
            cat "$d" | (cd gcc-$GCC_VER ; patch -p1)
        fi
    done


    rm -rf $NEWLIB
    tar xvfz $NEWLIB.tar.gz
    for d in $NEWLIB*.diff
    do
        if [ -r "$d" ]
        then
            cat "$d" | (cd $NEWLIB ; patch -p1)
        fi
    done
    cd gcc-$GCC_VER
    ln -s ../$NEWLIB/newlib newlib
    ln -s ../$NEWLIB/libgloss libgloss
    cd ..
}

unpackGLIBC() {

   rm -rf glibc-$GLIBC_VER
   tar xvfz glibc-$GLIBC_VER.tar.gz
   for d in glibc-$GLIBC_VER*.diff
   do
      if [ -r "$d" ]
      then
         cat "$d" | (cd glibc-$GLIBC_VER ; patch -p1)
        fi
    done
    cd glibc-$GLIBC_VER
    tar xvfz ../glibc-linuxthreads-$GLIBC_VER.tar.gz
    cd ..

}

#
# Build
#
build() {
    PATH=$PREFIX/bin:$PATH
    export PATH
    for arch in $ARCHS
    do
        rm -rf BINUTILS
        mkdir BINUTILS
        cd BINUTILS
        ../$BINUTILS/configure --target=$arch --prefix=$PREFIX
	make
        make install
        cd ..

        rm -rf GCC
        mkdir  GCC
        cd GCC
        ../gcc-$GCC_VER/configure --target=$arch --prefix=$PREFIX \
            --with-gnu-as --with-gnu-ld --verbose \
            --with-system-zlib --disable-nls \
            --disable-threads \
	    --disable-shared  \
            --with-newlib \
	    --with-headers=$KERNEL \
            --enable-languages=c

	make
        make install
        cd ..
    done
}

build_glibc() {
    PATH=$PREFIX/bin:$PATH
    export PATH
    for arch in $ARCHS
    do
	rm -rf GLIBC
	mkdir GLIBC
	cd GLIBC
	rm -rf $PREFIX/$arch/include $PREFIX/$arch/sys-include
$PREFIX/$arch/lib
        CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
../glibc-$GLIBC_VER/configure \
	 	--host=$arch \
                --enable-add-ons=linuxthreads \
                --with-headers=$KERNEL  \
                 --prefix=$PREFIX/$arch
	make
	#make install_root=$arch install
	make install
	cd ..
   done
}

build_gcc_glibc() {
    PATH=$PREFIX/bin:$PATH
    export PATH
    for arch in $ARCHS
    do


	rm -rf GCC_GLIBC
	mkdir GCC_GLIBC
	cd GCC_GLIBC
        ../gcc-$GCC_VER/configure --target=$arch --prefix=$PREFIX \
                 --with-gnu-as --with-gnu-ld \
                 --enable-shared \
                 --enable-threads=posix \
                 --enable-languages=c \
                 --with-headers=$KERNEL
#\
#                 --with-headers=$PREFIX/include/
	make
        make install
	cd ..


    done
}

getCPPSource() {
    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_GCC_URL/gcc-g++-$GCC_VER.tar.gz
    wget --passive-ftp --no-directories --retr-symlinks
$RTEMS_GCC_URL/gcc-g++-$GCC_VER*.diff
    wget --passive-ftp --no-directories --retr-symlinks
$LIBSTDC_URL/libstdc++-2.90.8.tar.gz
}

unpackCPPSource(){
    pwd
    echo UNPACK G++
    tar xfz gcc-g++-$GCC_VER.tar.gz
}

build_g++_glibc() {
    PATH=$PREFIX/bin:$PATH
    export PATH
    for arch in $ARCHS
    do


	rm -rf G++_GLIBC
	mkdir G++_GLIBC
	cd G++_GLIBC
        #cd gcc-$GCC_VER
        ../gcc-$GCC_VER/configure --target=$arch --prefix=$PREFIX \
                 --with-gnu-as --with-gnu-ld \
                 --enable-shared \
                 --enable-threads=posix \
                 --enable-languages=c,c++ \
                 --with-headers=$KERNEL --with-sysroot=$PREFIX/$arch

	          #mkdir libstdc++
	          #cd libstdc++
                  #../gcc-2.95.3/libstdc++/configure --target=powerpc-linux
\
                  #                        --prefix=/home/jgdon/ppcgcc3 \
                  #                        --enable-shared \
                  #                        --enable-threads=posix \
                  #                        --enable-languages=c,c++ \
                  #
--with-headers=/home/jgdon/ppclinux/include/
cd l	          #cd ..




	make
        #make install
	cd ..


    done
}

unpackStd() {
    pwd
    echo UNPASK STDC
    tar xfz libstdc++-2.90.8.tar.gz
    patch -p0 -b -z.ORIG < libstdc++-2.90.8-compat-gcc-2.95.3.diff
    cd gcc-$GCC_VER
    #pwd
    #ls
    #echo here
    mv libstdc++ libstdc++ORIG
    mv libio     libioORIG
    ls -l libstdc++/src/Makefile.in
    sleep 10
    touch libstdc++/src/Makefile.in
    #echo here2
    cp -rf ../libstdc++-2.90.8 ./

    #echo here3
    #cp -rf ./libstdc++-2.90.8/* ./libstdc++/
    #rm -rf ./libstdc++
    mv ./libstdc++-2.90.8 ./libstdc++
    cd ..
}


#
# Do everything
#
# Comment out any activities you wish to omit
#
#set -ex

export PATH=$PREFIX/bin/:$PATH

echo ====================================
echo BUILD BOOT STRAPPED COMPILER
echo ====================================
sleep 10
#getSource
#unpackSource
#unpackCPPSource
#build


echo ====================================
echo BUILD GLIBC
echo ====================================
#getSourceGLIBC
#unpackGLIBC
#cdbuild_glibc

echo ====================================
echo BUILD GCC WITH GLIBC
echo ====================================
#build_gcc_glibc

echo =====================================
echo BUILD G++/GCC WITH GLIBC AND LIBSTC++
echo =====================================
#getCPPSource
unpackCPPSource
unpackStd
build_g++_glibc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
