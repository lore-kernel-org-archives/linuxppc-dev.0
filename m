From: John_McRoberts@Mitel.COM
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <85256ADC.00515614.00@kanmta01.software.mitel.com>
Date: Fri, 5 Oct 2001 15:50:09 +0100
Subject: Hard disk and segmentation violation.
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I seem to have a problem with fdisk whereby I get an segmentation violation to
the hard disk, address 0x43000000 +. I have performed and ioremap to this area.

Terminal output below:

PPCBoot 1.0.4 (Oct  1 2001 - 14:55:12)
MN3100 PPC Linux Boot Loader (c) MARCH NETWORKS 2001


CPU:   XPC860xxZPnnD4 at 50 MHz: 16 kB I-Cache 8 kB D-Cache FEC present
Board: ### No HW ID - assuming TQM8xxL
Initialising the FPGA...............OK, Version DC32
DRAM:  128 MB
FLASH: 512 kB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial

=> bootd
ARP broadcast 1
TFTP from server 192.168.0.64; our IP address is 192.168.0.1
Filename 'vmlinux.img'.
Load address: 0x1e00000
Loading: #######################################################################
##########################################################
done
Bytes transferred = 658636 (a0ccc hex)
ARP broadcast 1
TFTP from server 192.168.0.64; our IP address is 192.168.0.1
Filename 'rootfs.img'.
Load address: 0x1f00000
Loading: #######################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
############################################
done
Bytes transferred = 3453418 (34b1ea hex)
## Booting image at 01e00000 ...
   Image Name:   2.4.9 for MN3100
   Created:      2001-10-05  14:38:04 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658572 Bytes = 643 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x07FAF968 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF63
## Loading RAMDisk Image at 01f00000 ...
   Image Name:   2.4.9 for MN3100
   Created:      2001-10-05   8:57:15 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3453354 Bytes = 3372 kB = 3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0x01F00040 ... 0x0224B1E9 (len=3453354=0x34B1AA)
   Loading Ramdisk to 07c63000, end 07fae1aa ... OK
## Transferring control to Linux (at address 00000000) ...
ioremap: addr=FF000000 to FF000000
ioremap: addr=30000000 to 30000000
ioremap: addr=40000000 to 40000000
ioremap: addr=50000000 to 50000000
Linux version 2.4.9 (root@localhost.localdomain) (gcc version 2.95.2 19991024 (r
elease)) #181 Fri Oct 5 15:34:36 BST 2001
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 console=tty0 ramdisk=17000 root=/dev/ram
 ide0=0x03000000,0x0300000e,12 ide=nodma
ide_setup: ide0=0x03000000,0x0300000e,12

ide_setup: ide=nodmaIDE: Prevented DMA
Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.76 BogoMIPS
Memory: 123344k available (1212k kernel code, 440k data, 44k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 17000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
with 1 interfaces
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
probing for hda: present=0, media=32, probetype=ATA
hda: Ritek Corporation, ATA DISK drive
ide0 at 0x3000000-0x3000007,0x300000e on irq 12
hda: 250368 sectors (128 MB) w/2KiB Cache, CHS=978/8/32
ide-floppy driver 0.97
Partition check:
 hda:ide0: start_request: current=0xc7ff2330
hda: do_special: 0xe0
ide0: start_request: current=0xc7ff2330
hda: do_special: 0x60
ide0: start_request: current=0xc7ff2330
hda: do_special: 0x20
ide0: start_request: current=0xc7ff2330
 hda1
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
ide-floppy driver 0.97
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 3372k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
****INIT****: /sbin/initmory: 44k ini
****INIT****: /etc/init
****INIT****: /bin/init
****INIT****: /bin/sh



# /sbin/fdisk /dev/hda
 hda:ide0: start_request: current=0xc7ff2270
Oops: kernel access of bad area, sig: 11
NIP: C00C1600 XER: 20000000 LR: C00C14B0 SP: C7CE1C50 REGS: c7ce1ba0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 43000006, DSISR: 00000C09
TASK = c7ce0000[8] 'fdisk' Last syscall: 5
last math 00000000 last altivec 00000000
GPR00: 000000E0 C7CE1C50 C7CE0000 00000028 00001032 00000001 00000001 00000002
GPR08: 00000002 43000006 C0452800 00000000 24002022 1002CF98 00000000 00000000
GPR16: 00000000 00000000 00000000 C0180000 00000000 07CE1F40 0000003F C0002A1C
GPR24: 00000001 00000001 C01A3DF4 C01A4125 00000000 C7FF2270 00000000 C01A3E5C
Call backtrace:
C00C14B0 C00C1AB4 C00C1B48 C00A9F80 C0014878 C0033DB8 C003581C
C0056EC4 C005689C C00569B0 C00C9808 C00C239C C003BF38 C00C96E8
C00C2638 C003C1CC C0032218 C003211C C0032514 C00027DC 100251D8
10002924 10007718 0FEE4238 00000000
Segmentation fault
#


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
