Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 3D2B2DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 02:12:59 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: grant.likely@secretlab.ca
Subject: [PATCH] mpc52xx/serial: add rts/cts handling
Date: Wed, 26 Nov 2008 16:04:54 +0100
Message-Id: <1227711894-28874-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add RTS/CTS-support for the PSC of the MPC5200B. Tested with a Phytec
MPC5200B-IO.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/powerpc/include/asm/mpc52xx_psc.h |   11 +++++++-
 drivers/serial/mpc52xx_uart.c          |   41 ++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index 8917ed6..a218da6 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -68,12 +68,20 @@
 #define MPC52xx_PSC_IMR_ORERR		0x1000
 #define MPC52xx_PSC_IMR_IPC		0x8000
 
-/* PSC input port change bit */
+/* PSC input port change bits */
 #define MPC52xx_PSC_CTS			0x01
 #define MPC52xx_PSC_DCD			0x02
 #define MPC52xx_PSC_D_CTS		0x10
 #define MPC52xx_PSC_D_DCD		0x20
 
+/* PSC acr bits */
+#define MPC52xx_PSC_IEC_CTS		0x01
+#define MPC52xx_PSC_IEC_DCD		0x02
+
+/* PSC output port bits */
+#define MPC52xx_PSC_OP_RTS		0x01
+#define MPC52xx_PSC_OP_RES		0x02
+
 /* PSC mode fields */
 #define MPC52xx_PSC_MODE_5_BITS			0x00
 #define MPC52xx_PSC_MODE_6_BITS			0x01
@@ -91,6 +99,7 @@
 #define MPC52xx_PSC_MODE_ONE_STOP_5_BITS	0x00
 #define MPC52xx_PSC_MODE_ONE_STOP		0x07
 #define MPC52xx_PSC_MODE_TWO_STOP		0x0f
+#define MPC52xx_PSC_MODE_TXCTS			0x10
 
 #define MPC52xx_PSC_RFNUM_MASK	0x01ff
 
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 6117d3d..3234100 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -429,14 +429,24 @@ mpc52xx_uart_tx_empty(struct uart_port *port)
 static void
 mpc52xx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	/* Not implemented */
+	if (mctrl & TIOCM_RTS)
+		out_8(&PSC(port)->op1, MPC52xx_PSC_OP_RTS);
+	else
+		out_8(&PSC(port)->op0, MPC52xx_PSC_OP_RTS);
 }
 
 static unsigned int
 mpc52xx_uart_get_mctrl(struct uart_port *port)
 {
-	/* Not implemented */
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+	unsigned int ret = TIOCM_DSR;
+	u8 status = in_8(&PSC(port)->mpc52xx_psc_ipcr);
+
+	if (!(status & MPC52xx_PSC_CTS))
+		ret |= TIOCM_CTS;
+	if (!(status & MPC52xx_PSC_DCD))
+		ret |= TIOCM_CAR;
+
+	return ret;
 }
 
 static void
@@ -479,7 +489,15 @@ mpc52xx_uart_stop_rx(struct uart_port *port)
 static void
 mpc52xx_uart_enable_ms(struct uart_port *port)
 {
-	/* Not implemented */
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+
+	/* clear D_*-bits by reading them */
+	in_8(&psc->mpc52xx_psc_ipcr);
+	/* enable CTS and DCD as IPC interrupts */
+	out_8(&psc->mpc52xx_psc_acr, MPC52xx_PSC_IEC_CTS | MPC52xx_PSC_IEC_DCD);
+
+	port->read_status_mask |= MPC52xx_PSC_IMR_IPC;
+	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
 }
 
 static void
@@ -580,6 +598,10 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			MPC52xx_PSC_MODE_ONE_STOP_5_BITS :
 			MPC52xx_PSC_MODE_ONE_STOP;
 
+	if (new->c_cflag & CRTSCTS) {
+		mr1 |= MPC52xx_PSC_MODE_RXRTS;
+		mr2 |= MPC52xx_PSC_MODE_TXCTS;
+	}
 
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
 	quot = uart_get_divisor(port, baud);
@@ -617,6 +639,9 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	out_8(&psc->ctur, ctr >> 8);
 	out_8(&psc->ctlr, ctr & 0xff);
 
+	if (UART_ENABLE_MS(port, new->c_cflag))
+		mpc52xx_uart_enable_ms(port);
+
 	/* Reenable TX & RX */
 	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
 	out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
@@ -826,6 +851,7 @@ mpc52xx_uart_int(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	unsigned long pass = ISR_PASS_LIMIT;
 	unsigned int keepgoing;
+	u8 status;
 
 	spin_lock(&port->lock);
 
@@ -842,6 +868,13 @@ mpc52xx_uart_int(int irq, void *dev_id)
 		if (psc_ops->tx_rdy(port))
 			keepgoing |= mpc52xx_uart_int_tx_chars(port);
 
+		status = in_8(&PSC(port)->mpc52xx_psc_ipcr);
+		if (status & MPC52xx_PSC_D_DCD)
+			uart_handle_dcd_change(port, !(status & MPC52xx_PSC_DCD));
+
+		if (status & MPC52xx_PSC_D_CTS)
+			uart_handle_cts_change(port, !(status & MPC52xx_PSC_CTS));
+
 		/* Limit number of iteration */
 		if (!(--pass))
 			keepgoing = 0;
-- 
1.5.6.5
