Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 073BEDDF48
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:49 +1000 (EST)
Message-Id: <20070705170239.706317000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:56 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 23/35] Work around UART erratas
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for, and workarounds for various problems with our UART.

This needs further cleanup at some point.


Index: mainline/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- mainline.orig/arch/powerpc/kernel/udbg_16550.c
+++ mainline/arch/powerpc/kernel/udbg_16550.c
@@ -86,9 +86,9 @@ void udbg_init_uart(void __iomem *compor
 	unsigned int dll, base_bauds;
 
 	if (clock == 0)
-		clock = 1843200;
+		clock = 133333333;
 	if (speed == 0)
-		speed = 9600;
+		speed = 115200;
 
 	base_bauds = clock / 16;
 	dll = base_bauds / speed;
@@ -143,7 +143,7 @@ unsigned int udbg_probe_uart_speed(void 
 
 	/* sanity check */
 	if (speed < 0 || speed > (clock / 16))
-		speed = 9600;
+		speed = 115200;
 
 	return speed;
 }
Index: mainline/include/asm-powerpc/serial.h
===================================================================
--- mainline.orig/include/asm-powerpc/serial.h
+++ mainline/include/asm-powerpc/serial.h
@@ -13,7 +13,7 @@
  */
 
 /* Default baud base if not found in device-tree */
-#define BASE_BAUD ( 1843200 / 16 )
+#define BASE_BAUD ( 133333333 / 16 )
 
 #ifdef CONFIG_PPC_UDBG_16550
 extern void find_legacy_serial_ports(void);
Index: mainline/drivers/serial/8250.c
===================================================================
--- mainline.orig/drivers/serial/8250.c
+++ mainline/drivers/serial/8250.c
@@ -173,7 +173,7 @@ static const struct serial8250_config ua
 		.name		= "16550A",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
-		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
 		.flags		= UART_CAP_FIFO,
 	},
 	[PORT_CIRRUS] = {
@@ -1242,7 +1242,7 @@ static void serial8250_start_tx(struct u
 			if ((up->port.type == PORT_RM9000) ?
 				(lsr & UART_LSR_THRE &&
 				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
-				(lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT))
+				(lsr & UART_LSR_TEMT && !(iir & UART_IIR_NO_INT)))
 				transmit_chars(up);
 		}
 	}
@@ -1465,7 +1465,7 @@ static irqreturn_t serial8250_interrupt(
 		up = list_entry(l, struct uart_8250_port, list);
 
 		iir = serial_in(up, UART_IIR);
-		if (!(iir & UART_IIR_NO_INT)) {
+		if ((iir & UART_IIR_NO_INT)) {
 			serial8250_handle_port(up);
 
 			handled = 1;
@@ -1583,7 +1583,7 @@ static void serial8250_timeout(unsigned 
 	unsigned int iir;
 
 	iir = serial_in(up, UART_IIR);
-	if (!(iir & UART_IIR_NO_INT))
+	if ((iir & UART_IIR_NO_INT))
 		serial8250_handle_port(up);
 	mod_timer(&up->timer, jiffies + poll_timeout(up->port.timeout));
 }
@@ -1610,14 +1610,14 @@ static void serial8250_backup_timeout(un
 	 * the "Diva" UART used on the management processor on many HP
 	 * ia64 and parisc boxes.
 	 */
-	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
+	if (!(iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
 	    (!uart_circ_empty(&up->port.info->xmit) || up->port.x_char) &&
 	    (serial_in(up, UART_LSR) & UART_LSR_THRE)) {
-		iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
-		iir |= UART_IIR_THRI;
+		iir &= ~UART_IIR_ID;
+		iir |= UART_IIR_THRI | UART_IIR_NO_INT;
 	}
 
-	if (!(iir & UART_IIR_NO_INT))
+	if ((iir & UART_IIR_NO_INT))
 		serial8250_handle_port(up);
 
 	if (is_real_interrupt(up->port.irq))
@@ -1826,7 +1826,7 @@ static int serial8250_startup(struct uar
 		 * If the interrupt is not reasserted, setup a timer to
 		 * kick the UART on a regular basis.
 		 */
-		if (iir & UART_IIR_NO_INT) {
+		if (!(iir & UART_IIR_NO_INT)) {
 			pr_debug("ttyS%d - using backup timer\n", port->line);
 			up->timer.function = serial8250_backup_timeout;
 			up->timer.data = (unsigned long)up;
@@ -1876,7 +1876,7 @@ static int serial8250_startup(struct uar
 	iir = serial_in(up, UART_IIR);
 	serial_outp(up, UART_IER, 0);
 
-	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
+	if (lsr & UART_LSR_TEMT && !(iir & UART_IIR_NO_INT)) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
 			up->bugs |= UART_BUG_TXEN;
 			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
Index: mainline/drivers/serial/8250_pci.c
===================================================================
--- mainline.orig/drivers/serial/8250_pci.c
+++ mainline/drivers/serial/8250_pci.c
@@ -984,6 +984,7 @@ enum pci_board_num_t {
 	pbn_exar_XR17C152,
 	pbn_exar_XR17C154,
 	pbn_exar_XR17C158,
+	pbn_pasemi_1682M,
 };
 
 /*
@@ -1511,6 +1512,14 @@ static struct pciserial_board pci_boards
 		.base_baud	= 921600,
 		.uart_offset	= 0x200,
 	},
+	/*
+	 * PA Semi PWRficient PA6T-1682M on-chip UART
+	 */
+	[pbn_pasemi_1682M] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 8333333,
+	},
 };
 
 /*
@@ -2402,6 +2411,13 @@ static struct pci_device_id serial_pci_t
 		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS8,
 		0, 0, pbn_b2_8_921600 },
 	/*
+	 * PA Semi PA6T-1682M on-chip UART
+	 */
+	{	PCI_VENDOR_ID_PASEMI, 0xa004,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_pasemi_1682M },
+
+	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
 	 */

--
