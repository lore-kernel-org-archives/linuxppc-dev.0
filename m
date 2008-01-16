Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 087F3DDEA2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 08:37:42 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0GLbXvW027139
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 14:37:34 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-34.am.freescale.net
	[10.214.72.34])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0GLbSnt018969
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 15:37:33 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v2 7/8] Factor out 52xx dependencies from
	52xx psc driver
Date: Wed, 16 Jan 2008 14:37:26 -0700
Message-Id: <1200519447-25555-7-git-send-email-jrigby@freescale.com>
In-Reply-To: <1200519447-25555-6-git-send-email-jrigby@freescale.com>
References: <1200519447-25555-1-git-send-email-jrigby@freescale.com>
	<1200519447-25555-2-git-send-email-jrigby@freescale.com>
	<1200519447-25555-3-git-send-email-jrigby@freescale.com>
	<1200519447-25555-4-git-send-email-jrigby@freescale.com>
	<1200519447-25555-5-git-send-email-jrigby@freescale.com>
	<1200519447-25555-6-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PSCs change from 5200 to 5121
this patch localizes the differences in
preparation for adding 5121 support

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 drivers/serial/mpc52xx_uart.c |  256 ++++++++++++++++++++++++++++++----------
 1 files changed, 192 insertions(+), 64 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 9bf4521..0f6036b 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -67,7 +67,6 @@
 #include <linux/serial.h>
 #include <linux/sysrq.h>
 #include <linux/console.h>
-
 #include <linux/delay.h>
 #include <linux/io.h>
 
@@ -110,8 +109,8 @@ static struct device_node *mpc52xx_uart_nodes[MPC52xx_PSC_MAXNUM];
 static void mpc52xx_uart_of_enumerate(void);
 #endif
 
+
 #define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
-#define FIFO(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
 
 
 /* Forward declaration of the interruption handling routine */
@@ -134,6 +133,162 @@ static const struct of_device_id mpc52xx_uart_of_match[] = {
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
+	return in_be16(&PSC(port)->mpc52xx_psc_status)
+	    & port->read_status_mask
+	    & MPC52xx_PSC_SR_RXRDY;
+}
+
+static int mpc52xx_psc_tx_rdy(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_status)
+	    & port->read_status_mask
+	    & MPC52xx_PSC_SR_TXRDY;
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
@@ -142,8 +297,7 @@ static const struct of_device_id mpc52xx_uart_of_match[] = {
 static unsigned int
 mpc52xx_uart_tx_empty(struct uart_port *port)
 {
-	int status = in_be16(&PSC(port)->mpc52xx_psc_status);
-	return (status & MPC52xx_PSC_SR_TXEMP) ? TIOCSER_TEMT : 0;
+	return psc_ops->tx_empty(port) ? TIOCSER_TEMT : 0;
 }
 
 static void
@@ -163,16 +317,14 @@ static void
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
@@ -185,8 +337,7 @@ mpc52xx_uart_send_xchar(struct uart_port *port, char ch)
 	if (ch) {
 		/* Make sure tx interrupts are on */
 		/* Truly necessary ??? They should be anyway */
-		port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
-		out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+		psc_ops->start_tx(port);
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -196,8 +347,7 @@ static void
 mpc52xx_uart_stop_rx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
-	port->read_status_mask &= ~MPC52xx_PSC_IMR_RXRDY;
-	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->stop_rx(port);
 }
 
 static void
@@ -224,7 +374,6 @@ static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
-	struct mpc52xx_psc_fifo __iomem *fifo = FIFO(port);
 	int ret;
 
 	/* Request IRQ */
@@ -239,15 +388,7 @@ mpc52xx_uart_startup(struct uart_port *port)
 
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
@@ -330,8 +471,7 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	 * boot for the console, all stuff is not yet ready to receive at that
 	 * time and that just makes the kernel oops */
 	/* while (j-- && mpc52xx_uart_int_rx_chars(port)); */
-	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
-	       --j)
+	while (!mpc52xx_uart_tx_empty(port) && --j)
 		udelay(1);
 
 	if (!j)
@@ -459,11 +599,9 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
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
@@ -478,6 +616,8 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
+		status = in_be16(&PSC(port)->mpc52xx_psc_status);
+
 		if (status & (MPC52xx_PSC_SR_PE |
 			      MPC52xx_PSC_SR_FE |
 			      MPC52xx_PSC_SR_RB)) {
@@ -507,7 +647,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 
 	tty_flip_buffer_push(tty);
 
-	return in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY;
+	return psc_ops->raw_rx_rdy(port);
 }
 
 static inline int
@@ -517,7 +657,7 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 
 	/* Process out of band chars */
 	if (port->x_char) {
-		out_8(&PSC(port)->mpc52xx_psc_buffer_8, port->x_char);
+		psc_ops->write_char(port, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
 		return 1;
@@ -530,8 +670,8 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 	}
 
 	/* Send chars */
-	while (in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXRDY) {
-		out_8(&PSC(port)->mpc52xx_psc_buffer_8, xmit->buf[xmit->tail]);
+	while (psc_ops->raw_tx_rdy(port)) {
+		psc_ops->write_char(port, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		if (uart_circ_empty(xmit))
@@ -557,7 +697,6 @@ mpc52xx_uart_int(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	unsigned long pass = ISR_PASS_LIMIT;
 	unsigned int keepgoing;
-	unsigned short status;
 
 	spin_lock(&port->lock);
 
@@ -566,18 +705,12 @@ mpc52xx_uart_int(int irq, void *dev_id)
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
@@ -644,36 +777,33 @@ static void
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
@@ -718,7 +848,7 @@ mpc52xx_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
 	struct device_node *np = mpc52xx_uart_nodes[co->index];
-	unsigned int ipb_freq;
+	unsigned int uartclk;
 	struct resource res;
 	int ret;
 
@@ -750,17 +880,16 @@ mpc52xx_console_setup(struct console *co, char *options)
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
@@ -946,7 +1075,7 @@ static int __devinit
 mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 {
 	int idx = -1;
-	unsigned int ipb_freq;
+	unsigned int uartclk;
 	struct uart_port *port = NULL;
 	struct resource res;
 	int ret;
@@ -962,10 +1091,9 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
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
 
@@ -973,7 +1101,7 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	port = &mpc52xx_uart_ports[idx];
 
 	spin_lock_init(&port->lock);
-	port->uartclk	= ipb_freq / 2;
+	port->uartclk = uartclk;
 	port->fifosize	= 512;
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF |
-- 
1.5.3.5.726.g41a7a
