Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 8BD3BDDFCE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 23:24:44 +1000 (EST)
Date: Fri, 19 Sep 2008 15:24:36 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] [MPC52XX] Trivial: printk-fixes in mpc52xx_common
Message-ID: <20080919132436.GF4307@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


 - one printk was missing a loglevel
 - remove double space while we are here

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
+++ arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -90,7 +90,7 @@
 	of_node_put(np);
 	if (!xlb) {
 		printk(KERN_ERR __FILE__ ": "
-			"Error mapping XLB in mpc52xx_setup_cpu().  "
+			"Error mapping XLB in mpc52xx_setup_cpu(). "
 			"Expect some abnormal behavior\n");
 		return;
 	}
@@ -216,7 +216,8 @@
 		out_be32(&mpc52xx_wdt->count, 0x000000ff);
 		out_be32(&mpc52xx_wdt->mode, 0x00009004);
 	} else
-		printk("mpc52xx_restart: Can't access wdt. "
+		printk(KERN_ERR __FILE__ ": "
+			"mpc52xx_restart: Can't access wdt. "
 			"Restart impossible, system halted.\n");
=20
 	while (1);
--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI06gUD27XaX1/VRsRAk05AJ48EeHJ/n40hhm1Py48ZzXquBECpgCgvS4m
JJ1ykQ2k1/8G587nqR/A/UU=
=LwXV
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
