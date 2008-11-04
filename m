Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 40471DDDE0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 22:15:32 +1100 (EST)
Date: Tue, 4 Nov 2008 12:15:45 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: =?iso-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
Subject: Re: [PATCH V2] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
Message-ID: <20081104111545.GB17864@pengutronix.de>
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
In-Reply-To: <4910274E.5030305@unicontrol.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rene,

I haven't actually applied the patch, just a few comments from a
glimpse:

> +/* macro with helper macros to safely reset rx which mustn't be done in =
break state.
> + * This is a workaround for processor bug #364 described in MPC5200 (L25=
R) Errata.

Minor nit: Kernel CodingStyle suggests long comments like this

/*
 * comment starts here
 * ...
 */

Major nit: Please add to the comment that this bug is still present on
the MPC5200B, although it is not in its errata sheet. Thils will avoid
later confusion. (Out of interest, did you contact Freescale about this
bug?)

> + *
> + * The workaround resets the baudrate to 4800, waits for a stable state =
and resets break state repeatedly if necessary.
> + * Optionally it can release the lock while waiting.
> + * 1 character at 4800 baud takes 2ms, 3ms should be enough for 1 charac=
ter at higher speed and 1 char at lowest
> + * works only with longer delays

Did I get it right that there are cases where the workaround won't work?

> + */
> +
> +static void mpc52xx_uart_reset_rx(struct uart_port *port, int unlock, un=
signed long flags)

'bool unlock'?

> +{
> +	struct mpc52xx_psc __iomem *psc =3D PSC(port);
> +#ifdef CONFIG_PPC_MPC52xx
> +	out_8(&psc->ctur,0x01);
> +	out_8(&psc->ctlr,0xae);

Those are magic values. If you can't build them using defined
constants, at least document them, please.

> +	do {
> +		out_8(&psc->command,MPC52xx_PSC_RST_ERR_STAT);
> +		if (unlock) {
> +			disable_irq(port->irq);
> +			spin_unlock_irqrestore(&port->lock, flags);
> +		}
> +		mdelay(10);
> +		if (unlock) {
> +			spin_lock_irqsave(&port->lock, flags);
> +			enable_irq(port->irq);
> +		}
> +	} while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB);
> +#endif
> +	out_8(&psc->command,MPC52xx_PSC_RST_RX);
> +}
> +
>  static int
>  mpc52xx_uart_startup(struct uart_port *port)
>  {
> @@ -510,7 +541,7 @@ mpc52xx_uart_startup(struct uart_port *port)
>  		return ret;
> =20
>  	/* Reset/activate the port, clear and enable interrupts */
> -	out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +	mpc52xx_uart_reset_rx(port, false, 0);
>  	out_8(&psc->command, MPC52xx_PSC_RST_TX);
> =20
>  	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
> @@ -529,7 +560,7 @@ mpc52xx_uart_shutdown(struct uart_port *port)
>  	struct mpc52xx_psc __iomem *psc =3D PSC(port);
> =20
>  	/* Shut down the port.  Leave TX active if on a console port */
> -	out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +	mpc52xx_uart_reset_rx(port, false, 0);
>  	if (!uart_console(port))
>  		out_8(&psc->command, MPC52xx_PSC_RST_TX);
> =20
> @@ -588,9 +619,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, stru=
ct ktermios *new,
>  	/* Get the lock */
>  	spin_lock_irqsave(&port->lock, flags);
> =20
> -	/* Update the per-port timeout */
> -	uart_update_timeout(port, new->c_cflag, baud);
> -
>  	/* Do our best to flush TX & RX, so we don't loose anything */
>  	/* But we don't wait indefinitly ! */
>  	j =3D 5000000;	/* Maximum wait */
> @@ -607,9 +635,12 @@ mpc52xx_uart_set_termios(struct uart_port *port, str=
uct ktermios *new,
>  			"Some chars may have been lost.\n");
> =20
>  	/* Reset the TX & RX */
> -	out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +	mpc52xx_uart_reset_rx(port, true, flags);
>  	out_8(&psc->command, MPC52xx_PSC_RST_TX);
> =20
> +	/* Update the per-port timeout */
> +	uart_update_timeout(port, new->c_cflag, baud);
> +
>  	/* Send new mode settings */
>  	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
>  	out_8(&psc->mode, mr1);

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Thanks!

   Wolfram Sang

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkQLuEACgkQD27XaX1/VRvzIACgqvrRb2blb8Dq4WEtb3YUYzM5
hZkAoMKCzEkAqLZccQPsfdGXP1CoFWWy
=r/Sn
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
