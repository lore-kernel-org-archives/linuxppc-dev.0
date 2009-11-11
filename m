Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 6C7FDB7067
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 20:48:59 +1100 (EST)
Date: Wed, 11 Nov 2009 10:48:38 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 1/3] mpc52xx_spi: fix clearing status register
Message-ID: <20091111094838.GA4234@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
	<1257844329-20687-2-git-send-email-l.fu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1257844329-20687-2-git-send-email-l.fu@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2009 at 10:12:07AM +0100, Luotao Fu wrote:
> Before reading status register to check MODF failure, we have to clear it
> first since the MODF flag will be set after initializing the spi master,
> if the hardware comes up with a low SS. The processor datasheet reads:
> Mode Fault flag -- bit sets if SS input goes low while SPI is configured =
as a
> master. Flag is cleared automatically by an SPI status register read (wit=
h MODF
> set) followed by a SPI control register 1 write.
> Hence simply rereading the register is not sufficient to clear the flag. =
We
> redo the write also to make sure to clear the flag.
>=20
> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>

Nit below, otherwise:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  drivers/spi/mpc52xx_spi.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
> index ef8379b..5b036f2 100644
> --- a/drivers/spi/mpc52xx_spi.c
> +++ b/drivers/spi/mpc52xx_spi.c
> @@ -391,6 +391,7 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  	struct mpc52xx_spi *ms;
>  	void __iomem *regs;
>  	int rc;
> +	int ctrl1;

u8?

> =20
>  	/* MMIO registers */
>  	dev_dbg(&op->dev, "probing mpc5200 SPI device\n");
> @@ -399,7 +400,8 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  		return -ENODEV;
> =20

Sidenote to all: It was tested that simply moving the read here will not su=
ffice.

>  	/* initialize the device */
> -	out_8(regs+SPI_CTRL1, SPI_CTRL1_SPIE | SPI_CTRL1_SPE | SPI_CTRL1_MSTR);
> +	ctrl1 =3D SPI_CTRL1_SPIE | SPI_CTRL1_SPE | SPI_CTRL1_MSTR;
> +	out_8(regs + SPI_CTRL1, ctrl1);
>  	out_8(regs + SPI_CTRL2, 0x0);
>  	out_8(regs + SPI_DATADIR, 0xe);	/* Set output pins */
>  	out_8(regs + SPI_PORTDATA, 0x8);	/* Deassert /SS signal */
> @@ -409,6 +411,8 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  	 * on the SPI bus.  This fault will also occur if the SPI signals
>  	 * are not connected to any pins (port_config setting) */
>  	in_8(regs + SPI_STATUS);
> +	out_8(regs + SPI_CTRL1, ctrl1);
> +
>  	in_8(regs + SPI_DATA);
>  	if (in_8(regs + SPI_STATUS) & SPI_STATUS_MODF) {
>  		dev_err(&op->dev, "mode fault; is port_config correct?\n");
> --=20
> 1.6.5.2
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr6iHYACgkQD27XaX1/VRuEsQCgs+LtiJ7K5kZTTSyaEcqiRCcd
MfEAn0dtprc8/tnGqncujzi5EXHPlCp9
=rlLX
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
