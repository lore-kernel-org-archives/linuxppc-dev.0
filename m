Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C8F332C01F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 17:30:05 +1000 (EST)
Message-ID: <5201F70F.8090007@pengutronix.de>
Date: Wed, 07 Aug 2013 09:28:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 11/31] net: can: mscan: improve clock API use
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-12-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-12-git-send-email-gsi@denx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WH1MRSqqH2qOLMXA2VWA3NH9Jr3EtHWTC"
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 David Woodhouse <dwmw2@infradead.org>,
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
--WH1MRSqqH2qOLMXA2VWA3NH9Jr3EtHWTC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/06/2013 10:43 PM, Gerhard Sittig wrote:
> the .get_clock() callback is run from probe() and might allocate
> resources, introduce a .put_clock() callback that is run from remove()
> to undo any allocation activities
>=20
> prepare and enable the clocks in open(), disable and unprepare the
> clocks in close() if clocks were acquired during probe(), to not assume=

> knowledge about which activities are done in probe() and remove()
>=20
> use devm_get_clk() to lookup the SYS and REF clocks, to have the clocks=

> put upon device shutdown
>=20
> store pointers to data structures upon successful allocation already
> instead of deferral until complete setup, such that subroutines in the
> setup sequence may access those data structures as well to track their
> resource acquisition
>=20
> since clock allocation remains optional, the release callback as well a=
s
> the enable/disable calls in open/close are optional as well
>=20
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |   18 ++++++++++++------
>  drivers/net/can/mscan/mscan.c       |   27 ++++++++++++++++++++++++++-=

>  drivers/net/can/mscan/mscan.h       |    3 +++
>  3 files changed, 41 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/msca=
n/mpc5xxx_can.c
> index bc422ba..e59b3a3 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -40,6 +40,7 @@ struct mpc5xxx_can_data {
>  	unsigned int type;
>  	u32 (*get_clock)(struct platform_device *ofdev, const char *clock_nam=
e,
>  			 int *mscan_clksrc);
> +	void (*put_clock)(struct platform_device *ofdev);
>  };
> =20
>  #ifdef CONFIG_PPC_MPC52xx
> @@ -180,7 +181,7 @@ static u32 mpc512x_can_get_clock(struct platform_de=
vice *ofdev,
>  			clockdiv =3D 1;
> =20
>  		if (!clock_name || !strcmp(clock_name, "sys")) {
> -			sys_clk =3D clk_get(&ofdev->dev, "sys_clk");
> +			sys_clk =3D devm_clk_get(&ofdev->dev, "sys_clk");
>  			if (IS_ERR(sys_clk)) {
>  				dev_err(&ofdev->dev, "couldn't get sys_clk\n");
>  				goto exit_unmap;
> @@ -203,7 +204,7 @@ static u32 mpc512x_can_get_clock(struct platform_de=
vice *ofdev,
>  		}
> =20
>  		if (clocksrc < 0) {
> -			ref_clk =3D clk_get(&ofdev->dev, "ref_clk");
> +			ref_clk =3D devm_clk_get(&ofdev->dev, "ref_clk");
>  			if (IS_ERR(ref_clk)) {
>  				dev_err(&ofdev->dev, "couldn't get ref_clk\n");
>  				goto exit_unmap;
> @@ -280,6 +281,8 @@ static int mpc5xxx_can_probe(struct platform_device=
 *ofdev)
>  	dev =3D alloc_mscandev();
>  	if (!dev)
>  		goto exit_dispose_irq;
> +	platform_set_drvdata(ofdev, dev);
> +	SET_NETDEV_DEV(dev, &ofdev->dev);
> =20
>  	priv =3D netdev_priv(dev);
>  	priv->reg_base =3D base;
> @@ -296,8 +299,6 @@ static int mpc5xxx_can_probe(struct platform_device=
 *ofdev)
>  		goto exit_free_mscan;
>  	}
> =20
> -	SET_NETDEV_DEV(dev, &ofdev->dev);
> -
>  	err =3D register_mscandev(dev, mscan_clksrc);
>  	if (err) {
>  		dev_err(&ofdev->dev, "registering %s failed (err=3D%d)\n",
> @@ -305,8 +306,6 @@ static int mpc5xxx_can_probe(struct platform_device=
 *ofdev)
>  		goto exit_free_mscan;
>  	}
> =20
> -	platform_set_drvdata(ofdev, dev);
> -
>  	dev_info(&ofdev->dev, "MSCAN at 0x%p, irq %d, clock %d Hz\n",
>  		 priv->reg_base, dev->irq, priv->can.clock.freq);
> =20
> @@ -324,10 +323,17 @@ exit_unmap_mem:
> =20
>  static int mpc5xxx_can_remove(struct platform_device *ofdev)
>  {
> +	const struct of_device_id *match;
> +	const struct mpc5xxx_can_data *data;
>  	struct net_device *dev =3D platform_get_drvdata(ofdev);
>  	struct mscan_priv *priv =3D netdev_priv(dev);
> =20
> +	match =3D of_match_device(mpc5xxx_can_table, &ofdev->dev);
> +	data =3D match ? match->data : NULL;
> +
>  	unregister_mscandev(dev);
> +	if (data && data->put_clock)
> +		data->put_clock(ofdev);
>  	iounmap(priv->reg_base);
>  	irq_dispose_mapping(dev->irq);
>  	free_candev(dev);
> diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/msca=
n.c
> index e6b4095..4f998f5 100644
> --- a/drivers/net/can/mscan/mscan.c
> +++ b/drivers/net/can/mscan/mscan.c
> @@ -573,10 +573,24 @@ static int mscan_open(struct net_device *dev)
>  	struct mscan_priv *priv =3D netdev_priv(dev);
>  	struct mscan_regs __iomem *regs =3D priv->reg_base;
> =20
> +	if (priv->clk_ipg) {
> +		ret =3D clk_prepare_enable(priv->clk_ipg);
> +		if (ret)
> +			goto exit_retcode;
> +	}
> +	if (priv->clk_can) {
> +		ret =3D clk_prepare_enable(priv->clk_can);
> +		if (ret) {
> +			if (priv->clk_ipg)
> +				clk_disable_unprepare(priv->clk_ipg);
> +			goto exit_retcode;

Why don't you add another jump label and jump to that to disable the
ipkg clock?


> +		}
> +	}
> +
>  	/* common open */
>  	ret =3D open_candev(dev);
>  	if (ret)
> -		return ret;
> +		goto exit_dis_clock;
> =20
>  	napi_enable(&priv->napi);
> =20
> @@ -604,6 +618,12 @@ exit_free_irq:
>  exit_napi_disable:
>  	napi_disable(&priv->napi);
>  	close_candev(dev);
> +exit_dis_clock:
> +	if (priv->clk_can)
> +		clk_disable_unprepare(priv->clk_can);
> +	if (priv->clk_ipg)
> +		clk_disable_unprepare(priv->clk_ipg);
> +exit_retcode:
>  	return ret;
>  }

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WH1MRSqqH2qOLMXA2VWA3NH9Jr3EtHWTC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIB9xgACgkQjTAFq1RaXHNNOQCeKJJ1CndWOwCAxoHL9wpTGMvE
X1YAn22R/bIWI3LhI9u21cUgEYOJtS52
=4F4P
-----END PGP SIGNATURE-----

--WH1MRSqqH2qOLMXA2VWA3NH9Jr3EtHWTC--
