Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 7B797B7CCD
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 08:07:38 +1100 (EST)
Received: by gxk28 with SMTP id 28so580796gxk.2
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Mar 2010 13:07:36 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1267640583.4760.0@antares>
References: <1267640583.4760.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 3 Mar 2010 14:07:16 -0700
Message-ID: <fa686aa41003031307j79e004cfk49297e419a65f5da@mail.gmail.com>
Subject: Re: [Patch v.2] mpc5200b/uart: improve baud rate calculation (reach
	high baud rates, better accuracy)
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Albrecht,

I like this version much better.  Comments below...

On Wed, Mar 3, 2010 at 11:23 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> On the MPC5200B, make very high baud rates (e.g. 3 MBaud) accessible and
> achieve a higher precision for high baud rates in general. =A0This is don=
e by
> selecting the appropriate prescaler (/4 or /32). =A0As to keep the code c=
lean,
> the getuartclk method has been dropped, and all calculations are done wit=
h a
> "virtual" /4 prescaler for all chips for maximum accuracy. =A0A new set_d=
ivisor
> method scales down the divisor values found by the generic serial code
> appropriately.
>
> Note: only "fsl,mpc5200b-psc-uart" compatible devices benefit from these
> improvements.
>
> Tested on a custom 5200B based board, with up to 3 MBaud, and with both
> "fsl,mpc5200b-psc-uart" and "fsl,mpc5200-psc-uart" devices.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>
> ---
>
> Changes vs. v.1: include improvements suggested by Wolfram and Grant (tha=
nks a
> lot for your helpful input!!): drop getuartclk method and use the highest
> possible frequency for calculation, use new psc_ops for the 5200b, let th=
e
> set_divisor method do all the dirty work, emit warnings if bad divisor va=
lues
> have been selected.
>
>
> --- linux-2.6.33-orig/drivers/serial/mpc52xx_uart.c =A0 =A0 2010-02-24 19=
:52:17.000000000 +0100
> +++ linux-2.6.33/drivers/serial/mpc52xx_uart.c =A02010-03-03 10:52:04.000=
000000 +0100
> @@ -388,9 +445,25 @@ static void mpc512x_psc_cw_restore_ints(
> =A0 =A0 =A0 =A0out_be32(&FIFO_512x(port)->rximr, port->read_status_mask &=
 0x7f);
> =A0}
>
> -static unsigned long mpc512x_getuartclk(void *p)
> +static void mpc512x_psc_set_divisor(struct uart_port *port,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uns=
igned int divisor)
> =A0{
> - =A0 =A0 =A0 return mpc5xxx_get_bus_frequency(p);
> + =A0 =A0 =A0 struct mpc52xx_psc __iomem *psc =3D PSC(port);
> +
> + =A0 =A0 =A0 /* adjust divisor for a /16 prescaler; see note in
> + =A0 =A0 =A0 =A0* mpc52xx_uart_of_probe() */
> + =A0 =A0 =A0 divisor =3D (divisor + 2) / 4;
> + =A0 =A0 =A0 if (divisor > 0xffff) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: divisor overflow (%x), use =
0xffff\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0divisor);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 divisor =3D 0xffff;
> + =A0 =A0 =A0 } else if (divisor =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: divisor 0, use 1\n", __func=
__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 divisor =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 out_8(&psc->ctur, divisor >> 8);
> + =A0 =A0 =A0 out_8(&psc->ctlr, divisor & 0xff);

Save yourself some duplicated code here.  The above 14 lines can be
shared between the 512x, 52xx and 5200b versions.  Create yourself an
internal __mpc5xxx_psc_set_divisor() function that is passed the *psc,
the divisor, and the clock select register setting (both the 5200 and
the 5121 have the clock select register).

> =A0}
>
> =A0static struct psc_ops mpc512x_psc_ops =3D {
> @@ -409,7 +482,7 @@ static struct psc_ops mpc512x_psc_ops =3D
> =A0 =A0 =A0 =A0.read_char =3D mpc512x_psc_read_char,
> =A0 =A0 =A0 =A0.cw_disable_ints =3D mpc512x_psc_cw_disable_ints,
> =A0 =A0 =A0 =A0.cw_restore_ints =3D mpc512x_psc_cw_restore_ints,
> - =A0 =A0 =A0 .getuartclk =3D mpc512x_getuartclk,
> + =A0 =A0 =A0 .set_divisor =3D mpc512x_psc_set_divisor,
> =A0};
> =A0#endif
>
> @@ -564,7 +637,6 @@ mpc52xx_uart_set_termios(struct uart_por
> =A0 =A0 =A0 =A0struct mpc52xx_psc __iomem *psc =3D PSC(port);
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0unsigned char mr1, mr2;
> - =A0 =A0 =A0 unsigned short ctr;
> =A0 =A0 =A0 =A0unsigned int j, baud, quot;
>
> =A0 =A0 =A0 =A0/* Prepare what we're gonna write */
> @@ -604,7 +676,6 @@ mpc52xx_uart_set_termios(struct uart_por
>
> =A0 =A0 =A0 =A0baud =3D uart_get_baud_rate(port, new, old, 0, port->uartc=
lk/16);

I'm probably nitpicking, because I don't know if the io pin will
handle this speed but uartclk/16 is no longer the maximum baudrate if
a /4 prescaler is used.

> =A0 =A0 =A0 =A0quot =3D uart_get_divisor(port, baud);
> - =A0 =A0 =A0 ctr =3D quot & 0xffff;
>
> =A0 =A0 =A0 =A0/* Get the lock */
> =A0 =A0 =A0 =A0spin_lock_irqsave(&port->lock, flags);
> @@ -635,8 +706,7 @@ mpc52xx_uart_set_termios(struct uart_por
> =A0 =A0 =A0 =A0out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
> =A0 =A0 =A0 =A0out_8(&psc->mode, mr1);
> =A0 =A0 =A0 =A0out_8(&psc->mode, mr2);
> - =A0 =A0 =A0 out_8(&psc->ctur, ctr >> 8);
> - =A0 =A0 =A0 out_8(&psc->ctlr, ctr & 0xff);
> + =A0 =A0 =A0 psc_ops->set_divisor(port, quot);

Hmmm.  The divisor calculations have some tricky bits to them.  I
would consider changing the set_divisor() function to accept a baud
rate, and modify the set_divisor function to call uart_get_divisor().
That way each set_divisor() can do whatever makes the most sense for
the divisors available to it.  The 5121 for example has both a /10 and
a /32 divisor, plus it can use an external clock.

>
> =A0 =A0 =A0 =A0if (UART_ENABLE_MS(port, new->c_cflag))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc52xx_uart_enable_ms(port);
> @@ -1007,7 +1077,8 @@ mpc52xx_console_setup(struct console *co
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 uartclk =3D psc_ops->getuartclk(np);
> + =A0 =A0 =A0 /* see remarks about the uart clock in mpc52xx_uart_of_prob=
e() */
> + =A0 =A0 =A0 uartclk =3D mpc5xxx_get_bus_frequency(np) * 4;
> =A0 =A0 =A0 =A0if (uartclk =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("Could not find uart clock freque=
ncy!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -1090,6 +1161,7 @@ static struct uart_driver mpc52xx_uart_d
>
> =A0static struct of_device_id mpc52xx_uart_of_match[] =3D {
> =A0#ifdef CONFIG_PPC_MPC52xx
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5200b-psc-uart", .data =3D &mpc52=
00b_psc_ops, },
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5200-psc-uart", .data =3D &mpc52=
xx_psc_ops, },
> =A0 =A0 =A0 =A0/* binding used by old lite5200 device trees: */
> =A0 =A0 =A0 =A0{ .compatible =3D "mpc5200-psc-uart", .data =3D &mpc52xx_p=
sc_ops, },
> @@ -1122,7 +1194,24 @@ mpc52xx_uart_of_probe(struct of_device *
> =A0 =A0 =A0 =A0pr_debug("Found %s assigned to ttyPSC%x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_uart_nodes[idx]->full_name, idx);
>
> - =A0 =A0 =A0 uartclk =3D psc_ops->getuartclk(op->node);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Note about the uart clock:
> + =A0 =A0 =A0 =A0* This series of processors use the ipb clock frequency =
for the clock
> + =A0 =A0 =A0 =A0* generation scaled down by prescalers and a 16-bit coun=
ter register:
> + =A0 =A0 =A0 =A0* - the 5200 has a /32 prescaler
> + =A0 =A0 =A0 =A0* - the 5200B has selectable /4 or /32 prescalers (i.e. =
the counter
> + =A0 =A0 =A0 =A0* =A0 reg can be viewed as a 19-bit value, of which we c=
an use either
> + =A0 =A0 =A0 =A0* =A0 the upper or the lower 16 bits - in the latter cas=
e the three
> + =A0 =A0 =A0 =A0* =A0 MSB's must of course be 0)
> + =A0 =A0 =A0 =A0* - the 512x has a /16 prescaler

According to the user manual, the 5121 has both a /32 and /10
prescaler.  As such, I'd rather see uartclk get set to the raw value
returned from mpc5xxx_get_bus_frequency() and do all the
transformations in the set_divisor() hook.

Also, I looked at the generic code, and while it does assume a /16
prescaler, that is pretty easy to handle at the point of calling the
uart_get_divisor() function.

> + =A0 =A0 =A0 =A0* The generic serial code assumes a prescaler of /16. =
=A0As we want to
> + =A0 =A0 =A0 =A0* achieve the maximum accuracy possible, we let the gene=
ric serial
> + =A0 =A0 =A0 =A0* code perform all calculations with the /4 prescaler, i=
.e. we have
> + =A0 =A0 =A0 =A0* to set the uart clock to ipb freq * 4 here. =A0The set=
_divisor methods
> + =A0 =A0 =A0 =A0* for the different chips are responsible for scaling do=
wn the divisor
> + =A0 =A0 =A0 =A0* value appropriately.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 uartclk =3D mpc5xxx_get_bus_frequency(op->node) * 4;
> =A0 =A0 =A0 =A0if (uartclk =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&op->dev, "Could not find uart clo=
ck frequency!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
