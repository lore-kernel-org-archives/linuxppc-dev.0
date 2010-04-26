Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 07589B7BEE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 07:18:21 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc5200b/uart: improve baud rate calculation (reach high baud
	rates, better accuracy)
Date: Mon, 26 Apr 2010 23:18:12 +0200
Message-Id: <1272316692-30335-1-git-send-email-agust@denx.de>
In-Reply-To: <1269888734.2995.2@antares>
References: <1269888734.2995.2@antares>
Cc: Albrecht Dress <albrecht.dress@arcor.de>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Albrecht Dress <albrecht.dress@arcor.de>

On the MPC5200B, make very high baud rates (e.g. 3 MBaud) accessible and
achieve a higher precision for high baud rates in general.  This is done by
selecting the appropriate prescaler (/4 or /32).  As to keep the code clean,
the getuartclk method has been dropped, and all calculations are done in a
new set_baudrate method.

Notes: only "fsl,mpc5200b-psc-uart" compatible devices benefit from these
improvements.

Tested on a custom 5200B based board, from 110 baud up to 3 MBaud, and with
both "fsl,mpc5200b-psc-uart" and "fsl,mpc5200-psc-uart" devices.
Also tested on the mpc5121ads board.

Signed-off-by: Albrecht Dress <albrecht.dress@arcor.de>
[agust: fixed mpc5121 prescaler comment]
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v3a -> v4:
 - Commit message cleanup
 - Fixed prescaler comment in mpc512x_psc_set_baudrate()
 - Fixed white space issues

 drivers/serial/mpc52xx_uart.c |  145 ++++++++++++++++++++++++++++++++--------
 1 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 3119fdd..80c8717 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -146,7 +146,9 @@ struct psc_ops {
 	unsigned char	(*read_char)(struct uart_port *port);
 	void		(*cw_disable_ints)(struct uart_port *port);
 	void		(*cw_restore_ints)(struct uart_port *port);
-	unsigned long	(*getuartclk)(void *p);
+	unsigned int	(*set_baudrate)(struct uart_port *port,
+					struct ktermios *new,
+					struct ktermios *old);
 	int		(*clock)(struct uart_port *port, int enable);
 	int		(*fifoc_init)(void);
 	void		(*fifoc_uninit)(void);
@@ -154,6 +156,16 @@ struct psc_ops {
 	irqreturn_t	(*handle_irq)(struct uart_port *port);
 };
 
+/* setting the prescaler and divisor reg is common for all chips */
+static inline void mpc52xx_set_divisor(struct mpc52xx_psc __iomem *psc,
+				       u16 prescaler, unsigned int divisor)
+{
+	/* select prescaler */
+	out_be16(&psc->mpc52xx_psc_clock_select, prescaler);
+	out_8(&psc->ctur, divisor >> 8);
+	out_8(&psc->ctlr, divisor & 0xff);
+}
+
 #ifdef CONFIG_PPC_MPC52xx
 #define FIFO_52xx(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
 static void mpc52xx_psc_fifo_init(struct uart_port *port)
@@ -161,9 +173,6 @@ static void mpc52xx_psc_fifo_init(struct uart_port *port)
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	struct mpc52xx_psc_fifo __iomem *fifo = FIFO_52xx(port);
 
-	/* /32 prescaler */
-	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
-
 	out_8(&fifo->rfcntl, 0x00);
 	out_be16(&fifo->rfalarm, 0x1ff);
 	out_8(&fifo->tfcntl, 0x07);
@@ -252,15 +261,47 @@ static void mpc52xx_psc_cw_restore_ints(struct uart_port *port)
 	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 }
 
-/* Search for bus-frequency property in this node or a parent */
-static unsigned long mpc52xx_getuartclk(void *p)
+static unsigned int mpc5200_psc_set_baudrate(struct uart_port *port,
+					     struct ktermios *new,
+					     struct ktermios *old)
 {
-	/*
-	 * 5200 UARTs have a / 32 prescaler
-	 * but the generic serial code assumes 16
-	 * so return ipb freq / 2
-	 */
-	return mpc5xxx_get_bus_frequency(p) / 2;
+	unsigned int baud;
+	unsigned int divisor;
+
+	/* The 5200 has a fixed /32 prescaler, uartclk contains the ipb freq */
+	baud = uart_get_baud_rate(port, new, old,
+				  port->uartclk / (32 * 0xffff) + 1,
+				  port->uartclk / 32);
+	divisor = (port->uartclk + 16 * baud) / (32 * baud);
+
+	/* enable the /32 prescaler and set the divisor */
+	mpc52xx_set_divisor(PSC(port), 0xdd00, divisor);
+	return baud;
+}
+
+static unsigned int mpc5200b_psc_set_baudrate(struct uart_port *port,
+					      struct ktermios *new,
+					      struct ktermios *old)
+{
+	unsigned int baud;
+	unsigned int divisor;
+	u16 prescaler;
+
+	/* The 5200B has a selectable /4 or /32 prescaler, uartclk contains the
+	 * ipb freq */
+	baud = uart_get_baud_rate(port, new, old,
+				  port->uartclk / (32 * 0xffff) + 1,
+				  port->uartclk / 4);
+	divisor = (port->uartclk + 2 * baud) / (4 * baud);
+
+	/* select the proper prescaler and set the divisor */
+	if (divisor > 0xffff) {
+		divisor = (divisor + 4) / 8;
+		prescaler = 0xdd00; /* /32 */
+	} else
+		prescaler = 0xff00; /* /4 */
+	mpc52xx_set_divisor(PSC(port), prescaler, divisor);
+	return baud;
 }
 
 static void mpc52xx_psc_get_irq(struct uart_port *port, struct device_node *np)
@@ -291,7 +332,28 @@ static struct psc_ops mpc52xx_psc_ops = {
 	.read_char = mpc52xx_psc_read_char,
 	.cw_disable_ints = mpc52xx_psc_cw_disable_ints,
 	.cw_restore_ints = mpc52xx_psc_cw_restore_ints,
-	.getuartclk = mpc52xx_getuartclk,
+	.set_baudrate = mpc5200_psc_set_baudrate,
+	.get_irq = mpc52xx_psc_get_irq,
+	.handle_irq = mpc52xx_psc_handle_irq,
+};
+
+static struct psc_ops mpc5200b_psc_ops = {
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
+	.set_baudrate = mpc5200b_psc_set_baudrate,
 	.get_irq = mpc52xx_psc_get_irq,
 	.handle_irq = mpc52xx_psc_handle_irq,
 };
@@ -425,9 +487,35 @@ static void mpc512x_psc_cw_restore_ints(struct uart_port *port)
 	out_be32(&FIFO_512x(port)->rximr, port->read_status_mask & 0x7f);
 }
 
-static unsigned long mpc512x_getuartclk(void *p)
+static unsigned int mpc512x_psc_set_baudrate(struct uart_port *port,
+					     struct ktermios *new,
+					     struct ktermios *old)
 {
-	return mpc5xxx_get_bus_frequency(p);
+	unsigned int baud;
+	unsigned int divisor;
+
+	/*
+	 * The "MPC5121e Microcontroller Reference Manual, Rev. 3" says on
+	 * pg. 30-10 that the chip supports a /32 and a /10 prescaler.
+	 * Furthermore, it states that "After reset, the prescaler by 10
+	 * for the UART mode is selected", but the reset register value is
+	 * 0x0000 which means a /32 prescaler. This is wrong.
+	 *
+	 * In reality using /32 prescaler doesn't work, as it is not supported!
+	 * Use /16 or /10 prescaler, see "MPC5121e Hardware Design Guide",
+	 * Chapter 4.1 PSC in UART Mode.
+	 * Calculate with a /16 prescaler here.
+	 */
+
+	/* uartclk contains the ips freq */
+	baud = uart_get_baud_rate(port, new, old,
+				  port->uartclk / (16 * 0xffff) + 1,
+				  port->uartclk / 16);
+	divisor = (port->uartclk + 8 * baud) / (16 * baud);
+
+	/* enable the /16 prescaler and set the divisor */
+	mpc52xx_set_divisor(PSC(port), 0xdd00, divisor);
+	return baud;
 }
 
 #define DEFAULT_FIFO_SIZE 16
@@ -600,7 +688,7 @@ static struct psc_ops mpc512x_psc_ops = {
 	.read_char = mpc512x_psc_read_char,
 	.cw_disable_ints = mpc512x_psc_cw_disable_ints,
 	.cw_restore_ints = mpc512x_psc_cw_restore_ints,
-	.getuartclk = mpc512x_getuartclk,
+	.set_baudrate = mpc512x_psc_set_baudrate,
 	.clock = mpc512x_psc_clock,
 	.fifoc_init = mpc512x_psc_fifoc_init,
 	.fifoc_uninit = mpc512x_psc_fifoc_uninit,
@@ -768,8 +856,8 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned long flags;
 	unsigned char mr1, mr2;
-	unsigned short ctr;
-	unsigned int j, baud, quot;
+	unsigned int j;
+	unsigned int baud;
 
 	/* Prepare what we're gonna write */
 	mr1 = 0;
@@ -806,16 +894,9 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 		mr2 |= MPC52xx_PSC_MODE_TXCTS;
 	}
 
-	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
-	quot = uart_get_divisor(port, baud);
-	ctr = quot & 0xffff;
-
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
 
-	/* Update the per-port timeout */
-	uart_update_timeout(port, new->c_cflag, baud);
-
 	/* Do our best to flush TX & RX, so we don't lose anything */
 	/* But we don't wait indefinitely ! */
 	j = 5000000;	/* Maximum wait */
@@ -839,8 +920,10 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);
 	out_8(&psc->mode, mr2);
-	out_8(&psc->ctur, ctr >> 8);
-	out_8(&psc->ctlr, ctr & 0xff);
+	baud = psc_ops->set_baudrate(port, new, old);
+
+	/* Update the per-port timeout */
+	uart_update_timeout(port, new->c_cflag, baud);
 
 	if (UART_ENABLE_MS(port, new->c_cflag))
 		mpc52xx_uart_enable_ms(port);
@@ -1220,7 +1303,7 @@ mpc52xx_console_setup(struct console *co, char *options)
 		return ret;
 	}
 
-	uartclk = psc_ops->getuartclk(np);
+	uartclk = mpc5xxx_get_bus_frequency(np);
 	if (uartclk == 0) {
 		pr_debug("Could not find uart clock frequency!\n");
 		return -EINVAL;
@@ -1303,6 +1386,7 @@ static struct uart_driver mpc52xx_uart_driver = {
 
 static struct of_device_id mpc52xx_uart_of_match[] = {
 #ifdef CONFIG_PPC_MPC52xx
+	{ .compatible = "fsl,mpc5200b-psc-uart", .data = &mpc5200b_psc_ops, },
 	{ .compatible = "fsl,mpc5200-psc-uart", .data = &mpc52xx_psc_ops, },
 	/* binding used by old lite5200 device trees: */
 	{ .compatible = "mpc5200-psc-uart", .data = &mpc52xx_psc_ops, },
@@ -1335,7 +1419,10 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	pr_debug("Found %s assigned to ttyPSC%x\n",
 		 mpc52xx_uart_nodes[idx]->full_name, idx);
 
-	uartclk = psc_ops->getuartclk(op->node);
+	/* set the uart clock to the input clock of the psc, the different
+	 * prescalers are taken into account in the set_baudrate() methods
+	 * of the respective chip */
+	uartclk = mpc5xxx_get_bus_frequency(op->node);
 	if (uartclk == 0) {
 		dev_dbg(&op->dev, "Could not find uart clock frequency!\n");
 		return -EINVAL;
-- 
1.6.3.3
