Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D926567B7F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 18:56:10 +1000 (EST)
Received: from igloo.df.lth.se (localhost [127.0.0.1])
	by df.lth.se (8.13.1/8.13.1) with ESMTP id k818u2W0024438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 1 Sep 2006 10:56:03 +0200 (CEST)
Received: (from roubert@localhost)
	by igloo.df.lth.se (8.13.1/8.13.1/Submit) id k818u2tl024437
	for linuxppc-embedded@ozlabs.org; Fri, 1 Sep 2006 10:56:02 +0200 (CEST)
Date: Fri, 1 Sep 2006 10:56:02 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: linuxppc-embedded@ozlabs.org
Subject: pdata->phy_id
Message-ID: <20060901085602.GD15795@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

When running a newer kernel on the MPC8349E-mITX development board, I do
the following changes to mpc834x_sys.c in order to get the PHY working:


diff -urN linux-2.6.17.4.orig/arch/ppc/platforms/83xx/mpc834x_sys.c linux-2=
.6.17.4/arch/ppc/platforms/83xx/mpc834x_sys.c
--- linux-2.6.17.4.orig/arch/ppc/platforms/83xx/mpc834x_sys.c	2006-07-06 22=
:02:28.000000000 +0200
+++ linux-2.6.17.4/arch/ppc/platforms/83xx/mpc834x_sys.c	2006-07-24 10:10:3=
6.000000000 +0200
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

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRPf1ocRKuLhQMn35AQLaMgP+PtHs1PatY+JU5qYMfLGxgj3DgsjLHyKI
sdMDAEhKqLlhwwcxiVIh5PC2nrApRjMYWzNg1QcPvd+fTbbE0+KTH5m7KCKcJO8c
w5Vhk79S8jnaLxc5i5O5s2/7MgeusKtOmICzyFByt4FBgl9IyRMuY70ve/QrcKcq
GMhgqollUmk=
=Ov8m
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
