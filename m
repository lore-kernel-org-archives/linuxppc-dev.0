Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 40C2FDDDD8
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:55:11 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2609771rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Nov 2008 12:55:10 -0800 (PST)
Message-ID: <fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
Date: Mon, 3 Nov 2008 13:55:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "=?ISO-8859-1?Q?Ren=E9_B=FCrgel?=" <r.buergel@unicontrol.de>
Subject: Re: [PATCH] workaround for mpc52xx erratum #364 (serial may not be
	reset in break state)
In-Reply-To: <490F51E7.3020309@unicontrol.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <490F51E7.3020309@unicontrol.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 3, 2008 at 12:32 PM, Ren=E9 B=FCrgel <r.buergel@unicontrol.de> =
wrote:
> Hi
>
> This patch is a workaround for bug #364 found in the MPC52xx processor.
> The errata document can be found under
> http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf?fpsp=3D1&WT_=
TYPE=3DErrata&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_ASSET=3DDocumen=
tation
>

This is an MPC5200 errata.  It doesn't exist on the MPC5200B.  The
bugfix code should be enabled at runtime only if running on the
original MPC5200.  You can use the value of the compatible property to
determine whether or not to enable it.  Optionally you can further
reduce impact by checking if CONFIG_PPC_MPC5200_BUGFIX is defined.

More comments below

> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.=
c
> index 6117d3d..929524b 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -496,6 +496,27 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int c=
tl)
>        spin_unlock_irqrestore(&port->lock, flags);
>  }
>
> +/* macro with helper macros to safely reset rx which mustn't be done in
> break state.
> + * This is a workaround for processor bug #364 described in MPC5200 (L25=
R)
> Errata.
> + *
> + * The workaround resets the baudrate to 4800, waits for a stable state =
and
> resets break state repeatedly if necessary
> + * optionally it can release the lock while waiting.
> + * 1 character at 4800 baud takes 2ms, 3ms should be enough for 1 charac=
ter
> at higher speed and 1 char at lowest
> + * works only with longer delays
> + */
> +#define LOCK(code) code
> +#define DONT_LOCK(code)
> +#define mpc52xx_uart_reset_rx(LOCK)
>                    \
> +       out_8(&psc->ctur,0x01);
>                     \
> +       out_8(&psc->ctlr,0xae);
>                     \
> +       do {
>                    \
> +               out_8(&psc->command,MPC52xx_PSC_RST_ERR_STAT);
>                    \
> +               LOCK(disable_irq(port->irq);
> spin_unlock_irqrestore(&port->lock, flags));       \
> +               mdelay(10);
>                     \
> +               LOCK(spin_lock_irqsave(&port->lock, flags);
> enable_irq(port->irq));             \
> +       } while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB)=
;
>                    \
> +       out_8(&psc->command,MPC52xx_PSC_RST_RX);
> +

ick.  ugly.  Don't mess about with a macro here, just write a
function.  Let the compiler decide if it should be inlined.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
