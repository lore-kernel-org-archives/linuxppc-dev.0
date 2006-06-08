Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx1-4.spamtrap.magma.ca (mx1-4.spamtrap.magma.ca
	[209.217.78.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1588567C05
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 06:42:00 +1000 (EST)
Received: from mail3.magma.ca (mail3.internal.magma.ca [10.0.10.13])
	by mx1-4.spamtrap.magma.ca (8.13.1/8.13.1) with ESMTP id k58KfuOX026772
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 16:41:56 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail3.magma.ca (Magma's Mail Server) with ESMTP id k58Kfs1Q012441
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 16:41:55 -0400
Message-ID: <44888B92.40409@ics-ltd.com>
Date: Thu, 08 Jun 2006 16:41:54 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: help with inittab
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am using the linux kernel 2.6.15 and initrd ramdisk image from ELDK 
4.0. Currently, I seem to be able to boot without errors, but after the 
root filesystem is mounted, things just stop.

I'm guessing that my problems are related to the setup of the RFS, and 
more specifically, my inittab file. Here is the output I get at boot time:
Linux version 2.6.15 (cdumoulin@localhost.localdomain) (gcc version 
4.0.0 (DENX ELDK 4.0 4.0.0)) #167 PREEMPT Thu Jun 8 6Built 1 zonelists
Kernel command line: console=ttyS0,57600 ip=off
PID hash table entries: 512 (order: 9, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 62120k available (968k kernel code, 272k data, 76k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 1404k freed
Linux NoNET1.0 for Linux 2.6
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 
sec (nowayout= 0)
ipmi message handler version 38.0
ipmi device interface
IPMI Watchdog: driver initialized
i8042.c: No controller found.
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 24) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
mice: PS/2 mouse device common for all mice
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).

And here is my initttab file:
::sysinit:/etc/rc.sh
::askfirst:/bin/sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init

Any ideas would be appreciated.

Cheers,
Chris Dumoulin
-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
