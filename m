Message-Id: <200312290416.hBT4GH3g094856@mail0.dreamwiz.com>
Date: Mon, 29 Dec 2003 13:16:17 +0900 (KST)
From: =?EUC-KR?B?wOXH/L/t?= <jazz0719@dreamwiz.com>
Subject: [Question]DMA problem in Sil0680A... 
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to recognize IDE drive via Sil0680A driver
in embedded linux enviroments. see below.

* OS : denx(http://www.denx.de) linuxppc_devel_2.4 (2.4.23)
* board : custom board for DVR
* bootloader : u-boot 0.4.0
* chipset : sil0680a(Siliconimage ultra ATA/133 PCI to ATA Host Controller)

I used default sil0680a driver(siimage.c siimage.h) included in
linuxppc_devel_2.4 (2.4.23).
(linux/drivers/ide/pci/siimage.c Version 1.06 June 11, 2003)


u-boot booting messages are as follows.

=> tftpboot 100000 /tftpboot/vmlinux.2
ENET Speed is 0 Mbps - FULL duplex connection
TFTP from server 192.168.1.210; our IP address is 192.168.1.200
Filename '/tftpboot/vmlinux.2'.
Load address: 0x100000
Loading: #################################################################
         #################################################################
         ##
done
Bytes transferred = 670977 (a3d01 hex)
=> tftpboot 200000 /tftpboot/ramdisk
ENET Speed is 0 Mbps - FULL duplex connection
TFTP from server 192.168.1.210; our IP address is 192.168.1.200
Filename '/tftpboot/ramdisk'.
Load address: 0x200000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##########################
done
Bytes transferred = 1460271 (16482f hex)
=> bootm 100000 200000
## Booting image at 00100000 ...
   Image Name: Linux-2.4.23
   Image Type: PowerPC Linux Kernel Image (gzip compressed)
   Data Size: 670913 Bytes = 655.2 kB
   Load Address: 00000000
   Entry Point: 00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00200000 ...
   Image Name: sil0680 test 11
   Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size: 1460207 Bytes = 1.4 MB
   Load Address: 00000000
   Entry Point: 00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 01e54000, end 01fb87ef ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.4.23 (root@hwjang) (gcc version 3.2.1 20020930 (MontaVista)) #1
Mon Dec 15 11:43:40 KST 2003
IBM Sycamore (IBM405GPr) Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 ip=192.168.2.176:192.168.2.190:192.168.2.79:
255.255.255.0
Calibrating delay loop... 266.24 BogoMIPS
Memory: 29356k available (1120k kernel code, 368k data, 84k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI fixup irq - dev->name:PCI device 1014:0156, pin:1, slot:0, irq:0
PCI fixup irq - dev->name:PCI device 10ea:5202, pin:1, slot:1, irq:0
PCI fixup irq - dev->name:PCI device 10ea:5252, pin:1, slot:1, irq:0
PCI fixup irq - dev->name:PCI device 1095:0680, pin:1, slot:2, irq:25
PCI fixup irq - dev->name:PCI device 104c:a106, pin:1, slot:3, irq:29
PCI fixup irq - dev->name:PCI device 1077:1020, pin:1, slot:4, irq:0

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI en
abled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
Generic RTC Driver v1.07
IBM gpio driver version 07.25.02
GPIO #0 at 0xc3000700
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
emac: IBM OCP EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt
mal0: Initialized, 2 tx channels, 1 rx channels
eth0: IBM emac, MAC 00:03:4e:00:00:16
eth0: Found Generic MII PHY (0x01)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller at PCI slot 00:02.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 25
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
probing for hda: present=0, media=32, probetype=ATA
hda: QUANTUM FIREBALL CX10.2A, ATA DISK drive
drive->name : hda, drive->id_read : 1, drive->media : 20, drive->present : 1
probing for hdb: present=0, media=32, probetype=ATA
probing for hdb: present=0, media=32, probetype=ATAPI
drive->name : hdb, drive->id_read : 0, drive->media : 20, drive->present : 0
blk: queue c0183878, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
probing for hdc: present=0, media=32, probetype=ATA
probing for hdc: present=0, media=32, probetype=ATAPI
drive->name : hdc, drive->id_read : 0, drive->media : 20, drive->present : 0
probing for hdd: present=0, media=32, probetype=ATA
eth0: Link is Up
eth0: Speed: 10, Half duplex.
do_probe : 1
probing for hdd: present=0, media=32, probetype=ATAPI
do_probe : 1
drive->name : hdd, drive->id_read : 0, drive->media : 20, drive->present : 0
ide0 at 0xc3009f80-0xc3009f87,0xc3009f8a on irq 25
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63, UDMA(33)
Partition check:
 hda: unknown partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
eth0: Speed: 10, Half duplex.
IP-Config: Complete:
      device=eth0, addr=192.168.2.176, mask=255.255.255.0, gw=192.168.2.79,
     host=192.168.2.176, domain=, nis-domain=(none),
     bootserver=192.168.2.190, rootserver=192.168.2.190, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1425k freed
VFS: Mounted root (ext2 filesystem).
serial console detected. Disabling virtual terminals.
init started: BusyBox v0.60.2 (2002.12.19-10:50+0000) multi-call binary

Welcome to MontaVista Linux Preview Kit

Starting system...
mounting /proc: done.
Mounting '/' read-write: done.
brining up loopback interface: done.
Mounting /tmp: done.
Starting syslogd: done.
Jan 1 00:00:10 192 syslog.info syslogd started: BusyBox v0.60.2 (2002.12.19-10:
50+0000)
Starting klogd: done.
Starting inetd: Jan 1 00:00:10 192 daemon.emerg klogd: klogd started: BusyBox v
0.60.2 (2002.12.19-10:50+0000)
Jan 1 00:00:10 192 daemon.warn klogd: Linux version 2.4.23 (root@hwjang) (gcc v
ersion 3.2.1 20020930 (MontaVista)) #1 Mon Dec 15 11:43:40 KST 2003
Jan 1 00:00:10 192 daemon.info klogd: IBM Sycamore (IBM405GPr) Platform
Jan 1 00:00:10 192 daemon.info klogd: Port by MontaVista Software, Inc. (source
@mvista.com)
Jan 1 00:00:10 192 daemon.warn klogd: On node 0 totalpages: 8192
Jan 1 00:00:10 192 daemon.warn klogd: zone(0): 8192 pages.
/etc/init.d/rcS: /usr/sbin/inetd: No such file or directory
Jan 1 00:00:10 192 daemon.warn klogd: zone(1): 0 pages.
Jan 1 00:00:10 192 daemon.warn klogd: zone(2): 0 pages.
Jan 1 00:00:10 192 daemon.warn klogd: Kernel command line: root=/dev/hda1 ip=19
2.168.2.176:192.168.2.190:192.168.2.79:255.255.255.0
Jan 1 00:00:10 192 daemon.warn Jan 1 00:00:11 192 user.info linuxrc: Starting
pid 46, console /dev/console: '/sbin/getty console'

MontaVista Linux 2.1, Preview Kit


/* after linux booting ...*/


$ cd /proc
$ ls
1 51 driver irq modules stat
2 6 execdomains kcore mounts swaps
3 7 filesystems kmsg net sys
32 bus fs ksyms partitions sysvipc
36 cmdline ide loadavg pci tty
4 cpuinfo interrupts locks ppc_htab uptime
46 devices iomem meminfo self version
5 dma ioports misc slabinfo
$ cat interrupts
           CPU0
  0: 587 IBM UIC Level serial
  9: 0 IBM UIC Level OCP EMAC Wakeup
 10: 0 IBM UIC Level MAL SERR
 11: 0 IBM UIC Level MAL TX EOB
 12: 0 IBM UIC Level MAL RX EOB
 13: 0 IBM UIC Level MAL TX DE
 14: 0 IBM UIC Level MAL RX DE
 15: 0 IBM UIC Level OCP EMAC MAC
 25: 4 IBM UIC Level ide0
BAD: 1
$ cat dma
 4: cascade
$ cat ioports
00000000-0000ffff : PCI I/O
  0000fd00-0000fdff : PCI device 1077:1020
  0000fec0-0000fecf : PCI device 104c:a106
  0000fed0-0000fedf : PCI device 1095:0680
  0000fee4-0000fee7 : PCI device 1095:0680
  0000fee8-0000feef : PCI device 1095:0680
  0000fef4-0000fef7 : PCI device 1095:0680
  0000fef8-0000feff : PCI device 1095:0680
  0000ff00-0000ffff : PCI device 10ea:5252
$ cd ide
$ ls
drivers hda ide0 siimage
$ cat siimage


Controller: 0
SiI680 Chipset.
MMIO Base 0xbeffef00
MMIO-DMA Base 0xbeffef00
MMIO-DMA Base 0xbeffef08

$ cat devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
 10 misc
128 ptm
136 pts
162 raw

Block devices:
  1 ramdisk
  3 ide0
  7 loop

$ /sbin/fdisk /dev/hda
hda: dma_timer_expiry: dma status == 0x22
hda: error waiting for DMA
hda: dma timeout retry: status=0x7f { DriveReady DeviceFault SeekComplete DataRe
quest CorrectedError Index Error }
hda: dma timeout retry: error=0x7f { DriveStatusError UncorrectableError SectorI
dNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=0
hda: DMA disabled
Jan 1 00:00:41 192 daemon.warn klogd: hda: dma_timer_expiry: dma status == 0x22
Jan 1 00:00:41 192 daemon.err klogd: hda: erride0: reset: success
or waiting for DMA
Jan 1 00:00:41 192 daemon.warn klogd: hda: dma timeout retry: status=0x7f { Dri
veReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Jan 1 00:00:41 192 daemon.warn klogd: hda: dma timeout retry: error=0x7f { Driv
eStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFo
und }, LBAsect=260013951, sector=0
Jan 1 00:00:41 192 daemon.info klogd: hda: DMA disabled
Jan 1 00:00:41 192 daemon.warn klogd: ide0: reset: success
hda: dma_timer_expiry: dma status == 0x22
hda: error waiting for DMA
hda: dma timeout retry: status=0x7f { DriveReady DeviceFault SeekComplete DataRe
quest CorrectedError Index Error }
hda: dma timeout retry: error=0x7f { DriveStatusError UncorrectableError SectorI
dNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=8
hda: DMA disabled
Jan 1 00:01:01 192 daemon.warn klogd: hda: dma_timer_expiry: dma status == 0x22
ide0: reset: success

Jan 1 00:01:01 192 daemon.err klogd: hda: error waiting for DMA
Jan 1 00:01:01 192 daemon.warn klogd: hda: dma timeout retry: status=0x7f { Dri
veReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Jan 1 00:01:01 192 daemon.warn klogd: hda: dma timeout retry: error=0x7f { Driv
eStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFo
und }, LBAsect=260013951, sector=8
Jan 1 00:01:01 192 daemon.info klogd: hda: DMA disabled
Jan 1 00:01:01 192 daemon.warn klogd: ide0: reset: success

The number of cylinders for this disk is set to 19885.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hda: 16 heads, 63 sectors, 19885 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot Start End Blocks Id System
/dev/hda1 1 10000 5039968+ 83 Linux
/dev/hda2 10001 19885 4982040 83 Linux

Command (m for help): q

$ /sbin/mkfs.ext2 /dev/hda1
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/sbin/mkfs.ext2: Device size reported to be zero. Invalid partition specified,
or
        partition table wasn't reread after running fdisk, due to
        a modified partition being busy and in use. You may need to reboot
        to re-read your partition table.



as you see, when i try fdisk on /dev/hda or hdparm -t /dev/hda
"hda: dma_timer_expiry: dma status == 0x22" message appears
and it seems like DMA doesn't work properly...
status bit 0x22 means
PBM Error(R/W1C) - PCI Bus Master Error - IDE0. This bit set indicates that
a PCI bus error occured while the Sil0680 was bus master.

please give me the reason why.. and any solution...

waiting for your response...
thanks in advance...

- H.W.Jang.

e-mail : jazz0719@dreamwiz.com



-------------------------------------------------
Your Life on the Net
DreamWiz Free Mail @ http://www.dreamwiz.com/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
