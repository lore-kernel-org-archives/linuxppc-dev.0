Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 185CEDE007
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 08:21:58 +1100 (EST)
Date: Tue, 4 Nov 2008 22:21:52 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: =?iso-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
Subject: Re: [PATCH V3] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
Message-ID: <20081104212152.GC28064@pengutronix.de>
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de>
	<20081104111545.GB17864@pengutronix.de>
	<4910A519.3030701@unicontrol.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
In-Reply-To: <4910A519.3030701@unicontrol.de>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ren=E9,

On Tue, Nov 04, 2008 at 08:40:09PM +0100, Ren=E9 B=FCrgel wrote:
> Hey, folks
>
> This is v3 of my patch to work around erratum #364 of the MPC5200(B). I =
=20
> removed most "magic" looking numbers, documenting the rest. As mentioned =
=20
> before, the previous patches weren't working for low baudrates (<9600). =
=20
> This should be fixed now.
>
> But there's still one thing, that bothers me a bit - if there is REALLY =
=20
> a break on the line, closing the driver may take until it's gone. I =20
> don't know whether this is really satisfying, but i think it's better =20
> than the alternative: no serial connection until the next reboot.

I think we should CC linux-serial to get some opinions about this. At
least, if it stays like this, it should be mentioned in the source.

>
> --=20
> Ren=E9 B=FCrgel
> Software Engineer
> Unicontrol Systemtechnik GmbH
> OT Dittersbach
> Sachsenburger Weg 34
> 09669 Frankenberg
>
> Tel.: 03 72 06/ 88 73 - 19
> Fax: 03 72 06/ 88 73 - 60
> E-Mail: r.buergel@unicontrol.de
> Internet: www.unicontrol.de
>
> Unicontrol Systemtechnik GmbH
> Gesch=E4ftsf=FChrer: Dipl.-Ing. Siegfried Heinze
> Sitz der Gesellschaft: Frankenberg
> Registergericht: Amtsgericht Chemnitz, HRB 15 475
>
>

> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 6117d3d..a2bb4d9 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -496,6 +496,59 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int c=
tl)
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
> =20
> +/*
> + * This is a workaround for processor bug #364 described in MPC5200 (L25=
R) Errata.
> + * The bug is still present in MPC5200B, but currently not listed in its=
 errata sheet
> + *
> + * The workaround resets the baudrate to the slowest possible,
> + * waits for a stable state and resets break state repeatedly if necessa=
ry.
> + * Optionally it can release the lock while waiting.
> + *
> + * That baudrate is roughly port->uartclk / (1000 * 1000)
> + * The minimum wait time for the first try has to include the time to wa=
it for stop-bits and a character,
> + * we wait for 2 chars to be sure
> + * Consecutive waits must just receive one character.
> + */

Here are lines >80 chars. Please let scripts/checkpatch.pl check this
patch (--strict doesn't hurt). And please try also
Documentation/CodingStyle.txt. It really helps maintaining that huge
amount of code the kernel is.

> +
> +static void mpc52xx_uart_reset_rx(struct uart_port *port, bool unlock, u=
nsigned long flags)
> +{
> +#ifdef CONFIG_PPC_MPC52xx
> +	void reset_errors_and_wait(struct uart_port *port, bool unlock, unsigne=
d long flags, unsigned int delay)
> +	{
> +		struct mpc52xx_psc __iomem *psc =3D PSC(port);
> +		out_8(&psc->command,MPC52xx_PSC_RST_ERR_STAT);
> +		if (unlock) {
> +			disable_irq(port->irq);
> +			spin_unlock_irqrestore(&port->lock, flags);
> +		}
> +		mdelay( delay );
> +		if (unlock) {
> +			spin_lock_irqsave(&port->lock, flags);
> +			enable_irq(port->irq);
> +		}
> +	}

Function inside a function? Haven't seen this before in kernel code. I
don't think it will be accepted, but leave this to maintainers.

> +
> +
> +	struct mpc52xx_psc __iomem *psc =3D PSC(port);
> +
> +	// One character on the serial port may consist of up to 12 bits.
> +	// So the time to receive one char is 12 /*bits*/ / (port->uartclk / (1=
000 * 1000) /*MHz -> Hz*/) * 1000 /*s -> ms*/,
> +	// but we'll wait 50% longer just to make sure

No // comments please.

> +	unsigned int one_char_receive_duration =3D (12 * 1000) / (port->uartclk=
 / (1000 * 1000) );
> +
> +	/* CT=3D0xFFFF sets the serial line to the minimal possible baudrate de=
pending on the uartclk. */
> +	out_8(&psc->ctur, 0xFF);
> +	out_8(&psc->ctlr, 0xFF);
> +
> +	reset_errors_and_wait( port, unlock, flags, one_char_receive_duration *=
 2 );
> +
> +	while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB) {
> +		reset_errors_and_wait( port, unlock, flags, one_char_receive_duration =
);
> +	}
> +#endif
> +	out_8(&psc->command,MPC52xx_PSC_RST_RX);
> +}
> +
>  static int
>  mpc52xx_uart_startup(struct uart_port *port)
>  {
> @@ -510,7 +563,7 @@ mpc52xx_uart_startup(struct uart_port *port)
>  		return ret;
> =20
>  	/* Reset/activate the port, clear and enable interrupts */
> -	out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +	mpc52xx_uart_reset_rx(port, false, 0);
>  	out_8(&psc->command, MPC52xx_PSC_RST_TX);
> =20
>  	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
> @@ -529,7 +582,7 @@ mpc52xx_uart_shutdown(struct uart_port *port)
>  	struct mpc52xx_psc __iomem *psc =3D PSC(port);
> =20
>  	/* Shut down the port.  Leave TX active if on a console port */
> -	out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +	mpc52xx_uart_reset_rx(port, false, 0);
>  	if (!uart_console(port))
>  		out_8(&psc->command, MPC52xx_PSC_RST_TX);
> =20
> @@ -588,9 +641,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, stru=
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
> @@ -607,9 +657,12 @@ mpc52xx_uart_set_termios(struct uart_port *port, str=
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

Bye,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkQvPAACgkQD27XaX1/VRsOvACgyvJQ2uLVHFAWHwcltbI72Jxp
N8cAn1/8BbIbZy3dhiSUZfKKH2FwhZ/X
=gT7T
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
