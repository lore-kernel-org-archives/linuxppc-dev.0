Return-Path: <Jogi95@web.de>
Received: from fmmailgate09.web.de (fmmailgate09.web.de [217.72.192.184])
	by ozlabs.org (Postfix) with ESMTP id D7F81DDF30
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 00:49:23 +1000 (EST)
Received: from web.de
	by fmmailgate09.web.de (Postfix) with SMTP id B32782A2F97C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 16:49:21 +0200 (CEST)
Date: Thu, 10 Jul 2008 16:49:21 +0200
Message-Id: <870343913@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: linuxppc-embedded@ozlabs.org
Subject: XSysAce: Queue is plugged
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

XSysAce: Queue is plugged
Can someone say me what this means and how to get rid of it=3F
I use a 2.6.23 xilinx Kernel on a XUPv2p. In the Kernel config-menu are 2 =
sysace drivers:
< > Xilinx SystemACE support
and=20
< > Xilinx SystemACE support (old driver)

I'm using the old driver because if I try to compile with the other it end=
s in this:

--------------------------------------------------------------------------=
--------------------------------
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      drivers/block/xsysace.o
drivers/block/xsysace.c:461: warning: `request=5Fqueue=5Ft' is deprecated (dec=
lared at include/linux/blkdev.h:40)
drivers/block/xsysace.c: In function `ace=5Ffsm=5Fdostate':
drivers/block/xsysace.c:627: warning: long unsigned int format, different =
type arg (arg 3)
drivers/block/xsysace.c: At top level:
drivers/block/xsysace.c:828: warning: `request=5Fqueue=5Ft' is deprecated (dec=
lared at include/linux/blkdev.h:40)
drivers/block/xsysace.c: In function `ace=5Fexit':
drivers/block/xsysace.c:1152: error: void value not ignored as it ought to=
 be
make[2]: *** [drivers/block/xsysace.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2
--------------------------------------------------------------------------=
--------------------------------------------------------

The message "XSysAce: Queue is plugged" appears the most when I start the =
system:
--------------------------------------------------------------------------=
-----------------------------------------------------------
Linux version 2.6.23xlnx (meyer@tiv007) (gcc version 3.4.5) #5 Wed Jul 2 1=
2:02:19 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx XUPV2P) (Virtex-II Pr=
o)
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early=5Fnode=5Fmap[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists in Zone order.  Total pages: 65024
Kernel command line: console=3DttyUL0 root=3D/dev/xsa2 rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
PID hash table entries: 1024 (order: 10, 4096 bytes)
I-pipe 1.6-03: pipeline enabled.
Console: colour dummy device 80x25
Console: Xilinx UART Lite
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257280k available (1816k kernel code, 640k data, 96k init, 0k high=
mem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
Registering device uartlite:0
Registering device xsysace:0
Fixup MAC address for xilinx=5Femac:0
Registering device xilinx=5Femac:0
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: real-time nucleus v2.4.2 (One Big Rush) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Xenomai: starting RTAI emulator.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
uartlite.0: ttyUL0 at MMIO 0x40600003 (irq =3D 5) is a uartlite
console [ttyUL0] enabled
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
System ACE at 0x41800000 mapped to 0xD1020000, irq=3D3, 500472KB
 xsa: xsa1 xsa2
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
xilinx=5Femac xilinx=5Femac.0: MAC address is now  0: a:35: 0: 2:29
XEmac: using fifo mode.
XEmac: Detected PHY at address 0, ManufID 0x0013, Rev. 0x78e2.
eth0: Dropping NETIF=5FF=5FSG since no checksum feature.
eth0: Xilinx 10/100 EMAC at 0x80400000 mapped to 0xD1040000, irq=3D4
eth0: XEmac id 1.1a, block id 32, type 1
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommende=
d
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
Use the --debug option to see the details of our search for an access meth=
od.
Setting clock : Thu Jan  1 00:00:25 UTC 1970 [  OK  ]
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
Starting portmap: XSysAce: Queue is plugged
XSysAce: Queue is plugged
[  OK  ]
Mounting NFS filesystems:  [  OK  ]
XSysAce: Queue is plugged
XSysAce: Queue is plugged
Mounting other filesystems:  [  OK  ]
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged
XSysAce: Queue is plugged

DENX ELDK version 4.1 build 2007-01-19
Linux 2.6.23xlnx on a ppc

localhost login: root
XSysAce: Queue is plugged
Last login: Thu Jan  1 00:00:43 on console
bash: dircolors: command not found
bash-3.00#
--------------------------------------------------------------------------=
-------------------------------------

Greez & Thx
Joachim
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220
