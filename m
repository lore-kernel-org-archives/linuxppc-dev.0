Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3533967B31
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 15:39:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5D5oTaH024419
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jun 2006 22:50:29 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5D5dlpn024973
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 00:39:49 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673069C3C3D@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Tue, 13 Jun 2006 13:39:46 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandre.Bounine@tundra.com, linux-kernel@vger.kernel.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > 
> > On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:
> > 
> > > This patch contains changes to the serial device driver 
> specific for 
> > > integrated serial port in Tsi108 Host Bridge.
> 
> There's no explaination about why this is required.  What is 
> the problem?
> Which changes relate directly to this problem and which 
> changes are related to fixing some other issue not related to 
> the errata?
> 
> Plus, every patch line is prefixed by "> "... patch doesn't like that.

The reason is that the serial port on tsi108/9 is a bit difference with the 
standard 8250 serial port. the patch deal with the difference.
The prefixed ">" is caused by "Fw" the email. Sorry for that. The following 
is the original patch.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

 drivers/serial/8250.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

6cb950357e9970afa671d59f172dbc4b03f11560
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c index bbf78aa..c12f516 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -723,7 +723,9 @@ static int broken_efr(struct uart_8250_p  static void autoconfig_16550a(struct uart_8250_port *up)  {
 	unsigned char status1, status2;
+#ifndef CONFIG_TSI108_BRIDGE
 	unsigned int iersave;
+#endif
 
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
@@ -833,6 +835,7 @@ static void autoconfig_16550a(struct uar
 	 * trying to write and read a 1 just to make sure it's not
 	 * already a 1 and maybe locked there before we even start start.
 	 */
+#ifndef CONFIG_TSI108_BRIDGE
 	iersave = serial_in(up, UART_IER);
 	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
 	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) { @@ -859,6 +862,7 @@ static void autoconfig_16550a(struct uar
 		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
 	}
 	serial_outp(up, UART_IER, iersave);
+#endif
 }
 
 /*
@@ -1348,7 +1352,12 @@ static irqreturn_t serial8250_interrupt(
 
 		up = list_entry(l, struct uart_8250_port, list);
 
+#ifdef CONFIG_TSI108_BRIDGE /* for TSI108_REV_Z1 errata U2 */
+		/* read IIR as part of 32-bit word */
+		iir = (in_be32((u32 *)(up->port.membase + UART_RX)) >> 8) & 0xff; 
+#else
 		iir = serial_in(up, UART_IIR);
+#endif
 		if (!(iir & UART_IIR_NO_INT)) {
 			serial8250_handle_port(up, regs);
 
@@ -1529,7 +1538,9 @@ static int serial8250_startup(struct uar  {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long flags;
+#ifndef CONFIG_TSI108_BRIDGE
 	unsigned char lsr, iir;
+#endif
 	int retval;
 
 	up->capabilities = uart_config[up->port.type].flags; @@ -1567,7 +1578,9 @@ #endif
 	 */
 	(void) serial_inp(up, UART_LSR);
 	(void) serial_inp(up, UART_RX);
+#ifndef CONFIG_TSI108_BRIDGE /* for TSI108_REV_Z1 errata U2 */
 	(void) serial_inp(up, UART_IIR);
+#endif
 	(void) serial_inp(up, UART_MSR);
 
 	/*
@@ -1634,6 +1647,7 @@ #endif
 
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
 
+#ifndef CONFIG_TSI108_BRIDGE
 	/*
 	 * Do a quick test to see if we receive an
 	 * interrupt when we enable the TX irq.
@@ -1652,6 +1666,7 @@ #endif
 	} else {
 		up->bugs &= ~UART_BUG_TXEN;
 	}
+#endif
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
@@ -1678,7 +1693,9 @@ #endif
 	 */
 	(void) serial_inp(up, UART_LSR);
 	(void) serial_inp(up, UART_RX);
+#ifndef CONFIG_TSI108_BRIDGE /* for TSI108_REV_Z1 errata U2 */
 	(void) serial_inp(up, UART_IIR);
+#endif
 	(void) serial_inp(up, UART_MSR);
 
 	return 0;
--
1.3.0
