Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.e2brain.de [62.159.155.200])
	by ozlabs.org (Postfix) with ESMTP id 49B0967BBD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 19:49:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: pdata->phy_id
Date: Fri, 1 Sep 2006 11:49:10 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E245F@kom-mailsrv1.kontron-modular.com>
In-Reply-To: <20060901085602.GD15795@igloo.df.lth.se>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "Fredrik Roubert" <roubert@df.lth.se>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Frederick,

if your board is somehow similiar to the MPC834x-SYS, but not exactly =
identical, i would copy the file mpc834x_sys.c and .h to .e.g =
mpc8349_mitx.c and .h; add a config option to the Kconfig within this =
directory, and an entry to the Makefile.

Then, you can add all the HW-specific modifications here.

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
=20

-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]
On Behalf Of Fredrik Roubert
Sent: Freitag, 1. September 2006 10:56
To: linuxppc-embedded@ozlabs.org
Subject: pdata->phy_id


Hi!

When running a newer kernel on the MPC8349E-mITX development board, I do
the following changes to mpc834x_sys.c in order to get the PHY working:


diff -urN linux-2.6.17.4.orig/arch/ppc/platforms/83xx/mpc834x_sys.c =
linux-2.6.17.4/arch/ppc/platforms/83xx/mpc834x_sys.c
--- linux-2.6.17.4.orig/arch/ppc/platforms/83xx/mpc834x_sys.c	2006-07-06 =
22:02:28.000000000 +0200
+++ linux-2.6.17.4/arch/ppc/platforms/83xx/mpc834x_sys.c	2006-07-24 =
10:10:36.000000000 +0200
@@ -130,7 +130,7 @@
 	if (pdata) {
 		pdata->board_flags =3D FSL_GIANFAR_BRD_HAS_PHY_INTR;
 		pdata->bus_id =3D 0;
-		pdata->phy_id =3D 0;
+		pdata->phy_id =3D 0x1c;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}

@@ -138,7 +138,7 @@
 	if (pdata) {
 		pdata->board_flags =3D FSL_GIANFAR_BRD_HAS_PHY_INTR;
 		pdata->bus_id =3D 0;
-		pdata->phy_id =3D 1;
+		pdata->phy_id =3D 0x1f;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}


Is this really the best way to do it, or would it be preferable to do it
some other way?

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/
