Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F70@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Liu Fred-a18596'" <fred.liu@motorola.com>,
	BREUVART Jean-Charles <jean-charles.breuvart@airbus.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: pb compiling cross gcc, binutils, glibc and so on ...
Date: Fri, 20 Dec 2002 09:12:31 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was given this script ... it works ;-)

Just match the directory structures ;-)

Maybe it will help ... make sure you have bison,flex,tetex installed ...

Good luck,
Jim

#!/bin/bash

#-------------------------------------------------------------
# This bash script creates a linux x866 gcc cross compiler
# for powerpc. This file has been tested with the following
# modules:
#    1.) binutils-2.13.90.0.2.tar.gz
#    2.) gcc-3.2.tar.gz
#    3.) newlib-synSept12-2002.tar.gz
#-------------------------------------------------------------

# Defining target
TARGET=powerpc-linux


# Defining prefix - final toolchain location
PREFIX=$HOME/ppcgcc

# PATH must updated
PATH=$PREFIX/bin:$PATH
export PATH

# My local includes
INCLUDE=/usr/include/

# Configuring packages versions
GCC_VER=2.95.3
BINUTILS_VER=2.13.90.0.2
NEWLIB_VER=1.10.0

echo ===================================================
echo BUILDING BINUTILS FOR $TARGET
echo ===================================================
# binutils
rm -rf binutils-$BINUTILS_VER binutils
tar zxvf binutils-$BINUTILS_VER.tar.gz
mkdir binutils
cd binutils
../binutils-$BINUTILS_VER/configure --target=$TARGET --prefix=$PREFIX
make all
make install
cd ..



echo ===================================================
echo BUILDING GCC FOR $TARGET
echo ===================================================

echo extract GCC source from tar ball ...
rm -rf gcc-$GCC_VER gcc
tar zxvf gcc-core-$GCC_VER.tar.gz
tar zxvf gcc-g++-$GCC_VER.tar.gz


echo extract newlib source from tar ball- needed for gcc ...
rm -rf  newlib-$NEWLIB_VER newlib
tar zxvf newlib-$NEWLIB_VER.tar.gz

echo set up symbolic links to newlib in gcc dir
cd  gcc-$GCC_VER
ln -s ../newlib-$NEWLIB_VER/newlib newlib
ln -s ../newlib-$NEWLIB_VER/libgloss libgloss
cd ..

echo build gcc ...
mkdir gcc
cd gcc
../gcc-$GCC_VER/configure --target=$TARGET --with-newlib --prefix=$PREFIX
--with-gnu-as --with-gnu-ld --with-headers=$INCLUDE
make all
make install
cd ..



echo ===================================================
echo BUILDING NEWLIB FOR $TARGET
echo ===================================================
# newlib
mkdir newlib
cd newlib
../newlib-$NEWLIB_VER/configure --target=$TARGET --prefix=$PREFIX --nfp
make all
make install
cd ..


-----Original Message-----
From: Liu Fred-a18596 [mailto:fred.liu@motorola.com]
Sent: Thursday, December 19, 2002 8:58 PM
To: BREUVART Jean-Charles; linuxppc-embedded@lists.linuxppc.org
Subject: RE: pb compiling cross gcc, binutils, glibc and so on ...


> 5. build gcc core 2.95.3 for powerpc cross compile, and install it in
> /opt/powerpc-linux/ :
>       - cd /usr/src/gcc-2.95.3/
>       - make clean
>       - make distclean
>       - CC=/usr/local/bin/gcc ./configure --target=powerpc-linux
> --enable-shared --enable-languages=c --with-newlib
> --prefix=/opt/powerpc-linux
>       - add /opt/powerpc-linux at the end of $PATH, otherwise
> make doesn't
> find powerpc-linux-as, powerpc-linux-ld and so on
>       - make
>
> Here is the trouble :
>
> choose-temp.c:29: stdio.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:30: sys/types.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:32: unistd.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:35: stdlib.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:38: sys/file.h: Aucun fichier ou r?pertoire de ce type
>
> there aren't any of those in /opt/powerpc-linux/ or its subdirs
>
It's true that there are no any of those files. They are in glibc which you
have not compiled yet.
Some useful tips at: http://www.mock.com/receiver/tools/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
