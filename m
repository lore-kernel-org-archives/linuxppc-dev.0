Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 327B9B7BFB
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 00:53:26 +1100 (EST)
Date: Mon, 2 Nov 2009 14:53:11 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/mpc52xx: check for invalid PSC usage
Message-ID: <20091102135244.GC4696@pengutronix.de>
References: <1256297157-28246-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910311822i4ba27b2bs350c5684cd57187b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
In-Reply-To: <fa686aa40910311822i4ba27b2bs350c5684cd57187b@mail.gmail.com>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I wouldn't even bother.  It's not actively dangerous to try and use
> PSC{4,5} in SPI mode.  It just not going to work.  Besides, the
> MPC5200 common code already checks for an invalid PSC number when
> setting the clock divisor.
>=20
> Have you seen cases of users trying to do the wrong thing with the
> crippled PSCs?

Yes, that was the reason for this patch :) How about this patch to give use=
rs a
better idea than just -ENODEV via set_psc_clkdiv? ...[/me hacks]...
Uuuh, there is even a bug which makes the case go unnoticed.

=3D=3D=3D

Subject: [PATCH] spi/mpc52xx-psc-spi: check for valid PSC

This driver calls mpc52xx_set_psc_clkdiv() but doesn't check its return val=
ue
to see if the PSC is actually valid for SPI use. Add the check and a hint f=
or
the user.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/mpc52xx_psc_spi.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 1b74d5c..e268437 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -313,11 +313,13 @@ static int mpc52xx_psc_spi_port_config(int psc_id, st=
ruct mpc52xx_psc_spi *mps)
 	struct mpc52xx_psc __iomem *psc =3D mps->psc;
 	struct mpc52xx_psc_fifo __iomem *fifo =3D mps->fifo;
 	u32 mclken_div;
-	int ret =3D 0;
+	int ret;
=20
 	/* default sysclk is 512MHz */
 	mclken_div =3D (mps->sysclk ? mps->sysclk : 512000000) / MCLK;
-	mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
+	ret =3D mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
+	if (ret)
+		return ret;
=20
 	/* Reset the PSC into a known state */
 	out_8(&psc->command, MPC52xx_PSC_RST_RX);
@@ -341,7 +343,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, stru=
ct mpc52xx_psc_spi *mps)
=20
 	mps->bits_per_word =3D 8;
=20
-	return ret;
+	return 0;
 }
=20
 static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
@@ -410,8 +412,10 @@ static int __init mpc52xx_psc_spi_do_probe(struct devi=
ce *dev, u32 regaddr,
 		goto free_master;
=20
 	ret =3D mpc52xx_psc_spi_port_config(master->bus_num, mps);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "can't configure PSC! Is it capable of SPI?\n");
 		goto free_irq;
+	}
=20
 	spin_lock_init(&mps->lock);
 	init_completion(&mps->done);

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkru5EcACgkQD27XaX1/VRvwfwCbBsp3Xw3V8FRDmz3dHvEvJCQy
tdcAn0tsMj3WX7C+DUZBA8p0nQCNXh2Z
=PK+b
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
