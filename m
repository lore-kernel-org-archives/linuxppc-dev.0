Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 7AC3167A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 03:12:21 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
Date: Mon, 28 Feb 2005 17:12:12 +0100
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200502281712.12798.g.jaeger@sysgo.com>
Subject: [PATCH][PPC32] Compilation fixes for Ebony, Luan and Ocotea
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

this patch fixes the problem, that the current kernel (linux-2.6.11-rc5) 
could not be compiled, when "support for early boot texts over serial port"
(CONFIG_SERIAL_TEXT_DEBUG=y) is active.

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

--- linux-2.6.11-rc5/arch/ppc/platforms/4xx/ebony.h.orig	2005-02-28 16:55:15.000000000 +0100
+++ linux-2.6.11-rc5/arch/ppc/platforms/4xx/ebony.h	2005-02-28 16:55:56.000000000 +0100
@@ -61,8 +61,8 @@
  */
 
 /* OpenBIOS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xE0000200
-#define UART1_IO_BASE	(u8 *) 0xE0000300
+#define UART0_IO_BASE	0xE0000200
+#define UART1_IO_BASE	0xE0000300
 
 /* external Epson SG-615P */
 #define BASE_BAUD	691200
--- linux-2.6.11-rc5/arch/ppc/platforms/4xx/luan.h.orig	2005-02-28 16:55:07.000000000 +0100
+++ linux-2.6.11-rc5/arch/ppc/platforms/4xx/luan.h	2005-02-28 16:55:43.000000000 +0100
@@ -47,9 +47,9 @@
 #define RS_TABLE_SIZE	3
 
 /* PIBS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xa0000200
-#define UART1_IO_BASE	(u8 *) 0xa0000300
-#define UART2_IO_BASE	(u8 *) 0xa0000600
+#define UART0_IO_BASE	0xa0000200
+#define UART1_IO_BASE	0xa0000300
+#define UART2_IO_BASE	0xa0000600
 
 #define BASE_BAUD	11059200
 #define STD_UART_OP(num)					\
--- linux-2.6.11-rc5/arch/ppc/platforms/4xx/ocotea.h.orig	2005-02-28 16:55:29.000000000 +0100
+++ linux-2.6.11-rc5/arch/ppc/platforms/4xx/ocotea.h	2005-02-28 16:56:14.000000000 +0100
@@ -56,8 +56,8 @@
 #define RS_TABLE_SIZE	2
 
 /* OpenBIOS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xE0000200
-#define UART1_IO_BASE	(u8 *) 0xE0000300
+#define UART0_IO_BASE	0xE0000200
+#define UART1_IO_BASE	0xE0000300
 
 #define BASE_BAUD	11059200/16
 #define STD_UART_OP(num)					\
