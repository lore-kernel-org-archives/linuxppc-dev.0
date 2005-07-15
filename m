Return-Path: <susheel_nuguru@yahoo.co.in>
Received: from web8506.mail.in.yahoo.com (web8506.mail.in.yahoo.com
	[202.43.219.168]) by ozlabs.org (Postfix) with SMTP id 6F3BD67C25
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 22:20:32 +1000 (EST)
Message-ID: <20050715122030.13663.qmail@web8506.mail.in.yahoo.com>
Date: Fri, 15 Jul 2005 05:20:29 -0700 (PDT)
From: Susheel Raj <susheel_nuguru@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: boot failure help needed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

 I am using freescale mpc5200B on the board. I have a
tftp-server on my machine and connect to the board
through this server. 
  the Kernel and the root file system are ion my
desktop PC in the directory /tftpboot/
  kernel --->  /tftpboot/pImage
  root fs ---> /tftpboot/rootfs/

We have U_Boot for booting system and it fetches the
kernel from the server (that is my esktop PC) through
the ETHERNET connection. rootfile systems stays here
in the server ,

ls command shows  like this in /tftpboot/rootfs/
[root@localhost rootfs]# ls

bin  build_dir  deep_sleep  dev  etc  lib  mnt  opt 
proc  sbin  tmp  usr  var

console interface is console=ttyS0 on to the board

now the problem is that if i use MPC5200 Rev A then
the kernel boots without any problem and gets into the
command 

but when i am using MPC5200 Rev B it shows like this


U-Boot 1.1.1 (Jul  8 2005 - 16:18:22)

CPU:   MPC5200 (JTAG ID 1001101d) at 396 MHz
       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
Board: Mitron MCT3
DRAM:  64 MB
FLASH:  4 MB
FPGA:  OK
SPI:   MPC5200_spi,mki_ad initialised
Backlight: (channel 2, dutycycle 50, freq 500)
initialised
Video: SMI720 @ 640x480x8 28kHz 53Hz
In:    serial
Out:   serial
Err:   serial
NAND:     Flash chip found:
          Manufacturer ID: 0x20, Chip ID: 0x79 (NAND
128MiB 3,3V 8-bit)
          1 flash chips found. Total nand_chip size:
128 MB
 128 MB at 0x28001000
Net:   FEC ETHERNET
IDE:   no card

## Booting image at 00800000 ...
   Image Name:   Linux-2.4.21-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    1004081 Bytes = 980.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Mitron CVS tag: mct3_moto1_update
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.21-rc1 (nuguru@SW-server) (gcc
version 2.95.4 20010319 (prerelease/franzo/20011204))
#67 Fri Jul 15 14:16:36 EEST 2005
Mitron SGVT port (C) 2003 Mitron Oy (mitron@mitron.fi)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs console=ttyS0
nfsroot=192.168.1.61:/tftpboot/rootfs
ip=192.168.30.130:192.168.1.61:192.168.1.1:255.255.0.0:SGVT_180::off
mgt5100_pic.c/mgt5100_init_irq: using configuration
from FPGA binary file
mgt5100_init_irq: external FPGA interrupt controller
(by Mitron Oy) initialized
Calibrating delay loop... 263.78 BogoMIPS
Memory: 61828k available (1768k kernel code, 576k
data, 76k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536
bytes)
Inode cache hash table entries: 4096 (order: 3, 32768
bytes)
Mount cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384
bytes)
Page-cache hash table entries: 16384 (order: 4, 65536
bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Memory resource not set for host bridge 0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red
H&#65533;erial.c->init_chipsels: mfdev->count !=
SGVT_RS_TABLE_SIZE
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
uart00 at 0xc5078000 (irq = 92) is a TI16750
uart01 at 0xc507a008 (irq = 92) is a TI16750
uart02 at 0xc507c010 (irq = 92) is a TI16750
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
Uniform Multi-Platform E-IDE driver Revision:
7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
SCSI subsystem driver Revision: 1.00
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci-embedded.c: USB OHCI at membase 0xf0001000,
IRQ 44
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik
<vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
pegasus.c: v0.4.26 (2002/03/21):Pegasus/Pegasus II USB
Ethernet driver
usb.c: registered new driver pegasus
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
Mitron multi chip CAN driver 0.4 inited
Mitron SPI core functionality initialized
spi-core.o: adapter SGVT SPI host registered as
adapter 0.
spi_add_driver: driver MKI driver registered.
kb_probe_func: MKI keyboard 0 found. Versions: hw:3.1
sw:2.2
spi_attach_client: client [SGVT SPI keyboard]
registered to adapter [SGVT SPI host](pos. 0).
MKI initialized succesfully
SGVT_WDT: Software Watchdog Timer version 0.1, timeout
60 sec.
SGVT Bank 0: Found 1 x16 devices at 0x0 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
SGVT Bank 0: Swapping erase regions for broken CFI
table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due
to code brokenness.
Creating 3 MTD partitions on "SGVT Bank 0":
0x00000000-0x00200000 : "kernel"
0x00200000-0x00280000 : "logo1"
0x00280000-0x00300000 : "logo2"
No NAND device found!!!
sgvt_nand_init: unable to find NAND device
Initialised PWM buzzer, v. 0.1
Nov. I/O 0.1 succesfully initialized
spi_add_driver: driver A/D driver registered.
spi_attach_client: client [SGVT SPI A/D converter]
registered to adapter [SGVT SPI host](pos. 5).
SPI A/D initialized succesfully
ppcpmw 0.8 initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
4096)
eth0: config: auto-negotiation off, 100HDX, 10HDX.
IP-Config: Complete:
      device=eth0, addr=192.168.30.130,
mask=255.255.0.0, gw=192.168.1.1,
     host=SGVT_180, domain=, nis-domain=(none),
     bootserver=192.168.1.61, rootserver=192.168.1.61,
rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.61
Looking up port of RPC 100005/1 on 192.168.1.61
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init


U-Boot 1.1.1 (Jul  8 2005 - 16:18:22)

CPU:   MPC5200 (JTAG ID 1001101d) at 396 MHz
       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
Board: Mitron MCT3
DRAM:  64 MB
FLASH:  4 MB
FPGA:  OK
SPI:   MPC5200_spi,mki_ad initialised
Backlight: (channel 2, dutycycle 50, freq 500)
initialised
Video: SMI720 @ 640x480x8 28kHz 53Hz
In:    serial
Out:   serial
Err:   serial
NAND:     Flash chip found:
          Manufacturer ID: 0x20, Chip ID: 0x79 (NAND
128MiB 3,3V 8-bit)
          1 flash chips found. Total nand_chip size:
128 MB

 
and it gooooooes on ...

i think it is not able to search for the INIT task ..
what could be the problem .. please help


Susheel

                    More Smiles Per Hour




		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
