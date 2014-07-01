Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1EFD1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 20:04:52 +1000 (EST)
Message-ID: <53B287A6.10707@pengutronix.de>
Date: Tue, 01 Jul 2014 12:04:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 wg@grandegger.com, linux-can@vger.kernel.org, B07421@freescale.com
Subject: Re: [PATCH v4] flexcan: add err_irq handler for flexcan
References: <1404201809-7010-1-git-send-email-B45475@freescale.com>
In-Reply-To: <1404201809-7010-1-git-send-email-B45475@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6RAC8qtXoIOFgb0Xe4rcfSBJopUBWIH1l"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6RAC8qtXoIOFgb0Xe4rcfSBJopUBWIH1l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/01/2014 10:03 AM, Zhao Qiang wrote:
> when flexcan is not physically linked, command 'cantest' will
> trigger an err_irq, add err_irq handler for it.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- use a space instead of tab
> 	- use flexcan_poll_state instead of print
> Changes for v3:
> 	- return IRQ_HANDLED if err is triggered
> 	- stop transmitted packets when there is an err_interrupt=20
> Changes for v4:
> 	- call flexcan_irq=20
>=20
>  drivers/net/can/flexcan.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f425ec2..098fcac 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -208,6 +208,7 @@ struct flexcan_priv {
>  	void __iomem *base;
>  	u32 reg_esr;
>  	u32 reg_ctrl_default;
> +	int err_irq;
> =20
>  	struct clk *clk_ipg;
>  	struct clk *clk_per;
> @@ -744,6 +745,27 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
id)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	u32 reg_ctrl, reg_esr;
> +
> +	reg_esr =3D flexcan_read(&regs->esr);
> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
> +
> +	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
> +		if (reg_esr & FLEXCAN_ESR_ERR_INT)
> +			flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK,
> +				      &regs->ctrl);
> +		flexcan_irq(irq, dev);

I still don't understand why you need a special flexcan_err_irq()
function. Why don't you just call:

request_irq(priv->err_irq, flexcan_irq, IRQF_SHARED, dev->name, dev);

instead?

> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
>  static void flexcan_set_bittiming(struct net_device *dev)
>  {
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
> @@ -944,6 +966,15 @@ static int flexcan_open(struct net_device *dev)
>  	if (err)
>  		goto out_close;
> =20
> +	if (priv->err_irq) {
> +		err =3D request_irq(priv->err_irq, flexcan_err_irq, IRQF_SHARED,
> +				  dev->name, dev);
> +		if (err) {
> +			free_irq(priv->err_irq, dev);

Why do you want to free the err_irq, if requesting the err_irq fails?
However you should adjust all error cleanup path following this request
irq, so that it will be freed.

BTW: where is the corresponding free_irq() in flexcan_close()?

> +			goto out_free_irq;
> +		}
> +	}
> +
>  	/* start chip and queuing */
>  	err =3D flexcan_chip_start(dev);
>  	if (err)
> @@ -1099,7 +1130,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	struct resource *mem;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	void __iomem *base;
> -	int err, irq;
> +	int err, irq, err_irq;
>  	u32 clock_freq =3D 0;
> =20
>  	if (pdev->dev.of_node)
> @@ -1126,6 +1157,10 @@ static int flexcan_probe(struct platform_device =
*pdev)
>  	if (irq <=3D 0)
>  		return -ENODEV;
> =20
> +	err_irq =3D platform_get_irq(pdev, 1);
> +	if (err_irq <=3D 0)
> +		err_irq =3D 0;
> +
>  	base =3D devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -1149,6 +1184,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	dev->flags |=3D IFF_ECHO;
> =20
>  	priv =3D netdev_priv(dev);
> +	priv->err_irq =3D err_irq;
>  	priv->can.clock.freq =3D clock_freq;
>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>  	priv->can.do_set_mode =3D flexcan_set_mode;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6RAC8qtXoIOFgb0Xe4rcfSBJopUBWIH1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOyh6YACgkQjTAFq1RaXHM2bwCfTnObkssWRq15oMeYzU+Yvxrg
OYwAnR/UMSQXG3qnDq66VMoEk1/E5hOB
=AHH9
-----END PGP SIGNATURE-----

--6RAC8qtXoIOFgb0Xe4rcfSBJopUBWIH1l--
