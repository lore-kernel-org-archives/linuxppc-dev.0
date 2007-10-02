Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by ozlabs.org (Postfix) with ESMTP id 90212DDF65
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:40:47 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so4678702fkz
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:40:45 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 06/18] [POWERPC] Fix UARTLITE reg io for little-endian
	architectures (ie. microblaze)
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 17:40:31 +0200
In-Reply-To: <20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Fri\, 28 Sep 2007 12\:17\:13 -0600")
Message-ID: <87abr134pc.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

 Grant> From: Grant Likely <grant.likely@secretlab.ca>
 Grant> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
 Grant> Acked-by: John Williams <jwilliams@itee.uq.edu.au>

Huh? This seems a bit confused. Microblaze is big endian and out_be32
is only defined in arch/p{,ower}pc.

This has been discussed before. The logical registers are 8bit, but
the OPB implementation (by virtue of it being a 32bit bus) uses
32bit spacing between the registers.

The fact is that the only portable access to non-pci registers in the
kernel is 8 bit.

The uartlite driver is ofcause primarily used to drive Xilinx
OPB_Uartlite IP blocks, but that's not the only use - E.G. we are
using another simple UART with the same hardware interface but sitting
on a 16bit bus. With the current driver this works fine, but won't
with the out_be32.

For a new design wi'll use an AT91 (arm). I don't see any reason why
we shouldn't be able to use the same UART block there.

 Grant> ---

 Grant>  arch/ppc/syslib/virtex_devices.c |    2 +-
 Grant>  drivers/serial/uartlite.c        |   32 ++++++++++++++++----------------
 Grant>  2 files changed, 17 insertions(+), 17 deletions(-)

 Grant> diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
 Grant> index ace4ec0..270ad3a 100644
 Grant> --- a/arch/ppc/syslib/virtex_devices.c
 Grant> +++ b/arch/ppc/syslib/virtex_devices.c
 Grant> @@ -28,7 +28,7 @@
 Grant>  	.num_resources = 2, \
 Grant>  	.resource = (struct resource[]) { \
 Grant>  		{ \
 Grant> -			.start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
 Grant> +			.start = XPAR_UARTLITE_##num##_BASEADDR, \
 Grant>  			.end = XPAR_UARTLITE_##num##_HIGHADDR, \
 Grant>  			.flags = IORESOURCE_MEM, \
 Grant>  		}, \
 Grant> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
 Grant> index f5051cf..59b674a 100644
 Grant> --- a/drivers/serial/uartlite.c
 Grant> +++ b/drivers/serial/uartlite.c
 Grant> @@ -61,7 +61,7 @@ static int ulite_receive(struct uart_port *port, int stat)
 Grant>  	/* stats */
 Grant>  	if (stat & ULITE_STATUS_RXVALID) {
 port-> icount.rx++;
 Grant> -		ch = readb(port->membase + ULITE_RX);
 Grant> +		ch = in_be32((void*)port->membase + ULITE_RX);
 
 Grant>  		if (stat & ULITE_STATUS_PARITY)
 port-> icount.parity++;
 Grant> @@ -106,7 +106,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 Grant>  		return 0;
 
 Grant>  	if (port->x_char) {
 Grant> -		writeb(port->x_char, port->membase + ULITE_TX);
 Grant> +		out_be32((void*)port->membase + ULITE_TX, port->x_char);
 port-> x_char = 0;
 port-> icount.tx++;
 Grant>  		return 1;
 Grant> @@ -115,7 +115,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 Grant>  	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 Grant>  		return 0;
 
 Grant> -	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
 Grant> +	out_be32((void*)port->membase + ULITE_TX, xmit->buf[xmit->tail]);
 xmit-> tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
 port-> icount.tx++;
 
 Grant> @@ -132,7 +132,7 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 Grant>  	int busy;
 
 Grant>  	do {
 Grant> -		int stat = readb(port->membase + ULITE_STATUS);
 Grant> +		int stat = in_be32((void*)port->membase + ULITE_STATUS);
 Grant>  		busy  = ulite_receive(port, stat);
 Grant>  		busy |= ulite_transmit(port, stat);
 Grant>  	} while (busy);
 Grant> @@ -148,7 +148,7 @@ static unsigned int ulite_tx_empty(struct uart_port *port)
 Grant>  	unsigned int ret;
 
 Grant>  	spin_lock_irqsave(&port->lock, flags);
 Grant> -	ret = readb(port->membase + ULITE_STATUS);
 Grant> +	ret = in_be32((void*)port->membase + ULITE_STATUS);
 Grant>  	spin_unlock_irqrestore(&port->lock, flags);
 
 Grant>  	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
 Grant> @@ -171,7 +171,7 @@ static void ulite_stop_tx(struct uart_port *port)
 
 Grant>  static void ulite_start_tx(struct uart_port *port)
 Grant>  {
 Grant> -	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
 Grant> +	ulite_transmit(port, in_be32((void*)port->membase + ULITE_STATUS));
 Grant>  }
 
 Grant>  static void ulite_stop_rx(struct uart_port *port)
 Grant> @@ -200,17 +200,17 @@ static int ulite_startup(struct uart_port *port)
 Grant>  	if (ret)
 Grant>  		return ret;
 
 Grant> -	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
 Grant> -	       port->membase + ULITE_CONTROL);
 Grant> -	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
 Grant> +	out_be32((void*)port->membase + ULITE_CONTROL,
 Grant> +	         ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
 Grant> +	out_be32((void*)port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
 
 Grant>  	return 0;
 Grant>  }
 
 Grant>  static void ulite_shutdown(struct uart_port *port)
 Grant>  {
 Grant> -	writeb(0, port->membase + ULITE_CONTROL);
 Grant> -	readb(port->membase + ULITE_CONTROL); /* dummy */
 Grant> +	out_be32((void*)port->membase + ULITE_CONTROL, 0);
 Grant> +	in_be32((void*)port->membase + ULITE_CONTROL); /* dummy */
 Grant>  	free_irq(port->irq, port);
 Grant>  }
 
 Grant> @@ -314,7 +314,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 
 Grant>  	/* wait up to 10ms for the character(s) to be sent */
 Grant>  	for (i = 0; i < 10000; i++) {
 Grant> -		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
 Grant> +		if (in_be32((void*)port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
 Grant>  			break;
 Grant>  		udelay(1);
 Grant>  	}
 Grant> @@ -323,7 +323,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 Grant>  static void ulite_console_putchar(struct uart_port *port, int ch)
 Grant>  {
 Grant>  	ulite_console_wait_tx(port);
 Grant> -	writeb(ch, port->membase + ULITE_TX);
 Grant> +	out_be32((void*)port->membase + ULITE_TX, ch);
 Grant>  }
 
 Grant>  static void ulite_console_write(struct console *co, const char *s,
 Grant> @@ -340,8 +340,8 @@ static void ulite_console_write(struct console *co, const char *s,
 Grant>  		spin_lock_irqsave(&port->lock, flags);
 
 Grant>  	/* save and disable interrupt */
 Grant> -	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
 Grant> -	writeb(0, port->membase + ULITE_CONTROL);
 Grant> +	ier = in_be32((void*)port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
 Grant> +	out_be32((void*)port->membase + ULITE_CONTROL, 0);
 
 Grant>  	uart_console_write(port, s, count, ulite_console_putchar);
 
 Grant> @@ -349,7 +349,7 @@ static void ulite_console_write(struct console *co, const char *s,
 
 Grant>  	/* restore interrupt state */
 Grant>  	if (ier)
 Grant> -		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
 Grant> +		out_be32((void*)port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
 
 Grant>  	if (locked)
 Grant>  		spin_unlock_irqrestore(&port->lock, flags);


-- 
Bye, Peter Korsgaard
