Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <885489B3B89FB6449F93E525DF78777F06451E@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: MMU on the power pc 860
Date: Fri, 20 Dec 2002 11:01:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

This might be a very dumb question, but I hope someone can give me some
insight and help.

I am porting the timeSys Linux to a custom Power PC 860 board.  Our board
currently runs
windRiver VxWorks.  I have modified the VxWorks bootrom to allow me to
download a motorola
hex record, and I have modified the timeSys bootcode
arch/ppc/boot/mbx/misc.c:decompress_kernel
to get the correct address of the vmlinux.gz in the hex record.  I got the
following information
on the serial port

Loading... S-Record:
        Module Name: ../images/zImage.srec
        Entry Location: 0x400000
Starting at 0x400000...

loaded at:     00400000 0040C30C
board data at: 004001C0 004001E4
relocated to:  0040C0E8 0040C10C
zimage at:     0040C30C 004BC440
avail ram:     004BD000 00800000

Linux/PPC load: console=ttyS0,9600
nfsroot=192.168.0.211:/exports/rpx860/2.4.7-t
imesys-3.1.254 ip=192.168.0.238
Uncompressing Linux... done.
Now booting the kernel

I was able to use the VisionICE BDM to single step, and see it does jump to
the address 0, and
begin execute the instruction in kernel/arch/ppc/kernel/head_8xx.S:_start

I think the MMU TLB setup I have is not exactly correct, since the vxWorks
BOOTROM does not
initialize any MMU registers.  Can someone tell me if I need to initialize
the M_TWB register for the
level one base register?  It looks like this register is never initialized.
Furthermore, what need
to be the value for this register?  My physical memory map consists of RAM
at location 0 to 0x1ffffff
and my IMMR is set to 0x2b00 0000

If M_TWB is mapped to some RAM location, will I be able to see the TLB
values at that location after i
issue the write to register MxRPN?

Your help is greatly appreciated.

Cecilia Muaddi

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
