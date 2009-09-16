Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CEA73B7B70
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 07:06:49 +1000 (EST)
Date: Wed, 16 Sep 2009 22:48:53 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Dragos Carp <dragos.carp@toptica.com>
Subject: Re: [spi-devel-general] [PATCH] mpc52xx_psc_spi: enlarge clock range
Message-ID: <20090916204853.GA21627@pengutronix.de>
References: <4AB0C706.5020601@toptica.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <4AB0C706.5020601@toptica.com>
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


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

adding powerpc-list and Grant to cc.

On Wed, Sep 16, 2009 at 01:07:50PM +0200, Dragos Carp wrote:
> allow spi clock values bellow 78kbps down to ca. 300bps

Looks like your patch converts the driver from mpc5200 to mpc5200b? If this=
 is
really all which is needed, it should support both versions, I think.

Regards,

   Wolfram

>=20
> Signed-off-by: Dragos Carp <dragos.carp@toptica.com>
> ---
>  mpc52xx_psc_spi.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20

> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
> index 1b74d5c..b15882a 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -78,7 +78,8 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_devi=
ce *spi)
>  	struct mpc52xx_psc_spi *mps =3D spi_master_get_devdata(spi->master);
>  	struct mpc52xx_psc __iomem *psc =3D mps->psc;
>  	u32 sicr;
> -	u16 ccr;
> +	u32 ccr;
> +	u32 bitclkdiv;
> =20
>  	sicr =3D in_be32(&psc->sicr);
> =20
> @@ -98,17 +99,16 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_de=
vice *spi)
>  		sicr &=3D ~0x10000000;
>  	out_be32(&psc->sicr, sicr);
> =20
> -	/* Set clock frequency and bits per word
> -	 * Because psc->ccr is defined as 16bit register instead of 32bit
> -	 * just set the lower byte of BitClkDiv
> -	 */
> -	ccr =3D in_be16((u16 __iomem *)&psc->ccr);
> -	ccr &=3D 0xFF00;
> -	if (cs->speed_hz)
> -		ccr |=3D (MCLK / cs->speed_hz - 1) & 0xFF;
> -	else /* by default SPI Clk 1MHz */
> -		ccr |=3D (MCLK / 1000000 - 1) & 0xFF;
> -	out_be16((u16 __iomem *)&psc->ccr, ccr);
> +	/* Set clock frequency */
> +	bitclkdiv =3D MCLK / (cs->speed_hz ? cs->speed_hz : 1000000) - 1;
> +	bitclkdiv &=3D 0xFFFF;
> +	bitclkdiv |=3D (bitclkdiv & 0xFF) << 16;	/* byte swapped */
> +	bitclkdiv &=3D 0x00FFFF00;
> +	ccr =3D in_be32(&psc->ccr);
> +	ccr &=3D 0xFF0000FF;
> +	ccr |=3D bitclkdiv;
> +	out_be32(&psc->ccr, ccr);
> +=09
>  	mps->bits_per_word =3D cs->bits_per_word;
> =20
>  	if (mps->cs_control)
> @@ -333,7 +333,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, st=
ruct mpc52xx_psc_spi *mps)
>  	/* Configure 8bit codec mode as a SPI master and use EOF flags */
>  	/* SICR_SIM_CODEC8|SICR_GENCLK|SICR_SPI|SICR_MSTR|SICR_USEEOF */
>  	out_be32(&psc->sicr, 0x0180C800);
> -	out_be16((u16 __iomem *)&psc->ccr, 0x070F); /* default SPI Clk 1MHz */
> +	out_be32(&psc->ccr, 0x07130000); /* default SPI Clk 1MHz */
> =20
>  	/* Set 2ms DTL delay */
>  	out_8(&psc->ctur, 0x00);

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqxTzUACgkQD27XaX1/VRt7IQCgrX/gKFuw7O0k/FPZ5Y/hoLZf
hhkAoMtR8i8gRVKrQ2fuXVc7eB8tXnUN
=O5YP
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
