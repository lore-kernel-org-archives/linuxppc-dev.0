Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 50B232BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 10:06:32 +1000 (EST)
Date: Fri, 8 Oct 2004 17:06:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041008170629.C15724@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Use gen550 for PPC44x progress/ppc-stub
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Use gen550 for early PPC progress messages and for the in-kernel
ppc-stub.c on PPC44x.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/platforms/4xx/Kconfig 1.10 vs edited =====
--- 1.10/arch/ppc/platforms/4xx/Kconfig	2004-08-07 11:05:39 -07:00
+++ edited/arch/ppc/platforms/4xx/Kconfig	2004-10-07 10:23:23 -07:00
@@ -184,6 +184,11 @@
 	depends on !STB03xxx && PPC4xx_DMA
 	default y
 
+config PPC_GEN550
+	bool
+	depends on 44x
+	default y
+
 config PM
 	bool "Power Management support (EXPERIMENTAL)"
 	depends on 4xx && EXPERIMENTAL
===== arch/ppc/platforms/4xx/ebony.c 1.5 vs edited =====
--- 1.5/arch/ppc/platforms/4xx/ebony.c	2004-10-07 10:39:15 -07:00
+++ edited/arch/ppc/platforms/4xx/ebony.c	2004-10-07 18:48:59 -07:00
@@ -1,10 +1,10 @@
 /*
- * arch/ppc/platforms/ebony.c
+ * arch/ppc/platforms/4xx/ebony.c
  *
  * Ebony board specific routines
  *
- * Matt Porter <mporter@mvista.com>
- * Copyright 2002 MontaVista Software Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2002-2004 MontaVista Software Inc.
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  * Copyright (c) 2003, 2004 Zultys Technologies
@@ -50,6 +50,10 @@
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
 
+#include <syslib/gen550.h>
+
+static struct ibm44x_clocks clocks __initdata;
+
 /*
  * Ebony IRQ triggering/polarity settings
  */
@@ -120,8 +124,6 @@
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 63: EMAC 1 WOL */
 };
 
-static struct ibm44x_clocks clocks __initdata;
-
 static void __init
 ebony_calibrate_decr(void)
 {
@@ -284,13 +286,24 @@
 		printk("Early serial init of port 0 failed\n");
 	}
 
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(0, &port);
+#endif
+
 	port.membase = ioremap64(PPC440GP_UART1_ADDR, 8);
 	port.irq = 1;
+	port.uartclk = clocks.uart1;
 	port.line = 1;
 
 	if (early_serial_setup(&port) != 0) {
 		printk("Early serial init of port 1 failed\n");
 	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(1, &port);
+#endif
 }
 
 static void __init
@@ -378,7 +391,6 @@
 
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
-
 #ifdef CONFIG_KGDB
 	ppc_md.early_serial_map = ebony_early_serial_map;
 #endif
===== arch/ppc/platforms/4xx/ocotea.c 1.6 vs edited =====
--- 1.6/arch/ppc/platforms/4xx/ocotea.c	2004-10-07 10:39:15 -07:00
+++ edited/arch/ppc/platforms/4xx/ocotea.c	2004-10-07 18:49:18 -07:00
@@ -1,11 +1,11 @@
 /*
- * arch/ppc/platforms/ocotea.c
+ * arch/ppc/platforms/4xx/ocotea.c
  *
  * Ocotea board specific routines
  *
- * Matt Porter <mporter@mvista.com>
+ * Matt Porter <mporter@kernel.crashing.org>
  *
- * Copyright 2003 MontaVista Software Inc.
+ * Copyright 2003-2004 MontaVista Software Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -49,6 +49,7 @@
 #include <asm/ppc4xx_pic.h>
 #include <asm/ppcboot.h>
 
+#include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
 
 /*
@@ -263,6 +264,11 @@
 		printk("Early serial init of port 0 failed\n");
 	}
 
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(0, &port);
+#endif
+
 	port.membase = ioremap64(PPC440GX_UART1_ADDR, 8);
 	port.irq = UART1_INT;
 	port.uartclk = clocks.uart1;
@@ -271,6 +277,11 @@
 	if (early_serial_setup(&port) != 0) {
 		printk("Early serial init of port 1 failed\n");
 	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(1, &port);
+#endif
 }
 
 static void __init
@@ -355,7 +366,6 @@
 
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
-
 #ifdef CONFIG_KGDB
 	ppc_md.early_serial_map = ocotea_early_serial_map;
 #endif
===== arch/ppc/syslib/gen550_kgdb.c 1.3 vs edited =====
--- 1.3/arch/ppc/syslib/gen550_kgdb.c	2004-02-03 22:28:09 -07:00
+++ edited/arch/ppc/syslib/gen550_kgdb.c	2004-10-07 11:04:33 -07:00
@@ -9,9 +9,9 @@
  *
  * Adapted from ppc4xx_kgdb.c.
  *
- * Author: Matt Porter <mporter@mvista.com>
+ * Author: Matt Porter <mporter@kernel.crashing.org>
  *
- * 2002-2003 (c) MontaVista Software, Inc.  This file is licensed under
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under
  * the terms of the GNU General Public License version 2.  This program
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
@@ -80,5 +80,7 @@
 gen550_kgdb_map_scc(void)
 {
 	printk(KERN_DEBUG "kgdb init\n");
+	if (ppc_md.early_serial_map)
+		ppc_md.early_serial_map();
 	kgdb_debugport = serial_init(KGDB_PORT, NULL);
 }
===== arch/ppc/syslib/ibm44x_common.c 1.2 vs edited =====
--- 1.2/arch/ppc/syslib/ibm44x_common.c	2004-10-07 10:39:15 -07:00
+++ edited/arch/ppc/syslib/ibm44x_common.c	2004-10-07 11:21:55 -07:00
@@ -3,8 +3,8 @@
  *
  * PPC44x system library
  *
- * Matt Porter <mporter@mvista.com>
- * Copyright 2002-2003 MontaVista Software Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2002-2004 MontaVista Software Inc.
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  * Copyright (c) 2003, 2004 Zultys Technologies
@@ -16,16 +16,18 @@
  *
  */
 #include <linux/config.h>
+#include <linux/time.h>
 #include <linux/types.h>
 #include <linux/serial.h>
 
-#include <asm/param.h>
 #include <asm/ibm44x.h>
 #include <asm/mmu.h>
 #include <asm/machdep.h>
 #include <asm/time.h>
 #include <asm/ppc4xx_pic.h>
 
+#include <syslib/gen550.h>
+
 phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
 {
 	phys_addr_t page_4gb = 0;
@@ -149,44 +151,6 @@
 		irq_desc[i].handler = ppc4xx_pic;
 }
 
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-static void ibm44x_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = (unsigned long)rs_table[0].iomem_base;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-			;
-		*(volatile unsigned char *)com_port = c;
-
-	}
-
-	/* Send LF/CR to pretty up output */
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		;
-	*(volatile unsigned char *)com_port = '\r';
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		;
-	*(volatile unsigned char *)com_port = '\n';
-}
-#endif /* CONFIG_SERIAL_TEXT_DEBUG */
-
 void __init ibm44x_platform_init(void)
 {
 	ppc_md.init_IRQ = ibm44x_init_irq;
@@ -196,7 +160,10 @@
 	ppc_md.halt = ibm44x_halt;
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = ibm44x_progress;
+	ppc_md.progress = gen550_progress;
 #endif /* CONFIG_SERIAL_TEXT_DEBUG */
+#ifdef CONFIG_KGDB
+	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
+#endif
 }
 
===== include/asm-ppc/machdep.h 1.23 vs edited =====
--- 1.23/include/asm-ppc/machdep.h	2004-06-27 17:27:18 -07:00
+++ edited/include/asm-ppc/machdep.h	2004-10-07 11:00:26 -07:00
@@ -56,6 +56,7 @@
 	unsigned long	(*find_end_of_memory)(void);
 	void		(*setup_io_mappings)(void);
 
+	void		(*early_serial_map)(void);
   	void		(*progress)(char *, unsigned short);
 	void		(*kgdb_map_scc)(void);
 
