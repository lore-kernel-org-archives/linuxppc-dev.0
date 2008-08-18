Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id E154DDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 00:18:37 +1000 (EST)
Date: Mon, 18 Aug 2008 16:18:31 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V2] MPC52XX: Don't touch pipelining for MPC5200B
Message-ID: <20080818141831.GD4282@pengutronix.de>
References: <20080818093132.GA4282@pengutronix.de>
	<200808181249.37220.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
In-Reply-To: <200808181249.37220.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


MPC5200 needs to have pipelining disabled for ATA to work. MPC5200B does no=
t.
So, for the latter, don't touch the original setting from the bootloader.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
Hello Arnd,

On Mon, Aug 18, 2008 at 12:49:36PM +0200, Arnd Bergmann wrote:

> Please make this a run-time conditional instead of compile-time.
Like this?

=2E.................................................................

This needs some testing IMHO. Most configs in U-Boot tend to enable pipelin=
ing,
which then used to be disabled by the kernel. So, on the one hand, this cha=
nge
would enable what is originally wanted; on the other hand, systems may run
under a new configuration and need to be checked for regressions. Especiall=
y as
there can be puzzling effects, like for one setup here, FEC only works reli=
ably
with pipelining enabled.

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
+++ arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -99,11 +99,14 @@
 	out_be32(&xlb->master_pri_enable, 0xff);
 	out_be32(&xlb->master_priority, 0x11111111);
=20
-	/* Disable XLB pipelining
+	/*
+	 * Disable XLB pipelining
 	 * (cfr errate 292. We could do this only just before ATA PIO
 	 *  transaction and re-enable it afterwards ...)
+	 * Not needed on MPC5200B.
 	 */
-	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
+	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) =3D=3D MPC5200_SVR)
+		out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
=20
 	iounmap(xlb);
 }

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIqYS3D27XaX1/VRsRAocpAKCsV7Fb6dMddDhtLzF7CeB47KE1twCgrwBM
k4T4Ly+DmB/kKxMnkSs4iaI=
=8e2S
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
