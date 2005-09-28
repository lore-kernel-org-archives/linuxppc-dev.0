Return-Path: <KokHow.Teh@marconi.com>
Received: from smtpoutuk01.marconi.com (smtpoutuk01.marconi.com
	[128.87.251.112]) by ozlabs.org (Postfix) with ESMTP id 26100683FB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 22:26:31 +1000 (EST)
Received: from cvdgwy02.uk.marconicomms.com (cvis27.uk.marconicomms.com
	[128.87.251.110])
	by smtpoutuk01.marconi.com (8.12.11/8.12.11) with ESMTP id
	j8SCFucH008713
	for <linuxppc-embedded@ozlabs.org>; Wed, 28 Sep 2005 13:16:24 +0100
	(envelope-from KokHow.Teh@marconi.com)
To: linuxppc-embedded@ozlabs.org
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Date: Wed, 28 Sep 2005 18:01:06 +0800
Message-ID: <OFB310EF66.7D840B38-ON4825708A.0036EC3B@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: booting and mounting PCIIDE: kernel access of bad area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi;
      I have rebuilt arabella linux kernel with PCI IDE support. However,
the kernel bootup crashes with "kernel access of bad area" message. I think
it has something to do with the IDE base addess setup. I have tried to
change the ide0=base,ctl but to no avail. Hope you are able to advise me on
that. Thanks.

Regards,
TEH
u-boot> diskboot $loadaddr 0:1

Loading from IDE device 0, partition 1: Name: hda1
  Type: U-Boot
   Image Name:   Linux Kernel Image
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    893382 Bytes = 872.4 kB
   Load Address: 00000000
   Entry Point:  00000000
u-boot> bootm
## Booting image at 00100000 ...
   Image Name:   Linux Kernel Image
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    893382 Bytes = 872.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
MPC82xxADS/PQ2FADS board support by Arabella
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.26 (root@ShrekII.marconi.com) (gcc version 3.3.2) #6 Wed
Sep 28 11:58:24 MYT 2005
ADS setup arch
MPC82xx PCI bridge initialization
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 rw ide0=0x1f0,0x3f6
ide_setup: ide0=0x1f0,0x3f6

ADS init IRQ. NR_IRQS=256
PIC: fully preemptible IRQ mode
ADS time init
ADS calibrate decrementer. FREQ=100000000, tb_ticks_per_jiffy=250000
Calibrating delay loop... 266.24 BogoMIPS
Memory: 30252k available (1384k kernel code, 472k data, 232k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: moved device 00:16.0 resource 6 (7201) to 90000000
PCI: moved device 00:16.0 resource 4 (101) to 0
PCI: moved device 00:16.0 resource 0 (101) to 10
PCI: moved device 00:16.0 resource 2 (101) to 10
PCI: moved device 00:16.0 resource 1 (101) to 20
PCI: moved device 00:16.0 resource 3 (101) to 20
ADS init
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.07
devsoc: devsoc_init:
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oops: kernel access of bad area, sig: 11
NIP: C00BC0B0 XER: 20000000 LR: C00BC0A4 SP: C02F1F20 REGS: c02f1e70 TRAP:
0300    Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000CFB, DSISR: 22000000
TASK = c02f0000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000001 C02F1F20 C02F0000 00000001 00009032 00000001 00000832
00000000
GPR08: C01E0000 C01B0000 C01E0000 00000000 C01E0000 FFFFFFFF 01FC5000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 003FF000 00000000 00000001
01B78978
GPR24: 00000000 00000000 40000000 00000000 007FFF00 C01E0000 C01B067C
C01E0000
Call backtrace:
C0197464 C01A7658 C01A88B8 C01A8940 C01A898C C019E684 C0003970
C000820C
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..
