Return-Path: <mzaturenskiy.st@gmail.com>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 0FD64B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 05:26:20 +1000 (EST)
Received: by qyk1 with SMTP id 1so6132459qyk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Jul 2009 12:26:18 -0700 (PDT)
MIME-Version: 1.0
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Wed, 8 Jul 2009 14:25:58 -0500
Message-ID: <97dd5fd20907081225g2dc4a8dep74407ece12223162@mail.gmail.com>
Subject: switching from initrd to initramfs
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, I have a working system with an initrd ramdisk and I'm having
some trouble switching it over to initramfs.

This is for an EP88xc Embedded Planet board, now running U-Boot and
using kernel 2.6.29. I prepare my initrd using:

genext2fs -U -d rootfs -D rootfs_devices.tab -b 9700 -i 380 initrd.img
gzip -v9 initrd.img
mkimage -T ramdisk -C gzip -n 'Test Ramdisk Image' -d initrd.img.gz uInitrd

(instructions are from
http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding )
...which seems to work ok and results in the following:

************************************************************************************
U-Boot 2009.03-svn8609 (Jun 30 2009 - 11:32:48)

CPU:   MPC885ZPnn at 100 MHz [40.0...133.0 MHz]
       8 kB I-Cache 8 kB D-Cache FEC present
Board: EP88xC 1.1  CPLD revision 2
DRAM:  64 MB
FLASH: 32 MB
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET, FEC2 ETHERNET
Hit any key to stop autoboot:  0
=>
=>
=> setenv bootargs console=ttyCPM0,9600n8 root=/dev/ram rw init=/sbin/init
=> tftp 400000 ep88x_uimage_29
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_uimage_29'.
Load address: 0x400000
Loading: #################################################################
         ##########
done
Bytes transferred = 1089141 (109e75 hex)
=> tftp 750000 ep88x_ramdisk_generated2
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_ramdisk_generated2'.
Load address: 0x750000
Loading: #################################################################
         ###############################################################
done
Bytes transferred = 1869959 (1c8887 hex)
=> tftp 1000000 ep88x_dtb
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_dtb'.
Load address: 0x1000000
Loading: #
done
Bytes transferred = 7643 (1ddb hex)
=> bootm 400000 750000 1000000
## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-2.6.29.6-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1089077 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 00750000 ...
   Image Name:   Test Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1869895 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 01000000
   Booting using the fdt blob at 0x1000000
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 03da5000, end 03f6d847 ... OK
   Loading Device Tree to 007fb000, end 007ffdda ... OK
Using Embedded Planet EP88xC machine description
Linux version 2.6.29.6-dirty (devone@localhost.localdomain) (gcc version 4.2.2)
#1 Mon Jul 6 12:53:12 CDT 2009
Found initrd at 0xc3da5000:0xc3f6d847
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
MMU: Allocated 72 bytes of context maps for 16 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyCPM0,9600n8 root=/dev/ram rw init=/sbin/init
PID hash table entries: 256 (order: 8, 1024 bytes)
Decrementer Frequency = 0x5f5e10
clocksource: timebase mult[28000000] shift[22] registered
console [ttyCPM0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60644k/65536k available (2124k kernel code, 4824k reserved, 88k data, 10
6k bss, 124k init)
SLUB: Genslabs=11, HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 12.41 BogoMIPS (lpj=62080)
Mount-cache hash table entries: 512
net_namespace: 296 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1826k freed
msgmni has been set to 122
io scheduler noop registered
io scheduler deadline registered (default)
Generic RTC Driver v1.07
f0000a80.serial: ttyCPM0 at MMIO 0xc500ea80 (irq = 19) is a CPM UART
f0000a20.serial: ttyCPM1 at MMIO 0xc5016a20 (irq = 29) is a CPM UART
brd: module loaded
loop: module loaded
eth0 (): not using net_device_ops yet
eth0: fs_enet: 00:00:00:00:00:00
eth1 (): not using net_device_ops yet
eth1: fs_enet: 00:00:00:00:00:00
FEC MII Bus: probed
fe000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
fe000000.flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 124k init
init started: BusyBox v1.7.1 (2008-04-02 09:14:47 MEST)
starting pid 208, tty '': '/etc/rc.sh'
starting pid 213, tty '': '/bin/application'
starting pid 214, tty '': '/bin/sh'
### Application running ...
~ #
*****************************************************************************

Then I tried to make an initramfs from the same root tree using:

find | cpio -ovc | gzip -v9 > ../initramfs.cpio.gz
mkimage -T ramdisk -C gzip -n 'Test Ramdisk Image' -d
../initramfs.cpio.gz ../uCpio

But the result seems to have an issue with init:

****************************************************************************
U-Boot 2009.03-svn8609 (Jun 30 2009 - 11:32:48)

CPU:   MPC885ZPnn at 100 MHz [40.0...133.0 MHz]
       8 kB I-Cache 8 kB D-Cache FEC present
Board: EP88xC 1.1  CPLD revision 2
DRAM:  64 MB
FLASH: 32 MB
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET, FEC2 ETHERNET
Hit any key to stop autoboot:  0
=>
=>
=> setenv bootargs console=ttyCPM0,9600n8 root=/dev/ram rw init=/sbin/init
=> tftp 400000 ep88x_uimage_29
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_uimage_29'.
Load address: 0x400000
Loading: #################################################################
         ##########
done
Bytes transferred = 1089141 (109e75 hex)
=> tftp 750000 ep88x_ramfs
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_ramfs'.
Load address: 0x750000
Loading: #################################################################
         ############################################################
done
Bytes transferred = 1832735 (1bf71f hex)
=> tftp 1000000 ep88x_dtb
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_dtb'.
Load address: 0x1000000
Loading: #
done
Bytes transferred = 7643 (1ddb hex)
=> bootm 400000 750000 1000000
## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-2.6.29.6-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1089077 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 00750000 ...
   Image Name:   Test Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1832671 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 01000000
   Booting using the fdt blob at 0x1000000
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 03dae000, end 03f6d6df ... OK
   Loading Device Tree to 007fb000, end 007ffdda ... OK
Using Embedded Planet EP88xC machine description
Linux version 2.6.29.6-dirty (devone@localhost.localdomain) (gcc version 4.2.2)
#1 Mon Jul 6 12:53:12 CDT 2009
Found initrd at 0xc3dae000:0xc3f6d6df
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
MMU: Allocated 72 bytes of context maps for 16 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyCPM0,9600n8 root=/dev/ram rw init=/sbin/init
PID hash table entries: 256 (order: 8, 1024 bytes)
Decrementer Frequency = 0x5f5e10
clocksource: timebase mult[28000000] shift[22] registered
console [ttyCPM0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60680k/65536k available (2124k kernel code, 4788k reserved, 88k data, 10
6k bss, 124k init)
SLUB: Genslabs=11, HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 12.41 BogoMIPS (lpj=62080)
Mount-cache hash table entries: 512
net_namespace: 296 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
Freeing initrd memory: 1789k freed
msgmni has been set to 122
io scheduler noop registered
io scheduler deadline registered (default)
Generic RTC Driver v1.07
f0000a80.serial: ttyCPM0 at MMIO 0xc500ea80 (irq = 19) is a CPM UART
f0000a20.serial: ttyCPM1 at MMIO 0xc5016a20 (irq = 29) is a CPM UART
brd: module loaded
loop: module loaded
eth0 (): not using net_device_ops yet
eth0: fs_enet: 00:00:00:00:00:00
eth1 (): not using net_device_ops yet
eth1: fs_enet: 00:00:00:00:00:00
FEC MII Bus: probed
fe000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
fe000000.flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
List of all partitions:
1f00           32768 mtdblock0 (driver?)
No filesystem could mount root, tried:  ext2 cramfs
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
Rebooting in 180 seconds..
**********************************************************************

I was hoping to convert this working initrd to initramfs before I try
and create my own initrd, I'm still learning about this process. I got
this to work yesterday morning, but I'm not sure what changed or what
I'm doing differently...
Can somebody help me figure out what's missing?

Thanks,
Mikhail Zaturenskiy
