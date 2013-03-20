Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id 03B9A2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 04:42:15 +1100 (EST)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] serial/mpc52xx_uart: add PSC UART support for MPC5125
 platforms.
Date: Wed, 20 Mar 2013 18:41:53 +0100
Message-Id: <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
In-Reply-To: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: gregkh@linuxfoundation.org,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC5125 PSC controller has different registers than MPC5121.

This patch was originally created by Vladimir Ermakov
https://lists.ozlabs.org/pipermail/linuxppc-dev/2011-March/088954.html

Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>

Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
---
 arch/powerpc/include/asm/mpc52xx_psc.h |   49 ++++
 drivers/tty/serial/mpc52xx_uart.c      |  407 ++++++++++++++++++++++++++++----
 2 files changed, 414 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index 2966df6..d0ece25 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -299,4 +299,53 @@ struct mpc512x_psc_fifo {
 #define rxdata_32 rxdata.rxdata_32
 };
 
+struct mpc5125_psc {
+	u8		mr1;			/* PSC + 0x00 */
+	u8		reserved0[3];
+	u8		mr2;			/* PSC + 0x04 */
+	u8		reserved1[3];
+	struct {
+		u16		status;		/* PSC + 0x08 */
+		u8		reserved2[2];
+		u8		clock_select;	/* PSC + 0x0c */
+		u8		reserved3[3];
+	} sr_csr;
+	u8		command;		/* PSC + 0x10 */
+	u8		reserved4[3];
+	union {					/* PSC + 0x14 */
+		u8		buffer_8;
+		u16		buffer_16;
+		u32		buffer_32;
+	} buffer;
+	struct {
+		u8		ipcr;		/* PSC + 0x18 */
+		u8		reserved5[3];
+		u8		acr;		/* PSC + 0x1c */
+		u8		reserved6[3];
+	} ipcr_acr;
+	struct {
+		u16		isr;		/* PSC + 0x20 */
+		u8		reserved7[2];
+		u16		imr;		/* PSC + 0x24 */
+		u8		reserved8[2];
+	} isr_imr;
+	u8		ctur;			/* PSC + 0x28 */
+	u8		reserved9[3];
+	u8		ctlr;			/* PSC + 0x2c */
+	u8		reserved10[3];
+	u32		ccr;			/* PSC + 0x30 */
+	u32		ac97slots;		/* PSC + 0x34 */
+	u32		ac97cmd;		/* PSC + 0x38 */
+	u32		ac97data;		/* PSC + 0x3c */
+	u8		reserved11[4];
+	u8		ip;			/* PSC + 0x44 */
+	u8		reserved12[3];
+	u8		op1;			/* PSC + 0x48 */
+	u8		reserved13[3];
+	u8		op0;			/* PSC + 0x4c */
+	u8		reserved14[3];
+	u32		sicr;			/* PSC + 0x50 */
+	u8		reserved15[4];	/* make eq. sizeof(mpc52xx_psc) */
+};
+
 #endif  /* __ASM_MPC52xx_PSC_H__ */
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 018bad9..3f77b9d 100644
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
@@ -134,6 +143,74 @@ static inline void mpc52xx_set_divisor(struct mpc52xx_psc __iomem *psc,
 	out_8(&psc->ctlr, divisor & 0xff);
 }
 
+static inline void mpc5125_set_divisor(struct mpc5125_psc __iomem *psc,
+		u8 prescaler, unsigned int divisor)
+{
+	/* select prescaler */
+	out_8(&psc->mpc52xx_psc_clock_select, prescaler);
+	out_8(&psc->ctur, divisor >> 8);
+	out_8(&psc->ctlr, divisor & 0xff);
+}
+
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
@@ -304,6 +381,15 @@ static struct psc_ops mpc52xx_psc_ops = {
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
@@ -325,6 +411,15 @@ static struct psc_ops mpc5200b_psc_ops = {
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
@@ -573,6 +668,242 @@ static void mpc512x_psc_get_irq(struct uart_port *port, struct device_node *np)
 	port->irq = psc_fifoc_irq;
 }
 
+#endif
+
+#ifdef CONFIG_PPC_MPC512x
+
+#define PSC_5125(port) ((struct mpc5125_psc __iomem *)((port)->membase))
+#define FIFO_5125(port) ((struct mpc512x_psc_fifo __iomem *)(PSC_5125(port)+1))
+
+static void mpc5125_psc_fifo_init(struct uart_port *port)
+{
+	/* /32 prescaler */
+	out_8(&PSC_5125(port)->mpc52xx_psc_clock_select, 0xdd);
+
+	out_be32(&FIFO_5125(port)->txcmd, MPC512x_PSC_FIFO_RESET_SLICE);
+	out_be32(&FIFO_5125(port)->txcmd, MPC512x_PSC_FIFO_ENABLE_SLICE);
+	out_be32(&FIFO_5125(port)->txalarm, 1);
+	out_be32(&FIFO_5125(port)->tximr, 0);
+
+	out_be32(&FIFO_5125(port)->rxcmd, MPC512x_PSC_FIFO_RESET_SLICE);
+	out_be32(&FIFO_5125(port)->rxcmd, MPC512x_PSC_FIFO_ENABLE_SLICE);
+	out_be32(&FIFO_5125(port)->rxalarm, 1);
+	out_be32(&FIFO_5125(port)->rximr, 0);
+
+	out_be32(&FIFO_5125(port)->tximr, MPC512x_PSC_FIFO_ALARM);
+	out_be32(&FIFO_5125(port)->rximr, MPC512x_PSC_FIFO_ALARM);
+}
+
+static int mpc5125_psc_raw_rx_rdy(struct uart_port *port)
+{
+	return !(in_be32(&FIFO_5125(port)->rxsr) & MPC512x_PSC_FIFO_EMPTY);
+}
+
+static int mpc5125_psc_raw_tx_rdy(struct uart_port *port)
+{
+	return !(in_be32(&FIFO_5125(port)->txsr) & MPC512x_PSC_FIFO_FULL);
+}
+
+static int mpc5125_psc_rx_rdy(struct uart_port *port)
+{
+	return in_be32(&FIFO_5125(port)->rxsr)
+	    & in_be32(&FIFO_5125(port)->rximr)
+	    & MPC512x_PSC_FIFO_ALARM;
+}
+
+static int mpc5125_psc_tx_rdy(struct uart_port *port)
+{
+	return in_be32(&FIFO_5125(port)->txsr)
+	    & in_be32(&FIFO_5125(port)->tximr)
+	    & MPC512x_PSC_FIFO_ALARM;
+}
+
+static int mpc5125_psc_tx_empty(struct uart_port *port)
+{
+	return in_be32(&FIFO_5125(port)->txsr)
+	    & MPC512x_PSC_FIFO_EMPTY;
+}
+
+static void mpc5125_psc_stop_rx(struct uart_port *port)
+{
+	unsigned long rx_fifo_imr;
+
+	rx_fifo_imr = in_be32(&FIFO_5125(port)->rximr);
+	rx_fifo_imr &= ~MPC512x_PSC_FIFO_ALARM;
+	out_be32(&FIFO_5125(port)->rximr, rx_fifo_imr);
+}
+
+static void mpc5125_psc_start_tx(struct uart_port *port)
+{
+	unsigned long tx_fifo_imr;
+
+	tx_fifo_imr = in_be32(&FIFO_5125(port)->tximr);
+	tx_fifo_imr |= MPC512x_PSC_FIFO_ALARM;
+	out_be32(&FIFO_5125(port)->tximr, tx_fifo_imr);
+}
+
+static void mpc5125_psc_stop_tx(struct uart_port *port)
+{
+	unsigned long tx_fifo_imr;
+
+	tx_fifo_imr = in_be32(&FIFO_5125(port)->tximr);
+	tx_fifo_imr &= ~MPC512x_PSC_FIFO_ALARM;
+	out_be32(&FIFO_5125(port)->tximr, tx_fifo_imr);
+}
+
+static void mpc5125_psc_rx_clr_irq(struct uart_port *port)
+{
+	out_be32(&FIFO_5125(port)->rxisr, in_be32(&FIFO_5125(port)->rxisr));
+}
+
+static void mpc5125_psc_tx_clr_irq(struct uart_port *port)
+{
+	out_be32(&FIFO_5125(port)->txisr, in_be32(&FIFO_5125(port)->txisr));
+}
+
+static void mpc5125_psc_write_char(struct uart_port *port, unsigned char c)
+{
+	out_8(&FIFO_5125(port)->txdata_8, c);
+}
+
+static unsigned char mpc5125_psc_read_char(struct uart_port *port)
+{
+	return in_8(&FIFO_5125(port)->rxdata_8);
+}
+
+static void mpc5125_psc_cw_disable_ints(struct uart_port *port)
+{
+	port->read_status_mask =
+		in_be32(&FIFO_5125(port)->tximr) << 16 |
+		in_be32(&FIFO_5125(port)->rximr);
+	out_be32(&FIFO_5125(port)->tximr, 0);
+	out_be32(&FIFO_5125(port)->rximr, 0);
+}
+
+static void mpc5125_psc_cw_restore_ints(struct uart_port *port)
+{
+	out_be32(&FIFO_5125(port)->tximr,
+		(port->read_status_mask >> 16) & 0x7f);
+	out_be32(&FIFO_5125(port)->rximr, port->read_status_mask & 0x7f);
+}
+
+static unsigned int mpc5125_psc_set_baudrate(struct uart_port *port,
+					     struct ktermios *new,
+					     struct ktermios *old)
+{
+	unsigned int baud;
+	unsigned int divisor;
+
+	/*
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
+	mpc5125_set_divisor(PSC_5125(port), 0xdd, divisor);
+	return baud;
+}
+
+/* MPC5125 have compatible PSC FIFO Controller.
+ * Special init not needed.
+ */
+
+static u16 mpc5125_psc_get_status(struct uart_port *port)
+{
+	return in_be16(&PSC_5125(port)->mpc52xx_psc_status);
+}
+
+static u8 mpc5125_psc_get_ipcr(struct uart_port *port)
+{
+	return in_8(&PSC_5125(port)->mpc52xx_psc_ipcr);
+}
+
+static void mpc5125_psc_command(struct uart_port *port, u8 cmd)
+{
+	out_8(&PSC_5125(port)->command, cmd);
+}
+
+static void mpc5125_psc_set_mode(struct uart_port *port, u8 mr1, u8 mr2)
+{
+	out_8(&PSC_5125(port)->mr1, mr1);
+	out_8(&PSC_5125(port)->mr2, mr2);
+}
+
+static void mpc5125_psc_set_rts(struct uart_port *port, int state)
+{
+	if (state & TIOCM_RTS)
+		out_8(&PSC_5125(port)->op1, MPC52xx_PSC_OP_RTS);
+	else
+		out_8(&PSC_5125(port)->op0, MPC52xx_PSC_OP_RTS);
+}
+
+static void
+mpc5125_psc_enable_ms(struct uart_port *port)
+{
+	struct mpc5125_psc __iomem *psc = PSC_5125(port);
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
+static void mpc5125_psc_set_sicr(struct uart_port *port, u32 val)
+{
+	out_be32(&PSC_5125(port)->sicr, val);
+}
+
+static void mpc5125_psc_set_imr(struct uart_port *port, u16 val)
+{
+	out_be16(&PSC_5125(port)->mpc52xx_psc_imr, val);
+}
+
+static u8 mpc5125_psc_get_mr1(struct uart_port *port)
+{
+	return in_8(&PSC_5125(port)->mr1);
+}
+
+static struct psc_ops mpc5125_psc_ops = {
+	.fifo_init = mpc5125_psc_fifo_init,
+	.raw_rx_rdy = mpc5125_psc_raw_rx_rdy,
+	.raw_tx_rdy = mpc5125_psc_raw_tx_rdy,
+	.rx_rdy = mpc5125_psc_rx_rdy,
+	.tx_rdy = mpc5125_psc_tx_rdy,
+	.tx_empty = mpc5125_psc_tx_empty,
+	.stop_rx = mpc5125_psc_stop_rx,
+	.start_tx = mpc5125_psc_start_tx,
+	.stop_tx = mpc5125_psc_stop_tx,
+	.rx_clr_irq = mpc5125_psc_rx_clr_irq,
+	.tx_clr_irq = mpc5125_psc_tx_clr_irq,
+	.write_char = mpc5125_psc_write_char,
+	.read_char = mpc5125_psc_read_char,
+	.cw_disable_ints = mpc5125_psc_cw_disable_ints,
+	.cw_restore_ints = mpc5125_psc_cw_restore_ints,
+	.set_baudrate = mpc5125_psc_set_baudrate,
+	.clock = mpc512x_psc_clock,
+	.fifoc_init = mpc512x_psc_fifoc_init,
+	.fifoc_uninit = mpc512x_psc_fifoc_uninit,
+	.get_irq = mpc512x_psc_get_irq,
+	.handle_irq = mpc512x_psc_handle_irq,
+	.get_status = mpc5125_psc_get_status,
+	.get_ipcr = mpc5125_psc_get_ipcr,
+	.command = mpc5125_psc_command,
+	.set_mode = mpc5125_psc_set_mode,
+	.set_rts = mpc5125_psc_set_rts,
+	.enable_ms = mpc5125_psc_enable_ms,
+	.set_sicr = mpc5125_psc_set_sicr,
+	.set_imr = mpc5125_psc_set_imr,
+	.get_mr1 = mpc5125_psc_get_mr1,
+};
+
 static struct psc_ops mpc512x_psc_ops = {
 	.fifo_init = mpc512x_psc_fifo_init,
 	.raw_rx_rdy = mpc512x_psc_raw_rx_rdy,
@@ -595,8 +926,18 @@ static struct psc_ops mpc512x_psc_ops = {
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
 
@@ -613,17 +954,14 @@ mpc52xx_uart_tx_empty(struct uart_port *port)
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
@@ -673,15 +1011,7 @@ mpc52xx_uart_stop_rx(struct uart_port *port)
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
@@ -691,9 +1021,9 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 	spin_lock_irqsave(&port->lock, flags);
 
 	if (ctl == -1)
-		out_8(&PSC(port)->command, MPC52xx_PSC_START_BRK);
+		psc_ops->command(port, MPC52xx_PSC_START_BRK);
 	else
-		out_8(&PSC(port)->command, MPC52xx_PSC_STOP_BRK);
+		psc_ops->command(port, MPC52xx_PSC_STOP_BRK);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -701,7 +1031,6 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
-	struct mpc52xx_psc __iomem *psc = PSC(port);
 	int ret;
 
 	if (psc_ops->clock) {
@@ -717,15 +1046,15 @@ mpc52xx_uart_startup(struct uart_port *port)
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
@@ -733,15 +1062,13 @@ mpc52xx_uart_startup(struct uart_port *port)
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
@@ -754,7 +1081,6 @@ static void
 mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			 struct ktermios *old)
 {
-	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned long flags;
 	unsigned char mr1, mr2;
 	unsigned int j;
@@ -818,13 +1144,11 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
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
@@ -834,8 +1158,8 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 		mpc52xx_uart_enable_ms(port);
 
 	/* Reenable TX & RX */
-	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
-	out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
+	psc_ops->command(port, MPC52xx_PSC_TX_ENABLE);
+	psc_ops->command(port, MPC52xx_PSC_RX_ENABLE);
 
 	/* We're all set, release the lock */
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -963,7 +1287,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
-		status = in_be16(&PSC(port)->mpc52xx_psc_status);
+		status = psc_ops->get_status(port);
 
 		if (status & (MPC52xx_PSC_SR_PE |
 			      MPC52xx_PSC_SR_FE |
@@ -983,7 +1307,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 			}
 
 			/* Clear error condition */
-			out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);
+			psc_ops->command(port, MPC52xx_PSC_RST_ERR_STAT);
 
 		}
 		tty_insert_flip_char(tport, ch, flag);
@@ -1066,7 +1390,7 @@ mpc5xxx_uart_process_int(struct uart_port *port)
 		if (psc_ops->tx_rdy(port))
 			keepgoing |= mpc52xx_uart_int_tx_chars(port);
 
-		status = in_8(&PSC(port)->mpc52xx_psc_ipcr);
+		status = psc_ops->get_ipcr(port);
 		if (status & MPC52xx_PSC_D_DCD)
 			uart_handle_dcd_change(port, !(status & MPC52xx_PSC_DCD));
 
@@ -1107,14 +1431,12 @@ static void __init
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
@@ -1304,6 +1626,7 @@ static struct of_device_id mpc52xx_uart_of_match[] = {
 #endif
 #ifdef CONFIG_PPC_MPC512x
 	{ .compatible = "fsl,mpc5121-psc-uart", .data = &mpc512x_psc_ops, },
+	{ .compatible = "fsl,mpc5125-psc-uart", .data = &mpc5125_psc_ops, },
 #endif
 	{},
 };
-- 
1.7.10.4
