Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id F1163DDF05
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 08:30:27 +1100 (EST)
Date: Thu, 16 Oct 2008 23:30:21 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [patch 1/2] FEC_MPC52XX_PHY: Remove obsolete code
Message-ID: <20081016213021.GD13629@pengutronix.de>
References: <20080816023159.126377505@pengutronix.de>
	<20080816024055.241009929@pengutronix.de>
	<20081015142855.GE16262@secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
In-Reply-To: <20081015142855.GE16262@secretlab.ca>
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


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2008 at 08:28:55AM -0600, Grant Likely wrote:

> description of what is wrong and why the code needs to be removed.  As
> far as I can tell, this code affects two different IRQ paths.  First is

Ups, you are right! I am sorry that I missed that somehow :( Here is
hopefully a better version, which just skips the really unnecessary
interrupt and fixes a glitch in mdio_remove:

=3D=3D=3D
[MPC52XX] fec_mpc52xx_phy: Minor cleanups

As this driver polls for a complete MDIO transaction, there is no need to e=
nable
interrupts for it. Furthermore, make both checks for freeing MDIO-bus irqs
consistent.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/fec_mpc52xx_phy.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index 08e18bc..3ad3750 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -133,9 +133,6 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of,=
 const struct of_device_i
 	/* set MII speed */
 	out_be32(&priv->regs->mii_speed, ((mpc52xx_find_ipb_freq(of->node) >> 20)=
 / 5) << 1);
=20
-	/* enable MII interrupt */
-	out_be32(&priv->regs->imask, in_be32(&priv->regs->imask) | FEC_IMASK_MII);
-
 	err =3D mdiobus_register(bus);
 	if (err)
 		goto out_unmap;
@@ -167,7 +164,7 @@ static int mpc52xx_fec_mdio_remove(struct of_device *of)
=20
 	iounmap(priv->regs);
 	for (i=3D0; i<PHY_MAX_ADDR; i++)
-		if (bus->irq[i])
+		if (bus->irq[i] !=3D PHY_POLL)
 			irq_dispose_mapping(bus->irq[i]);
 	kfree(priv);
 	kfree(bus->irq);
--=20
1.5.6.5

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3sm0ACgkQD27XaX1/VRutrgCeNUFoABTRVlogYPWfGqZRZV4N
OYIAn1tyXYiAzqLs91xAPJ9JEUC4unbx
=gl2n
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
