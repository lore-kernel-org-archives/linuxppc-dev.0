Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <E8F83D6D2A6AD3118E0300902786A20502371417@NTEX>
From: "David Marqvar (DAM)" <DAM@tt.dk>
To: "Embedded Linux PPC List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Laurits Lassen Petersen (LLP)" <LLP@tt.dk>
Subject: Kernel 2.4.4
Date: Mon, 11 Feb 2002 11:56:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've downloaded the Linux kernel 2.4.4-2002-01-19 from ftp.denx.de.
I want to compile it for a custom MPC823-based board.

I'm a newbie with Linux. Maybe someone have a comment at my problems and
fixes.... :)

I'm using:
gcc-3.0.3, cross-compiling for "powerpc-elf".
binutils-2.11.2
newlib-1.10.0

make menuconfig
make dep
make clean
make zImage

During the compilation (last step) I've encountered the following problems:

1) error compiling coda.h (missing keywords)
Fix: adding the switch -D__linux__ to the makefile.

2) error compiling ... (don't remember)
Fix: changed sched.c:540 declaring time struct, to ..volatile..

3) error compiling embedded_config.c:
Fix: changed include sys/types to linux/types.h

4) I had to stop enabling "Magic SysRq Key" in Kernel hacking in menuconfig.
Error: m8xx_setup.c:851: structure has no member named  'kbd_sysrq_xlate'.

Please give me any comments about my fixes? Anyone had the same problems?

Where do I find the zImage file - it is compressed, right? I've located the
vmlinux, but as far as I know this is the uncompressed kernel-image.


I want to compile SASH for powerpc too. Does anyone know a place with
powerpc-ready source for this? I've tried to compile it from the latest
source, but I'm missing some kind of way to make i compile for powerpc - the
Makefile keeps compiling for i386 (working fine by the way).

My next step is to find a simple bootloader..

Best regards,
David Marqvar

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
