Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 27BDEDDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 00:20:26 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so1716558wag.9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:20:25 -0700 (PDT)
Date: Wed, 24 Sep 2008 08:20:16 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Sinisa Denic <sinisa.denic@abs-cs.com>
Subject: Re: mpc52xx_uart and rs485
Message-ID: <20080924142015.GA12119@secretlab.ca>
References: <WorldClient-F200808141123.AA23490073@abs-cs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <WorldClient-F200808141123.AA23490073@abs-cs.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 11:23:49AM +0200, Sinisa Denic wrote:
> From bf050adbc092043c1ba6e43373563bb761bb2e40 Mon Sep 17 00:00:00 2001
> From: Sinisa Denic <sinisa.denic@abs-cs.com>
> Date: Wed, 13 Aug 2008 15:57:52 +0200
> Subject: [PATCH] mpc52xx_uart RS485 support added
> 
> Hi Wolfgang and others, 
> below is patch for mpc52xx_usrt.c which add software rs485 support to 
> this driver.
> It has worked for me and if you think it is good enough it might be 
> useful for someone else.

Thanks for the patch.  I've made a number of comments below and it
appears that your mail client has damaged the patch.  Can you please
respin after addressing the comments.  When you repost, please include a
technical description of what you have done and why.

Thanks,
g.

> ---
>  drivers/serial/mpc52xx_uart.c |   47 +++++++++++++++++++++++++++++++++
> +-------
>  1 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 7a3625f..38b2751 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -62,7 +62,7 @@
>   * by the bootloader or in the platform init code.
>   */
>  
> -#undef DEBUG
> +//#undef DEBUG

Unrelated changes; please remove.

>  
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -142,11 +142,13 @@ struct psc_ops {
>  	int		(*rx_rdy)(struct uart_port *port);
>  	int		(*tx_rdy)(struct uart_port *port);
>  	int		(*tx_empty)(struct uart_port *port);
> +	int		(*tx_empty_enabled)(struct uart_port *port);
>  	void		(*stop_rx)(struct uart_port *port);
>  	void		(*start_tx)(struct uart_port *port);
>  	void		(*stop_tx)(struct uart_port *port);
>  	void		(*rx_clr_irq)(struct uart_port *port);
>  	void		(*tx_clr_irq)(struct uart_port *port);
> +	void		(*tx_empty_clr_irq)(struct uart_port *port);
>  	void		(*write_char)(struct uart_port *port, unsigned 
> char c);
>  	unsigned char	(*read_char)(struct uart_port *port);
>  	void		(*cw_disable_ints)(struct uart_port *port);
> @@ -169,7 +171,7 @@ static void mpc52xx_psc_fifo_init(struct uart_port 
> *port)
>  	out_8(&fifo->tfcntl, 0x07);
>  	out_be16(&fifo->tfalarm, 0x80);
>  
> -	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | 
> MPC52xx_PSC_IMR_TXRDY;
> +	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | 
> MPC52xx_PSC_IMR_TXRDY | MPC52xx_PSC_IMR_TXEMP; 

Patch was line wrapped here by your mailer

>  	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
>  }
>  
> @@ -200,6 +202,13 @@ static int mpc52xx_psc_tx_rdy(struct uart_port *port)
>  	    & MPC52xx_PSC_IMR_TXRDY;
>  }
>  
> +static int mpc52xx_psc_tx_empty_enabled(struct uart_port *port)
> +{
> +	return in_be16(&PSC(port)->mpc52xx_psc_isr)
> +	    & port->read_status_mask
> +	    & MPC52xx_PSC_IMR_TXEMP;
> +}
> +
>  static int mpc52xx_psc_tx_empty(struct uart_port *port)
>  {
>  	return in_be16(&PSC(port)->mpc52xx_psc_status)
> @@ -209,6 +218,7 @@ static int mpc52xx_psc_tx_empty(struct uart_port 
> *port)
>  static void mpc52xx_psc_start_tx(struct uart_port *port)
>  {
>  	port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
> +	port->read_status_mask |= MPC52xx_PSC_IMR_TXEMP;

You're enabling the TXEMP interrupts unconditionally, regardless of
whether or not rs485 is used.  This adds performance impact to
non-rs485 users.

>  	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
>  }
>  
> @@ -232,6 +242,11 @@ static void mpc52xx_psc_tx_clr_irq(struct uart_port 
> *port)
>  {
>  }
>  
> +static void mpc52xx_psc_tx_empty_clr_irq(struct uart_port *port)
> +{
> +	port->read_status_mask &= ~MPC52xx_PSC_IMR_TXEMP;
> +	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
> +}
>  static void mpc52xx_psc_write_char(struct uart_port *port, unsigned char 
> c)
>  {
>  	out_8(&PSC(port)->mpc52xx_psc_buffer_8, c);
> @@ -275,11 +290,13 @@ static struct psc_ops mpc52xx_psc_ops = {
>  	.rx_rdy = mpc52xx_psc_rx_rdy,
>  	.tx_rdy = mpc52xx_psc_tx_rdy,
>  	.tx_empty = mpc52xx_psc_tx_empty,
> +	.tx_empty_enabled = mpc52xx_psc_tx_empty_enabled,
>  	.stop_rx = mpc52xx_psc_stop_rx,
>  	.start_tx = mpc52xx_psc_start_tx,
>  	.stop_tx = mpc52xx_psc_stop_tx,
>  	.rx_clr_irq = mpc52xx_psc_rx_clr_irq,
>  	.tx_clr_irq = mpc52xx_psc_tx_clr_irq,
> +	.tx_empty_clr_irq = mpc52xx_psc_tx_empty_clr_irq,
>  	.write_char = mpc52xx_psc_write_char,
>  	.read_char = mpc52xx_psc_read_char,
>  	.cw_disable_ints = mpc52xx_psc_cw_disable_ints,
> @@ -583,7 +600,7 @@ mpc52xx_uart_set_termios(struct uart_port *port, 
> struct ktermios *new,
>  
>  
>  	mr2 = 0;
> -
> +	

Unrelated whitespace change; please omit from patch

>  	if (new->c_cflag & CSTOPB)
>  		mr2 |= MPC52xx_PSC_MODE_TWO_STOP;
>  	else
> @@ -591,7 +608,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, 
> struct ktermios *new,
>  			MPC52xx_PSC_MODE_ONE_STOP_5_BITS :
>  			MPC52xx_PSC_MODE_ONE_STOP;
>  
> -

Ditto

>  	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
>  	quot = uart_get_divisor(port, baud);
>  	ctr = quot & 0xffff;
> @@ -735,7 +751,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
>  	struct tty_struct *tty = port->info->tty;
>  	unsigned char ch, flag;
>  	unsigned short status;
> -
> +	//printk("Int. citanje...\n");

Remove

>  	/* While we can read, do so ! */
>  	while (psc_ops->raw_rx_rdy(port)) {
>  		/* Get the char */
> @@ -792,7 +808,9 @@ static inline int
>  mpc52xx_uart_int_tx_chars(struct uart_port *port)
>  {
>  	struct circ_buf *xmit = &port->info->xmit;
> +	out_8(&PSC(port)->op1,1);
>  
> +//	printk("Int. slanje...\n");

Remove

>  	/* Process out of band chars */
>  	if (port->x_char) {
>  		psc_ops->write_char(port, port->x_char);
> @@ -812,8 +830,10 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
>  		psc_ops->write_char(port, xmit->buf[xmit->tail]);
>  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>  		port->icount.tx++;
> -		if (uart_circ_empty(xmit))
> +		if (uart_circ_empty(xmit)){
> +//		printk("Uart circular buffer is empty!!\n");
>  			break;
> +			}

Remove

>  	}
>  
>  	/* Wake up */
> @@ -828,7 +848,15 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
>  
>  	return 1;
>  }
> -
> +static inline int
> +mpc52xx_uart_int_tx_empty(struct uart_port *port)
> +{
> +	out_8(&PSC(port)->op0,1);
> +	port->read_status_mask &= ~MPC52xx_PSC_IMR_TXEMP;
> +	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
> +//printk("tx_empty_interrupt!\n");

Remove debug line.

> +	return 0;
> +}
>  static irqreturn_t
>  mpc52xx_uart_int(int irq, void *dev_id)
>  {
> @@ -850,7 +878,10 @@ mpc52xx_uart_int(int irq, void *dev_id)
>  		psc_ops->tx_clr_irq(port);
>  		if (psc_ops->tx_rdy(port))
>  			keepgoing |= mpc52xx_uart_int_tx_chars(port);
> -
> +		if (psc_ops->tx_empty_enabled(port)){
> +			keepgoing |= mpc52xx_uart_int_tx_empty(port);
> +//			psc_ops->tx_empty_clr_irq(port);
> +		}

It isn't clear what this code is doing.
mpc52xx_uart_int_tx_empty() only ever returns 0, so it will not change
the value of keepgoing.  The call to mpc52xx_uart_int_tx_empty() will
clear the TXEMP mask, but you need to describe why it is done.

>  		/* Limit number of iteration */
>  		if (!(--pass))
>  			keepgoing = 0;
> -- 
> 1.5.4.5
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
