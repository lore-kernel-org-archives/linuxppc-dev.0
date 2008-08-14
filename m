Return-Path: <SRS0+/Mdb+65+abs-cs.com=sinisa.denic@beotel.net>
Received: from beotel.net (mail.beotel.net [194.106.162.23])
	by ozlabs.org (Postfix) with ESMTP id BA5F3DDDE1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 19:41:31 +1000 (EST)
Received: from abs-beograd.co.yu (unverified [80.93.243.15])
	by beotel.net (SurgeMail 3.7b6) with ESMTP id 1951755
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 11:26:14 +0200
Received: from WorldClient by abs-beograd.co.yu (MDaemon PRO v9.6.6)
	with ESMTP id md50000141882.msg
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 11:23:52 +0200
Date: Thu, 14 Aug 2008 11:23:49 +0200
From: "Sinisa Denic" <sinisa.denic@abs-cs.com>
To: <linuxppc-dev@ozlabs.org>
Subject: mpc52xx_uart and rs485
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <WorldClient-F200808141123.AA23490073@abs-cs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From bf050adbc092043c1ba6e43373563bb761bb2e40 Mon Sep 17 00:00:00 2001
From: Sinisa Denic <sinisa.denic@abs-cs.com>
Date: Wed, 13 Aug 2008 15:57:52 +0200
Subject: [PATCH] mpc52xx_uart RS485 support added

Hi Wolfgang and others, 
below is patch for mpc52xx_usrt.c which add software rs485 support to 
this driver.
It has worked for me and if you think it is good enough it might be 
useful for someone else.
Regards, 
Sinisa Denic
System and software  engineer
tel: +381(0)112016142
ABS Control Systems
bul.Zorana Djindjica 8a
Belgrade,Serbia
---
 drivers/serial/mpc52xx_uart.c |   47 +++++++++++++++++++++++++++++++++
+-------
 1 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 7a3625f..38b2751 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -62,7 +62,7 @@
  * by the bootloader or in the platform init code.
  */
 
-#undef DEBUG
+//#undef DEBUG
 
 #include <linux/device.h>
 #include <linux/module.h>
@@ -142,11 +142,13 @@ struct psc_ops {
 	int		(*rx_rdy)(struct uart_port *port);
 	int		(*tx_rdy)(struct uart_port *port);
 	int		(*tx_empty)(struct uart_port *port);
+	int		(*tx_empty_enabled)(struct uart_port *port);
 	void		(*stop_rx)(struct uart_port *port);
 	void		(*start_tx)(struct uart_port *port);
 	void		(*stop_tx)(struct uart_port *port);
 	void		(*rx_clr_irq)(struct uart_port *port);
 	void		(*tx_clr_irq)(struct uart_port *port);
+	void		(*tx_empty_clr_irq)(struct uart_port *port);
 	void		(*write_char)(struct uart_port *port, unsigned 
char c);
 	unsigned char	(*read_char)(struct uart_port *port);
 	void		(*cw_disable_ints)(struct uart_port *port);
@@ -169,7 +171,7 @@ static void mpc52xx_psc_fifo_init(struct uart_port 
*port)
 	out_8(&fifo->tfcntl, 0x07);
 	out_be16(&fifo->tfalarm, 0x80);
 
-	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | 
MPC52xx_PSC_IMR_TXRDY;
+	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | 
MPC52xx_PSC_IMR_TXRDY | MPC52xx_PSC_IMR_TXEMP; 
 	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
 }
 
@@ -200,6 +202,13 @@ static int mpc52xx_psc_tx_rdy(struct uart_port *port)
 	    & MPC52xx_PSC_IMR_TXRDY;
 }
 
+static int mpc52xx_psc_tx_empty_enabled(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_isr)
+	    & port->read_status_mask
+	    & MPC52xx_PSC_IMR_TXEMP;
+}
+
 static int mpc52xx_psc_tx_empty(struct uart_port *port)
 {
 	return in_be16(&PSC(port)->mpc52xx_psc_status)
@@ -209,6 +218,7 @@ static int mpc52xx_psc_tx_empty(struct uart_port 
*port)
 static void mpc52xx_psc_start_tx(struct uart_port *port)
 {
 	port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
+	port->read_status_mask |= MPC52xx_PSC_IMR_TXEMP;
 	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 }
 
@@ -232,6 +242,11 @@ static void mpc52xx_psc_tx_clr_irq(struct uart_port 
*port)
 {
 }
 
+static void mpc52xx_psc_tx_empty_clr_irq(struct uart_port *port)
+{
+	port->read_status_mask &= ~MPC52xx_PSC_IMR_TXEMP;
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+}
 static void mpc52xx_psc_write_char(struct uart_port *port, unsigned char 
c)
 {
 	out_8(&PSC(port)->mpc52xx_psc_buffer_8, c);
@@ -275,11 +290,13 @@ static struct psc_ops mpc52xx_psc_ops = {
 	.rx_rdy = mpc52xx_psc_rx_rdy,
 	.tx_rdy = mpc52xx_psc_tx_rdy,
 	.tx_empty = mpc52xx_psc_tx_empty,
+	.tx_empty_enabled = mpc52xx_psc_tx_empty_enabled,
 	.stop_rx = mpc52xx_psc_stop_rx,
 	.start_tx = mpc52xx_psc_start_tx,
 	.stop_tx = mpc52xx_psc_stop_tx,
 	.rx_clr_irq = mpc52xx_psc_rx_clr_irq,
 	.tx_clr_irq = mpc52xx_psc_tx_clr_irq,
+	.tx_empty_clr_irq = mpc52xx_psc_tx_empty_clr_irq,
 	.write_char = mpc52xx_psc_write_char,
 	.read_char = mpc52xx_psc_read_char,
 	.cw_disable_ints = mpc52xx_psc_cw_disable_ints,
@@ -583,7 +600,7 @@ mpc52xx_uart_set_termios(struct uart_port *port, 
struct ktermios *new,
 
 
 	mr2 = 0;
-
+	
 	if (new->c_cflag & CSTOPB)
 		mr2 |= MPC52xx_PSC_MODE_TWO_STOP;
 	else
@@ -591,7 +608,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, 
struct ktermios *new,
 			MPC52xx_PSC_MODE_ONE_STOP_5_BITS :
 			MPC52xx_PSC_MODE_ONE_STOP;
 
-
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
 	quot = uart_get_divisor(port, baud);
 	ctr = quot & 0xffff;
@@ -735,7 +751,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 	struct tty_struct *tty = port->info->tty;
 	unsigned char ch, flag;
 	unsigned short status;
-
+	//printk("Int. citanje...\n");
 	/* While we can read, do so ! */
 	while (psc_ops->raw_rx_rdy(port)) {
 		/* Get the char */
@@ -792,7 +808,9 @@ static inline int
 mpc52xx_uart_int_tx_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->info->xmit;
+	out_8(&PSC(port)->op1,1);
 
+//	printk("Int. slanje...\n");
 	/* Process out of band chars */
 	if (port->x_char) {
 		psc_ops->write_char(port, port->x_char);
@@ -812,8 +830,10 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 		psc_ops->write_char(port, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
-		if (uart_circ_empty(xmit))
+		if (uart_circ_empty(xmit)){
+//		printk("Uart circular buffer is empty!!\n");
 			break;
+			}
 	}
 
 	/* Wake up */
@@ -828,7 +848,15 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 
 	return 1;
 }
-
+static inline int
+mpc52xx_uart_int_tx_empty(struct uart_port *port)
+{
+	out_8(&PSC(port)->op0,1);
+	port->read_status_mask &= ~MPC52xx_PSC_IMR_TXEMP;
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+//printk("tx_empty_interrupt!\n");
+	return 0;
+}
 static irqreturn_t
 mpc52xx_uart_int(int irq, void *dev_id)
 {
@@ -850,7 +878,10 @@ mpc52xx_uart_int(int irq, void *dev_id)
 		psc_ops->tx_clr_irq(port);
 		if (psc_ops->tx_rdy(port))
 			keepgoing |= mpc52xx_uart_int_tx_chars(port);
-
+		if (psc_ops->tx_empty_enabled(port)){
+			keepgoing |= mpc52xx_uart_int_tx_empty(port);
+//			psc_ops->tx_empty_clr_irq(port);
+		}
 		/* Limit number of iteration */
 		if (!(--pass))
 			keepgoing = 0;
-- 
1.5.4.5
