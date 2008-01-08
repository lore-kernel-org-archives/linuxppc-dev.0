Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 2CF86DDEEB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:26:25 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1625004anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 09:26:24 -0800 (PST)
Message-ID: <fa686aa40801080926j20394811u3349462455d0ce24@mail.gmail.com>
Date: Tue, 8 Jan 2008 10:26:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 5/7] Separate MPC52xx PSC FIFO registers from rest of PSC
In-Reply-To: <1199808093-15929-6-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
	<1199808093-15929-6-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
> This is in preparation for the addition of MPC512x
> PSC support.  The main difference in the 512x is
> in the fifo registers.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>

Looks good, I'll pick this one up.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/serial/mpc52xx_uart.c     |   10 ++++++----
>  include/asm-powerpc/mpc52xx_psc.h |    3 +++
>  include/asm-ppc/mpc52xx_psc.h     |    3 +++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index ec36ad7..25a91c9 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -111,6 +111,7 @@ static void mpc52xx_uart_of_enumerate(void);
>  #endif
>
>  #define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
> +#define FIFO(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
>
>
>  /* Forward declaration of the interruption handling routine */
> @@ -222,6 +223,7 @@ static int
>  mpc52xx_uart_startup(struct uart_port *port)
>  {
>         struct mpc52xx_psc __iomem *psc = PSC(port);
> +       struct mpc52xx_psc_fifo __iomem *fifo = FIFO(port);
>         int ret;
>
>         /* Request IRQ */
> @@ -238,10 +240,10 @@ mpc52xx_uart_startup(struct uart_port *port)
>
>         out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /16 prescaler on */
>
> -       out_8(&psc->rfcntl, 0x00);
> -       out_be16(&psc->rfalarm, 0x1ff);
> -       out_8(&psc->tfcntl, 0x07);
> -       out_be16(&psc->tfalarm, 0x80);
> +       out_8(&fifo->rfcntl, 0x00);
> +       out_be16(&fifo->rfalarm, 0x1ff);
> +       out_8(&fifo->tfcntl, 0x07);
> +       out_be16(&fifo->tfalarm, 0x80);
>
>         port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | MPC52xx_PSC_IMR_TXRDY;
>         out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
> diff --git a/include/asm-powerpc/mpc52xx_psc.h b/include/asm-powerpc/mpc52xx_psc.h
> index 26690d2..bea42b9 100644
> --- a/include/asm-powerpc/mpc52xx_psc.h
> +++ b/include/asm-powerpc/mpc52xx_psc.h
> @@ -153,6 +153,9 @@ struct mpc52xx_psc {
>         u8              reserved16[3];
>         u8              irfdr;          /* PSC + 0x54 */
>         u8              reserved17[3];
> +};
> +
> +struct mpc52xx_psc_fifo {
>         u16             rfnum;          /* PSC + 0x58 */
>         u16             reserved18;
>         u16             tfnum;          /* PSC + 0x5c */
> diff --git a/include/asm-ppc/mpc52xx_psc.h b/include/asm-ppc/mpc52xx_psc.h
> index c82b8d4..39fcd02 100644
> --- a/include/asm-ppc/mpc52xx_psc.h
> +++ b/include/asm-ppc/mpc52xx_psc.h
> @@ -159,6 +159,9 @@ struct mpc52xx_psc {
>         u8              reserved16[3];
>         u8              irfdr;          /* PSC + 0x54 */
>         u8              reserved17[3];
> +};
> +
> +struct mpc52xx_psc_fifo {
>         u16             rfnum;          /* PSC + 0x58 */
>         u16             reserved18;
>         u16             tfnum;          /* PSC + 0x5c */
> --
> 1.5.3.5.726.g41a7a
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
