Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4F495B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 02:41:00 +1000 (EST)
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id D80F7DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 02:40:58 +1000 (EST)
Date: Mon, 03 Aug 2009 18:40:46 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH] powerpc/mpc52xx/wdt: Fix 5200 wdt always being used as gpt
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1249317654.3404.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-JJACRTMXkePK6HPLaMSf"
Cc: wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-JJACRTMXkePK6HPLaMSf
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the current code, all MPC5200 timers are registered by the =20
mpc52xx_gpt driver, even if gpt0 (the only one with this capability) =20
shall be used as hardware watchdog which is indicated by the =20
"fsl,has-wdt" or "has-wdt" property in the device tree.  Thus, the =20
watchdog driver does never find any watchdog and simply doesn't work.

This trivial patch protects timers with a "(fsl,)?has-wdt" property =20
from being probed as gpt's.  The watchdog timer now works just fine.

Tested on a custom (roughly Icecube based) MPC5200B board, with the =20
5200 watchdog driver built into the kernel.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

---

--- linux-2.6.30.3.orig/arch/powerpc/platforms/52xx/mpc52xx_gpt.c	=20
2009-07-24 23:47:51.000000000 +0200
+++ linux-2.6.30.3/arch/powerpc/platforms/52xx/mpc52xx_gpt.c	=20
2009-08-03 14:20:10.000000000 +0200
@@ -343,6 +343,14 @@
  {
  	struct mpc52xx_gpt_priv *gpt;

+	/* do not grab devices which shall be used as watchdog */
+	if (of_get_property(ofdev->node, "fsl,has-wdt", NULL) ||
+		of_get_property(ofdev->node, "has-wdt", NULL)) {
+		pr_notice("%s: ignore wdt %s\n", __func__,
+			  ofdev->node->full_name);
+		return -ENODEV;
+	}
+
  	gpt =3D kzalloc(sizeof *gpt, GFP_KERNEL);
  	if (!gpt)
  		return -ENOMEM;


--=-JJACRTMXkePK6HPLaMSf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKdxMWn/9unNAn/9ERAnUUAKCknQK9OwWPna+7/N5A/L38bHxEBgCgxOd6
U25XvAEeBHHC3uf4nAk1ntc=
=1VHa
-----END PGP SIGNATURE-----

--=-JJACRTMXkePK6HPLaMSf--
