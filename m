Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BD7C9DDFA1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Dec 2008 22:35:50 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LCBjm-00047y-8m
	for linuxppc-embedded@ozlabs.org; Mon, 15 Dec 2008 03:35:46 -0800
Message-ID: <21012378.post@talk.nabble.com>
Date: Mon, 15 Dec 2008 03:35:46 -0800 (PST)
From: "xavier.vvv" <xavier.vvv@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: use xilinx gpio from linux on a ppc405
In-Reply-To: <20081215111809.GA22007@ee.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <883498565@web.de> <21010485.post@talk.nabble.com>
	<20081215111809.GA22007@ee.ethz.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Jan,
I used EDK 9.1 and I have the opb_emac ethernet controller.
I selected Xilinx 10/100 opb emac support in linux 2.6 configuration (devic=
e
drivers/ Network device support/ Ethernet (10 or 100Mbit) ).
Concerning sysace, you have downloaded linux 2.6 from denx or xilinx tree?
I will try creating xsa nodes . Hope that it will work.
Thanks
Xavier

Jan M=C3=BCller wrote:
>=20
> Hi,
>=20
> This is interesting...
>=20
> I have the sysace working but the ethernet not.
>=20
> Just an idea:
> For the sysace driver in the 2.6 kernel the old device file
> entries don't work anymore.
>=20
> Do you have the correct device nodes in /dev? You can create those
> nodes with the following commands:
>=20
> # mknod -m 660 xsa b 254 0
> # mknod -m 660 xsa1 b 254 1
> # mknod -m 660 xsa2 b 254 2
> # mknod -m 660 xsa3 b 254 3
>=20
>=20
> Concerning the ethernet...:  ;-)
> Which IP Type do you have for the Ethernet_MAC? Mine is
> xps_ethernetlite but I can't find a linux driver which seems to
> work with this one.
>=20
> regards,
> Jan
>=20
>=20
> On Mon, Dec 15, 2008 at 01:12:18 -0800, xavier.vvv wrote:
>>=20
>> Hi,
>> I have installed linux 2.6 on the xupv2p board. I have uart, ethernet,
>> but
>> sysace device is not working.
>> I have seen in this forum that other persons have the problem.
>> Could you tell me if you have sysace driver working?
>> Also I want to install xenomai, but the problem is that linux from denx
>> tree
>> does not support opb_emac ethernet=20
>> driver. I need Ethernet because I use nfs to access the root file system=
.
>> So another question is:=20
>> when you installed xenomai, where was the rfs? and did you used Ethernet
>> driver?
>>=20
>> Thanks
>>=20
>>=20
>> Joachim Meyer wrote:
>> >=20
>> > Hi
>> >=20
>> > I installed (with some help of this mailinglist) a Linux (Kernel 2.6.2=
3
>> > from xilinx) on a ppc405 of a Virtex 2 PRO on a XUPV2P. Then I
>> installed
>> > Xenomai. Now I want to control some devices from the Board, so I
>> thought
>> > first I try to turn the LEDs on and of. I enabled the LEDs in my Desig=
n
>> > without interrupt and also compiled the Kernel with Xilinx OPG GPIO
>> > support. But I don't know realy how to go on. I found only 2 pages in
>> the
>> > internet which gave me a bit of information, but nothing helped me.
>> > Can Anyone explain me what I have to do, or send me a link to a page
>> where
>> > it is explained?
>> >=20
>> > The 2 pages I found:
>> > --------------------------
>> > http://osdir.com/ml/linux.uclinux.microblaze/2005-08/msg00120.html
>> > http://www.tango-controls.org/Members/jbutanowicz/tango-on-ml403
>> >=20
>> > The output of the kernel while booting:
>> > -------------------------------------------------
>> > Linux version 2.6.23xlnx (meyer@tiv007) (gcc version 3.4.5) #1 Thu Jul
>> 17
>> > 12:10:27 CEST 2008
>> > Xilinx Generic PowerPC board support package (Xilinx XUPV2P) (Virtex-I=
I
>> > Pro)
>> > Zone PFN ranges:
>> >   DMA             0 ->    65536
>> >   Normal      65536 ->    65536
>> > Movable zone start PFN for each node
>> > early_node_map[1] active PFN ranges
>> >     0:        0 ->    65536
>> > Built 1 zonelists in Zone order.  Total pages: 65024
>> > Kernel command line: console=3DttyUL0 root=3D/dev/xsa2 rw
>> > Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
>> > PID hash table entries: 1024 (order: 10, 4096 bytes)
>> > Console: colour dummy device 80x25
>> > Console: Xilinx UART Lite
>> > Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>> > Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>> > Memory: 257664k available (1580k kernel code, 500k data, 96k init, 0k
>> > highmem)
>> > Mount-cache hash table entries: 512
>> > NET: Registered protocol family 16
>> > Registering device uartlite:0
>> > Registering device xsysace:0
>> > Registering device xilinx_emac:0
>> > NET: Registered protocol family 2
>> > IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
>> > TCP established hash table entries: 8192 (order: 4, 65536 bytes)
>> > TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
>> > TCP: Hash tables configured (established 8192 bind 8192)
>> > TCP reno registered
>> > io scheduler noop registered
>> > io scheduler anticipatory registered (default)
>> > io scheduler deadline registered
>> > io scheduler cfq registered
>> > uartlite.0: ttyUL0 at MMIO 0x40600003 (irq =3D 3) is a uartlite
>> > console [ttyUL0] enabled
>> > RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
>> > System ACE at 0x41800000 mapped to 0xD1020000, irq=3D1, 500472KB
>> >  xsa: xsa1 xsa2
>> > tun: Universal TUN/TAP device driver, 1.6
>> > tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
>> > xilinx_emac xilinx_emac.0: MAC address is now  2: 0: 0: 0: 0: 0
>> > XEmac: using fifo mode.
>> > XEmac: Detected PHY at address 0, ManufID 0x0013, Rev. 0x78e2.
>> > eth0: Dropping NETIF_F_SG since no checksum feature.
>> > eth0: Xilinx 10/100 EMAC at 0x80400000 mapped to 0xD1040000, irq=3D2
>> > eth0: XEmac id 1.1a, block id 32, type 1
>> > mice: PS/2 mouse device common for all mice
>> > TCP cubic registered
>> > NET: Registered protocol family 1
>> > NET: Registered protocol family 17
>> > kjournald starting.  Commit interval 5 seconds
>> > EXT3-fs warning: maximal mount count reached, running e2fsck is
>> > recommended
>> > EXT3 FS on xsa2, internal journal
>> > EXT3-fs: recovery complete.
>> > EXT3-fs: mounted filesystem with ordered data mode.
>> > VFS: Mounted root (ext3 filesystem).
>> > Freeing unused kernel memory: 96k init
>> > INIT: version 2.85 booting
>> >                 Welcome to DENX Embedded Linux Environment
>> >                 Press 'I' to enter interactive startup.
>> > Building the cache [  OK  ]
>> >  storage network audio done[  OK  ]
>> > Cannot access the Hardware Clock via any known method.
>> > Use the --debug option to see the details of our search for an access
>> > method.
>> > Setting clock : Thu Jan  1 00:00:20 UTC 1970 [  OK  ]
>> > Setting hostname localhost:  [  OK  ]
>> > Checking filesystems
>> > Checking all file systems.
>> > [  OK  ]
>> > Mounting local filesystems:  [  OK  ]
>> > Enabling swap space:  [  OK  ]
>> > INIT: Entering runlevel: 3
>> > Entering non-interactive startup
>> > Bringing up loopback interface:  [  OK  ]
>> > Starting system logger: [  OK  ]
>> > Starting kernel logger: [  OK  ]
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > XSysAce: Queue is plugged
>> > Starting portmap: [  OK  ]
>> > Mounting NFS filesystems:  XSysAce: Queue is plugged
>> > [  OK  ]
>> > XSysAce: Queue is plugged
>> > Mounting other filesystems:  [  OK  ]
>> >=20
>> > DENX ELDK version 4.1 build 2007-01-19
>> > Linux 2.6.23xlnx on a ppc
>> >=20
>> > localhost login:
>> >=20
>> >=20
>> >=20
>> >=20
>> >=20
>> > Thanks and Greez
>> > Joachim
>> >
>> ________________________________________________________________________=
_
>> > In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und
>> gestalten!=20
>> > Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=3D021114
>> >=20
>> > _______________________________________________
>> > Linuxppc-embedded mailing list
>> > Linuxppc-embedded@ozlabs.org
>> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> >=20
>> >=20
>>=20
>> --=20
>> View this message in context:
>> http://www.nabble.com/use-xilinx-gpio-from-linux-on-a-ppc405-tp18507061p=
21010485.html
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>=20
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/use-xilinx-gpio-from-li=
nux-on-a-ppc405-tp18507061p21012378.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
