Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E3459DDFE5
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 12:35:37 +1000 (EST)
Date: Sat, 24 May 2008 12:35:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC PATCH 2/2] mmc: add OpenFirmware bindings for the mmc_spi
	driver
Message-Id: <20080524123527.04794974.sfr@canb.auug.org.au>
In-Reply-To: <20080523182842.GB469@polina.dev.rtsoft.ru>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<20080523182842.GB469@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__24_May_2008_12_35_27_+1000__xk2Yif9FDYTnlQy"
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__24_May_2008_12_35_27_+1000__xk2Yif9FDYTnlQy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Fri, 23 May 2008 22:28:42 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +++ b/drivers/mmc/host/of_mmc_spi.c

> +static int of_mmc_spi_probe(struct spi_device *spi)

> +	/*
> +	 * mmc_spi_probe will use drvdata, so we can't use it. Use node's
> +	 * data instead.
> +	 */
> +	spi->dev.archdata.of_node->data =3D oms;

If you delay this assignment, you may not have to clean it up in the
error path.

> +	ocr_mask =3D of_get_property(np, "linux,mmc-ocr-mask", &size);

You should really explicitly include linux/of.h to use of_get_property etc

> +int __devexit of_mmc_spi_remove(struct spi_device *spi)
> +{
> +	struct of_mmc_spi *oms =3D spi->dev.archdata.of_node->data;
> +	int ret;
> +
> +	ret =3D mmc_spi_remove(spi);
> +	if (ret)
> +		return ret;

Maybe you should do this last so that you don't leak more than necessary
if mmc_spi_remove fails.  (I don't know what state mmc_spi_remove leaves
stuff in if it fails ...)

> +static struct spi_driver of_mmc_spi_driver =3D {
> +	.driver =3D {
> +		.name =3D "of_mmc_spi",
> +		.bus =3D &spi_bus_type,

This is initialised by spi_register_driver().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__24_May_2008_12_35_27_+1000__xk2Yif9FDYTnlQy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIN370TgG2atn1QN8RAsnyAJ4+U5d39q5m5og1in7YRTCjl4SelwCglWgp
BkupoItpG1foUF/ec/46xYE=
=q6d8
-----END PGP SIGNATURE-----

--Signature=_Sat__24_May_2008_12_35_27_+1000__xk2Yif9FDYTnlQy--
