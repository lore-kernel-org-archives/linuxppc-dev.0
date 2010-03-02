Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DBCFB7CFB
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Mar 2010 11:32:34 +1100 (EST)
Date: Tue, 2 Mar 2010 01:32:28 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high
	baud rates, better accuracy)
Message-ID: <20100302003228.GA8431@pengutronix.de>
References: <1267467114.2218.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
In-Reply-To: <1267467114.2218.0@antares>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Albrecht,

On Mon, Mar 01, 2010 at 07:11:54PM +0100, Albrecht Dre=DF wrote:
> On the MPC5200B, select the baud rate prescaler as /4 by default to make =
very
> high baud rates (e.g. 3 MBaud) accessible and to achieve a higher precisi=
on
> for high baud rates in general. For baud rates below ~500 Baud, the code =
will
> automatically fall back to the /32 prescaler.  The original MPC5200 does =
only
> have a /32 prescaler which is detected only once and stored in a global. =
 A
> new chip-dependent method is used to set the divisor.
>=20
> Tested on a custom 5200B based board, with up to 3 MBaud.
>=20
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>=20
> ---
>=20
> --- linux-2.6.33/drivers/serial/mpc52xx_uart.c.orig	2010-02-24 19:52:17.0=
00000000 +0100
> +++ linux-2.6.33/drivers/serial/mpc52xx_uart.c	2010-02-26 21:12:51.000000=
000 +0100
> @@ -144,9 +144,17 @@ struct psc_ops {
>  	unsigned char	(*read_char)(struct uart_port *port);
>  	void		(*cw_disable_ints)(struct uart_port *port);
>  	void		(*cw_restore_ints)(struct uart_port *port);
> +	void		(*set_divisor)(struct uart_port *port,
> +				       unsigned int divisor);
>  	unsigned long	(*getuartclk)(void *p);
>  };
> =20
> +/* We need to distinguish between the MPC5200 which has only a /32 presc=
aler,
> + * and the MPC5200B which has a /32 and a /4 prescaler.  The global is f=
ine,
> + * as the chip can be only either a 5200B or not. */
> +static int is_mpc5200b =3D -1;
> +
> +

One empty line too much. Maybe we can also get rid of the static later in t=
he
process, but first things first.

>  #ifdef CONFIG_PPC_MPC52xx
>  #define FIFO_52xx(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1=
))
>  static void mpc52xx_psc_fifo_init(struct uart_port *port)
> @@ -154,9 +162,6 @@ static void mpc52xx_psc_fifo_init(struct
>  	struct mpc52xx_psc __iomem *psc =3D PSC(port);
>  	struct mpc52xx_psc_fifo __iomem *fifo =3D FIFO_52xx(port);
> =20
> -	/* /32 prescaler */
> -	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
> -
>  	out_8(&fifo->rfcntl, 0x00);
>  	out_be16(&fifo->rfalarm, 0x1ff);
>  	out_8(&fifo->tfcntl, 0x07);
> @@ -245,15 +250,40 @@ static void mpc52xx_psc_cw_restore_ints(
>  	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
>  }
> =20
> +static void mpc52xx_psc_set_divisor(struct uart_port *port,
> +				    unsigned int divisor)
> +{
> +	struct mpc52xx_psc __iomem *psc =3D PSC(port);
> +
> +	/* prescaler */
> +	if (is_mpc5200b !=3D 1)
> +		out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /32 */
> +	else if (divisor > 0xffff) {
> +		out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /32 */
> +		divisor =3D (divisor + 4) / 8;
> +	} else
> +		out_be16(&psc->mpc52xx_psc_clock_select, 0xff00); /* /4 */
> +
> +	/* ctr */
> +	divisor &=3D 0xffff;
> +	out_8(&psc->ctur, divisor >> 8);
> +	out_8(&psc->ctlr, divisor & 0xff);
> +}
> +
>  /* Search for bus-frequency property in this node or a parent */
>  static unsigned long mpc52xx_getuartclk(void *p)
>  {
>  	/*
> -	 * 5200 UARTs have a / 32 prescaler
> -	 * but the generic serial code assumes 16
> -	 * so return ipb freq / 2
> +	 * The 5200 has only /32 prescalers.
> +	 * 5200B UARTs have a /4 or a /32 prescaler.  For higher accuracy, we
> +	 * do all calculations using the /4 prescaler for this chip.
> +	 * The generic serial code assumes /16 so return ipb freq / 2 (5200)
> +	 * or ipb freq * 4 (5200B).
>  	 */
> -	return mpc5xxx_get_bus_frequency(p) / 2;
> +	if (is_mpc5200b =3D=3D 1)
> +		return mpc5xxx_get_bus_frequency(p) * 4;
> +	else
> +		return mpc5xxx_get_bus_frequency(p) / 2;

Isn't this wrong? You can also have /32 on the 5200B (the fallback).

>  }
> =20
>  static struct psc_ops mpc52xx_psc_ops =3D {
> @@ -272,6 +302,7 @@ static struct psc_ops mpc52xx_psc_ops =3D=20
>  	.read_char =3D mpc52xx_psc_read_char,
>  	.cw_disable_ints =3D mpc52xx_psc_cw_disable_ints,
>  	.cw_restore_ints =3D mpc52xx_psc_cw_restore_ints,
> +	.set_divisor =3D mpc52xx_psc_set_divisor,
>  	.getuartclk =3D mpc52xx_getuartclk,
>  };
> =20
> @@ -388,6 +419,16 @@ static void mpc512x_psc_cw_restore_ints(
>  	out_be32(&FIFO_512x(port)->rximr, port->read_status_mask & 0x7f);
>  }
> =20
> +static void mpc512x_psc_set_divisor(struct uart_port *port,
> +				    unsigned int divisor)
> +{
> +	struct mpc52xx_psc __iomem *psc =3D PSC(port);
> +
> +	divisor &=3D 0xffff;
> +	out_8(&psc->ctur, divisor >> 8);
> +	out_8(&psc->ctlr, divisor & 0xff);
> +}
> +
>  static unsigned long mpc512x_getuartclk(void *p)
>  {
>  	return mpc5xxx_get_bus_frequency(p);
> @@ -409,6 +450,7 @@ static struct psc_ops mpc512x_psc_ops =3D=20
>  	.read_char =3D mpc512x_psc_read_char,
>  	.cw_disable_ints =3D mpc512x_psc_cw_disable_ints,
>  	.cw_restore_ints =3D mpc512x_psc_cw_restore_ints,
> +	.set_divisor =3D mpc512x_psc_set_divisor,
>  	.getuartclk =3D mpc512x_getuartclk,
>  };
>  #endif
> @@ -564,7 +606,6 @@ mpc52xx_uart_set_termios(struct uart_por
>  	struct mpc52xx_psc __iomem *psc =3D PSC(port);
>  	unsigned long flags;
>  	unsigned char mr1, mr2;
> -	unsigned short ctr;
>  	unsigned int j, baud, quot;
> =20
>  	/* Prepare what we're gonna write */
> @@ -604,7 +645,6 @@ mpc52xx_uart_set_termios(struct uart_por
> =20
>  	baud =3D uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
>  	quot =3D uart_get_divisor(port, baud);
> -	ctr =3D quot & 0xffff;
> =20
>  	/* Get the lock */
>  	spin_lock_irqsave(&port->lock, flags);
> @@ -635,8 +675,7 @@ mpc52xx_uart_set_termios(struct uart_por
>  	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
>  	out_8(&psc->mode, mr1);
>  	out_8(&psc->mode, mr2);
> -	out_8(&psc->ctur, ctr >> 8);
> -	out_8(&psc->ctlr, ctr & 0xff);
> +	psc_ops->set_divisor(port, quot);
> =20
>  	if (UART_ENABLE_MS(port, new->c_cflag))
>  		mpc52xx_uart_enable_ms(port);
> @@ -1113,6 +1152,19 @@ mpc52xx_uart_of_probe(struct of_device *
> =20
>  	dev_dbg(&op->dev, "mpc52xx_uart_probe(op=3D%p, match=3D%p)\n", op, matc=
h);
> =20
> +	/* Check only once if we are running on a mpc5200b or not */
> +	if (is_mpc5200b =3D=3D -1) {
> +		struct device_node *np;
> +
> +		np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5200b-immr");

This should be handled using a new compatible-entry "fsl,mpc5200b-psc-uart".

> +		if (np) {
> +			is_mpc5200b =3D 1;
> +			dev_dbg(&op->dev, "mpc5200b: using /4 prescaler\n");

Does this message respect the fallback case?

You could also have a set_divisor-function for 5200 and 5200B and set it he=
re
in the function struct (one reason less for the static ;))

> +			of_node_put(np);
> +		} else
> +			is_mpc5200b =3D 0;
> +	}
> +
>  	/* Check validity & presence */
>  	for (idx =3D 0; idx < MPC52xx_PSC_MAXNUM; idx++)
>  		if (mpc52xx_uart_nodes[idx] =3D=3D op->node)
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuMXJwACgkQD27XaX1/VRtWBQCcDS/uB4a/Esjj6E8aB4+4Xong
YQ0AoMlBT6ipwjDfire1KoUtZL2Itz3M
=OTeZ
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
