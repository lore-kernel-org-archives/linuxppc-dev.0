Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id 2E12767BC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 00:30:29 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.0.3.R)
	with ESMTP id md50000037795.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 07 Jul 2005 16:30:28 +0200
From: "David Grab" <d.grab@hima.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 7 Jul 2005 16:28:57 +0200
Message-ID: <001401c58300$3643f870$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: PPC440GX IBM EMAC2/3 RGMII mode selection
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

i have some problems to configure emac2, emac3 support of my ibm ppc440gx
for linux kernel 2.6.11.6. I have two RGMII Phy´s connected to the ppc an no
other PHY´s are connected. PPC Strapping is selected for Group4 (SMII, SMII,
RGMII/RTBI, RGMII/RTBI). I only want to configure the RGMII support of emac2
and emac3. But it seems like the PHY´s are used for eth0 (emac1) and eth1
(emac2) which are configured as SMII. Could someone tell me, what i have to
configure to select only emac2 and emac3 in RGMII mode?

Thx for help,

David

console output:

=> bootd
## Booting image at ff000000 ...
   Image Name:   Linux-2.6.11.6
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    890881 Bytes = 870 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x1FF9D898 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF25
bd address  = 0x1FF9DF54
memstart    = 0x00000000
memsize     = 0x20000000
flashstart  = 0xFF000000
flashsize   = 0x01000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0xC01D2D00
intfreq     =    500 MHz
busfreq     = 166.666 MHz
ethaddr     = 00:04:AC:E3:28:8A
eth1addr    = 00:04:AC:E3:28:8B
eth2addr    = 00:04:AC:E3:28:8C
eth3addr    = 00:04:AC:E3:28:8D
IP addr     = 192.168.0.116
baudrate    = 115200 bps
## Loading RAMDisk Image at ff800000 ...
   Image Name:   Test Ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1629365 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0xFF800040 ... 0xFF98DCF4 (len=1629365=0x18DCB5)
   Loading Ramdisk to 1fe0f000, end 1ff9ccb5 ... OK
Linux version 2.6.11.6 (david@FedoraDG) (gcc-Version 3.3.3 (DENX ELDK 3.1
3.3.3-8)) #2 Thu Jul 7 01:33:11 CEST 2005
IBM
Built 1 zonelists
Kernel command line: console=ttyS1,115200 root=/dev/ram rw
PID hash table entries: 4096 (order: 12, 65536 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515712k available (1372k kernel code, 464k data, 108k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1591k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: bridge rsrc 0..ffff (100), parent c0195018
PCI: bridge rsrc 80000000..ffffefff (200), parent c0195034
SCSI subsystem initialized
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
mal0: Initialized, 4 tx channels, 4 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
eth0: IBM emac, MAC 00:04:ac:e3:28:8a
eth0: Found Generic MII PHY (0x05)
zmii0: input 1 in SMII mode
eth1: IBM emac, MAC 00:04:ac:e3:28:8b
eth1: Found Generic MII PHY (0x06)
zmii0: input 2 in SMII mode
rgmii0: input 0 in RGMII mode
emac2: Can't find PHY.
zmii0: input 3 in SMII mode
rgmii0: input 1 in RGMII mode
emac3: Can't find PHY.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 1024) 4194304
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 108k init
eth0: Link is Up
eth0: Cannot reset EMAC
### Application running ...

BusyBox v0.60.5 (2004.11.10-15:02+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.
