Return-Path: <jack_liu@usish.com>
Received: from ms.usish.com (ms.usish.com [61.152.132.204])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C6252BD9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 10:33:32 +1000 (EST)
Received: from usish000029-1 (usish000029-1 [192.168.56.93] (may be forged))
	by ms.usish.com (8.12.8/8.12.8) with ESMTP id i9C0XREW012556
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Oct 2004 08:33:28 +0800
Message-Id: <200410120033.i9C0XREW012556@ms.usish.com>
From: "Jack Liu" <jack_liu@usish.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Date: Tue, 12 Oct 2004 8:33:24 +0800
Subject: ext2 problem?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,all
	Currently I am porting linux 2.4.22 to a 8248 board. It has a PCI IDE controller. Now the board is bringing up through ramdisk. I can fdisk the disk and see the partition table. I can mkfs.minix on it, yet I can not use ext2 file system. My first guess is because of ext2 file system so I replace all ext2 related code from a working linux code. Still not working.
Can it because of PCI memory problem? Does I have to ioremap 0x80000000 PCI memory range?

	# fdisk -l /dev/hda
	Disk /dev/hda: 120.0 GB, 120025735168 bytes
	255 heads, 63 sectors/track, 14592 cylinders
	Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1               1        2000    16064968+  83  Linux
/dev/hda2            2001        4000    16065000   83  Linux
	
	However when I mkfs.ext2 /dev/hda1, it crashes. 

 	 mke2fs 1.26 (3-Feb-2002)
	 Filesystem label=
	 OS type: Linux
	 Block size=4096 (log=2)
	 Fragment size=4096 (log=2)
	 2011296 inodes, 4016250 blocks
	 200812 blocks (5.00) reserved for the super user
	 First data block=0
	 123 block groups
	 32768 blocks per group, 32768 fragments per group
	 16352 inodes per group
	Superblock backups stored on blocks: 
	 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208
     Writing inode tables:  Crashed...
	
	I can use mkfs.minix on the disk.
     # busybox mkfs.minix /dev/hda2
	21856 inodes
	65535 blocks
	Firstdatazone=696 (696)
	Zonesize=1024
	Maxsize=268966912
    # mount -t minix /dev/hda3 temp
	System is OK and can read/write on it.

	What could be the problem?

	# cat ioports
00000000-0000ffff : PCI host bridge
  0000ffd0-0000ffdf : PCI device 1106:3164 (VIA Technologies, Inc.)
    0000ffd0-0000ffd7 : ide0
    0000ffd8-0000ffdf : ide1
  0000ffe4-0000ffe7 : PCI device 1106:3164 (VIA Technologies, Inc.)
  0000ffe8-0000ffef : PCI device 1106:3164 (VIA Technologies, Inc.)
  0000fff4-0000fff7 : PCI device 1106:3164 (VIA Technologies, Inc.)
    0000fff6-0000fff6 : ide0
  0000fff8-0000ffff : PCI device 1106:3164 (VIA Technologies, Inc.)
    0000fff8-0000ffff : ide0
# cat pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1057:18c1 (Motorola) (rev 16).
      Master Capable.  Latency=248.  
      Non-prefetchable 32 bit memory at 0x0 [0x1ffff].
      Prefetchable 32 bit memory at 0x0 [0x1fffffff].
  Bus  0, device  23, function  0:
    RAID bus controller: PCI device 1106:3164 (VIA Technologies, Inc.) (rev 6).
      IRQ 23.
      Master Capable.  Latency=128.  
      I/O at 0xfff8 [0xffff].
      I/O at 0xfff4 [0xfff7].
      I/O at 0xffe8 [0xffef].
      I/O at 0xffe4 [0xffe7].
      I/O at 0xffd0 [0xffdf].

	
Best regard
Jack
