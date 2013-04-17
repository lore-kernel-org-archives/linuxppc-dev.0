Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B8FE82C016B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 07:22:15 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-serial@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/2] serial/mpc52xx_uart: prepare for adding MPC5125 PSC
 UART support
Date: Wed, 17 Apr 2013 23:21:41 +0200
Message-Id: <1366233702-20689-1-git-send-email-agust@denx.de>
In-Reply-To: <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Vladimir Ermakov <vooon341@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>

MPC5125 PSC controller has different register layout than MPC5121.
To support MPC5125 PSC in this driver we have to provide further
psc_ops functions for SoC specific register accesses.

Add new register access functions to the psc_ops structure and
provide MPC52xx and MPC512x specific implementation for them.
Then replace remaining direct register accesses in the driver by
appropriate psc_ops function calls. The subsequent patch can now
add MPC5125 specific set of psc_ops functions.

Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---

Greg, with your Acked-by I can push these patches to my mpc5xxx tree.
But it is fine with me if you prefer to apply them to tty tree.

Thanks,

Anatolij

Changes in v2:
 - split into two patches to simplify review
 - minor coding style changes
 - revise commit log

 drivers/tty/serial/mpc52xx_uart.c |  161 +++++++++++++++++++++++++++----------
 1 file changed, 119 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 018bad9..5aa87ac 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -122,6 +122,15 @@ struct psc_ops {
 	void		(*fifoc_uninit)(void);
 	void		(*get_irq)(struct uart_port *, struct device_node *);
 	irqreturn_t	(*handle_irq)(struct uart_port *port);
+	u16		(*get_status)(struct uart_port *port);
+	u8		(*get_ipcr)(struct uart_port *port);
+	void		(*command)(struct uart_port *port, u8 cmd);
+	void		(*set_mode)(struct uart_port *port, u8 mr1, u8 mr2);
+	void		(*set_rts)(struct uart_port *port, int state);
+	void		(*enable_ms)(struct uart_port *port);
+	void		(*set_sicr)(struct uart_port *port, u32 val);
+	void		(*set_imr)(struct uart_port *port, u16 val);
+	u8		(*get_mr1)(struct uart_port *port);
 };
 
 /* setting the prescaler and divisor reg is common for all chips */
@@ -134,6 +143,65 @@ static inline void mpc52xx_set_divisor(struct mpc52xx_psc __iomem *psc,
 	out_8(&psc->ctlr, divisor & 0xff);
 }
 
+static u16 mpc52xx_psc_get_status(struct uart_port *port)
+{
+	return in_be16(&PSC(port)->mpc52xx_psc_status);
+}
+
+static u8 mpc52xx_psc_get_ipcr(struct uart_port *port)
+{
+	return in_8(&PSC(port)->mpc52xx_psc_ipcr);
+}
+
+static void mpc52xx_psc_command(struct uart_port *port, u8 cmd)
+{
+	out_8(&PSC(port)->command, cmd);
+}
+
+static void mpc52xx_psc_set_mode(struct uart_port *port, u8 mr1, u8 mr2)
+{
+	out_8(&PSC(port)->command, MPC52xx_PSC_SEL_MODE_REG_1);
+	out_8(&PSC(port)->mode, mr1);
+	out_8(&PSC(port)->mode, mr2);
+}
+
+static void mpc52xx_psc_set_rts(struct uart_port *port, int state)
+{
+	if (state)
+		out_8(&PSC(port)->op1, MPC52xx_PSC_OP_RTS);
+	else
+		out_8(&PSC(port)->op0, MPC52xx_PSC_OP_RTS);
+}
+
+static void mpc52xx_psc_enable_ms(struct uart_port *port)
+{
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+
+	/* clear D_*-bits by reading them */
+	in_8(&psc->mpc52xx_psc_ipcr);
+	/* enable CTS and DCD as IPC interrupts */
+	out_8(&psc->mpc52xx_psc_acr, MPC52xx_PSC_IEC_CTS | MPC52xx_PSC_IEC_DCD);
+
+	port->read_status_mask |= MPC52xx_PSC_IMR_IPC;
+	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
+}
+
+static void mpc52xx_psc_set_sicr(struct uart_port *port, u32 val)
+{
+	out_be32(&PSC(port)->sicr, val);
+}
+
+static void mpc52xx_psc_set_imr(struct uart_port *port, u16 val)
+{
+	out_be16(&PSC(port)->mpc52xx_psc_imr, val);
+}
+
+static u8 mpc52xx_psc_get_mr1(struct uart_port *port)
+{
+	out_8(&PSC(port)->command, MPC52xx_PSC_SEL_MODE_REG_1);
+	return in_8(&PSC(port)->mode);
+}
+
 #ifdef CONFIG_PPC_MPC52xx
 #define FIFO_52xx(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
 static void mpc52xx_psc_fifo_init(struct uart_port *port)
@@ -304,6 +372,15 @@ static struct psc_ops mpc52xx_psc_ops = {
 	.set_baudrate = mpc5200_psc_set_baudrate,
 	.get_irq = mpc52xx_psc_get_irq,
 	.handle_irq = mpc52xx_psc_handle_irq,
+	.get_status = mpc52xx_psc_get_status,
+	.get_ipcr = mpc52xx_psc_get_ipcr,
+	.command = mpc52xx_psc_command,
+	.set_mode = mpc52xx_psc_set_mode,
+	.set_rts = mpc52xx_psc_set_rts,
+	.enable_ms = mpc52xx_psc_enable_ms,
+	.set_sicr = mpc52xx_psc_set_sicr,
+	.set_imr = mpc52xx_psc_set_imr,
+	.get_mr1 = mpc52xx_psc_get_mr1,
 };
 
 static struct psc_ops mpc5200b_psc_ops = {
@@ -325,6 +402,15 @@ static struct psc_ops mpc5200b_psc_ops = {
 	.set_baudrate = mpc5200b_psc_set_baudrate,
 	.get_irq = mpc52xx_psc_get_irq,
 	.handle_irq = mpc52xx_psc_handle_irq,
+	.get_status = mpc52xx_psc_get_status,
+	.get_ipcr = mpc52xx_psc_get_ipcr,
+	.command = mpc52xx_psc_command,
+	.set_mode = mpc52xx_psc_set_mode,
+	.set_rts = mpc52xx_psc_set_rts,
+	.enable_ms = mpc52xx_psc_enable_ms,
+	.set_sicr = mpc52xx_psc_set_sicr,
+	.set_imr = mpc52xx_psc_set_imr,
+	.get_mr1 = mpc52xx_psc_get_mr1,
 };
 
 #endif /* CONFIG_MPC52xx */
@@ -595,8 +681,18 @@ static struct psc_ops mpc512x_psc_ops = {
 	.fifoc_uninit = mpc512x_psc_fifoc_uninit,
 	.get_irq = mpc512x_psc_get_irq,
 	.handle_irq = mpc512x_psc_handle_irq,
+	.get_status = mpc52xx_psc_get_status,
+	.get_ipcr = mpc52xx_psc_get_ipcr,
+	.command = mpc52xx_psc_command,
+	.set_mode = mpc52xx_psc_set_mode,
+	.set_rts = mpc52xx_psc_set_rts,
+	.enable_ms = mpc52xx_psc_enable_ms,
+	.set_sicr = mpc52xx_psc_set_sicr,
+	.set_imr = mpc52xx_psc_set_imr,
+	.get_mr1 = mpc52xx_psc_get_mr1,
 };
-#endif
+#endif /* CONFIG_PPC_MPC512x */
+
 
 static const struct psc_ops *psc_ops;
 
@@ -613,17 +709,14 @@ mpc52xx_uart_tx_empty(struct uart_port *port)
 static void
 mpc52xx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	if (mctrl & TIOCM_RTS)
-		out_8(&PSC(port)->op1, MPC52xx_PSC_OP_RTS);
-	else
-		out_8(&PSC(port)->op0, MPC52xx_PSC_OP_RTS);
+	psc_ops->set_rts(port, mctrl & TIOCM_RTS);
 }
 
 static unsigned int
 mpc52xx_uart_get_mctrl(struct uart_port *port)
 {
 	unsigned int ret = TIOCM_DSR;
-	u8 status = in_8(&PSC(port)->mpc52xx_psc_ipcr);
+	u8 status = psc_ops->get_ipcr(port);
 
 	if (!(status & MPC52xx_PSC_CTS))
 		ret |= TIOCM_CTS;
@@ -673,15 +766,7 @@ mpc52xx_uart_stop_rx(struct uart_port *port)
 static void
 mpc52xx_uart_enable_ms(struct uart_port *port)
 {
-	struct mpc52xx_psc __iomem *psc = PSC(port);
-
-	/* clear D_*-bits by reading them */
-	in_8(&psc->mpc52xx_psc_ipcr);
-	/* enable CTS and DCD as IPC interrupts */
-	out_8(&psc->mpc52xx_psc_acr, MPC52xx_PSC_IEC_CTS | MPC52xx_PSC_IEC_DCD);
-
-	port->read_status_mask |= MPC52xx_PSC_IMR_IPC;
-	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->enable_ms(port);
 }
 
 static void
@@ -691,9 +776,9 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 	spin_lock_irqsave(&port->lock, flags);
 
 	if (ctl == -1)
-		out_8(&PSC(port)->command, MPC52xx_PSC_START_BRK);
+		psc_ops->command(port, MPC52xx_PSC_START_BRK);
 	else
-		out_8(&PSC(port)->command, MPC52xx_PSC_STOP_BRK);
+		psc_ops->command(port, MPC52xx_PSC_STOP_BRK);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -701,7 +786,6 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
-	struct mpc52xx_psc __iomem *psc = PSC(port);
 	int ret;
 
 	if (psc_ops->clock) {
@@ -717,15 +801,15 @@ mpc52xx_uart_startup(struct uart_port *port)
 		return ret;
 
 	/* Reset/activate the port, clear and enable interrupts */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
-	out_8(&psc->command, MPC52xx_PSC_RST_TX);
+	psc_ops->command(port, MPC52xx_PSC_RST_RX);
+	psc_ops->command(port, MPC52xx_PSC_RST_TX);
 
-	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
+	psc_ops->set_sicr(port, 0);	/* UART mode DCD ignored */
 
 	psc_ops->fifo_init(port);
 
-	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
-	out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
+	psc_ops->command(port, MPC52xx_PSC_TX_ENABLE);
+	psc_ops->command(port, MPC52xx_PSC_RX_ENABLE);
 
 	return 0;
 }
@@ -733,15 +817,13 @@ mpc52xx_uart_startup(struct uart_port *port)
 static void
 mpc52xx_uart_shutdown(struct uart_port *port)
 {
-	struct mpc52xx_psc __iomem *psc = PSC(port);
-
 	/* Shut down the port.  Leave TX active if on a console port */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	psc_ops->command(port, MPC52xx_PSC_RST_RX);
 	if (!uart_console(port))
-		out_8(&psc->command, MPC52xx_PSC_RST_TX);
+		psc_ops->command(port, MPC52xx_PSC_RST_TX);
 
 	port->read_status_mask = 0;
-	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
+	psc_ops->set_imr(port, port->read_status_mask);
 
 	if (psc_ops->clock)
 		psc_ops->clock(port, 0);
@@ -754,7 +836,6 @@ static void
 mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			 struct ktermios *old)
 {
-	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned long flags;
 	unsigned char mr1, mr2;
 	unsigned int j;
@@ -818,13 +899,11 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			"Some chars may have been lost.\n");
 
 	/* Reset the TX & RX */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
-	out_8(&psc->command, MPC52xx_PSC_RST_TX);
+	psc_ops->command(port, MPC52xx_PSC_RST_RX);
+	psc_ops->command(port, MPC52xx_PSC_RST_TX);
 
 	/* Send new mode settings */
-	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
-	out_8(&psc->mode, mr1);
-	out_8(&psc->mode, mr2);
+	psc_ops->set_mode(port, mr1, mr2);
 	baud = psc_ops->set_baudrate(port, new, old);
 
 	/* Update the per-port timeout */
@@ -834,8 +913,8 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 		mpc52xx_uart_enable_ms(port);
 
 	/* Reenable TX & RX */
-	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
-	out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
+	psc_ops->command(port, MPC52xx_PSC_TX_ENABLE);
+	psc_ops->command(port, MPC52xx_PSC_RX_ENABLE);
 
 	/* We're all set, release the lock */
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -963,7 +1042,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
-		status = in_be16(&PSC(port)->mpc52xx_psc_status);
+		status = psc_ops->get_status(port);
 
 		if (status & (MPC52xx_PSC_SR_PE |
 			      MPC52xx_PSC_SR_FE |
@@ -983,7 +1062,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 			}
 
 			/* Clear error condition */
-			out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);
+			psc_ops->command(port, MPC52xx_PSC_RST_ERR_STAT);
 
 		}
 		tty_insert_flip_char(tport, ch, flag);
@@ -1066,7 +1145,7 @@ mpc5xxx_uart_process_int(struct uart_port *port)
 		if (psc_ops->tx_rdy(port))
 			keepgoing |= mpc52xx_uart_int_tx_chars(port);
 
-		status = in_8(&PSC(port)->mpc52xx_psc_ipcr);
+		status = psc_ops->get_ipcr(port);
 		if (status & MPC52xx_PSC_D_DCD)
 			uart_handle_dcd_change(port, !(status & MPC52xx_PSC_DCD));
 
@@ -1107,14 +1186,12 @@ static void __init
 mpc52xx_console_get_options(struct uart_port *port,
 			    int *baud, int *parity, int *bits, int *flow)
 {
-	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned char mr1;
 
 	pr_debug("mpc52xx_console_get_options(port=%p)\n", port);
 
 	/* Read the mode registers */
-	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
-	mr1 = in_8(&psc->mode);
+	mr1 = psc_ops->get_mr1(port);
 
 	/* CT{U,L}R are write-only ! */
 	*baud = CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
-- 
1.7.9.5
