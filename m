Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 17EB367D53
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:14:34 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k4HBU8Jk022909
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:30:08 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k4HAH6Vp016788
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:17:07 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626D625@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Wed, 17 May 2006 18:14:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch contains changes to the serial device driver specific for integrated
serial port in Tsi108 Host Bridge.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

>From nobody Mon Sep 17 00:00:00 2001
From: roy zang <tie-fei.zang@freescale.com>
Date: Tue May 16 15:26:02 2006 +0800
Subject: [PATCH] Add tsi108 serial support

---

 drivers/serial/8250.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

6cb950357e9970afa671d59f172dbc4b03f11560
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index bbf78aa..c12f516 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -723,7 +723,9 @@ static int broken_efr(struct uart_8250_p
 static void autoconfig_16550a(struct uart_8250_port *up)
 {
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
 	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
@@ -859,6 +862,7 @@ static void autoconfig_16550a(struct uar
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
 
@@ -1529,7 +1538,9 @@ static int serial8250_startup(struct uar
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long flags;
+#ifndef CONFIG_TSI108_BRIDGE
 	unsigned char lsr, iir;
+#endif
 	int retval;
 
 	up->capabilities = uart_config[up->port.type].flags;
@@ -1567,7 +1578,9 @@ #endif
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
