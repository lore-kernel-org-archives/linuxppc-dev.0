Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B2B61A0151
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 20:13:43 +1000 (EST)
Message-ID: <53B52CC4.8030309@pengutronix.de>
Date: Thu, 03 Jul 2014 12:13:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 wg@grandegger.com, linux-can@vger.kernel.org, B07421@freescale.com
Subject: Re: [PATCH v6] flexcan: add err_irq handler for flexcan
References: <1404379337-15351-1-git-send-email-B45475@freescale.com>
In-Reply-To: <1404379337-15351-1-git-send-email-B45475@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="R3t0VdcnuAgmresl678nl0VrcDWtwhNVF"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R3t0VdcnuAgmresl678nl0VrcDWtwhNVF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2014 11:22 AM, Zhao Qiang wrote:
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
> Changes for v5:
> 	- move err_int_handling code from flexcan_irq to flexcan_err_irq
> 	- call flexcan_err_irq from flexcan_irq
> Changes for v6:
> 	- move RX_IRQ handling back to flexcan_irq
>=20
>  drivers/net/can/flexcan.c | 52 +++++++++++++++++++++++++++++++++++++++=
++------
>  1 file changed, 46 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f425ec2..f6c92bc 100644
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
> @@ -690,6 +691,28 @@ static int flexcan_poll(struct napi_struct *napi, =
int quota)
>  	return work_done;
>  }
> =20
> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	u32 reg_ctrl, reg_esr;
> +	irqreturn_t ret =3D IRQ_NONE;
> +
> +	reg_esr =3D flexcan_read(&regs->esr);
> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
> +
> +	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
> +		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
> +		ret =3D IRQ_HANDLED;
> +	}
> +
> +	if (reg_esr & FLEXCAN_ESR_ERR_INT)
> +		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);

Now you just ACK the interrupts, but you're not triggering the NAPI,
where the actual error interrupts are handled.

In the current interrupt handler we are looking at two registers for
interrupts, that is "iflag1" and "esr". "iflag1" is triggered on RX,
RX-FIFO overflow and TX-complete. "esr" is triggered by errors in
general. In the interrupt handler we distinguish between bus errors
(FLEXCAN_ESR_ERR_BUS) and errors effecting a change of state
(FLEXCAN_ESR_ERR_STATE).

The next step is to figure out which bits in which register trigger the
error irq. Then move the code handling this register into the error irq
handler. As the seconds half of the error irq handling takes place in
the napi function, you have to duplicate the napi_schedule(&priv->napi).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--R3t0VdcnuAgmresl678nl0VrcDWtwhNVF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO1LMQACgkQjTAFq1RaXHNFYwCeO5BS4JhtsjeqZcSWS0mbDnNt
7+wAnR5Wo8kr1t9QQOAyIAX+2YK1jVOM
=B9rs
-----END PGP SIGNATURE-----

--R3t0VdcnuAgmresl678nl0VrcDWtwhNVF--
