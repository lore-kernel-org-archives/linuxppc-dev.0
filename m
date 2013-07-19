Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB5762C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 17:35:45 +1000 (EST)
Message-ID: <51E8EC17.9060703@pengutronix.de>
Date: Fri, 19 Jul 2013 09:34:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v2 16/24] net: can: mscan: make mpc512x code use common
 clock
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374178858-8683-2-git-send-email-gsi@denx.de>
In-Reply-To: <1374178858-8683-2-git-send-email-gsi@denx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DTNEXGQXRADGJQMOIODG"
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 devicetree-discuss@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DTNEXGQXRADGJQMOIODG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2013 10:20 PM, Gerhard Sittig wrote:
> extend the mscan(4) driver with alternative support for the COMMON_CLK
> approach which is an option in the MPC512x platform, keep the existing
> clock support implementation in place since the driver is shared with
> other MPC5xxx SoCs which don't have common clock support
>=20
> one byproduct of this change is that the CAN driver no longer needs to
> access the SoC's clock control registers, which shall be the domain of
> the platform's clock driver
>=20
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |  139 +++++++++++++++++++++++++++=
++++++++
>  1 file changed, 139 insertions(+)
>=20
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/msca=
n/mpc5xxx_can.c
> index bc422ba..dd26ab6 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -108,6 +108,143 @@ static u32 mpc52xx_can_get_clock(struct platform_=
device *ofdev,
>  #endif /* CONFIG_PPC_MPC52xx */
> =20
>  #ifdef CONFIG_PPC_MPC512x
> +
> +#if IS_ENABLED(CONFIG_COMMON_CLK)
> +
> +static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
> +				 const char *clock_source, int *mscan_clksrc)
> +{
> +	struct device_node *np;
> +	u32 clockdiv;
> +	enum {
> +		CLK_FROM_AUTO,
> +		CLK_FROM_IPS,
> +		CLK_FROM_SYS,
> +		CLK_FROM_REF,
> +	} clk_from;
> +	struct clk *clk_in, *clk_can;
> +	unsigned long freq_calc;
> +
> +	/* the caller passed in the clock source spec that was read from
> +	 * the device tree, get the optional clock divider as well
> +	 */
> +	np =3D ofdev->dev.of_node;
> +	clockdiv =3D 1;
> +	of_property_read_u32(np, "fsl,mscan-clock-divider", &clockdiv);
> +	dev_dbg(&ofdev->dev, "device tree specs: clk src[%s] div[%d]\n",
> +		clock_source ? clock_source : "<NULL>", clockdiv);
> +
> +	/* when clock-source is 'ip', the CANCTL1[CLKSRC] bit needs to
> +	 * get set, and the 'ips' clock is the input to the MSCAN
> +	 * component
> +	 *
> +	 * for clock-source values of 'ref' or 'sys' the CANCTL1[CLKSRC]
> +	 * bit needs to get cleared, an optional clock-divider may have
> +	 * been specified (the default value is 1), the appropriate
> +	 * MSCAN related MCLK is the input to the MSCAN component
> +	 *
> +	 * in the absence of a clock-source spec, first an optimal clock
> +	 * gets determined based on the 'sys' clock, if that fails the
> +	 * 'ref' clock is used
> +	 */
> +	clk_from =3D CLK_FROM_AUTO;
> +	if (clock_source) {
> +		/* interpret the device tree's spec for the clock source */
> +		if (!strcmp(clock_source, "ip"))
> +			clk_from =3D CLK_FROM_IPS;
> +		else if (!strcmp(clock_source, "sys"))
> +			clk_from =3D CLK_FROM_SYS;
> +		else if (!strcmp(clock_source, "ref"))
> +			clk_from =3D CLK_FROM_REF;
> +		else
> +			goto err_invalid;
> +		dev_dbg(&ofdev->dev, "got a clk source spec[%d]\n", clk_from);
> +	}
> +	if (clk_from =3D=3D CLK_FROM_AUTO) {
> +		/* no spec so far, try the 'sys' clock; round to the
> +		 * next MHz and see if we can get a multiple of 16MHz
> +		 */
> +		dev_dbg(&ofdev->dev, "no clk source spec, trying SYS\n");
> +		clk_in =3D clk_get(&ofdev->dev, "sys");
> +		if (IS_ERR(clk_in))
> +			goto err_notavail;
> +		freq_calc =3D clk_get_rate(clk_in);
> +		freq_calc +=3D  499999;
> +		freq_calc /=3D 1000000;
> +		freq_calc *=3D 1000000;
> +		if ((freq_calc % 16000000) =3D=3D 0) {
> +			clk_from =3D CLK_FROM_SYS;
> +			clockdiv =3D freq_calc / 16000000;
> +			dev_dbg(&ofdev->dev,
> +				"clk fit, sys[%lu] div[%d] freq[%lu]\n",
> +				freq_calc, clockdiv, freq_calc / clockdiv);
> +		}
> +	}
> +	if (clk_from =3D=3D CLK_FROM_AUTO) {
> +		/* no spec so far, use the 'ref' clock */
> +		dev_dbg(&ofdev->dev, "no clk source spec, trying REF\n");
> +		clk_in =3D clk_get(&ofdev->dev, "ref");
> +		if (IS_ERR(clk_in))
> +			goto err_notavail;
> +		clk_from =3D CLK_FROM_REF;
> +		freq_calc =3D clk_get_rate(clk_in);
> +		dev_dbg(&ofdev->dev,
> +			"clk fit, ref[%lu] (no div) freq[%lu]\n",
> +			freq_calc, freq_calc);
> +	}
> +
> +	/* select IPS or MCLK as the MSCAN input (returned to the caller),
> +	 * setup the MCLK mux source and rate if applicable, apply the
> +	 * optionally specified or derived above divider, and determine
> +	 * the actual resulting clock rate to return to the caller
> +	 */
> +	switch (clk_from) {
> +	case CLK_FROM_IPS:
> +		clk_can =3D clk_get(&ofdev->dev, "ips");
> +		if (IS_ERR(clk_can))
> +			goto err_notavail;
> +		clk_prepare_enable(clk_can);

Where is the corresponding clk_disable_unprepare()?a

> +		freq_calc =3D clk_get_rate(clk_can);
> +		*mscan_clksrc =3D MSCAN_CLKSRC_IPS;
> +		dev_dbg(&ofdev->dev, "clk from IPS, clksrc[%d] freq[%lu]\n",
> +			*mscan_clksrc, freq_calc);
> +		break;
> +	case CLK_FROM_SYS:
> +	case CLK_FROM_REF:
> +		clk_can =3D clk_get(&ofdev->dev, "mclk");
> +		if (IS_ERR(clk_can))
> +			goto err_notavail;
> +		clk_prepare_enable(clk_can);

dito

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2DTNEXGQXRADGJQMOIODG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHo7BcACgkQjTAFq1RaXHP+rwCgmSiOgoJ7zGF673U9ASu12PUf
Z9gAn0e46f6RAXg9WOETLx3P5ncWsCFC
=qSof
-----END PGP SIGNATURE-----

------enig2DTNEXGQXRADGJQMOIODG--
