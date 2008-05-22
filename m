Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83507.mail.sp1.yahoo.com (web83507.mail.sp1.yahoo.com
	[216.252.120.163]) by ozlabs.org (Postfix) with SMTP id 97022DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 06:43:14 +1000 (EST)
Date: Thu, 22 May 2008 13:36:32 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: JFFS2 FS not writeable
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <606394.37977.qm@web83507.mail.sp1.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to make new directories, create files, save
changes to files, etc. and when I reboot my changes
are not being saved.  I'm sorry if this is vague, but
I haven't run into this problem before in previous
kernels.  I'm using 2.6.25 and my configuration is
very similar to mpc8313erdb_defconfig, with changes to
include NAND support as my flash device is a NAND. 
Also, my dts is very similar to mpc8313erdb.dts as
well.  I don't know where to start looking for the
problem as there is no error.  Here is what is printed
on boot.

## Booting kernel from Legacy Image at 00500000 ...
   Image Name:   Linux-2.6.25
   Created:      2008-05-22  20:17:02 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    1783834 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 007e0000
   Booting using the fdt blob at 0x7e0000
Using MPC831x RDB machine description
Linux version 2.6.25 (root@localhost.localdomain) (gcc
version 4.0.0 (DENX ELDK
4.1 4.0.0)) #6 Thu May 22 13:17:01 PDT 2008
console [udbg0] enabled
setup_arch: bootmem
mpc831x_rdb_setup_arch()
arch: exit
Zone PFN ranges:
  DMA             0 ->   131072
  Normal     131072 ->   131072
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   131072
Built 1 zonelists in Zone order, mobility grouping on.
 Total pages: 130048
Kernel command line: root=/dev/mtdblock2
rootfstype=jffs2 rw console=ttyS0,115200
IPIC (128 IRQ sources) at fdffb700
PID hash table entries: 2048 (order: 11, 8192 bytes)
clocksource: timebase mult[7800001] shift[22]
registered
Dentry cache hash table entries: 65536 (order: 6,
262144 bytes)
Inode-cache hash table entries: 32768 (order: 5,
131072 bytes)
Memory: 515584k/524288k available (3484k kernel code,
8252k reserved, 132k data, 92k bss, 152k init)
SLUB: Genslabs=12, HWalign=32, Order=0-1,
MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 152 bytes
NET: Registered protocol family 16

SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4,
65536 bytes)
TCP established hash table entries: 65536 (order: 7,
524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144
bytes)
TCP: Hash tables configured (established 65536 bind
65536)
TCP reno registered
NTFS driver 2.1.29 [Flags: R/O].
JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 18) is a
16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 21) is a
16550A
brd: module loaded
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2,
00:e0:0c:00:95:01
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2,
00:00:00:00:00:00
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
Driver 'sd' needs updating - please use bus_type
methods
Freescale eLBC NAND Driver (C) 2006 Freescale - Ron!
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda
(Micron NAND 256MiB 3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 821 at 0x066a0000
Bad eraseblock 1765 at 0x0dca0000
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Creating 3 MTD partitions on "NAND 256MiB 3,3V 8-bit":
0x00000000-0x00100000 : "u-boot"
0x00100000-0x00400000 : "kernel"
0x00400000-0x02000000 : "fs"
eLBC NAND device at 0xe2800000, bank 0
usbmon: debugfs is not available
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host
Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned
bus number 1
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00,
driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
Freescale High-Speed USB SOC Device Controller driver
(Apr 20, 2007)
i2c /dev entries driver
rtc-ds1307: probe of 0-0068 failed with error -5
WDT driver for MPC83xx initialized. mode:reset
timeout=65535 (32 seconds)
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
/root/Desktop/linux-2.6.25/drivers/rtc/hctosys.c:
unable to open rtc device (rtc0)
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 152k init
Setting the hostname to freescale
Mounting filesystems
Running sysctl
Setting up networking on loopback device:
Setting up networking on eth0:
Adding static route for default gateway to
10.196.31.1:
Setting nameserver to 10.196.31.1 in /etc/resolv.conf:
Starting inetd:
Generating keys for the dropbear ssh server:
Will output 1024 bit rsa secret key to
'/etc/dropbear/dropbear_rsa_host_key'
Generating key, this may take a while...
Public key portion is:
ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAAAgwC/UlHirLLkjIKsXFpy4Glx6f3y1mOYU9tCTjs94bxVb1gzQXfNBdUKOc2GXFPT91pqXhesVl6wRtKUuvwqfXjYtAatIxBF3c4dO9ZBnp7B2B1C3T3g3dbv7Ah9NtB+s3d55mI8Z3ml2fMxQI6gtCbda8ZjzZiUcwNXZ2JOcMv4YaEx
Fingerprint: md5
21:aa:fd:a2:cc:53:ba:fd:e3:e9:86:3d:90:c7:9b:22
Starting the dropbear ssh server:

I see this when rebooting

/ # reboot
/ # Stopping the dropbear ssh server:
Stopping inetd:
Unmounting filesystems
The system is going down NOW !!
Sending SIGTERM to all processes.
Please stand by while rebooting the system.
md: stopping all md devices.
Restarting system.

Thank you,
Ron Madrid
