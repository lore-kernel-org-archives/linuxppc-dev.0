Return-Path: <broonie@sirena.org.uk>
Date: Mon, 15 Jul 2013 21:17:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Gerhard Sittig <gsi@denx.de>
Message-ID: <20130715201734.GF11538@sirena.org.uk>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-2-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wtUqn8XWZYmnPFNh"
In-Reply-To: <1373914074-20889-2-git-send-email-gsi@denx.de>
Subject: Re: [PATCH v1 01/24] spi: mpc512x: prepare clocks before enabling them
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 devicetree-discuss@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wtUqn8XWZYmnPFNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 08:47:30PM +0200, Gerhard Sittig wrote:
> clocks need to get prepared before they can get enabled,
> fix the MPC512x PSC SPI master's initialization

> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/spi/spi-mpc512x-psc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
> index 29fce6a..76b20ea 100644
> --- a/drivers/spi/spi-mpc512x-psc.c
> +++ b/drivers/spi/spi-mpc512x-psc.c
> @@ -395,7 +395,7 @@ static int mpc512x_psc_spi_port_config(struct spi_mas=
ter *master,
> =20
>  	sprintf(name, "psc%d_mclk", master->bus_num);
>  	spiclk =3D clk_get(&master->dev, name);
> -	clk_enable(spiclk);
> +	clk_prepare_enable(spiclk);
>  	mps->mclk =3D clk_get_rate(spiclk);
>  	clk_put(spiclk);

This code is *clearly* buggy and should be fixed rather than papered
over.  Not only is there no matching put the driver is also dropping the
reference to the clock rather than holding on to it while it's in use.

--wtUqn8XWZYmnPFNh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5FjaAAoJELSic+t+oim9ctUP/iCnBh/1amGFygE1gYC1zXRp
aZNbHrpxP/o2nWGu+j8RAO3w6pLNblwBGpTUl1hE3l4Jc9kG49LP5kvkjdb7p8lL
EGXiYB+4WXGnCpwzZRsA52Zg8vPcWEpk9LX2C6INeJ0krBfGx7I0eJyzGYTJ4NjB
1uO/xEuhpuPRCTRaPJ5Jo91uIYZdUSYbu6BR5WIZiIu9y9KQFlj8YhZkQFjXwBEl
Oh8TeRTXG04AXazl/gJPRUO3NqE3OWjv9/iE9Pafoqn6vo/KMK5aSrskYcuWzh1Z
NVparZNOKpPnitdndtUlG3ndBoJ9rltZ6OZbTQRkaORVG5N3KUxTqgAEYHk0uBYB
iwmYJehfvrzZYr3Q8EMedywJIgqKa9AJATZF8s3UFCxwmVRcE3AZTLOBOR9RPBxR
aL3WR7+eps5Nha6TLqqhuamu2vCGxeoa9agQ6Z0sROUvEzHOqcLxaaVcPRVfIMVi
YV6GaNiF2BioZ2gvh9x5wCc8bCsvLmHFrrC1wfyHSht+a5xiB0qFTQkpUNOq+rJf
zvTNDg4QoSivnktsmEEZqGtcpgfFJfxeMkg5HVaC4zf2AFDknIMrRb+oCWXOL7+V
eVe+dE+WrjJd92ahA2hk5fbyg6uEEFAfoli88fNqo6xsRfxx6BY6UIQp6isWt0XG
0g+Pu71gndqWIzqGPBRD
=RIL+
-----END PGP SIGNATURE-----

--wtUqn8XWZYmnPFNh--
