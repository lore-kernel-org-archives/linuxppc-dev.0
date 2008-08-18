Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7A1A4DDF13
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Aug 2008 19:31:40 +1000 (EST)
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71] ident=Debian-exim)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <wsa@pengutronix.de>) id 1KV15J-0005ff-1V
	for linuxppc-embedded@ozlabs.org; Mon, 18 Aug 2008 11:31:33 +0200
Received: from wsa by leda.ptxnet.pengutronix.de with local (Exim 4.67)
	(envelope-from <wsa@pengutronix.de>) id 1KV15I-0007cG-7g
	for linuxppc-embedded@ozlabs.org; Mon, 18 Aug 2008 11:31:32 +0200
Date: Mon, 18 Aug 2008 11:31:32 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] MPC52XX: Don't touch pipelining for MPC5200B
Message-ID: <20080818093132.GA4282@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


MPC5200 needs to have pipelining disabled for ATA to work. MPC5200B does no=
t.
So, for the latter, don't touch the original setting from the bootloader.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

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

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: playground/arch/powerpc/platforms/52xx/mpc52xx_common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- playground.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ playground/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -99,12 +99,13 @@
 	out_be32(&xlb->master_pri_enable, 0xff);
 	out_be32(&xlb->master_priority, 0x11111111);
=20
+#if defined(CONFIG_PPC_MPC5200_BUGFIX)
 	/* Disable XLB pipelining
 	 * (cfr errate 292. We could do this only just before ATA PIO
 	 *  transaction and re-enable it afterwards ...)
 	 */
 	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
-
+#endif
 	iounmap(xlb);
 }
=20
--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIqUF0D27XaX1/VRsRAqpjAJoDrylqprfbrVNWVMDTPpIEM+8f8gCfbrpR
33RzhpS3GycSMsEkRSoLFWQ=
=Vc6b
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
