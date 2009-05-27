Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id C028ADDFCA
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 06:00:43 +1000 (EST)
Received: from antares (xdsl-84-44-237-107.netcologne.de [84.44.237.107])
	by smtp4.netcologne.de (Postfix) with ESMTP id 4715EDA8A1
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 22:00:42 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 24957BA03E
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 22:00:42 +0200 (CEST)
Date: Wed, 27 May 2009 22:00:41 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1243454441.3489.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-ny46ZzImd75iQcwkw341"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-ny46ZzImd75iQcwkw341
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This trivial patch changes memcpy_(to|from)io as to transfer as many =20
32-bit words as possible in 32-bit accesses (in the current solution, =20
the last 32-bit word was transferred as 4 byte accesses).

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
---

diff -urpN -X linux-2.6.29.1.orig/Documentation/dontdiff =20
linux-2.6.29.1.orig/arch/powerpc/kernel/io.c =20
linux-2.6.29.1/arch/powerpc/kernel/io.c
--- linux-2.6.29.1.orig/arch/powerpc/kernel/io.c	2009-04-02 =20
22:55:27.000000000 +0200
+++ linux-2.6.29.1/arch/powerpc/kernel/io.c	2009-05-27 =20
11:36:09.000000000 +0200
@@ -161,7 +161,7 @@ void _memcpy_fromio(void *dest, const vo
  		dest++;
  		n--;
  	}
-	while(n > 4) {
+	while(n >=3D 4) {
  		*((u32 *)dest) =3D *((volatile u32 *)vsrc);
  		eieio();
  		vsrc +=3D 4;
@@ -190,7 +190,7 @@ void _memcpy_toio(volatile void __iomem
  		vdest++;
  		n--;
  	}
-	while(n > 4) {
+	while(n >=3D 4) {
  		*((volatile u32 *)vdest) =3D *((volatile u32 *)src);
  		src +=3D 4;
  		vdest +=3D 4;

--=-ny46ZzImd75iQcwkw341
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKHZvpn/9unNAn/9ERAvUoAJ9sL4yZ52uMplVbGshiNHlOlQ83ggCeNcLB
/Tu50l1AXor/lxSLMwOuAeM=
=drxX
-----END PGP SIGNATURE-----

--=-ny46ZzImd75iQcwkw341--
