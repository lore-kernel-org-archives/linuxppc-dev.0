Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F179167A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jan 2005 03:47:52 +1100 (EST)
Date: Fri, 21 Jan 2005 10:47:39 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0501211044060.20917@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: ppc32: allow usage of gen550 on platforms that do not define
 SERIAL_PORT_DFNS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Allows a platform to initialize serial_state completely from gen550_init 
and no longer requires it to define SERIAL_PORT_DFNS.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/syslib/gen550_dbg.c b/arch/ppc/syslib/gen550_dbg.c
--- a/arch/ppc/syslib/gen550_dbg.c	2005-01-21 10:43:30 -06:00
+++ b/arch/ppc/syslib/gen550_dbg.c	2005-01-21 10:43:30 -06:00
@@ -29,6 +29,11 @@
 
 #define SERIAL_BAUD	9600
 
+/* SERIAL_PORT_DFNS is defined in <asm/serial.h> */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+
 static struct serial_state rs_table[RS_TABLE_SIZE] = {
 	SERIAL_PORT_DFNS	/* defined in <asm/serial.h> */
 };
@@ -154,6 +159,7 @@
 	rs_table[i].port = serial_req->iobase;
 	rs_table[i].iomem_base = serial_req->membase;
 	rs_table[i].iomem_reg_shift = serial_req->regshift;
+	rs_table[i].baud_base = serial_req->uartclk ? serial_req->uartclk / 16 : BASE_BAUD;
 }
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
