Message-ID: <20030401013109.20978.qmail@sina.com>
From: ysminnpu <ysminnpu@sina.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: powerpc-elf compiler build errors
MIME-Version: 1.0
Date: Tue, 01 Apr 2003 09:31:09 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I want to make a cross toolchain for powerpc-elf target,but encounter some errors. My host is cygwin on windows2000.

My directory hierarchy:
/src--binutils
|--gcc
|--newlib-1.9.0
|--build-binutils
|--build-gcc
|--build-newlib
|--install

My steps:
1. export TARGET=powerpc-elf
export PREFIX=/src/install
export PATH=$PREFIX/bin:$PATH
2.
cd build-binutils
$ ../binutils/binutils-2.11.2/configure --target=$TARGET --prefix=$PREFIX
$ make all install 2>&1 | tee make.log
$ cd ..
3.
cd build-gcc
../gcc/gcc-2.95.3/configure --target=$TARGET --prefix=$PREFIX \
--with-newlib --without-headers --with-gnu-as \
--with-gnu-ld --disable-shared --enable-languages=c
make all-gcc install-gcc 2>&1 | tee make.log
cd ..
4.
cd build-newlib
../newlib-1.9.0/configure --target=$TARGET --prefix=$PREFIX
make all install 2>&1 | tee make.log
cd ..
5.
cd build-gcc && rm -rf *
../gcc/gcc-2.95.3/configure --target=$TARGET --prefix=$PREFIX \
--with-gnu-as --with-gnu-ld --enable-languages=c,c++
make all install 2>&1 | tee make.log

The result:
................
/src/build-gcc/gcc/xgcc -B/src/build-gcc/gcc/ -B/src/install//powerpc-elf/bin/ -c -DHAVE_CONFIG_H -g -O2 -I. -I../../../gcc/gcc-2.95.2/libiberty/../include ../../../gcc/gcc-2.95.2/libiberty/vsprintf.c -o pic/vsprintf.o
/src/build-gcc/gcc/xgcc -B/src/build-gcc/gcc/ -B/src/install//powerpc-elf/bin/ -c -DHAVE_CONFIG_H -g -O2 -I. -I../../../gcc/gcc-2.95.2/libiberty/../include ../../../gcc/gcc-2.95.2/libiberty/vsprintf.c
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c: In function `vsprintf':
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c:47: structure has no member named `_flag'
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c:47: `_IOWRT' undeclared (first use in this function)
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c:47: (Each undeclared identifier is reported only once
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c:47: for each function it appears in.)
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c:47: `_IOSTRG' undeclared (first use in this function)
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c:48: structure has no member named `_ptr'
../../../gcc/gcc-2.95.2/libiberty/vsprintf.c:49: structure has no member named `_cnt'
make[1]: *** [vsprintf.o] Error 1
make[1]: Leaving directory `/src/build-gcc/powerpc-elf/libiberty'
make: *** [all-target-libiberty] Error 2

I have found some clues to attack the error information at your CrossGCC Faq, which says the following: " When building for powerpc-eabi, the complete gcc build step will fail due to a reported error building libiberty. To finish building gcc, do this after the failure:
$ make CFLAGS="-O2 -myellowknife" install 2>&1 | tee make2.log
The problem here is that the powerpc-eabi crosscompiler doesn't come with a "default" build target, the way other versions of gcc do. By selecting ©\myellowknife, we tell gcc to use the yellowknife target's linker scripts during building. This doesn't affect anything in the end, because the step that fails is merely testing that the compiler works¡ª without the ©\m, it won't. "

But when I try the above method, the make says cannot find the "-myelloknife" option. I think the reason maybe it is for powerpc-eabi only.

What's wrong on earth with my steps?
Any recommendation will be much appreciated!
thanks in advance!

______________________________________

===================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
