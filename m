Message-ID: <003c01c1d72c$8c48d200$0202a8c0@ebrady.net>
From: "Ed Brady" <ed@ebrady.net>
To: "LinuxPPC - Embedded List" <linuxppc-embedded@lists.linuxppc.org>
Subject: undefined reference to `__eabi'
Date: Fri, 29 Mar 2002 09:18:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am getting the following error when trying to perform the final link on a
2.4.18 kernel (the last part of "make zImage").  I am trying to
cross-compile the kernel for an MBX board.

powerpc-eabi-ld -T ../ld.script -Ttext 0x00180000 -Bstatic -o zvmlinux
head.o ../common/relocate.o  misc-embedded.o ../common/misc-common.o
../common/string.o ../common/util.o embed_config.o iic.o m8xx_tty.o image.o
../lib/zlib.a
image.o: In function `main':
image.o(.text+0xc): undefined reference to `__eabi'
make[2]: *** [zvmlinux] Error 1
make[2]: Leaving directory `/usr/src/ppc/linux/arch/ppc/boot/simple'
make[1]: *** [zImage] Error 2
make[1]: Leaving directory `/usr/src/ppc/linux/arch/ppc/boot'
make: *** [zImage] Error 2

I have tried the following steps to make sure that my kernel build
environment is correct.

$ make mbx_config
$ make old_config
$ make dep
$ make clean
$ make zImage


I have also had to add -D__linux__ to CFLAGS and CPPFLAGS the top level's
makefile to get the compile to work.
I have read the information that indicates that gcc inserts __eabi into main
to help setup the stack frame.

Where is __eabi symbol defined at?  I have found one in libgcc.a, but when I
use that then start getting undefined references to __SDATA_START__,
__SDATA_END__, __SDATA2_START__, and SDATA2_END__

I am using the following versions for the cross-compiler.

binutils-2.12
gcc-2.95.3
newlib-1.90

I cross-compiled the compiler for a target of powerpc-unknown-eabi

$ make pImage - Appears to work succesfully if I have the path set correctly
to mkImage AND if I add pImage as one of the BOOT_TARGETS to
arch/ppc/Makefile

Any help is greatly appreciated....

Ed Brady


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
