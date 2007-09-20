Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 605EEDDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 23:03:27 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IYLgi-0006mG-HE
	for linuxppc-embedded@ozlabs.org; Thu, 20 Sep 2007 06:03:24 -0700
Message-ID: <12796771.post@talk.nabble.com>
Date: Thu, 20 Sep 2007 06:03:24 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel 2.6 and INITRAMFS in one file booting problem on ml403
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear All,

I am dealing with kernel 2.6.23 (by Grant) on virtex-4 (ml403 like
evaluation board with ppc405 built-in processor). The kernel boots fine by
means of u-boot 1.2.0 when using nfs mounted root files system. 

My Board has 32MB of RAM memory (0x00000000 - 0x1ffffff) 

Right now I wanted to combine the linux kernel and the root file system in
one file in order to store it in the Flash memory.

I was able to build sucessfuly the kernel image which conatins the rootfile
system. Unfortunately during booting the rootfile system is not recognized.

My linux image with built-in the root fs has 6.7 MB. The uncompressed
rootfile system has 17 MB.

Steps which I have done are as following:

On my embedded system  I use u-boot 1.2.0
1. I load via tftp the the uImageWithRamFs

tftp 0x1500000 uImageWithRamFs

2. Next I execute the image 

bootm 0x1500000

The output is as following:

## Booting image at 01500000 ...
   Image Name:   Linux-2.6.23-rc2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    6983377 Bytes =  6.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
[    0.000000] Linux version 2.6.23-rc2 (root@pc5215) (gcc version 4.0.2)
#13 Thu Sep 20 13:49:26 CEST 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     8192
[    0.000000]   Normal       8192 ->     8192
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->     8192
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 8128
[    0.000000] Kernel command line: console=ttyUL0 root=/dev/ram rw
ip=129.118.144.82:129.118.144.113:129.118.144.1:255.255.255.0:virtex4-mirek:eth0:off
panic=1
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 128 (order: 7, 512 bytes)
[    0.000289] Console: colour dummy device 80x25
[    0.000615] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.001181] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.009923] Memory: 24304k available (1656k kernel code, 544k data, 5968k
init, 0k highmem)
[    0.097097] Mount-cache hash table entries: 512
[    0.103761] NET: Registered protocol family 16
[    0.144382] NET: Registered protocol family 2
[    0.180548] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.181582] TCP established hash table entries: 1024 (order: 1, 8192
bytes)
[    0.181903] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.182122] TCP: Hash tables configured (established 1024 bind 1024)
[    0.182200] TCP reno registered
[    7.835360] io scheduler noop registered
[    7.835446] io scheduler anticipatory registered (default)
[    7.835524] io scheduler deadline registered
[    7.835801] io scheduler cfq registered
[    8.529280] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 2) is a uartlite
[    8.530949] console [ttyUL0] enabled
[   10.549186] RAMDISK driver initialized: 2 RAM disks of 16384K size 1024
blocksize
[   10.648123] loop: module loaded
[   10.688195] tun: Universal TUN/TAP device driver, 1.6
[   10.749201] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   10.825474] XTemac: using FIFO direct interrupt driven mode.
[   10.893905] eth%d: XTemac: PHY detected at address 3.
[   10.956872] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC3020000,
irq=0
[   11.040788] eth0: XTemac id 1.0f, block id 5, type 8
[   11.101628] mice: PS/2 mouse device common for all mice
[   11.164837] TCP cubic registered
[   11.203869] NET: Registered protocol family 1
[   11.256350] NET: Registered protocol family 17
[   11.813548] eth0: XTemac: Options: 0xb8f2
[   15.835154] eth0: XTemac: We renegotiated the speed to: 100
[   15.901906] eth0: XTemac: speed set to 100Mb/s
[   16.985905] IP-Config: Complete:
[   17.022598]       device=eth0, addr=129.118.144.82, mask=255.255.255.0,
gw=129.118.144.1,
[   17.119958]      host=virtex4-mirek, domain=, nis-domain=(none),
[   17.192276]      bootserver=129.118.144.113, rootserver=129.118.144.113,
rootpath=
[   17.292444] List of all partitions:
[   17.334388] No filesystem could mount root, tried:  ext2 msdos vfat
[   17.409805] Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
[   17.509374] Rebooting in 1 seconds..<NULL>
[   18.563180] Oops: Exception in kernel mode, sig: 4 [#1]
[   18.625695] NIP: c07e0000 LR: c085fe70 CTR: c085fee0
[   18.685072] REGS: c085fdb0 TRAP: 2000000   Not tainted  (2.6.23-rc2)
[   18.761190] MSR: 00000f13 <DR>  CR: c01ca858  XER: c00e8c80
[   18.827869] TASK = c085cba0[1] 'swapper' THREAD: c085e000
[   18.890350] GPR00: c085fdd0 c000437c 00000000 00008000 c01c37e0 000003e5
c01c3858 00008000


My .config file which is used to build the linux kernel has following
settings which refer to the initramfs:

CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_INITRAMFS_SOURCE="smallRootFs.cpio"
CONFIG_INITRAMFS_ROOT_UID=0
CONFIG_INITRAMFS_ROOT_GID=0
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=2
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_NVRAM is not set
CONFIG_RAMFS=y

I appreciate any hint on that why the root fs is not recognized

Best Regards

Mirek

-- 
View this message in context: http://www.nabble.com/Kernel-2.6-and-INITRAMFS-in-one-file-booting-problem-on-ml403-tf4487411.html#a12796771
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
