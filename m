Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3B2ADDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:12:12 +1100 (EST)
From: John Rigby <jrigby@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: [POWERPC] mpc5200: Factor out 52xx dependencies from 52xx psc driver
Date: Tue, 22 Jan 2008 12:12:04 -0700
Message-Id: <1201029124-454-1-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This version fixes the problem of no output
in userland on efika and liteb.

PSCs change from 5200 to 5121
this patch localizes the differences in
preparation for adding 5121 support

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 drivers/serial/mpc52xx_uart.c |  256 ++++++++++++++++++++++++++++++----------
 1 files changed, 192 insertions(+), 64 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 1e3721a..5bd1171 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -67,7 +67,6 @@
 #include <linux/serial.h>
 #include <linux/sysrq.h>
 #include <linux/console.h>
-
 #include <linux/delay.h>
 #include <linux/io.h>
 
@@ -111,8 +110,8 @@ static struct device_node *mpc52xx_uart_nodes[MPC52xx_PSC_MAXNUM];
 static void mpc52xx_uart_of_enumerate(void);
 #endif
 
+
 #define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
-#define FIFO(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
 
 
 /* Forward declaration of the interruption handling routine */
@@ -135,6 +134,162 @@ static struct of_device_id mpc52xx_uart_of_match[] = {
 };
 #endif
 
+/* ======================================================================== */
+/* PSC fifo operations for isolating differences between 52xx and 512x      */
+/* ======================================================================== */
+
+struct psc_ops {
+	void		(*fifo_init)(struct uart_port *port);
+	int		(*raw_rx_rdy)(struct uart_port *port);
+	int		(*raw_tx_rdy)(struct uart_port *port);
+	int		(*rx_rdy)(struct uart_port *port);
+	int		(*tx_rdy)(struct uart_port *port);
+	int		(*tx_empty)(struct uart_port *port);
+	void		(*stop_rx)(struct uart_port *port);
+	void		(*start_tx)(struct uart_port *port);
+	void		(*stop_tx)(struct uart_port *port);
+	void		(*rx_clr_irq)(struct uart_port *port);
+	void		(*tx_clr_irq)(struct uart_port *port);
+	void		(*write_char)(struct uart_port *port, unsigned char c);
+	unsigned char	(*read_char)(struct uart_port *port);
+	void		(*cw_disable_ints)(struct uart_port *port);
+	void		(*cw_restore_ints)(struct uart_port *port);
+	unsigned long	(*getuartclk)(void *p);
+};
+
+#define FIFO_52xx(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
+static void mpc52xx_psc_fifo_init(struct uart_port *port)
+{
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+	struct mpc52xx_psc_fifo __iomem *fifo = FIFO_52xx(port);
+
+	/* /32 prescaler */
+	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
+
+	out_8(&fifo->rfcntl, 0x00);
+	out_be16(&fifo->rfalarm, 0x1ff);
+	out_8(&fifo->tfcntl, 0x07);
+	out_be16(&fifo->tfalarm, 0x80);
+
+	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | MPC52xx_PSC_IMR_TXRDY;
+	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
+}
+
+static int mpc52xx_psc_raw_rx_rdy(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_status)
+	    & MPC52xx_PSC_SR_RXRDY;
+}
+
+static int mpc52xx_psc_raw_tx_rdy(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_status)
+	    & MPC52xx_PSC_SR_TXRDY;
+}
+
+
+static int mpc52xx_psc_rx_rdy(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_isr)
+	    & port->read_status_mask
+	    & MPC52xx_PSC_IMR_RXRDY;
+}
+
+static int mpc52xx_psc_tx_rdy(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_isr)
+	    & port->read_status_mask
+	    & MPC52xx_PSC_IMR_TXRDY;
+}
+
+static int mpc52xx_psc_tx_empty(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_status)
+	    & MPC52xx_PSC_SR_TXEMP;
+}
+
+static void mpc52xx_psc_start_tx(struct uart_port *port)
+{
+	port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+}
+
+static void mpc52xx_psc_stop_tx(struct uart_port *port)
+{
+	port->read_status_mask &= ~MPC52xx_PSC_IMR_TXRDY;
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+}
+
+static void mpc52xx_psc_stop_rx(struct uart_port *port)
+{
+	port->read_status_mask &= ~MPC52xx_PSC_IMR_RXRDY;
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+}
+
+static void mpc52xx_psc_rx_clr_irq(struct uart_port *port)
+{
+}
+
+static void mpc52xx_psc_tx_clr_irq(struct uart_port *port)
+{
+}
+
+static void mpc52xx_psc_write_char(struct uart_port *port, unsigned char c)
+{
+	out_8(&PSC(port)->mpc52xx_psc_buffer_8, c);
+}
+
+static unsigned char mpc52xx_psc_read_char(struct uart_port *port)
+{
+	return in_8(&PSC(port)->mpc52xx_psc_buffer_8);
+}
+
+static void mpc52xx_psc_cw_disable_ints(struct uart_port *port)
+{
+	out_be16(&PSC(port)->mpc52xx_psc_imr, 0);
+}
+
+static void mpc52xx_psc_cw_restore_ints(struct uart_port *port)
+{
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+}
+
+/* Search for bus-frequency property in this node or a parent */
+static unsigned long mpc52xx_getuartclk(void *p)
+{
+#if defined(CONFIG_PPC_MERGE)
+	/*
+	 * 5200 UARTs have a / 32 prescaler
+	 * but the generic serial code assumes 16
+	 * so return ipb freq / 2
+	 */
+	return mpc52xx_find_ipb_freq(p) / 2;
+#else
+	pr_debug("unexpected call to mpc52xx_getuartclk with arch/ppc\n");
+	return NULL;
+#endif
+}
+
+static struct psc_ops mpc52xx_psc_ops = {
+	.fifo_init = mpc52xx_psc_fifo_init,
+	.raw_rx_rdy = mpc52xx_psc_raw_rx_rdy,
+	.raw_tx_rdy = mpc52xx_psc_raw_tx_rdy,
+	.rx_rdy = mpc52xx_psc_rx_rdy,
+	.tx_rdy = mpc52xx_psc_tx_rdy,
+	.tx_empty = mpc52xx_psc_tx_empty,
+	.stop_rx = mpc52xx_psc_stop_rx,
+	.start_tx = mpc52xx_psc_start_tx,
+	.stop_tx = mpc52xx_psc_stop_tx,
+	.rx_clr_irq = mpc52xx_psc_rx_clr_irq,
+	.tx_clr_irq = mpc52xx_psc_tx_clr_irq,
+	.write_char = mpc52xx_psc_write_char,
+	.read_char = mpc52xx_psc_read_char,
+	.cw_disable_ints = mpc52xx_psc_cw_disable_ints,
+	.cw_restore_ints = mpc52xx_psc_cw_restore_ints,
+	.getuartclk = mpc52xx_getuartclk,
+};
+
+static struct psc_ops *psc_ops = &mpc52xx_psc_ops;
 
 /* ======================================================================== */
 /* UART operations                                                          */
@@ -143,8 +298,7 @@ static struct of_device_id mpc52xx_uart_of_match[] = {
 static unsigned int
 mpc52xx_uart_tx_empty(struct uart_port *port)
 {
-	int status = in_be16(&PSC(port)->mpc52xx_psc_status);
-	return (status & MPC52xx_PSC_SR_TXEMP) ? TIOCSER_TEMT : 0;
+	return psc_ops->tx_empty(port) ? TIOCSER_TEMT : 0;
 }
 
 static void
@@ -164,16 +318,14 @@ static void
 mpc52xx_uart_stop_tx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
-	port->read_status_mask &= ~MPC52xx_PSC_IMR_TXRDY;
-	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->stop_tx(port);
 }
 
 static void
 mpc52xx_uart_start_tx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
-	port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
-	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->start_tx(port);
 }
 
 static void
@@ -186,8 +338,7 @@ mpc52xx_uart_send_xchar(struct uart_port *port, char ch)
 	if (ch) {
 		/* Make sure tx interrupts are on */
 		/* Truly necessary ??? They should be anyway */
-		port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
-		out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+		psc_ops->start_tx(port);
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -197,8 +348,7 @@ static void
 mpc52xx_uart_stop_rx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
-	port->read_status_mask &= ~MPC52xx_PSC_IMR_RXRDY;
-	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->stop_rx(port);
 }
 
 static void
@@ -225,7 +375,6 @@ static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
-	struct mpc52xx_psc_fifo __iomem *fifo = FIFO(port);
 	int ret;
 
 	/* Request IRQ */
@@ -240,15 +389,7 @@ mpc52xx_uart_startup(struct uart_port *port)
 
 	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
 
-	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /16 prescaler on */
-
-	out_8(&fifo->rfcntl, 0x00);
-	out_be16(&fifo->rfalarm, 0x1ff);
-	out_8(&fifo->tfcntl, 0x07);
-	out_be16(&fifo->tfalarm, 0x80);
-
-	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | MPC52xx_PSC_IMR_TXRDY;
-	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->fifo_init(port);
 
 	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
 	out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
@@ -331,8 +472,7 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	 * boot for the console, all stuff is not yet ready to receive at that
 	 * time and that just makes the kernel oops */
 	/* while (j-- && mpc52xx_uart_int_rx_chars(port)); */
-	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
-	       --j)
+	while (!mpc52xx_uart_tx_empty(port) && --j)
 		udelay(1);
 
 	if (!j)
@@ -460,11 +600,9 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 	unsigned short status;
 
 	/* While we can read, do so ! */
-	while ((status = in_be16(&PSC(port)->mpc52xx_psc_status)) &
-		MPC52xx_PSC_SR_RXRDY) {
-
+	while (psc_ops->raw_rx_rdy(port)) {
 		/* Get the char */
-		ch = in_8(&PSC(port)->mpc52xx_psc_buffer_8);
+		ch = psc_ops->read_char(port);
 
 		/* Handle sysreq char */
 #ifdef SUPPORT_SYSRQ
@@ -479,6 +617,8 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
+		status = in_be16(&PSC(port)->mpc52xx_psc_status);
+
 		if (status & (MPC52xx_PSC_SR_PE |
 			      MPC52xx_PSC_SR_FE |
 			      MPC52xx_PSC_SR_RB)) {
@@ -508,7 +648,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 
 	tty_flip_buffer_push(tty);
 
-	return in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY;
+	return psc_ops->raw_rx_rdy(port);
 }
 
 static inline int
@@ -518,7 +658,7 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 
 	/* Process out of band chars */
 	if (port->x_char) {
-		out_8(&PSC(port)->mpc52xx_psc_buffer_8, port->x_char);
+		psc_ops->write_char(port, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
 		return 1;
@@ -531,8 +671,8 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 	}
 
 	/* Send chars */
-	while (in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXRDY) {
-		out_8(&PSC(port)->mpc52xx_psc_buffer_8, xmit->buf[xmit->tail]);
+	while (psc_ops->raw_tx_rdy(port)) {
+		psc_ops->write_char(port, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		if (uart_circ_empty(xmit))
@@ -558,7 +698,6 @@ mpc52xx_uart_int(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	unsigned long pass = ISR_PASS_LIMIT;
 	unsigned int keepgoing;
-	unsigned short status;
 
 	spin_lock(&port->lock);
 
@@ -567,18 +706,12 @@ mpc52xx_uart_int(int irq, void *dev_id)
 		/* If we don't find anything to do, we stop */
 		keepgoing = 0;
 
-		/* Read status */
-		status = in_be16(&PSC(port)->mpc52xx_psc_isr);
-		status &= port->read_status_mask;
-
-		/* Do we need to receive chars ? */
-		/* For this RX interrupts must be on and some chars waiting */
-		if (status & MPC52xx_PSC_IMR_RXRDY)
+		psc_ops->rx_clr_irq(port);
+		if (psc_ops->rx_rdy(port))
 			keepgoing |= mpc52xx_uart_int_rx_chars(port);
 
-		/* Do we need to send chars ? */
-		/* For this, TX must be ready and TX interrupt enabled */
-		if (status & MPC52xx_PSC_IMR_TXRDY)
+		psc_ops->tx_clr_irq(port);
+		if (psc_ops->tx_rdy(port))
 			keepgoing |= mpc52xx_uart_int_tx_chars(port);
 
 		/* Limit number of iteration */
@@ -645,36 +778,33 @@ static void
 mpc52xx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
-	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned int i, j;
 
 	/* Disable interrupts */
-	out_be16(&psc->mpc52xx_psc_imr, 0);
+	psc_ops->cw_disable_ints(port);
 
 	/* Wait the TX buffer to be empty */
 	j = 5000000;	/* Maximum wait */
-	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
-	       --j)
+	while (!mpc52xx_uart_tx_empty(port) && --j)
 		udelay(1);
 
 	/* Write all the chars */
 	for (i = 0; i < count; i++, s++) {
 		/* Line return handling */
 		if (*s == '\n')
-			out_8(&psc->mpc52xx_psc_buffer_8, '\r');
+			psc_ops->write_char(port, '\r');
 
 		/* Send the char */
-		out_8(&psc->mpc52xx_psc_buffer_8, *s);
+		psc_ops->write_char(port, *s);
 
 		/* Wait the TX buffer to be empty */
 		j = 20000;	/* Maximum wait */
-		while (!(in_be16(&psc->mpc52xx_psc_status) &
-			 MPC52xx_PSC_SR_TXEMP) && --j)
+		while (!mpc52xx_uart_tx_empty(port) && --j)
 			udelay(1);
 	}
 
 	/* Restore interrupt state */
-	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->cw_restore_ints(port);
 }
 
 #if !defined(CONFIG_PPC_MERGE)
@@ -719,7 +849,7 @@ mpc52xx_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
 	struct device_node *np = mpc52xx_uart_nodes[co->index];
-	unsigned int ipb_freq;
+	unsigned int uartclk;
 	struct resource res;
 	int ret;
 
@@ -751,17 +881,16 @@ mpc52xx_console_setup(struct console *co, char *options)
 		return ret;
 	}
 
-	/* Search for bus-frequency property in this node or a parent */
-	ipb_freq = mpc52xx_find_ipb_freq(np);
-	if (ipb_freq == 0) {
-		pr_debug("Could not find IPB bus frequency!\n");
+	uartclk = psc_ops->getuartclk(np);
+	if (uartclk == 0) {
+		pr_debug("Could not find uart clock frequency!\n");
 		return -EINVAL;
 	}
 
 	/* Basic port init. Needed since we use some uart_??? func before
 	 * real init for early access */
 	spin_lock_init(&port->lock);
-	port->uartclk	= ipb_freq / 2;
+	port->uartclk = uartclk;
 	port->ops	= &mpc52xx_uart_ops;
 	port->mapbase = res.start;
 	port->membase = ioremap(res.start, sizeof(struct mpc52xx_psc));
@@ -947,7 +1076,7 @@ static int __devinit
 mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 {
 	int idx = -1;
-	unsigned int ipb_freq;
+	unsigned int uartclk;
 	struct uart_port *port = NULL;
 	struct resource res;
 	int ret;
@@ -963,10 +1092,9 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	pr_debug("Found %s assigned to ttyPSC%x\n",
 		 mpc52xx_uart_nodes[idx]->full_name, idx);
 
-	/* Search for bus-frequency property in this node or a parent */
-	ipb_freq = mpc52xx_find_ipb_freq(op->node);
-	if (ipb_freq == 0) {
-		dev_dbg(&op->dev, "Could not find IPB bus frequency!\n");
+	uartclk = psc_ops->getuartclk(op->node);
+	if (uartclk == 0) {
+		dev_dbg(&op->dev, "Could not find uart clock frequency!\n");
 		return -EINVAL;
 	}
 
@@ -974,7 +1102,7 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	port = &mpc52xx_uart_ports[idx];
 
 	spin_lock_init(&port->lock);
-	port->uartclk	= ipb_freq / 2;
+	port->uartclk = uartclk;
 	port->fifosize	= 512;
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF |
-- 
1.5.3.5.726.g41a7a
