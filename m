Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <00e301c243ac$14182dc0$db00000a@dejanj>
From: "Dejan Jovanovic" <dejanj@erlangtech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux on SBC8260
Date: Wed, 14 Aug 2002 11:03:06 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to run Linux on a EST's SBC8260 board.

First thing I have tried is using ppcboot to load the Linux kernel image.
- ppcboot version is 1.1.6
- Linux version is 2.4.4 - the one that comes with ELDK from Wolfgang. (as a
side question - is it enough if I do the 'make est8260_config' or I need to do
menuconfig as well after that?)

First I have used the Linux kernel image, one in arch/ppc/coffboot and converted
using mkimage tool (with parameters -a 0x0000_0000 and -e 0x0000_0000)
ppcboot is running on my board and I have loaded linux image (the converted
one).
After that I have executed ppcboot 'bootm' command, and got the message
'Loading Kernel Image OK' -- (?? this is strange though - should it not say here
Uncompressing Kernel Image ?)
After that nothing happens on my serial console.

So I tried to use the BDI2000 to debug this.
I skipped the ppcboot, and loaded the Linux Kernel Image (now the one from
arch/ppc/mbxboot) into the RAM directly.
After setting the PC and doing a 'go' I got the message that the 'Target has
entered debug state' with 'Debug Entry cause (reserved 0)' I am not sure how
much this helps, but by doing a 'objdump' on the image file and comparing the
last PC after the 'go' command, it seems to be stuck somewhere is 'serial_init'
section.

BTW, I also tried compiling the Linux Kernel with '-g -ggdb' option. Should not
the image size in case I compile with and without this options differ, because
when I compare images in these two cases they are the same. I wanted to use this
for gdb debugging.

What am I doing wrong in this process(es)?

Regards and thanks
Dejan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
