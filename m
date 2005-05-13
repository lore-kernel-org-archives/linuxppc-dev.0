Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 26080679FF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 May 2005 01:39:12 +1000 (EST)
Message-ID: <4284CA1A.5@anagramm.de>
Date: Fri, 13 May 2005 17:39:06 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>,
	linuxppc-dev@ozlabs.org
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2A@exnet.3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2A@exnet.3il.fr>
Content-Type: multipart/mixed; boundary="------------060704000806080906070300"
Subject: Re: eth0: PHY id 0x00221619 is not supported! HELP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060704000806080906070300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi, Garcia!

Well, it's usually not a big deal to add your phyid to the driver.
Maybe some generic support is sufficient for your needs.
Check the datasheet of your Board and the PHY.
When you are sure you use an unsupported PHY, read the *phy.c of
your driver and add it. YMMV

Just FYI, I attached a (quick and dirty) patch to add an Intel LXT971 PHY=
 to
the gianfar driver. The LXT981 is a 100Mbit PHY on the gigabit capable TS=
EC
of a mpc8540 cpu.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

Garcia J=E9r=E9mie wrote:
> Hi everybody,
> We are developping a custom board which uses a ppc405EP and on which on=
e we'd like to load a linux hardhat.
> During the boot process, we're getting error messages about the etherne=
t PHY. That is really annoying cause we plan to moubnt the file system vi=
a nfs. So no ethernet no NFS...
> Could someone give us a tip and tell us if the messages displayed befor=
e seem to be normal cause we had to modify some part of the kernel in ord=
er to get Linux booting.
> What those ethernet messages mean? Everythin seems to happen in the "ib=
m_ocp_enet.c" eand "ibm_ocp_phy.c" filesPlease help....
> So here we go ---->>>>>>>>>
>=20
> Linux/PPC load: console=3DttyS0,19200 root=3D/dev/nfs rw ip=3Don
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.4.20_mvl31-405ep_eval (root@sop-dhcp-10-16-5-126.amcc.c=
om) (version gcc 3.3.1 (MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #26 =
ven mai 13 5
> AMCC Q80G Board
> On node 0 totalpages: 4096
> zone(0): 4096 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: console=3DttyS0,19200 root=3D/dev/nfs rw ip=3Don
> hr_time_init: arch_to_nsec =3D 10485759, nsec_to_arch =3D 858993476
> Calibrating delay loop... 199.47 BogoMIPS
> Memory: 14416k available (1280k kernel code, 424k data, 64k init, 0k hi=
ghmem)
> Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
> Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> OCP uart ver 1.6.2 init complete
> LSP Revision 1
> ikconfig 0.5 with /proc/ikconfig
> Starting kswapd
> Disabling the Out Of Memory Killer
> JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis Commu=
nications AB.
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
> i2c-proc.o version 2.6.2 (20011118)
> pty: 256 Unix98 ptys configured
> eeprom.o version 2.6.2 (20011118)
> Serial driver version 5.05c (2001-07-08) with no serial options enabled=

> ttyS00 at 0xef600300 (irq =3D 0) is a 16550A
> ttyS01 at 0xef600400 (irq =3D 1) is a 16550A
> IBM gpio driver version 07.25.02
> GPIO #0 at 0xc207d700
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> eth0: PHY id 0x00221619 is not supported!
> eth0: PHY id 0x00221619 is not supported!
> eth0: No PHY device found.
> removing net dev
> eth0: PHY id 0x00221619 is not supported!
> eth0: PHY id 0x00221619 is not supported!
> eth0: No PHY device found.
> removing net dev
> IBM IIC driver v2.0
> ibm-iic: using compatibility value for OPB freq, fix your board specifi=
c setup
> ibm-iic0: using standard (100 kHz) mode
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMPIP: routing cache hash table of 512 b=
uckets, 4Kbytes
> TCP: Hash tables configured (established 1024 bind 2048)
> IP-Config: No network devices available.
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Root-NFS: No NFS server available, giving up.
> VFS: Unable to mount root fs via NFS, trying floppy.
> kmod: failed to exec /sbin/modprobe -s -k block-major-2, errno =3D 2
> VFS: Cannot open root device "nfs" or 02:00
> Please append a correct "root=3D" boot option
> Kernel panic: VFS: Unable to mount root fs on 02:00
>  <0>Rebooting in 180 seconds..
>=20
>=20
> Tks a lot for your precious help
> Dj=E9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20

--------------060704000806080906070300
Content-Type: text/x-diff;
 name="gianfar.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gianfar.diff"

diff -Nur --exclude-from=exclude-files linux-2.6.11-clean/drivers/net/gianfar.h linux/drivers/net/gianfar.h
--- linux-2.6.11-clean/drivers/net/gianfar.h	2005-03-02 02:38:25.000000000 -0500
+++ linux/drivers/net/gianfar.h	2005-03-04 19:19:43.000000000 -0500
@@ -131,7 +131,9 @@
 #define MACCFG1_SYNCD_TX_EN	0x00000002
 #define MACCFG1_TX_EN		0x00000001
 
-#define MACCFG2_INIT_SETTINGS	0x00007205
+/* #define MACCFG2_INIT_SETTINGS	0x00007205*/
+/* CK--- changed to use MII instead of GMII */
+#define MACCFG2_INIT_SETTINGS	0x00007105
 #define MACCFG2_FULL_DUPLEX	0x00000001
 #define MACCFG2_IF              0x00000300
 #define MACCFG2_MII             0x00000100
diff -Nur --exclude-from=exclude-files linux-2.6.11-clean/drivers/net/gianfar_phy.c linux/drivers/net/gianfar_phy.c
--- linux-2.6.11-clean/drivers/net/gianfar_phy.c	2005-03-02 02:38:09.000000000 -0500
+++ linux/drivers/net/gianfar_phy.c	2005-03-04 18:24:54.000000000 -0500
@@ -580,6 +580,15 @@
 	.config_intr	= &marvell_config_intr,
 };
 
+static struct phy_info phy_info_lxt971 = {
+	.phy_id		= 0x001378e0,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "Intel LXT971",
+	.features	= MII_BASIC_FEATURES,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= genmii_read_status,
+};
+
 static struct phy_info phy_info_genmii= {
 	.phy_id		= 0x00000000,
 	.phy_id_mask	= 0x00000000,
@@ -593,6 +602,7 @@
 	&phy_info_cis820x,
 	&phy_info_marvell,
 	&phy_info_dm9161,
+	&phy_info_lxt971,
 	&phy_info_genmii,
 	NULL
 };

--------------060704000806080906070300--
