Message-ID: <384E56B1.2FA934D5@ascom.ch>
Date: Wed, 08 Dec 1999 14:01:37 +0100
From: Ruedi Hofer <ruedi.hofer@ascom.ch>
MIME-Version: 1.0
To: kd@flaga.is
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: fadsrom.tgz 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Thanx for the reply!

Further troubles were while compiling:

powerpc-linux-gcc -D__KERNEL__ -I -O2 -mcpu=860 -I../linux/include
-I../linux/arch/ppc/8xx_io -D__powerpc__ -DMHZ_50 -DFADS_860
-D__KERNEL__ -DDATA_MEM_ADDR=0x00010000 -DCONFIG_8xx -fsigned-char
-msoft-float  -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring   -c super.c -o super.o
super.c: In function `read_sb':
super.c:136: structure has no member named `s_rename_lock'
super.c:137: structure has no member named `s_rename_wait'
make: *** [super.o] Error 1


I commented lines 136, 137 out. Compiling now works fine, but linking
????

powerpc-linux-ld -T ppcrom.lds -Ttext 0xfe000000 -Tdata 0x00010000
-Bstatic start.o main.o serial.o traps.o vsprintf.o ctype.o string.o
memstuff.o cflash.o partition.o super.o inode.o d
ir.o ppcstring.o extable.o -o fadsrom
super.o: In function `read_sb':
super.o(.text+0xb4): undefined reference to `__fswab16'
super.o(.text+0xd4): undefined reference to `__fswab16'
super.o(.text+0x124): undefined reference to `__fswab32'
super.o(.text+0x13c): undefined reference to `__fswab32'
super.o(.text+0x170): undefined reference to `__fswab32'
super.o(.text+0x1d4): undefined reference to `__fswab32'
super.o(.text+0x210): undefined reference to `__fswab16'
super.o(.text+0x228): undefined reference to `__fswab32'
super.o(.text+0x26c): undefined reference to `__fswab32'
super.o(.text+0x284): undefined reference to `__fswab32'
super.o(.text+0x29c): undefined reference to `__fswab32'
super.o(.text+0x2b4): undefined reference to `__fswab32'
super.o(.text+0x310): more undefined references to `__fswab32' follow
super.o: In function `read_sb':
super.o(.text+0x3ac): undefined reference to `__fswab16'
super.o(.text+0x3d0): undefined reference to `__fswab16'
super.o(.text+0x3f4): undefined reference to `__fswab16'
super.o(.text+0x41c): undefined reference to `ffz'
super.o(.text+0x43c): undefined reference to `ffz'
super.o(.text+0x570): undefined reference to `__fswab32'
super.o(.text+0x580): undefined reference to `__fswab32'
make: *** [fadsrom] Error 1


Do you have any idea? Am I using the wrong kernel code? (currently
2.2.13)

Thanx in advance.

--
Best regards

Ruedi Hofer


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
