Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B470967DF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 09:02:50 +1000 (EST)
Date: Fri, 29 Jul 2005 16:02:46 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050729230246.GA19315@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix 44x early serial debug for configurations with
	more than 512M of RAM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix 44x early serial debugging for big RAM configurations (more than 
512M). We cannot use default OpenBIOS virtual mapping, because it 
interferes with pinned TLB entry. 

While we are at it, move early UART mapping to TLB slot 0, so it can 
survive longer during boot process (slot 1 is used by the first 
ioremap call, effectively killing UART mapping if it occupies this 
slot). Also, change UART TLB entry size to 4K (256M is too much for a 
bunch of registers :). Squash some warnings on the way.

Tested on Ebony and Ocotea with 1G of RAM.

Thanks to Scott Coulter <scott.coulter@cyclone.com> for diagnosing 
this problem.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -179,14 +179,14 @@ skpinv:	addi	r4,r4,1				/* Increment */
 4:
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/*
-	 * Add temporary UART mapping for early debug.  This
-	 * mapping must be identical to that used by the early
-	 * bootloader code since the same asm/serial.h parameters
-	 * are used for polled operation.
+	 * Add temporary UART mapping for early debug.
+	 * We can map UART registers wherever we want as long as they don't
+	 * interfere with other system mappings (e.g. with pinned entries).
+	 * For an example of how we handle this - see ocotea.h.       --ebs
 	 */
  	/* pageid fields */
 	lis	r3,UART0_IO_BASE@h
-	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_256M
+	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_4K
 
 	/* xlat fields */
 	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
@@ -196,7 +196,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	li	r5,0
 	ori	r5,r5,(PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_I | PPC44x_TLB_G)
 
-        li      r0,1                    /* TLB slot 1 */
+        li      r0,0                    /* TLB slot 0 */
 
 	tlbwe	r3,r0,PPC44x_TLB_PAGEID	/* Load the pageid fields */
 	tlbwe	r4,r0,PPC44x_TLB_XLAT	/* Load the translation fields */
diff --git a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c
+++ b/arch/ppc/platforms/4xx/ebony.c
@@ -7,7 +7,7 @@
  * Copyright 2002-2005 MontaVista Software Inc.
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- * Copyright (c) 2003, 2004 Zultys Technologies
+ * Copyright (c) 2003-2005 Zultys Technologies
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -50,6 +50,7 @@
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
 #include <asm/ppcboot.h>
+#include <asm/tlbflush.h>
 
 #include <syslib/gen550.h>
 #include <syslib/ibm440gp_common.h>
@@ -248,6 +249,9 @@ ebony_early_serial_map(void)
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
 	/* Configure debug serial access */
 	gen550_init(0, &port);
+
+	/* Purge TLB entry added in head_44x.S for early serial access */
+	_tlbie(UART0_IO_BASE);
 #endif
 
 	port.membase = ioremap64(PPC440GP_UART1_ADDR, 8);
diff --git a/arch/ppc/platforms/4xx/ebony.h b/arch/ppc/platforms/4xx/ebony.h
--- a/arch/ppc/platforms/4xx/ebony.h
+++ b/arch/ppc/platforms/4xx/ebony.h
@@ -56,9 +56,18 @@
  * Serial port defines
  */
 
-/* OpenBIOS defined UART mappings, used before early_serial_setup */
+#if defined(__BOOTER__)
+/* OpenBIOS defined UART mappings, used by bootloader shim */
 #define UART0_IO_BASE	0xE0000200
 #define UART1_IO_BASE	0xE0000300
+#else
+/* head_44x.S created UART mapping, used before early_serial_setup.
+ * We cannot use default OpenBIOS UART mappings because they
+ * don't work for configurations with more than 512M RAM.    --ebs
+ */
+#define UART0_IO_BASE	0xF0000200
+#define UART1_IO_BASE	0xF0000300
+#endif
 
 /* external Epson SG-615P */
 #define BASE_BAUD	691200
@@ -66,7 +75,7 @@
 #define STD_UART_OP(num)					\
 	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
 		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
-		iomem_base: UART##num##_IO_BASE,		\
+		iomem_base: (void*)UART##num##_IO_BASE,		\
 		io_type: SERIAL_IO_MEM},
 
 #define SERIAL_PORT_DFNS	\
diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c
+++ b/arch/ppc/platforms/4xx/ocotea.c
@@ -48,6 +48,7 @@
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
 #include <asm/ppcboot.h>
+#include <asm/tlbflush.h>
 
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
@@ -266,6 +267,9 @@ ocotea_early_serial_map(void)
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
 	/* Configure debug serial access */
 	gen550_init(0, &port);
+
+	/* Purge TLB entry added in head_44x.S for early serial access */
+	_tlbie(UART0_IO_BASE);
 #endif
 
 	port.membase = ioremap64(PPC440GX_UART1_ADDR, 8);
diff --git a/arch/ppc/platforms/4xx/ocotea.h b/arch/ppc/platforms/4xx/ocotea.h
--- a/arch/ppc/platforms/4xx/ocotea.h
+++ b/arch/ppc/platforms/4xx/ocotea.h
@@ -55,15 +55,24 @@
  */
 #define RS_TABLE_SIZE	2
 
-/* OpenBIOS defined UART mappings, used before early_serial_setup */
+#if defined(__BOOTER__)
+/* OpenBIOS defined UART mappings, used by bootloader shim */
 #define UART0_IO_BASE	0xE0000200
 #define UART1_IO_BASE	0xE0000300
+#else
+/* head_44x.S created UART mapping, used before early_serial_setup.
+ * We cannot use default OpenBIOS UART mappings because they
+ * don't work for configurations with more than 512M RAM.    --ebs
+ */
+#define UART0_IO_BASE	0xF0000200
+#define UART1_IO_BASE	0xF0000300
+#endif
 
 #define BASE_BAUD	11059200/16
 #define STD_UART_OP(num)					\
 	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
 		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
-		iomem_base: UART##num##_IO_BASE,		\
+		iomem_base: (void*)UART##num##_IO_BASE,		\
 		io_type: SERIAL_IO_MEM},
 
 #define SERIAL_PORT_DFNS	\
