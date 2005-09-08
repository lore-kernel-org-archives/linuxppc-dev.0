Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 7246668206
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 01:13:45 +1000 (EST)
Date: Thu, 8 Sep 2005 08:13:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20050908151343.GJ3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.13] ppc32: In the boot code,
	don't rely on BASE_BAUD directly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Modifies serial_init to get base baud rate from the rs_table entry
instead of BAUD_BASE.  This patch eliminates duplication between the
SERIAL_PORT_DFNS macro and BAUD_BASE.  Without the patch, if a port
set the baud rate in SERIAL_PORT_DFNS, but did not update BASE_BAUD,
the BASE_BAUD value would still be used.

Signed-off-by: Grant Likely <grant.likely@gdcanada.com>  
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6/arch/ppc/boot/common/ns16550.c
===================================================================
--- linux-2.6.orig/arch/ppc/boot/common/ns16550.c
+++ linux-2.6/arch/ppc/boot/common/ns16550.c
@@ -23,7 +23,7 @@ static int shift;
 
 unsigned long serial_init(int chan, void *ignored)
 {
-	unsigned long com_port;
+	unsigned long com_port, base_baud;
 	unsigned char lcr, dlm;
 
 	/* We need to find out which type io we're expecting.  If it's
@@ -43,6 +43,8 @@ unsigned long serial_init(int chan, void
 
 	/* How far apart the registers are. */
 	shift = rs_table[chan].iomem_reg_shift;
+	/* Base baud.. */
+	base_baud = rs_table[chan].baud_base;
 	
 	/* save the LCR */
 	lcr = inb(com_port + (UART_LCR << shift));
@@ -62,9 +64,9 @@ unsigned long serial_init(int chan, void
 	else {
 		/* Input clock. */
 		outb(com_port + (UART_DLL << shift),
-		     (BASE_BAUD / SERIAL_BAUD) & 0xFF);
+		     (base_baud / SERIAL_BAUD) & 0xFF);
 		outb(com_port + (UART_DLM << shift),
-		     (BASE_BAUD / SERIAL_BAUD) >> 8);
+		     (base_baud / SERIAL_BAUD) >> 8);
 		/* 8 data, 1 stop, no parity */
 		outb(com_port + (UART_LCR << shift), 0x03);
 		/* RTS/DTR */

-- 
Tom Rini
http://gate.crashing.org/~trini/
