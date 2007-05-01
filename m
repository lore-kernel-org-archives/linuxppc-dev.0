Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5217CDDFF0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 14:55:22 +1000 (EST)
Message-ID: <4636C836.4050502@itee.uq.edu.au>
Date: Tue, 01 May 2007 14:55:18 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, jacmet@sunsite.dk
Subject: [RFC] uartlite driver MicroBlaze compatability
Content-Type: multipart/mixed; boundary="------------010708000906060803060706"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010708000906060803060706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

The attached patch gets your uartlite driver going on MicroBlaze.

All readb/writeb ops are converted to ioread32/iowrite32.

On MicroBlaze readb/writeb are picking up the MSB, instead of LSB, and 
thus reading all zeros instead of the 8-bit control/status/FIFO 
registers that you intended.

Can you please confirm if this works on PPC?

I note that Grant's recent bootloader driver uses in_be32/out_be32 - 
would you prefer that instead of ioread32/iowrite32?

Thanks,

John

--------------010708000906060803060706
Content-Type: text/plain;
 name="00001-uartlite-32bit-ops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="00001-uartlite-32bit-ops.patch"

Convert readb/writeb ops into ioread32/iowrite32.

This gets the driver working with MicroBlaze (2.6.20).

signed-off-by: John Williams jwilliams@itee.uq.edu.au

Index: linux-2.6.x/drivers/serial/uartlite.c
===================================================================
--- linux-2.6.x/drivers/serial/uartlite.c	(revision 2561)
+++ linux-2.6.x/drivers/serial/uartlite.c	(working copy)
@@ -61,7 +61,7 @@
 	/* stats */
 	if (stat & ULITE_STATUS_RXVALID) {
 		port->icount.rx++;
-		ch = readb(port->membase + ULITE_RX);
+		ch = ioread32(port->membase + ULITE_RX);
 
 		if (stat & ULITE_STATUS_PARITY)
 			port->icount.parity++;
@@ -106,7 +106,7 @@
 		return 0;
 
 	if (port->x_char) {
-		writeb(port->x_char, port->membase + ULITE_TX);
+		iowrite32(port->x_char, port->membase + ULITE_TX);
 		port->x_char = 0;
 		port->icount.tx++;
 		return 1;
@@ -115,7 +115,7 @@
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return 0;
 
-	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
+	iowrite32(xmit->buf[xmit->tail], port->membase + ULITE_TX);
 	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
 	port->icount.tx++;
 
@@ -132,7 +132,7 @@
 	int busy;
 
 	do {
-		int stat = readb(port->membase + ULITE_STATUS);
+		int stat = ioread32(port->membase + ULITE_STATUS);
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
 	} while (busy);
@@ -148,7 +148,7 @@
 	unsigned int ret;
 
 	spin_lock_irqsave(&port->lock, flags);
-	ret = readb(port->membase + ULITE_STATUS);
+	ret = ioread32(port->membase + ULITE_STATUS);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
@@ -171,7 +171,7 @@
 
 static void ulite_start_tx(struct uart_port *port)
 {
-	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
+	ulite_transmit(port, ioread32(port->membase + ULITE_STATUS));
 }
 
 static void ulite_stop_rx(struct uart_port *port)
@@ -200,17 +200,17 @@
 	if (ret)
 		return ret;
 
-	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
+	iowrite32(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
 	       port->membase + ULITE_CONTROL);
-	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+	iowrite32(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
 
 	return 0;
 }
 
 static void ulite_shutdown(struct uart_port *port)
 {
-	writeb(0, port->membase + ULITE_CONTROL);
-	readb(port->membase + ULITE_CONTROL); /* dummy */
+	iowrite32(0, port->membase + ULITE_CONTROL);
+	ioread32(port->membase + ULITE_CONTROL); /* dummy */
 	free_irq(port->irq, port);
 }
 
@@ -314,7 +314,7 @@
 
 	/* wait up to 10ms for the character(s) to be sent */
 	for (i = 0; i < 10000; i++) {
-		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
+		if (ioread32(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
 			break;
 		udelay(1);
 	}
@@ -323,7 +323,7 @@
 static void ulite_console_putchar(struct uart_port *port, int ch)
 {
 	ulite_console_wait_tx(port);
-	writeb(ch, port->membase + ULITE_TX);
+	iowrite32(ch, port->membase + ULITE_TX);
 }
 
 static void ulite_console_write(struct console *co, const char *s,
@@ -340,8 +340,8 @@
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
-	writeb(0, port->membase + ULITE_CONTROL);
+	ier = ioread32(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
+	iowrite32(0, port->membase + ULITE_CONTROL);
 
 	uart_console_write(port, s, count, ulite_console_putchar);
 
@@ -349,7 +349,7 @@
 
 	/* restore interrupt state */
 	if (ier)
-		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+		iowrite32(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);

--------------010708000906060803060706--
