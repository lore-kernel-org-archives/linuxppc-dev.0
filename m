Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 0A06967DEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 19:40:30 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWERPC] whitespace cleanup
Date: Wed,  1 Nov 2006 01:39:53 -0700
Message-Id: <1162370407105-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11623704071131-git-send-email-grant.likely@secretlab.ca>
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>
	<11623704061869-git-send-email-grant.likely@secretlab.ca>
	<11623704063907-git-send-email-grant.likely@secretlab.ca>
	<11623704071131-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Performed here to make the next patch (of_platform support) cleaner...  And,
yes, I know that whitespace patches are debatable, but I'm being lazy and this
is easier that trying to take my whitespace changes back out.  :P

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/serial/mpc52xx_uart.c |  114 ++++++++++++++++++++---------------------
 1 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 4f80c5b..29c9300 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1,6 +1,4 @@
 /*
- * drivers/serial/mpc52xx_uart.c
- *
  * Driver for the PSC of the Freescale MPC52xx PSCs configured as UARTs.
  *
  * FIXME According to the usermanual the status bits in the status register
@@ -14,18 +12,18 @@
  *
  *
  * Maintainer : Sylvain Munaut <tnt@246tNt.com>
- * 
+ *
  * Some of the code has been inspired/copied from the 2.4 code written
  * by Dale Farnsworth <dfarnsworth@mvista.com>.
- * 
+ *
  * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
  * Copyright (C) 2003 MontaVista, Software, Inc.
- * 
+ *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  */
- 
+
 /* Platform device Usage :
  *
  * Since PSCs can have multiple function, the correct driver for each one
@@ -101,27 +99,27 @@ #endif
 /* UART operations                                                          */
 /* ======================================================================== */
 
-static unsigned int 
+static unsigned int
 mpc52xx_uart_tx_empty(struct uart_port *port)
 {
 	int status = in_be16(&PSC(port)->mpc52xx_psc_status);
 	return (status & MPC52xx_PSC_SR_TXEMP) ? TIOCSER_TEMT : 0;
 }
 
-static void 
+static void
 mpc52xx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	/* Not implemented */
 }
 
-static unsigned int 
+static unsigned int
 mpc52xx_uart_get_mctrl(struct uart_port *port)
 {
 	/* Not implemented */
 	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
 }
 
-static void 
+static void
 mpc52xx_uart_stop_tx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
@@ -129,7 +127,7 @@ mpc52xx_uart_stop_tx(struct uart_port *p
 	out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
 }
 
-static void 
+static void
 mpc52xx_uart_start_tx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
@@ -137,12 +135,12 @@ mpc52xx_uart_start_tx(struct uart_port *
 	out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
 }
 
-static void 
+static void
 mpc52xx_uart_send_xchar(struct uart_port *port, char ch)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&port->lock, flags);
-	
+
 	port->x_char = ch;
 	if (ch) {
 		/* Make sure tx interrupts are on */
@@ -150,7 +148,7 @@ mpc52xx_uart_send_xchar(struct uart_port
 		port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
 		out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
 	}
-	
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -178,7 +176,7 @@ mpc52xx_uart_break_ctl(struct uart_port 
 		out_8(&PSC(port)->command,MPC52xx_PSC_START_BRK);
 	else
 		out_8(&PSC(port)->command,MPC52xx_PSC_STOP_BRK);
-	
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -197,11 +195,11 @@ mpc52xx_uart_startup(struct uart_port *p
 	/* Reset/activate the port, clear and enable interrupts */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
 	out_8(&psc->command,MPC52xx_PSC_RST_TX);
-	
+
 	out_be32(&psc->sicr,0);	/* UART mode DCD ignored */
 
 	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /16 prescaler on */
-	
+
 	out_8(&psc->rfcntl, 0x00);
 	out_be16(&psc->rfalarm, 0x1ff);
 	out_8(&psc->tfcntl, 0x07);
@@ -209,10 +207,10 @@ mpc52xx_uart_startup(struct uart_port *p
 
 	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | MPC52xx_PSC_IMR_TXRDY;
 	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
-	
+
 	out_8(&psc->command,MPC52xx_PSC_TX_ENABLE);
 	out_8(&psc->command,MPC52xx_PSC_RX_ENABLE);
-		
+
 	return 0;
 }
 
@@ -220,19 +218,19 @@ static void
 mpc52xx_uart_shutdown(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
-	
+
 	/* Shut down the port, interrupt and all */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
 	out_8(&psc->command,MPC52xx_PSC_RST_TX);
-	
-	port->read_status_mask = 0; 
+
+	port->read_status_mask = 0;
 	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
 
 	/* Release interrupt */
 	free_irq(port->irq, port);
 }
 
-static void 
+static void
 mpc52xx_uart_set_termios(struct uart_port *port, struct termios *new,
                          struct termios *old)
 {
@@ -241,10 +239,10 @@ mpc52xx_uart_set_termios(struct uart_por
 	unsigned char mr1, mr2;
 	unsigned short ctr;
 	unsigned int j, baud, quot;
-	
+
 	/* Prepare what we're gonna write */
 	mr1 = 0;
-	
+
 	switch (new->c_cflag & CSIZE) {
 		case CS5:	mr1 |= MPC52xx_PSC_MODE_5_BITS;
 				break;
@@ -261,8 +259,8 @@ mpc52xx_uart_set_termios(struct uart_por
 			MPC52xx_PSC_MODE_PARODD : MPC52xx_PSC_MODE_PAREVEN;
 	} else
 		mr1 |= MPC52xx_PSC_MODE_PARNONE;
-	
-	
+
+
 	mr2 = 0;
 
 	if (new->c_cflag & CSTOPB)
@@ -276,7 +274,7 @@ mpc52xx_uart_set_termios(struct uart_por
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
 	quot = uart_get_divisor(port, baud);
 	ctr = quot & 0xffff;
-	
+
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -290,14 +288,14 @@ mpc52xx_uart_set_termios(struct uart_por
 	 * boot for the console, all stuff is not yet ready to receive at that
 	 * time and that just makes the kernel oops */
 	/* while (j-- && mpc52xx_uart_int_rx_chars(port)); */
-	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) && 
+	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
 	       --j)
 		udelay(1);
 
 	if (!j)
 		printk(	KERN_ERR "mpc52xx_uart.c: "
 			"Unable to flush RX & TX fifos in-time in set_termios."
-			"Some chars may have been lost.\n" ); 
+			"Some chars may have been lost.\n" );
 
 	/* Reset the TX & RX */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
@@ -309,7 +307,7 @@ mpc52xx_uart_set_termios(struct uart_por
 	out_8(&psc->mode,mr2);
 	out_8(&psc->ctur,ctr >> 8);
 	out_8(&psc->ctlr,ctr & 0xff);
-	
+
 	/* Reenable TX & RX */
 	out_8(&psc->command,MPC52xx_PSC_TX_ENABLE);
 	out_8(&psc->command,MPC52xx_PSC_RX_ENABLE);
@@ -373,7 +371,7 @@ mpc52xx_uart_verify_port(struct uart_por
 
 	if ( (ser->irq != port->irq) ||
 	     (ser->io_type != SERIAL_IO_MEM) ||
-	     (ser->baud_base != port->uartclk)  || 
+	     (ser->baud_base != port->uartclk)  ||
 	     (ser->iomem_base != (void*)port->mapbase) ||
 	     (ser->hub6 != 0 ) )
 		return -EINVAL;
@@ -404,11 +402,11 @@ static struct uart_ops mpc52xx_uart_ops 
 	.verify_port	= mpc52xx_uart_verify_port
 };
 
-	
+
 /* ======================================================================== */
 /* Interrupt handling                                                       */
 /* ======================================================================== */
-	
+
 static inline int
 mpc52xx_uart_int_rx_chars(struct uart_port *port)
 {
@@ -435,11 +433,11 @@ #endif
 
 		flag = TTY_NORMAL;
 		port->icount.rx++;
-	
+
 		if ( status & (MPC52xx_PSC_SR_PE |
 		               MPC52xx_PSC_SR_FE |
 		               MPC52xx_PSC_SR_RB) ) {
-			
+
 			if (status & MPC52xx_PSC_SR_RB) {
 				flag = TTY_BREAK;
 				uart_handle_break(port);
@@ -464,7 +462,7 @@ #endif
 	}
 
 	tty_flip_buffer_push(tty);
-	
+
 	return in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY;
 }
 
@@ -509,25 +507,25 @@ mpc52xx_uart_int_tx_chars(struct uart_po
 	return 1;
 }
 
-static irqreturn_t 
+static irqreturn_t
 mpc52xx_uart_int(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	unsigned long pass = ISR_PASS_LIMIT;
 	unsigned int keepgoing;
 	unsigned short status;
-	
+
 	spin_lock(&port->lock);
-	
+
 	/* While we have stuff to do, we continue */
 	do {
 		/* If we don't find anything to do, we stop */
-		keepgoing = 0; 
-		
+		keepgoing = 0;
+
 		/* Read status */
 		status = in_be16(&PSC(port)->mpc52xx_psc_isr);
 		status &= port->read_status_mask;
-			
+
 		/* Do we need to receive chars ? */
 		/* For this RX interrupts must be on and some chars waiting */
 		if ( status & MPC52xx_PSC_IMR_RXRDY )
@@ -537,15 +535,15 @@ mpc52xx_uart_int(int irq, void *dev_id)
 		/* For this, TX must be ready and TX interrupt enabled */
 		if ( status & MPC52xx_PSC_IMR_TXRDY )
 			keepgoing |= mpc52xx_uart_int_tx_chars(port);
-		
+
 		/* Limit number of iteration */
 		if ( !(--pass) )
 			keepgoing = 0;
 
 	} while (keepgoing);
-	
+
 	spin_unlock(&port->lock);
-	
+
 	return IRQ_HANDLED;
 }
 
@@ -566,7 +564,7 @@ mpc52xx_console_get_options(struct uart_
 	/* Read the mode registers */
 	out_8(&psc->command,MPC52xx_PSC_SEL_MODE_REG_1);
 	mr1 = in_8(&psc->mode);
-	
+
 	/* CT{U,L}R are write-only ! */
 	*baud = __res.bi_baudrate ?
 		__res.bi_baudrate : CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
@@ -579,26 +577,26 @@ mpc52xx_console_get_options(struct uart_
 		case MPC52xx_PSC_MODE_8_BITS:
 		default:			*bits = 8;
 	}
-	
+
 	if (mr1 & MPC52xx_PSC_MODE_PARNONE)
 		*parity = 'n';
 	else
 		*parity = mr1 & MPC52xx_PSC_MODE_PARODD ? 'o' : 'e';
 }
 
-static void  
+static void
 mpc52xx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned int i, j;
-	
+
 	/* Disable interrupts */
 	out_be16(&psc->mpc52xx_psc_imr, 0);
 
 	/* Wait the TX buffer to be empty */
-	j = 5000000;	/* Maximum wait */	
-	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) && 
+	j = 5000000;	/* Maximum wait */
+	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
 	       --j)
 		udelay(1);
 
@@ -607,13 +605,13 @@ mpc52xx_console_write(struct console *co
 		/* Line return handling */
 		if (*s == '\n')
 			out_8(&psc->mpc52xx_psc_buffer_8, '\r');
-		
+
 		/* Send the char */
 		out_8(&psc->mpc52xx_psc_buffer_8, *s);
 
 		/* Wait the TX buffer to be empty */
-		j = 20000;	/* Maximum wait */	
-		while (!(in_be16(&psc->mpc52xx_psc_status) & 
+		j = 20000;	/* Maximum wait */
+		while (!(in_be16(&psc->mpc52xx_psc_status) &
 		         MPC52xx_PSC_SR_TXEMP) && --j)
 			udelay(1);
 	}
@@ -634,7 +632,7 @@ mpc52xx_console_setup(struct console *co
 
 	if (co->index < 0 || co->index >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
-	
+
 	/* Basic port init. Needed since we use some uart_??? func before
 	 * real init for early access */
 	spin_lock_init(&port->lock);
@@ -669,8 +667,8 @@ static struct console mpc52xx_console = 
 	.data	= &mpc52xx_uart_driver,
 };
 
-	
-static int __init 
+
+static int __init
 mpc52xx_console_init(void)
 {
 	register_console(&mpc52xx_console);
-- 
1.4.3.rc2.g0503
