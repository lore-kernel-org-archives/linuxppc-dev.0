Return-Path: <matias.sundman@ericsson.com>
Received: from mailgw4.ericsson.se (mailgw4.ericsson.se [193.180.251.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CBD9DDFED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 00:43:12 +1100 (EST)
Received: from mailgw4.ericsson.se (unknown [127.0.0.1])
	by mailgw4.ericsson.se (Symantec Mail Security) with ESMTP id
	D9AC720566 for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 14:43:06 +0100 (CET)
Received: from esealmw129.eemea.ericsson.se (unknown [153.88.254.124])
	by mailgw4.ericsson.se (Symantec Mail Security) with ESMTP id
	BF86F2103A for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 14:43:06 +0100 (CET)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C76BBE.DA8CF8C7"
Subject: RE: Ramdisk : Linux 2.6 : U-boot :: RAMDISK: incomplete write (-28 !=
	32768) 52428800
Date: Wed, 21 Mar 2007 14:43:05 +0100
Message-ID: <AEA1A32F001C6B4F98614B5B80D7647D0180DC84@esealmw115.eemea.ericsson.se>
From: "Matias Sundman \(AS/EAB\)" <matias.sundman@ericsson.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76BBE.DA8CF8C7
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Guys,
I just realized what I did wrong ;

When making the ramdisk ;
:
:
dd if=3D/dev/zero of=3Dramdisk bs=3D1k count=3D500000
:
:
I should use count 50000 instead of 500000.

:-))

Thx // M

> _____________________________________________=20
> From: 	Matias Sundman (AS/EAB) =20
> Sent:	den 21 mars 2007 14:08
> To:	'linuxppc-embedded@ozlabs.org'
> Subject:	Ramdisk : Linux 2.6 : U-boot :: RAMDISK: incomplete
> write (-28 !=3D 32768) 52428800
>=20
> Hello,
> I am trying to get a U-boot multi-image to function properly for my
> custom board.
> I've had it working with the 2.4 kernel but having problems with 2.6.
>=20
> Here is what I get;
> ----------------------------------------------------------------------
> -------------------------------
>                         [U-boot] Platform Initialized ,
>                         handing over control to [Linux]
> Linux version 2.6.14.7 (matias@schizo) (gcc version 3.4.4 ) #11 Wed
> Mar 21 13:41:22 CET 2007
> Ericsson, MXB4 port
> Using IDMA1 for MPC8260 device erratum PCI 9 workaround
> SIUMCR is value =3D 5200000
> arch/ppc/syslib/m82xx_pci.c: The PCI bus is 50 Mhz.
> Waiting 0.5 seconds after deasserting RST...
> Built 1 zonelists
> Kernel command line: mem=3D0x0F000000 root=3D/dev/ram
> ip=3D$ipaddr:$serverip:$gatewayi
> p:$netmask:$hostname:eth0:off console=3DttyCPM0,115200
> PID hash table entries: 1024 (order: 10, 16384 bytes)
> Warning: real time clock seems stuck!
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 216576k available (1864k kernel code, 580k data, 108k init, 0k
> highmem)
> Security Framework v1.0.0 initialized
> Capability LSM initialized
> Mount-cache hash table entries: 512
> checking if image is initramfs...it isn't (no cpio magic); looks like
> an initrd
> softlockup thread 0 started up.
> Freeing initrd memory: 24153k freed
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> PCI: Cannot allocate resource region 0 of device 0000:00:00.0
> PCI: Cannot allocate resource region 1 of device 0000:00:00.0
> PCI: Cannot allocate resource region 0 of device 0000:00:0e.0
> PCI: Cannot allocate resource region 0 of device 0000:00:0f.0
> PCI: Cannot allocate resource region 0 of device 0000:00:10.0
> Registering GDB sysrq handler
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> Initializing Cryptographic API
> Serial: CPM driver $Revision: 0.01 $
> ttyCPM0 at MMIO map 0xf0011a00 mem 0x0 (irq =3D 40) is a CPM UART
> ttyCPM1 at MMIO map 0xf0011a20 mem 0x0 (irq =3D 41) is a CPM UART
> ttyCPM2 at MMIO map 0xf0011a40 mem 0x0 (irq =3D 42) is a CPM UART
> ttyCPM3 at MMIO map 0xf0011a60 mem 0x0 (irq =3D 43) is a CPM UART
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 1 RAM disks of 51200K size 1024 blocksize
> loop: loaded (max 8 devices)
> physmap flash device: 2000000 at fe000000
> phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> phys_mapped_flash: CFI does not contain boot bank location. Assuming
> top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code
> brokenness.
> cmdlinepart partition parsing not available
> RedBoot partition parsing not available
> mtd: Giving out device 0 to phys_mapped_flash
> i2c /dev entries driver
> eth0: FCC ENET Version 0.3, 00:01:ec:b4:07:e6
> eth0: Phy @ 0x0, type XXB-BCM (0x00406322)
> eth1: FCC ENET Version 0.3, 00:01:ec:f4:07:e6
> eth1: Phy @ 0x1, type XXB-BCM (0x00406322)
> eth2: FCC ENET Version 0.3, 00:01:ec:b4:07:e6
> eth2: Phy @ 0x2, type XXB-BCM (0x00406322)
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> ip_tables: (C) 2000-2002 Netfilter core team
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
> IP-Config: Unable to set interface netmask (-22).
> RAMDISK: Compressed image found at block 0
> RAMDISK: incomplete write (-28 !=3D 32768) 52428800
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 108k init
> attempt to access beyond end of device
> ram0: rw=3D0, want=3D622600, limit=3D102400
> EXT2-fs error (device ram0): ext2_get_inode: unable to read inode
> block - inode=3D
> 78129, block=3D311299
> Warning: unable to open an initial console.
> attempt to access beyond end of device
> ram0: rw=3D0, want=3D688136, limit=3D102400
> EXT2-fs error (device ram0): ext2_get_inode: unable to read inode
> block - inode=3D
> 86353, block=3D344067
> attempt to access beyond end of device
> ram0: rw=3D0, want=3D311304, limit=3D102400
> EXT2-fs error (device ram0): ext2_get_inode: unable to read inode
> block - inode=3D
> 39065, block=3D155651
> attempt to access beyond end of device
> ram0: rw=3D0, want=3D589832, limit=3D102400
> EXT2-fs error (device ram0): ext2_get_inode: unable to read inode
> block - inode=3D
> 74017, block=3D294915
> Kernel panic - not syncing: No init found.  Try passing init=3D option
> to kernel.
>  <0>Rebooting in 180 seconds..=20
> ----------------------------------------------------------------------
> -------------------------------
>=20
> This is the way I build the Multi-Image;
>=20
> #!/bin/bash
> clear
> echo 'Producing Multi Image File'
> echo 'You are root RIGHT?!'
> dd if=3D/dev/zero of=3Dramdisk bs=3D1k count=3D500000
> mke2fs -F -v -m0 ramdisk
> mount -o loop ramdisk /mnt/initrd2/
> cp -a /tftpboot/rootfs_mxb4_1/* /mnt/initrd2/
> umount /mnt/initrd2
> gzip -9 ramdisk
> echo 'Name of the MultiImage: '
> read name
> mkimage -n $name -A ppc -O linux -T multi -C gzip -d
> vmlinux.gz:ramdisk.gz $name
> echo 'Well, we are kinda done'
> ----------------------------------------------------------------------
> -------------------------------
>=20
> I configured the Kernel to have 1 ramdisk with the size of 50M ,
> however I tried various combinations
> of 16 Ramdisk and 4M and 8M .. nothing seems to work for me today ...
>=20
> Happy for any tips to point me in the right direction.
>=20
> Cheers // Matias
>=20

------_=_NextPart_001_01C76BBE.DA8CF8C7
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: Ramdisk : Linux 2.6 : U-boot :: RAMDISK: incomplete write =
(-28 !=3D 32768) 52428800</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">Hi =
Guys,</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">I just =
realized what I did wrong ;</FONT>
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">When making =
the ramdisk ;</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">:</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">:</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">dd =
if=3D/dev/zero of=3Dramdisk bs=3D1k count=3D500000</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">:</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">:</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">I should use =
count 50000 instead of 500000.</FONT>
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">:-))</FONT>
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Comic Sans MS">Thx // =
M</FONT>
</P>

<P><FONT SIZE=3D1 =
FACE=3D"Tahoma">_____________________________________________ </FONT>

<BR><B><FONT SIZE=3D1 FACE=3D"Tahoma">From: &nbsp;</FONT></B> <FONT =
SIZE=3D1 FACE=3D"Tahoma">Matias Sundman (AS/EAB)&nbsp; </FONT>

<BR><B><FONT SIZE=3D1 FACE=3D"Tahoma">Sent:&nbsp;&nbsp;</FONT></B> <FONT =
SIZE=3D1 FACE=3D"Tahoma">den 21 mars 2007 14:08</FONT>

<BR><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">To:&nbsp;&nbsp;&nbsp;&nbsp;</FONT></B> <FONT SIZE=3D1 =
FACE=3D"Tahoma">'linuxppc-embedded@ozlabs.org'</FONT>

<BR><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>=
</B> <FONT SIZE=3D1 FACE=3D"Tahoma">Ramdisk : Linux 2.6 : U-boot :: =
RAMDISK: incomplete write (-28 !=3D 32768) 52428800</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Hello,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">I am trying to get a U-boot =
multi-image to function properly for my custom board.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">I've had it working with the =
2.4 kernel but having problems with 2.6.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Here is what I get;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans =
MS">---------------------------------------------------------------------=
--------------------------------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans =
MS">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
[U-boot] Platform Initialized ,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans =
MS">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
handing over control to [Linux]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Linux version 2.6.14.7 =
(matias@schizo) (gcc version 3.4.4 ) #11 Wed Mar 21 13:41:22 CET =
2007</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Ericsson, MXB4 port</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Using IDMA1 for MPC8260 device =
erratum PCI 9 workaround</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">SIUMCR is value =3D =
5200000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">arch/ppc/syslib/m82xx_pci.c: =
The PCI bus is 50 Mhz.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Waiting 0.5 seconds after =
deasserting RST...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Built 1 zonelists</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Kernel command line: =
mem=3D0x0F000000 root=3D/dev/ram ip=3D$ipaddr:$serverip:$gatewayi</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">p:$netmask:$hostname:eth0:off =
console=3DttyCPM0,115200</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">PID hash table entries: 1024 =
(order: 10, 16384 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Warning: real time clock seems =
stuck!</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Console: colour dummy device =
80x25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Dentry cache hash table =
entries: 32768 (order: 5, 131072 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Inode-cache hash table =
entries: 16384 (order: 4, 65536 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Memory: 216576k available =
(1864k kernel code, 580k data, 108k init, 0k highmem)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Security Framework v1.0.0 =
initialized</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Capability LSM =
initialized</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Mount-cache hash table =
entries: 512</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">checking if image is =
initramfs...it isn't (no cpio magic); looks like an initrd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">softlockup thread 0 started =
up.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Freeing initrd memory: 24153k =
freed</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">NET: Registered protocol =
family 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">PCI: Probing PCI =
hardware</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">PCI: Cannot allocate resource =
region 0 of device 0000:00:00.0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">PCI: Cannot allocate resource =
region 1 of device 0000:00:00.0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">PCI: Cannot allocate resource =
region 0 of device 0000:00:0e.0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">PCI: Cannot allocate resource =
region 0 of device 0000:00:0f.0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">PCI: Cannot allocate resource =
region 0 of device 0000:00:10.0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Registering GDB sysrq =
handler</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">JFFS2 version 2.2. (NAND) (C) =
2001-2003 Red Hat, Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Initializing Cryptographic =
API</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Serial: CPM driver $Revision: =
0.01 $</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ttyCPM0 at MMIO map 0xf0011a00 =
mem 0x0 (irq =3D 40) is a CPM UART</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ttyCPM1 at MMIO map 0xf0011a20 =
mem 0x0 (irq =3D 41) is a CPM UART</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ttyCPM2 at MMIO map 0xf0011a40 =
mem 0x0 (irq =3D 42) is a CPM UART</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ttyCPM3 at MMIO map 0xf0011a60 =
mem 0x0 (irq =3D 43) is a CPM UART</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">io scheduler noop =
registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">io scheduler anticipatory =
registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">io scheduler deadline =
registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">io scheduler cfq =
registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">RAMDISK driver initialized: 1 =
RAM disks of 51200K size 1024 blocksize</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">loop: loaded (max 8 =
devices)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">physmap flash device: 2000000 =
at fe000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">phys_mapped_flash: Found 1 x16 =
devices at 0x0 in 16-bit bank</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">&nbsp;Amd/Fujitsu Extended =
Query Table at 0x0040</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">phys_mapped_flash: CFI does =
not contain boot bank location. Assuming top.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">number of CFI chips: 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">cfi_cmdset_0002: Disabling =
erase-suspend-program due to code brokenness.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">cmdlinepart partition parsing =
not available</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">RedBoot partition parsing not =
available</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">mtd: Giving out device 0 to =
phys_mapped_flash</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">i2c /dev entries driver</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">eth0: FCC ENET Version 0.3, =
00:01:ec:b4:07:e6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">eth0: Phy @ 0x0, type XXB-BCM =
(0x00406322)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">eth1: FCC ENET Version 0.3, =
00:01:ec:f4:07:e6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">eth1: Phy @ 0x1, type XXB-BCM =
(0x00406322)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">eth2: FCC ENET Version 0.3, =
00:01:ec:b4:07:e6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">eth2: Phy @ 0x2, type XXB-BCM =
(0x00406322)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">NET: Registered protocol =
family 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">IP route cache hash table =
entries: 2048 (order: 1, 8192 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">TCP established hash table =
entries: 8192 (order: 3, 32768 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">TCP bind hash table entries: =
8192 (order: 3, 32768 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">TCP: Hash tables configured =
(established 8192 bind 8192)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">TCP reno registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ip_tables: (C) 2000-2002 =
Netfilter core team</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">TCP bic registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">NET: Registered protocol =
family 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">NET: Registered protocol =
family 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">802.1Q VLAN Support v1.8 Ben =
Greear &lt;greearb@candelatech.com&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">All bugs added by David S. =
Miller &lt;davem@redhat.com&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">eth0: config: auto-negotiation =
on, 100FDX, 100HDX, 10FDX, 10HDX.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">IP-Config: Unable to set =
interface netmask (-22).</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">RAMDISK: Compressed image =
found at block 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">RAMDISK: incomplete write (-28 =
!=3D 32768) 52428800</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">VFS: Mounted root (ext2 =
filesystem) readonly.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Freeing unused kernel memory: =
108k init</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">attempt to access beyond end =
of device</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ram0: rw=3D0, want=3D622600, =
limit=3D102400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">EXT2-fs error (device ram0): =
ext2_get_inode: unable to read inode block - inode=3D</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">78129, block=3D311299</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Warning: unable to open an =
initial console.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">attempt to access beyond end =
of device</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ram0: rw=3D0, want=3D688136, =
limit=3D102400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">EXT2-fs error (device ram0): =
ext2_get_inode: unable to read inode block - inode=3D</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">86353, block=3D344067</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">attempt to access beyond end =
of device</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ram0: rw=3D0, want=3D311304, =
limit=3D102400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">EXT2-fs error (device ram0): =
ext2_get_inode: unable to read inode block - inode=3D</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">39065, block=3D155651</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">attempt to access beyond end =
of device</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ram0: rw=3D0, want=3D589832, =
limit=3D102400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">EXT2-fs error (device ram0): =
ext2_get_inode: unable to read inode block - inode=3D</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">74017, block=3D294915</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Kernel panic - not syncing: No =
init found.&nbsp; Try passing init=3D option to kernel.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">&nbsp;&lt;0&gt;Rebooting in =
180 seconds.. </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans =
MS">---------------------------------------------------------------------=
--------------------------------</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">This is the way I build the =
Multi-Image;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">#!/bin/bash</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">clear</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">echo 'Producing Multi Image =
File'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">echo 'You are root =
RIGHT?!'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">dd if=3D/dev/zero of=3Dramdisk =
bs=3D1k count=3D500000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">mke2fs -F -v -m0 =
ramdisk</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">mount -o loop ramdisk =
/mnt/initrd2/</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">cp -a =
/tftpboot/rootfs_mxb4_1/* /mnt/initrd2/</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">umount /mnt/initrd2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">gzip -9 ramdisk</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">echo 'Name of the MultiImage: =
'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">read name</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">mkimage -n $name -A ppc -O =
linux -T multi -C gzip -d vmlinux.gz:ramdisk.gz $name</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">echo 'Well, we are kinda =
done'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans =
MS">---------------------------------------------------------------------=
--------------------------------</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">I configured the Kernel to have =
1 ramdisk with the size of 50M , however I tried various =
combinations</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">of 16 Ramdisk and 4M and 8M .. =
nothing seems to work for me today ...</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Happy for any tips to point me =
in the right direction.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Cheers // Matias</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C76BBE.DA8CF8C7--
