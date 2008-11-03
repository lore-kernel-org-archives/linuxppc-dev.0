Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	by ozlabs.org (Postfix) with ESMTP id 6D6E5DDEDE
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 06:32:14 +1100 (EST)
Message-ID: <490F51E7.3020309@unicontrol.de>
Date: Mon, 03 Nov 2008 20:32:55 +0100
From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] workaround for mpc52xx erratum #364 (serial may not be reset
	in break state)
Content-Type: multipart/mixed; boundary="------------010301060909020608050500"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010301060909020608050500
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi

This patch is a workaround for bug #364 found in the MPC52xx processor.
The errata document can be found under 
http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf?fpsp=1&WT_TYPE=Errata&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation

When a device with a low baudrate is connected to the serial port, but 
the processor "listens" on a higher baudrate, it might falsely receive 
breaks from the controller. During a break, the serial controller may 
not be reset. The appended patch provides a workaround for that 
situation by lowering the baudrate without resetting the controller and 
waiting until no break is received anymore.


-- 
René Bürgel
Software Engineer
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
 
Tel.: 03 72 06/ 88 73 - 19
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de
 
Unicontrol Systemtechnik GmbH
Geschäftsführer: Dipl.-Ing. Siegfried Heinze
Sitz der Gesellschaft: Frankenberg
Registergericht: Amtsgericht Chemnitz, HRB 15 475



--------------010301060909020608050500
Content-Type: text/plain;
 name="122-mpc52xx_erratum_364.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="122-mpc52xx_erratum_364.patch"

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 6117d3d..929524b 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -496,6 +496,27 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+/* macro with helper macros to safely reset rx which mustn't be done in break state.
+ * This is a workaround for processor bug #364 described in MPC5200 (L25R) Errata.
+ *
+ * The workaround resets the baudrate to 4800, waits for a stable state and resets break state repeatedly if necessary
+ * optionally it can release the lock while waiting.
+ * 1 character at 4800 baud takes 2ms, 3ms should be enough for 1 character at higher speed and 1 char at lowest
+ * works only with longer delays
+ */
+#define LOCK(code) code
+#define DONT_LOCK(code)
+#define mpc52xx_uart_reset_rx(LOCK)								\
+	out_8(&psc->ctur,0x01);									\
+	out_8(&psc->ctlr,0xae);									\
+	do {											\
+		out_8(&psc->command,MPC52xx_PSC_RST_ERR_STAT);					\
+		LOCK(disable_irq(port->irq); spin_unlock_irqrestore(&port->lock, flags));	\
+		mdelay(10);									\
+		LOCK(spin_lock_irqsave(&port->lock, flags); enable_irq(port->irq));		\
+	} while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB);			\
+	out_8(&psc->command,MPC52xx_PSC_RST_RX);
+
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
@@ -510,7 +531,7 @@ mpc52xx_uart_startup(struct uart_port *port)
 		return ret;
 
 	/* Reset/activate the port, clear and enable interrupts */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(DONT_LOCK);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
 	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
@@ -529,7 +550,7 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
 	/* Shut down the port.  Leave TX active if on a console port */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(DONT_LOCK);
 	if (!uart_console(port))
 		out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
@@ -588,9 +609,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
 
-	/* Update the per-port timeout */
-	uart_update_timeout(port, new->c_cflag, baud);
-
 	/* Do our best to flush TX & RX, so we don't loose anything */
 	/* But we don't wait indefinitly ! */
 	j = 5000000;	/* Maximum wait */
@@ -607,9 +625,12 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			"Some chars may have been lost.\n");
 
 	/* Reset the TX & RX */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(LOCK);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
+	/* Update the per-port timeout */
+	uart_update_timeout(port, new->c_cflag, baud);
+
 	/* Send new mode settings */
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);

--------------010301060909020608050500--
