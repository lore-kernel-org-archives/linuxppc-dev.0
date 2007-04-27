Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id AE7FCDE129
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 05:50:37 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org,
	paulus@samba.org
Subject: [PATCH 5/7] [PPC] Add uartlite boot console driver for the zImage
	wrapper
Date: Fri, 27 Apr 2007 13:50:03 -0600
Message-Id: <11777034153009-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11777034152490-git-send-email-grant.likely@secretlab.ca>
References: <11777034052773-git-send-email-grant.likely@secretlab.ca>
	<1177703413970-git-send-email-grant.likely@secretlab.ca>
	<1177703413868-git-send-email-grant.likely@secretlab.ca>
	<11777034143069-git-send-email-grant.likely@secretlab.ca>
	<11777034141879-git-send-email-grant.likely@secretlab.ca>
	<11777034152490-git-send-email-grant.likely@secretlab.ca>
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/ppc/boot/common/misc-common.c  |   15 +++++++++----
 arch/ppc/boot/simple/Makefile       |    1 +
 arch/ppc/boot/simple/uartlite_tty.c |   37 +++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 5 deletions(-)
 create mode 100644 arch/ppc/boot/simple/uartlite_tty.c

diff --git a/arch/ppc/boot/common/misc-common.c b/arch/ppc/boot/common/misc-common.c
index 8e1fccd..9589969 100644
--- a/arch/ppc/boot/common/misc-common.c
+++ b/arch/ppc/boot/common/misc-common.c
@@ -57,7 +57,8 @@ unsigned char *ISA_io = NULL;
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 extern unsigned long com_port;
 
 extern int serial_tstc(unsigned long com_port);
@@ -80,7 +81,8 @@ int tstc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	if(keyb_present)
 		return (CRT_tstc() || serial_tstc(com_port));
 	else
@@ -95,7 +97,8 @@ int getc(void)
 	while (1) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 		if (serial_tstc(com_port))
 			return (serial_getc(com_port));
 #endif /* serial console */
@@ -112,7 +115,8 @@ putc(const char c)
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	serial_putc(com_port, c);
 	if ( c == '\n' )
 		serial_putc(com_port, '\r');
@@ -161,7 +165,8 @@ void puts(const char *s)
 	while ( ( c = *s++ ) != '\0' ) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	        serial_putc(com_port, c);
 	        if ( c == '\n' ) serial_putc(com_port, '\r');
 #endif /* serial console */
diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index bcfb6cd..5b87779 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -201,6 +201,7 @@ boot-$(CONFIG_8260)		+= m8260_tty.o
 endif
 boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
 boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
+boot-$(CONFIG_SERIAL_UARTLITE_CONSOLE)	+= uartlite_tty.o
 
 LIBS				:= $(common)/lib.a $(bootlib)/lib.a
 ifeq ($(CONFIG_PPC_PREP),y)
diff --git a/arch/ppc/boot/simple/uartlite_tty.c b/arch/ppc/boot/simple/uartlite_tty.c
new file mode 100644
index 0000000..0eae1ea
--- /dev/null
+++ b/arch/ppc/boot/simple/uartlite_tty.c
@@ -0,0 +1,37 @@
+/*
+ * Xilinx UARTLITE bootloader driver
+ *
+ * Copyright (c) 2007 Secret Lab Technologies Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <asm/serial.h>
+#include <asm/io.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+#define UARTLITE_BASEADDR ((void*)(XPAR_UARTLITE_0_BASEADDR))
+
+void
+serial_putc(unsigned long com_port, unsigned char c)
+{
+	while ((in_be32(UARTLITE_BASEADDR + 0x8) & 0x08) != 0); /* spin */
+	out_be32(UARTLITE_BASEADDR + 0x4, c);
+}
+
+unsigned char
+serial_getc(unsigned long com_port)
+{
+	while ((in_be32(UARTLITE_BASEADDR + 0x8) & 0x01) == 0); /* spin */
+	return in_be32(UARTLITE_BASEADDR);
+}
+
+int
+serial_tstc(unsigned long com_port)
+{
+	return ((in_be32(UARTLITE_BASEADDR + 0x8) & 0x01) != 0);
+}
-- 
1.5.1
