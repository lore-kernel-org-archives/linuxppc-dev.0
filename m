Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id D5A95DE2FE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 22:09:49 +1000 (EST)
Received: from web.de
	by fmmailgate04.web.de (Postfix) with SMTP id 1C5985DF938C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 14:09:47 +0200 (CEST)
Date: Thu, 17 Jul 2008 14:09:47 +0200
Message-Id: <883498565@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: linuxppc-embedded@ozlabs.org
Subject: use xilinx gpio from linux on a ppc405
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I installed (with some help of this mailinglist) a Linux (Kernel 2.6.23 from xilinx) on a ppc405 of a Virtex 2 PRO on a XUPV2P. Then I installed Xenomai. Now I want to control some devices from the Board, so I thought first I try to turn the LEDs on and of. I enabled the LEDs in my Design without interrupt and also compiled the Kernel with Xilinx OPG GPIO support. But I don't know realy how to go on. I found only 2 pages in the internet which gave me a bit of information, but nothing helped me.
Can Anyone explain me what I have to do, or send me a link to a page where it is explained?

The 2 pages I found:
--------------------------
http://osdir.com/ml/linux.uclinux.microblaze/2005-08/msg00120.html
http://www.tango-controls.org/Members/jbutanowicz/tango-on-ml403

The output of the kernel while booting:
-------------------------------------------------
Linux version 2.6.23xlnx (meyer@tiv007) (gcc version 3.4.5) #1 Thu Jul 17 12:10:27 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx XUPV2P) (Virtex-II Pro)
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists in Zone order.  Total pages: 65024
Kernel command line: console=ttyUL0 root=/dev/xsa2 rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x25
Console: Xilinx UART Lite
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257664k available (1580k kernel code, 500k data, 96k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
Registering device uartlite:0
Registering device xsysace:0
Registering device xilinx_emac:0
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
uartlite.0: ttyUL0 at MMIO 0x40600003 (irq = 3) is a uartlite
console [ttyUL0] enabled
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
System ACE at 0x41800000 mapped to 0xD1020000, irq=1, 500472KB
 xsa: xsa1 xsa2
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
xilinx_emac xilinx_emac.0: MAC address is now  2: 0: 0: 0: 0: 0
XEmac: using fifo mode.
XEmac: Detected PHY at address 0, ManufID 0x0013, Rev. 0x78e2.
eth0: Dropping NETIF_F_SG since no checksum feature.
eth0: Xilinx 10/100 EMAC at 0x80400000 mapped to 0xD1040000, irq=2
eth0: XEmac id 1.1a, block id 32, type 1
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on xsa2, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing unused kernel memory: 96k init
INIT: version 2.85 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Building the cache [  OK  ]
 storage network audio done[  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
Setting clock : Thu Jan  1 00:00:20 UTC 1970 [  OK  ]
Setting hostname localhost:  [  OK  ]
Checking filesystems
Checking all file systems.
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Bringing up loopback interface:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
Starting portmap: [  OK  ]
Mounting NFS filesystems:  XSysAce: Queue is plugged
[  OK  ]
XSysAce: Queue is plugged
Mounting other filesystems:  [  OK  ]

DENX ELDK version 4.1 build 2007-01-19
Linux 2.6.23xlnx on a ppc

localhost login:





Thanks and Greez
Joachim
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114
