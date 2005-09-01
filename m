Return-Path: <aweissma_ppc@yahoo.com>
Received: from web35208.mail.mud.yahoo.com (web35208.mail.mud.yahoo.com
	[66.163.179.87]) by ozlabs.org (Postfix) with SMTP id 60E99680F4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 15:53:32 +1000 (EST)
Message-ID: <20050901054650.11322.qmail@web35208.mail.mud.yahoo.com>
Date: Wed, 31 Aug 2005 22:46:50 -0700 (PDT)
From: "Adrian B. Weissman" <aweissma_ppc@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: A question regarding ramdisks
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello:
     I am having some configuration / problems with
using a ramdisk and the 2.6.12 Kernel for a ppc 7447A
processor, using u-boot version 0.3.0
     Here is what I am doing, I make uImage, after
configuring ramdisk support

CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=2
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RAMFS=y
     I then set my bootargs in uboot to 
root=/dev/ram rw  
     I then load my kernel and ramdisk image into
memory and specify to boot the kernel with the ramdisk
in uboot via
     bootm 0x300000 0x10000000
The following is the output:

U-Boot 0.3.0 (Jun 29 2005 - 09:50:51)SKY Computers
1.1.3

CPU:   MPC7447A v1.1 @ 1399.650 MHz
BOARD: HDPU_COMPUTE_BLADE SINGLE
BUS:   133300000
DRAM:  512 MB
******************************************************
Please Wait, Scrubbing SDRAM to initialize ECC bits...
******************************************************
FLASH: [65536kB@fc000000] 64 MB
In:    serial
Out:   serial
Err:   serial
Net:   ### Error: Phy is not active
mv_enet0
=> bootp
bootp
### Error: Phy is not active
BOOTP broadcast 1
DHCP client bound to address 10.0.0.5
ARP broadcast 1
TFTP from server 10.0.0.254; our IP address is
10.0.0.5
Filename 'adrian/uImage.adr'.
Load address: 0x300000
Loading:
#################################################################
        
#################################################################
        
#################################################################
        
#################################################################
        
#################################################################
done
Bytes transferred = 1661461 (195a15 hex)
=> tftpboot 0x10000000 adrian/ramdisk.img
tftpboot 0x10000000 adrian/ramdisk.img
### Error: Phy is not active
ARP broadcast 1
TFTP from server 10.0.0.254; our IP address is
10.0.0.5
Filename 'adrian/ramdisk.img'.
Load address: 0x10000000
Loading:
#################################################################
        
#################################################################
        
#################################################################
        
#################################################################
         ###############
done
Bytes transferred = 1403903 (156bff hex)
=> bootm 0x300000 0x10000000
bootm 0x300000 0x10000000
## Booting image at 00300000 ...
   Image Name:   Linux-2.6.12-2_0_2
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    1661397 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 10000000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip
compressed)
   Data Size:    1403839 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 1fe47000, end 1ff9dbbf ... OK
Total memory = 512MB; using 1024kB for hash table (at
80400000)
Linux version 2.6.12-2_0_2 (root@1_4_0_0) (gcc version
3.3) #18 Wed Aug 31 16:49:39 EDT 2005
SKY HDPU Compute Blade
Built 1 zonelists
Kernel command line: root=/dev/ram rw
PID hash table entries: 4096 (order: 12, 65536 bytes)
time_init: decrementer frequency = 33.325000 MHz
Dentry cache hash table entries: 131072 (order: 7,
524288 bytes)
Inode-cache hash table entries: 65536 (order: 6,
262144 bytes)
Memory: 514304k available (2388k kernel code, 1264k
data, 132k init, 0k highmem)
Mount-cache hash table entries: 512
scheduling while atomic: swapper/0x00000002/0
Call trace:
 [80007b1c] dump_stack+0x18/0x28
 [80250614] schedule+0x764/0x768
 [80004980] syscall_exit_work+0x108/0x10c
 [8037d78c] proc_root_init+0x164/0x170
 [80390000] __log_buf+0xb9c/0x8000
 [8036a68c] start_kernel+0x18c/0x1c4
 [00003a30] 0x3a30
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 2 of PCI bridge 2
SCSI subsystem initialized
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: MPSC driver $Revision: 1.1.1.1 $
ttyMM0 at MMIO 0xf1008000 (irq = 36) is a MPSC
ttyMM1 at MMIO 0xf1009000 (irq = 38) is a MPSC
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 2 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
Sky CPU State Driver v1.1
MV-643xx 10/100/1000 Ethernet Driver
eth0: port 0 with MAC address 00:50:c2:1f:10:cd
eth0: RX NAPI Enabled
st: Version 20050312, fixed bufsize 32768, s/g segs
256
physmap flash device: 4000000 at fc000000
phys_mapped_flash: Found 2 x16 devices at 0x0 in
32-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Using physmap partition definition
Creating 6 MTD partitions on "phys_mapped_flash":
0x00000000-0x04000000 : "No FS"
mtd: Giving out device 0 to No FS
0x00000000-0x03400000 : "Root FS"
mtd: Giving out device 1 to Root FS
0x03400000-0x03c00000 : "User FS"
mtd: Giving out device 2 to User FS
0x03c00000-0x03ec0000 : "Kernel Image"
mtd: Giving out device 3 to Kernel Image
0x03ec0000-0x03f00000 : "bootEnv"
mtd: Giving out device 4 to bootEnv
0x03f00000-0x04000000 : "bootROM"
mtd: Giving out device 5 to bootROM
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144
bytes)
TCP: Hash tables configured (established 131072 bind
65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(1,0)
 <0>Rebooting in 180 seconds..

     However, the kernel is unable to mount the block.
I have tried the following:

1.  Setting root=/dev/ram0 rw

2.  Setting root=/dev/ram ramdisk_start=0x1fe47000
Thus, spelling out where the ramdisk is unpacked by
uboot to the Kernel.

3.  tftpboot 0x10000000 adrian/ramdisk.gz and
root=/dev/ram ramdisk_start=0x10000000, thus loading
the compressed ramdisk right into memory.

4.   Combining the ramdisk and kernel image, with a 
uboot header via Wolfgang's directions:
http://www.denx.de/twiki/bin/view/DULG/CombiningKernelAndRamdisk

     After looking through uboot, there really is no
super custom cpu initialization.  And the bootm 
command works solid.  So I don't think having a 
somewhat old version of uboot is the reason.  But I 
am out of ideas.

1.    My question is why don't I see
"RAMDISK: Compressed image found at block 0"
    instead of the Kernel Panic?  Am I missing some
arguments?  noinitrd, ramdisk_start, ramdisk_size,
etc?

2.    Does uboot have issues with this processor,
MPX bus, ramdisks?  I don't think so, but has anyone
seen an issue with version 0.3.0 of uboot?

3.    Also, I am using the SELF ramdisk provided on
Wolfgang Denk's U-boot and Linux guide.  ( Thank you
Wolfgang!!!) and am able once booted via nfs to 
mount the ramdisk without a problem.  Thus, I believe
the ramdisk is ok.

     Any pointers, comments, constructive critisism
would be greatly appreciated.  And yes, I have read
through several archives quite abit before posting.  
     A close example of my problem is
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019071.html
     However, no solution was posted.

Regards and thanks in advance!

Adrian



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
