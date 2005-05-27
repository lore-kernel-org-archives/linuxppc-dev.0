Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id 1BF63679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 01:48:09 +1000 (EST)
Received: from filter03.roc.ny.frontiernet.net
	(filter03.roc.ny.frontiernet.net [66.133.183.70])
	by relay01.roc.ny.frontiernet.net (Postfix) with ESMTP id BA3A536610C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 15:48:07 +0000 (UTC)
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164])
	by filter03.roc.ny.frontiernet.net (filter03.roc.ny.frontiernet.net
	[66.133.183.70]) (amavisd-new, port 10024)
	with LMTP id 19324-11-37 for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 15:48:07 +0000 (UTC)
Received: from chuck2 (70-97-124-8.br1.rmn.wv.frontiernet.net [70.97.124.8])
	by relay01.roc.ny.frontiernet.net (Postfix) with ESMTP id 08E77366113
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 15:48:02 +0000 (UTC)
Message-ID: <004101c562d3$8dc5a910$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <20050520141244.GD24923@logos.cnet><e503cf4ab6d2d389b29474561048f2f2@embeddededge.com><20050520175152.GB26221@logos.cnet><5d184282e7d324fb009b8dcf6e6f967d@embeddededge.com>
	<20050521222713.GA28813@logos.cnet>
Date: Fri, 27 May 2005 11:48:34 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003E_01C562B2.0322F310"
Subject: [PATCH] PSC with devfs on 5200
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

------=_NextPart_000_003E_01C562B2.0322F310
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The attached patch allows the PSC ports on the MPC5200 to work with the
devfs file system.

I've never posted a patch before, somebody let me know if I should do
anything differently.

Mark Chambers

------=_NextPart_000_003E_01C562B2.0322F310
Content-Type: application/octet-stream;
	name="psc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="psc.patch"

--- arch/ppc/5xxx_io/psc.c	2005-05-27 11:09:36.000000000 -0400=0A=
+++ /opt/eldk/ppc_82xx/usr/src/linux-2.4.24/arch/ppc/5xxx_io/psc.c	=
2003-12-03 14:08:19.000000000 -0500=0A=
@@ -806,11 +806,7 @@=0A=
 	memset(&rs_driver, 0, sizeof(rs_driver));=0A=
 	rs_driver.magic =3D TTY_DRIVER_MAGIC;=0A=
 	rs_driver.driver_name =3D "serial";=0A=
-#ifdef CONFIG_DEVFS_FS=0A=
-	rs_driver.name =3D "tts/%d";=0A=
-#else=0A=
 	rs_driver.name =3D "ttyS";=0A=
-#endif=0A=
 	rs_driver.major =3D TTY_MAJOR;=0A=
 	rs_driver.minor_start =3D 64;=0A=
 	rs_driver.num =3D MPC5xxx_PSC_NPORTS;=0A=
@@ -841,11 +837,7 @@=0A=
 	rs_driver.hangup =3D gs_hangup;=0A=
 =0A=
 	rs_callout_driver =3D rs_driver;=0A=
-#ifdef CONFIG_DEVFS_FS=0A=
-	rs_callout_driver.name =3D "cua/%d";=0A=
-#else=0A=
 	rs_callout_driver.name =3D "cua";=0A=
-#endif=0A=
 	rs_callout_driver.major =3D TTYAUX_MAJOR;=0A=
 	rs_callout_driver.subtype =3D SERIAL_TYPE_CALLOUT;=0A=
 =0A=

------=_NextPart_000_003E_01C562B2.0322F310--
