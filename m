Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B779E2C016A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 07:22:15 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-serial@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/2] serial/mpc52xx_uart: add MPC5125 PSC support
Date: Wed, 17 Apr 2013 23:21:42 +0200
Message-Id: <1366233702-20689-2-git-send-email-agust@denx.de>
In-Reply-To: <1366233702-20689-1-git-send-email-agust@denx.de>
References: <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
 <1366233702-20689-1-git-send-email-agust@denx.de>
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

Add MPC5125 PSC register layout structure, MPC5125 specific
psc_ops function set and the compatible string.

Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Changes in v2:
 - split into two patches to simplify review
 - minor coding style changes 
 - revise commit log

 arch/powerpc/include/asm/mpc52xx_psc.h |   49 +++++++
 drivers/tty/serial/mpc52xx_uart.c      |  241 ++++++++++++++++++++++++++++++++
 2 files changed, 290 insertions(+)

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
index 5aa87ac..9c3eab5 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -658,6 +658,246 @@ static void mpc512x_psc_get_irq(struct uart_port *port, struct device_node *np)
 	port->irqflags = IRQF_SHARED;
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
+	return in_be32(&FIFO_5125(port)->rxsr) &
+	       in_be32(&FIFO_5125(port)->rximr) & MPC512x_PSC_FIFO_ALARM;
+}
+
+static int mpc5125_psc_tx_rdy(struct uart_port *port)
+{
+	return in_be32(&FIFO_5125(port)->txsr) &
+	       in_be32(&FIFO_5125(port)->tximr) & MPC512x_PSC_FIFO_ALARM;
+}
+
+static int mpc5125_psc_tx_empty(struct uart_port *port)
+{
+	return in_be32(&FIFO_5125(port)->txsr) & MPC512x_PSC_FIFO_EMPTY;
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
+static inline void mpc5125_set_divisor(struct mpc5125_psc __iomem *psc,
+		u8 prescaler, unsigned int divisor)
+{
+	/* select prescaler */
+	out_8(&psc->mpc52xx_psc_clock_select, prescaler);
+	out_8(&psc->ctur, divisor >> 8);
+	out_8(&psc->ctlr, divisor & 0xff);
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
+/*
+ * MPC5125 have compatible PSC FIFO Controller.
+ * Special init not needed.
+ */
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
+static void mpc5125_psc_enable_ms(struct uart_port *port)
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
 
 static struct psc_ops mpc512x_psc_ops = {
 	.fifo_init = mpc512x_psc_fifo_init,
@@ -1381,6 +1621,7 @@ static struct of_device_id mpc52xx_uart_of_match[] = {
 #endif
 #ifdef CONFIG_PPC_MPC512x
 	{ .compatible = "fsl,mpc5121-psc-uart", .data = &mpc512x_psc_ops, },
+	{ .compatible = "fsl,mpc5125-psc-uart", .data = &mpc5125_psc_ops, },
 #endif
 	{},
 };
-- 
1.7.9.5
