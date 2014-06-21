Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B4951A0080
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jun 2014 05:38:36 +1000 (EST)
Message-ID: <53A5DF26.8090904@pengutronix.de>
Date: Sat, 21 Jun 2014 21:38:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-can@vger.kernel.org, wg@grandegger.com, B07421@freescale.com
Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
In-Reply-To: <1403229664-33912-1-git-send-email-B45475@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="swhjpskcVuJWdtK6ttVpEHM8dVQuN1dfq"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--swhjpskcVuJWdtK6ttVpEHM8dVQuN1dfq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/20/2014 04:01 AM, Zhao Qiang wrote:
> when flexcan is not physically linked, command 'cantest' will
> trigger an err_irq, add err_irq handler for it.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- use a space instead of tab
> 	- use flexcan_poll_state instead of print
>=20
>  drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f425ec2..7432ba4 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -208,6 +208,7 @@ struct flexcan_priv {
>  	void __iomem *base;
>  	u32 reg_esr;
>  	u32 reg_ctrl_default;
> +	unsigned int err_irq;
> =20
>  	struct clk *clk_ipg;
>  	struct clk *clk_per;
> @@ -744,6 +745,23 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
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
> +	if (reg_esr & FLEXCAN_ESR_TX_WRN) {

When is the err_irq triggered?

> +		flexcan_write(reg_esr & ~FLEXCAN_ESR_TX_WRN, &regs->esr);
> +		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
> +		flexcan_poll_state(dev, reg_esr);

poll_state() is does not work, if called from an IRQ
handler.....Depending when err_irq is triggered, is it worth to just
call the normal interrupt handler?

> +	}
> +	return IRQ_HANDLED;

Please return IRQ_HANDLED, only if there really was an interrupt.

> +}
> +
>  static void flexcan_set_bittiming(struct net_device *dev)
>  {
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
> @@ -944,6 +962,12 @@ static int flexcan_open(struct net_device *dev)
>  	if (err)
>  		goto out_close;
> =20
> +	if (priv->err_irq)
> +		err =3D request_irq(priv->err_irq, flexcan_err_irq, IRQF_SHARED,
> +				  dev->name, dev);
> +	if (err)
> +		goto out_close;

In case of an error, you don't free() dev->irq.

> +
>  	/* start chip and queuing */
>  	err =3D flexcan_chip_start(dev);
>  	if (err)
> @@ -1099,7 +1123,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	struct resource *mem;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	void __iomem *base;
> -	int err, irq;
> +	int err, irq, err_irq;
>  	u32 clock_freq =3D 0;
> =20
>  	if (pdev->dev.of_node)
> @@ -1126,6 +1150,10 @@ static int flexcan_probe(struct platform_device =
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
> @@ -1149,6 +1177,7 @@ static int flexcan_probe(struct platform_device *=
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


--swhjpskcVuJWdtK6ttVpEHM8dVQuN1dfq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOl3ycACgkQjTAFq1RaXHOLAgCdFVt8dJgM1RZq4nRmFKS/acnN
wS4An3ZRWMBu8OIkVxPUL4BnrnvPgnp/
=F33t
-----END PGP SIGNATURE-----

--swhjpskcVuJWdtK6ttVpEHM8dVQuN1dfq--
