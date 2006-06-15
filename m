Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9C5D367B66
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 21:04:55 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5FB4p6v014592
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 04:04:51 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5FB4m23024164
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 06:04:50 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306AB01E4@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Adrian Cox <adrian@humboldt.co.uk>, Russell King
	<rmk+lkml@arm.linux.org.uk>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Thu, 15 Jun 2006 19:04:48 +0800
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


> 
> Perhaps you should define a new value for 
> uart_8250_port.port.iotype, and add code to serial_in and 
> serial_out to handle the IIR register.
> 
> --
> Adrian Cox <adrian@humboldt.co.uk>
> 
The following patch gets rid of CONFIG_TSI108_BRIDGE.
I add UPIO_TSI  to handle IIR and IER register in serial_in and
serial_out.

(1) the reason to rewrite serial_in:
TSI108 rev Z1 version ERRATA. Reading the UART's Interrupt Identification Register (IIR) clears the Transmit 
Holding Register Empty (THRE) and Transmit buffer Empty (TEMP) interrupts even if they are not enabled in
 the Interrupt Enable Register (IER). This leads to loss of the interrupts. Interrupts are not cleared
 when reading UART registers as 32-bit word.

(2) the reason to rewrite serial_out:
Check for UART_IER_UUE bit in the autoconfig routine. This section of autoconfig is excluded for 
Tsi108/109 because bits 7 and 6 are reserved for internal use. They are R/W bits. In addition to 
incorrect identification, changing these bits (from 00) will make Tsi108/109 UART non-functional.  


diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index bbf78aa..6343d7a 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -300,6 +300,7 @@ #endif
 
 static unsigned int serial_in(struct uart_8250_port *up, int offset)
 {
+	unsigned int tmp;
 	offset = map_8250_in_reg(up, offset) << up->port.regshift;
 
 	switch (up->port.iotype) {
@@ -317,6 +318,13 @@ #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
 		return __raw_readl(up->port.membase + offset);
 #endif
+		
+	case UPIO_TSI:
+		if (offset == UART_IIR){
+			tmp = readl((u32 *)(up->port.membase + UART_RX)) ;
+			return (cpu_to_le32(tmp)>> 8) & 0xff;
+		}else
+			return readb(up->port.membase + offset);
 
 	default:
 		return inb(up->port.iobase + offset);
@@ -347,6 +355,10 @@ #ifdef CONFIG_SERIAL_8250_AU1X00
 		__raw_writel(value, up->port.membase + offset);
 		break;
 #endif
+	case UPIO_TSI:
+		if (!((offset == UART_IER) && (value & UART_IER_UUE)))
+			writeb(value, up->port.membase + offset);
+		break;
 
 	default:
 		outb(value, up->port.iobase + offset);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bd14858..fcf48d3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -224,6 +224,7 @@ #define UPIO_HUB6		(1)
 #define UPIO_MEM		(2)
 #define UPIO_MEM32		(3)
 #define UPIO_AU			(4)			/* Au1x00 type IO */
+#define UPIO_TSI		(5)			/* Tsi108/109 type IO */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
