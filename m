Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 7E978DE0CE
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 12:16:40 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP9003G6IAKW3F0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:56 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP900M0HIA9M390@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 01 Oct 2007 20:15:56 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP900HFMIA28VA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:38 -0600 (MDT)
Date: Mon, 01 Oct 2007 20:15:39 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 06/12] Uartlite: Fix reg io to access documented register
	size
In-reply-to: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20071002021539.9579.31448.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The Uartlite data sheet defines the registers as 32 bit wide.  This
patch changes the register access to use 32 bit transfers and eliminates
the magic +3 offset which is currently required to make the device
work.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: John Williams <jwilliams@itee.uq.edu.au>
---

 arch/ppc/syslib/virtex_devices.c |    2 +-
 drivers/serial/uartlite.c        |   32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index ace4ec0..270ad3a 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -28,7 +28,7 @@
 	.num_resources = 2, \
 	.resource = (struct resource[]) { \
 		{ \
-			.start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
+			.start = XPAR_UARTLITE_##num##_BASEADDR, \
 			.end = XPAR_UARTLITE_##num##_HIGHADDR, \
 			.flags = IORESOURCE_MEM, \
 		}, \
diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index f5051cf..59b674a 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -61,7 +61,7 @@ static int ulite_receive(struct uart_port *port, int stat)
 	/* stats */
 	if (stat & ULITE_STATUS_RXVALID) {
 		port->icount.rx++;
-		ch = readb(port->membase + ULITE_RX);
+		ch = in_be32((void*)port->membase + ULITE_RX);
 
 		if (stat & ULITE_STATUS_PARITY)
 			port->icount.parity++;
@@ -106,7 +106,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 		return 0;
 
 	if (port->x_char) {
-		writeb(port->x_char, port->membase + ULITE_TX);
+		out_be32((void*)port->membase + ULITE_TX, port->x_char);
 		port->x_char = 0;
 		port->icount.tx++;
 		return 1;
@@ -115,7 +115,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return 0;
 
-	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
+	out_be32((void*)port->membase + ULITE_TX, xmit->buf[xmit->tail]);
 	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
 	port->icount.tx++;
 
@@ -132,7 +132,7 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 	int busy;
 
 	do {
-		int stat = readb(port->membase + ULITE_STATUS);
+		int stat = in_be32((void*)port->membase + ULITE_STATUS);
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
 	} while (busy);
@@ -148,7 +148,7 @@ static unsigned int ulite_tx_empty(struct uart_port *port)
 	unsigned int ret;
 
 	spin_lock_irqsave(&port->lock, flags);
-	ret = readb(port->membase + ULITE_STATUS);
+	ret = in_be32((void*)port->membase + ULITE_STATUS);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
@@ -171,7 +171,7 @@ static void ulite_stop_tx(struct uart_port *port)
 
 static void ulite_start_tx(struct uart_port *port)
 {
-	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
+	ulite_transmit(port, in_be32((void*)port->membase + ULITE_STATUS));
 }
 
 static void ulite_stop_rx(struct uart_port *port)
@@ -200,17 +200,17 @@ static int ulite_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
-	       port->membase + ULITE_CONTROL);
-	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+	out_be32((void*)port->membase + ULITE_CONTROL,
+	         ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
+	out_be32((void*)port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
 
 	return 0;
 }
 
 static void ulite_shutdown(struct uart_port *port)
 {
-	writeb(0, port->membase + ULITE_CONTROL);
-	readb(port->membase + ULITE_CONTROL); /* dummy */
+	out_be32((void*)port->membase + ULITE_CONTROL, 0);
+	in_be32((void*)port->membase + ULITE_CONTROL); /* dummy */
 	free_irq(port->irq, port);
 }
 
@@ -314,7 +314,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 
 	/* wait up to 10ms for the character(s) to be sent */
 	for (i = 0; i < 10000; i++) {
-		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
+		if (in_be32((void*)port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
 			break;
 		udelay(1);
 	}
@@ -323,7 +323,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 static void ulite_console_putchar(struct uart_port *port, int ch)
 {
 	ulite_console_wait_tx(port);
-	writeb(ch, port->membase + ULITE_TX);
+	out_be32((void*)port->membase + ULITE_TX, ch);
 }
 
 static void ulite_console_write(struct console *co, const char *s,
@@ -340,8 +340,8 @@ static void ulite_console_write(struct console *co, const char *s,
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
-	writeb(0, port->membase + ULITE_CONTROL);
+	ier = in_be32((void*)port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
+	out_be32((void*)port->membase + ULITE_CONTROL, 0);
 
 	uart_console_write(port, s, count, ulite_console_putchar);
 
@@ -349,7 +349,7 @@ static void ulite_console_write(struct console *co, const char *s,
 
 	/* restore interrupt state */
 	if (ier)
-		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+		out_be32((void*)port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
