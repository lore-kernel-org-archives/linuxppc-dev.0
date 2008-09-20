Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id CC7E0DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 16:28:01 +1000 (EST)
Date: Sat, 20 Sep 2008 08:27:53 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [MPC52XX] Trivial: printk-fixes in mpc52xx_common
Message-ID: <20080920062753.GA12497@pengutronix.de>
References: <20080919132436.GF4307@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <20080919132436.GF4307@pengutronix.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 - one printk was missing a loglevel
 - remove double space while we are here

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

I'm sorry, accidently sent a -p0-patch before :(

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: playground/arch/powerpc/platforms/52xx/mpc52xx_common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- playground.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ playground/arch/powerpc/platforms/52xx/mpc52xx_common.c
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

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjUl+kACgkQD27XaX1/VRskKwCgj5q/pcmxG8S+gph9FX+nvQTo
ZYoAnRk1AAuySNoBbi0ne1oHq8bitK9X
=lV0I
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
