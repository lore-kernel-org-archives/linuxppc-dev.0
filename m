Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55786DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jan 2008 00:34:30 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JKD57-0001TL-Jd
	for linuxppc-embedded@ozlabs.org; Wed, 30 Jan 2008 05:34:25 -0800
Message-ID: <15182195.post@talk.nabble.com>
Date: Wed, 30 Jan 2008 05:34:25 -0800 (PST)
From: greenlean <jmgomez@atc.ugr.es>
To: linuxppc-embedded@ozlabs.org
Subject: rootfs problem kernel 2.6 XUPV2P
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all, I'm having some problems with the rootfs:

If I use an initial ram disk, such as the initramfs  from ELDK4.1 to build
an zImage.ielf file, I've got this log:
It looks like no image have been loaded!!!  I have supplied a directory,
where I''ve mounted the EDLK ramdisk image, to the kernel and let him to
build the ramdisk (to avoid mistakes):

loaded at:     00400000 006691A0                                           =
    =20
board data at: 00667124 006671A0                                           =
    =20
relocated to:  004040A8 00404124                  <-- I think that here
should be line showing the direction where the                             =
 =20
zimage at:     00404E99 00666C26                         RAMDISK have been
loaded, I've seen it on other boot logs!!!
avail ram:     0066A000 0F424000                                           =
    =20
                                                                           =
    =20
Linux/PPC load: console=3DttyS0,9600 root=3D/dev/ram0 rw                   =
        =20
Uncompressing Linux...done.                                                =
    =20
Now booting the kernel                                                     =
    =20
[    0.000000] Linux version 2.6.23-rc9-dirty (jmgomez@jmgomez-laptop) (gcc
ver8
[    0.000000] Xilinx ML300 Reference System (Virtex-II Pro)               =
    =20
[    0.000000] Zone PFN ranges:                                            =
    =20
[    0.000000]   DMA             0 ->    62500                             =
    =20
[    0.000000]   Normal      62500 ->    62500                             =
    =20
[    0.000000] Movable zone start PFN for each node                        =
    =20
[    0.000000] early_node_map[1] active PFN ranges                         =
    =20
[    0.000000]     0:        0 ->    62500                                 =
    =20
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 62012        =
    =20
[    0.000000] Kernel command line: console=3DttyS0,9600 root=3D/dev/ram0 r=
w       =20
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000           =
    =20
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)        =
    =20
[    0.000349] Console: colour dummy device 80x25                          =
    =20
[    0.004726] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes) =20
[    0.010854] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes=
)   =20
[    0.117251] Memory: 244224k available (1424k kernel code, 480k data,
1640k i)
[    0.304888] Mount-cache hash table entries: 512                         =
    =20
[    0.315611] NET: Registered protocol family 16                          =
    =20
[    0.370262] NET: Registered protocol family 2                           =
    =20
[    0.436663] IP route cache hash table entries: 2048 (order: 1, 8192
bytes)  =20
[    0.438058] TCP established hash table entries: 8192 (order: 4, 65536
bytes)=20
[    0.440252] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)   =
    =20
[    0.441291] TCP: Hash tables configured (established 8192 bind 8192)    =
    =20
[    0.441332] TCP reno registered                                         =
    =20
[    1.545621] io scheduler noop registered                                =
    =20
[    1.545703] io scheduler anticipatory registered (default)              =
    =20
[    1.545740] io scheduler deadline registered                            =
    =20
[    1.545963] io scheduler cfq registered                                 =
    =20
[    1.657974] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharingd
[    1.668865] serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 2) is a 1655=
0A    =20
[    1.670637] console [ttyS0] enabled                                     =
    =20
[    3.764034] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024
bloe
[    3.857351] xsysace xsysace.0: Xilinx SystemACE revision 1.0.12         =
    =20
[    3.929487] xsysace xsysace.0: capacity: 986320 sectors                 =
    =20
[    3.992901]  xsa: unknown partition table                               =
    =20
[    4.049520] tun: Universal TUN/TAP device driver, 1.6                   =
    =20
[    4.110425] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>      =
    =20
[    4.187993] mice: PS/2 mouse device common for all mice                 =
    =20
[    4.251498] TCP cubic registered                                        =
    =20
[    4.290639] NET: Registered protocol family 1                           =
    =20
[    4.343201] NET: Registered protocol family 17                          =
    =20
[    4.400662] VFS: Cannot open root device "ram0" or unknown-block(1,0)   =
    =20
[    4.478329] Please append a correct "root=3D" boot option; here are the
availa:
[    4.578874] fe00     493160 xsa (driver?)                               =
    =20
[    4.627166] Kernel panic - not syncing: VFS: Unable to mount root fs on
unkn)
[    4.726623] Rebooting in 180 seconds..

The ramdisk have not been loaded to memory, or anything similar!!!


//**********************************************************///
Linux/PPC load: console=3DttyS0,9600 root=3D/dev/xsa3 rw           =20

I've also tried to boot from SystemACE but I've got a partition table error
( xsa: unknown partition table ).  I've reformat my CF card for some times,
and nothing have change:


The partition table must be MS-DOS, type 6 on fdisk.

That's the fdisk partition table:
Disco /dev/sdc: 521 MB, 521773056 bytes
17 cabezas, 59 sectores/pistas, 1016 cilindros
Unidades =3D cilindros de 1003 * 512 =3D 513536 bytes
Disk identifier: 0x537c213d

Disposit. Inicio    Comienzo      Fin      Bloques  Id  Sistema
/dev/sdc1               1         300      150420+   6  FAT16
/dev/sdc2             301         418       59177   82  Linux swap / Solari=
s
/dev/sdc3             419        1016      299897   83  Linux


0x1B0: 00 00 00 00 00 00 00 00 3D 21 7C 53 00 00 00 01
0x1C0: 01 00 06 10 7B 2B 3B 00 00 00 29 97 04 00 00 00
0x1D0: 41 2C 82 10 7B A1 64 97 04 00 52 CE 01 00 00 00
0x1E0: 41 A2 83 10 FB F7 B6 65 06 00 F2 26 09 00 00 00
0x1F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 AA

That's the dump of my CF Card maybe some one could send me a dump of yours.

One of my tries, after using the CF Card in the XUPV2P, I get this message:=
=20
El dispositivo no contiene una tabla de particiones DOS v=C3=A1lida ni una
etiqueta de disco Sun o SGI o OSF
Building a new DOS disklabel with disk identifier 0x0eb5b431.
Changes will remain in memory only, until you decide to write them.
After that, of course, the previous content won't be recoverable.

Atenci=C3=B3n: el indicador 0x0000 inv=C3=A1lido de la tabla de particiones=
 4 se
corregir=C3=A1 mediante w(rite)

But It didn't repeat anymore.. So I suppose that the CF card isn't valid fo=
r
the SystemAce of the board!! But I don't know why??

I don't know what is the problem, if anyone knows, reply please=20

Thanx

PD: Sorry for writing so large messages but I've included all the info I've
recover..
--=20
View this message in context: http://www.nabble.com/rootfs-problem-kernel-2=
.6-XUPV2P-tp15182195p15182195.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
