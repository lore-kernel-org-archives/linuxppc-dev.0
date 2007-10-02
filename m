Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 8C212DDF49
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:49:42 +1000 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPA00672MPRPTE0@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 02 Oct 2007 10:49:03 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPA00NDAMPQ0L20@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 02 Oct 2007 10:49:04 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPA00MTHMMEEAG2@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 02 Oct 2007 10:47:02 -0600 (MDT)
Date: Tue, 02 Oct 2007 10:47:02 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Uartlite: Revert register io access changes
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20071002164702.24707.79414.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Reverts commit 58205d2b1256a32c9e8b02587f8ef3cdcf1eb8bd

This driver is used by devices other than the xilinx opb-uartlite which
depend on bytewise access to the registers.  The change to 32 bit access
does not work on these devices.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/ppc/syslib/virtex_devices.c |    2 +-
 drivers/serial/uartlite.c        |   36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index 270ad3a..ace4ec0 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -28,7 +28,7 @@
 	.num_resources = 2, \
 	.resource = (struct resource[]) { \
 		{ \
-			.start = XPAR_UARTLITE_##num##_BASEADDR, \
+			.start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
 			.end = XPAR_UARTLITE_##num##_HIGHADDR, \
 			.flags = IORESOURCE_MEM, \
 		}, \
diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 2b8404c..dfef83f 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -75,7 +75,7 @@ static int ulite_receive(struct uart_port *port, int stat)
 	/* stats */
 	if (stat & ULITE_STATUS_RXVALID) {
 		port->icount.rx++;
-		ch = in_be32((void*)port->membase + ULITE_RX);
+		ch = readb(port->membase + ULITE_RX);
 
 		if (stat & ULITE_STATUS_PARITY)
 			port->icount.parity++;
@@ -120,7 +120,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 		return 0;
 
 	if (port->x_char) {
-		out_be32((void*)port->membase + ULITE_TX, port->x_char);
+		writeb(port->x_char, port->membase + ULITE_TX);
 		port->x_char = 0;
 		port->icount.tx++;
 		return 1;
@@ -129,7 +129,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return 0;
 
-	out_be32((void*)port->membase + ULITE_TX, xmit->buf[xmit->tail]);
+	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
 	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
 	port->icount.tx++;
 
@@ -146,7 +146,7 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 	int busy;
 
 	do {
-		int stat = in_be32((void*)port->membase + ULITE_STATUS);
+		int stat = readb(port->membase + ULITE_STATUS);
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
 	} while (busy);
@@ -162,7 +162,7 @@ static unsigned int ulite_tx_empty(struct uart_port *port)
 	unsigned int ret;
 
 	spin_lock_irqsave(&port->lock, flags);
-	ret = in_be32((void*)port->membase + ULITE_STATUS);
+	ret = readb(port->membase + ULITE_STATUS);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
@@ -185,7 +185,7 @@ static void ulite_stop_tx(struct uart_port *port)
 
 static void ulite_start_tx(struct uart_port *port)
 {
-	ulite_transmit(port, in_be32((void*)port->membase + ULITE_STATUS));
+	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
 }
 
 static void ulite_stop_rx(struct uart_port *port)
@@ -214,17 +214,17 @@ static int ulite_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	out_be32((void*)port->membase + ULITE_CONTROL,
-	         ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
-	out_be32((void*)port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
+	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
+	       port->membase + ULITE_CONTROL);
+	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
 
 	return 0;
 }
 
 static void ulite_shutdown(struct uart_port *port)
 {
-	out_be32((void*)port->membase + ULITE_CONTROL, 0);
-	in_be32((void*)port->membase + ULITE_CONTROL); /* dummy */
+	writeb(0, port->membase + ULITE_CONTROL);
+	readb(port->membase + ULITE_CONTROL); /* dummy */
 	free_irq(port->irq, port);
 }
 
@@ -332,7 +332,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 
 	/* wait up to 10ms for the character(s) to be sent */
 	for (i = 0; i < 10000; i++) {
-		if (in_be32((void*)port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
+		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
 			break;
 		udelay(1);
 	}
@@ -341,7 +341,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 static void ulite_console_putchar(struct uart_port *port, int ch)
 {
 	ulite_console_wait_tx(port);
-	out_be32((void*)port->membase + ULITE_TX, ch);
+	writeb(ch, port->membase + ULITE_TX);
 }
 
 static void ulite_console_write(struct console *co, const char *s,
@@ -358,8 +358,8 @@ static void ulite_console_write(struct console *co, const char *s,
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-	ier = in_be32((void*)port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
-	out_be32((void*)port->membase + ULITE_CONTROL, 0);
+	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
+	writeb(0, port->membase + ULITE_CONTROL);
 
 	uart_console_write(port, s, count, ulite_console_putchar);
 
@@ -367,7 +367,7 @@ static void ulite_console_write(struct console *co, const char *s,
 
 	/* restore interrupt state */
 	if (ier)
-		out_be32((void*)port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
+		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -598,7 +598,7 @@ ulite_of_probe(struct of_device *op, const struct of_device_id *match)
 
 	rc = of_address_to_resource(op->node, 0, &res);
 	if (rc) {
-		dev_err(&op->dev, "invalide address\n");
+		dev_err(&op->dev, "invalid address\n");
 		return rc;
 	}
 
@@ -606,7 +606,7 @@ ulite_of_probe(struct of_device *op, const struct of_device_id *match)
 
 	id = of_get_property(op->node, "port-number", NULL);
 
-	return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
+	return ulite_assign(&op->dev, id ? *id : -1, res.start+3, irq);
 }
 
 static int __devexit ulite_of_remove(struct of_device *op)
