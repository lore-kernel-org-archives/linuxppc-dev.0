Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	by ozlabs.org (Postfix) with ESMTP id 09E47DDE17
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 06:40:19 +1100 (EST)
Message-ID: <4910A519.3030701@unicontrol.de>
Date: Tue, 04 Nov 2008 20:40:09 +0100
From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V3] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de>
	<20081104111545.GB17864@pengutronix.de>
In-Reply-To: <20081104111545.GB17864@pengutronix.de>
Content-Type: multipart/mixed; boundary="------------020606040600000400020507"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020606040600000400020507
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hey, folks

This is v3 of my patch to work around erratum #364 of the MPC5200(B). I 
removed most "magic" looking numbers, documenting the rest. As mentioned 
before, the previous patches weren't working for low baudrates (<9600). 
This should be fixed now.

But there's still one thing, that bothers me a bit - if there is REALLY 
a break on the line, closing the driver may take until it's gone. I 
don't know whether this is really satisfying, but i think it's better 
than the alternative: no serial connection until the next reboot.

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



--------------020606040600000400020507
Content-Type: text/plain;
 name="130-mpc52xx_erratum_364.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="130-mpc52xx_erratum_364.patch"

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 6117d3d..a2bb4d9 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -496,6 +496,59 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+/*
+ * This is a workaround for processor bug #364 described in MPC5200 (L25R) Errata.
+ * The bug is still present in MPC5200B, but currently not listed in its errata sheet
+ *
+ * The workaround resets the baudrate to the slowest possible,
+ * waits for a stable state and resets break state repeatedly if necessary.
+ * Optionally it can release the lock while waiting.
+ *
+ * That baudrate is roughly port->uartclk / (1000 * 1000)
+ * The minimum wait time for the first try has to include the time to wait for stop-bits and a character,
+ * we wait for 2 chars to be sure
+ * Consecutive waits must just receive one character.
+ */
+
+static void mpc52xx_uart_reset_rx(struct uart_port *port, bool unlock, unsigned long flags)
+{
+#ifdef CONFIG_PPC_MPC52xx
+	void reset_errors_and_wait(struct uart_port *port, bool unlock, unsigned long flags, unsigned int delay)
+	{
+		struct mpc52xx_psc __iomem *psc = PSC(port);
+		out_8(&psc->command,MPC52xx_PSC_RST_ERR_STAT);
+		if (unlock) {
+			disable_irq(port->irq);
+			spin_unlock_irqrestore(&port->lock, flags);
+		}
+		mdelay( delay );
+		if (unlock) {
+			spin_lock_irqsave(&port->lock, flags);
+			enable_irq(port->irq);
+		}
+	}
+
+
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+
+	// One character on the serial port may consist of up to 12 bits.
+	// So the time to receive one char is 12 /*bits*/ / (port->uartclk / (1000 * 1000) /*MHz -> Hz*/) * 1000 /*s -> ms*/,
+	// but we'll wait 50% longer just to make sure
+	unsigned int one_char_receive_duration = (12 * 1000) / (port->uartclk / (1000 * 1000) );
+
+	/* CT=0xFFFF sets the serial line to the minimal possible baudrate depending on the uartclk. */
+	out_8(&psc->ctur, 0xFF);
+	out_8(&psc->ctlr, 0xFF);
+
+	reset_errors_and_wait( port, unlock, flags, one_char_receive_duration * 2 );
+
+	while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB) {
+		reset_errors_and_wait( port, unlock, flags, one_char_receive_duration );
+	}
+#endif
+	out_8(&psc->command,MPC52xx_PSC_RST_RX);
+}
+
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
@@ -510,7 +563,7 @@ mpc52xx_uart_startup(struct uart_port *port)
 		return ret;
 
 	/* Reset/activate the port, clear and enable interrupts */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, false, 0);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
 	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
@@ -529,7 +582,7 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
 	/* Shut down the port.  Leave TX active if on a console port */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, false, 0);
 	if (!uart_console(port))
 		out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
@@ -588,9 +641,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
 
-	/* Update the per-port timeout */
-	uart_update_timeout(port, new->c_cflag, baud);
-
 	/* Do our best to flush TX & RX, so we don't loose anything */
 	/* But we don't wait indefinitly ! */
 	j = 5000000;	/* Maximum wait */
@@ -607,9 +657,12 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			"Some chars may have been lost.\n");
 
 	/* Reset the TX & RX */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, true, flags);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
+	/* Update the per-port timeout */
+	uart_update_timeout(port, new->c_cflag, baud);
+
 	/* Send new mode settings */
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);

--------------020606040600000400020507--
