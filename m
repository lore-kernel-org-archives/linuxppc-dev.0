Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24C2CDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 01:17:29 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l6UFGSwP005122
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 19:16:28 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l6UFGSJg005119
	for linuxppc-dev@ozlabs.org; Mon, 30 Jul 2007 19:16:28 +0400
Date: Mon, 30 Jul 2007 19:16:28 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Message-ID: <20070730151628.GA5100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

AMCC 440EPx Sequoia board support.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/cputable.c       |   36 +++++++++++++++++++
 arch/powerpc/kernel/head_44x.S       |    2 -
 arch/powerpc/platforms/44x/Kconfig   |   17 ++++++++-
 arch/powerpc/platforms/44x/Makefile  |    1 
 arch/powerpc/platforms/44x/sequoia.c |   66 +++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 2 deletions(-)

diff -ruN linux.orig/arch/powerpc/kernel/cputable.c linux/arch/powerpc/kernel/cputable.c
--- linux.orig/arch/powerpc/kernel/cputable.c	2007-07-27 20:37:10.000000000 +0400
+++ linux/arch/powerpc/kernel/cputable.c	2007-07-27 20:44:26.000000000 +0400
@@ -1132,6 +1132,42 @@
 		.dcache_bsize		= 32,
 		.platform		= "ppc440",
 	},
+	{ /* 440EPX  - with Security/Kasumi  */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008D0,
+		.cpu_name		= "440EPX - with Security/Kasumi",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
+	{ /* 440EPX  - without Security/Kasumi  */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008D4,
+		.cpu_name		= "440EPX - no Security/Kasumi",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
+	{ /* 440GRX  - with Security/Kasumi  */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008D8,
+		.cpu_name		= "440GRX - with Security/Kasumi",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
+	{ /* 440GRX  - without Security/Kasumi  */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008DC,
+		.cpu_name		= "440GRX - no Security/Kasumi",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 	{	/* 440GP Rev. B */
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x40000440,
diff -ruN linux.orig/arch/powerpc/kernel/head_44x.S linux/arch/powerpc/kernel/head_44x.S
--- linux.orig/arch/powerpc/kernel/head_44x.S	2007-07-27 20:37:10.000000000 +0400
+++ linux/arch/powerpc/kernel/head_44x.S	2007-07-27 20:44:26.000000000 +0400
@@ -217,7 +217,7 @@
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
 	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
 	mfspr	r2,SPRN_CCR0
 	lis	r3,0xffef
diff -ruN linux.orig/arch/powerpc/platforms/44x/Kconfig linux/arch/powerpc/platforms/44x/Kconfig
--- linux.orig/arch/powerpc/platforms/44x/Kconfig	2007-07-27 20:37:11.000000000 +0400
+++ linux/arch/powerpc/platforms/44x/Kconfig	2007-07-27 21:10:32.000000000 +0400
@@ -14,6 +14,14 @@
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.
 
+config SEQUOIA
+	bool "Sequoia"
+	depends on 44x
+	default n
+	select 440EPX
+	help
+	  This option enables support for the AMCC PPC440EPX evaluation board.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
@@ -36,6 +44,13 @@
 	select PPC_FPU
 	select IBM440EP_ERR42
 
+config 440EPX
+	bool
+	select PPC_FPU
+# Disabled until the new EMAC Driver is merged.
+#	select IBM_NEW_EMAC_EMAC4
+#	select IBM_NEW_EMAC_ZMII
+
 config 440GP
 	bool
 # Disabled until the new EMAC Driver is merged.
@@ -49,7 +64,7 @@
 
 config 440A
 	bool
-	depends on 440GX
+	depends on 440GX || 440EPX
 	default y
 
 # 44x errata/workaround config symbols, selected by the CPU models above
diff -ruN linux.orig/arch/powerpc/platforms/44x/Makefile linux/arch/powerpc/platforms/44x/Makefile
--- linux.orig/arch/powerpc/platforms/44x/Makefile	2007-07-27 20:37:11.000000000 +0400
+++ linux/arch/powerpc/platforms/44x/Makefile	2007-07-27 20:44:26.000000000 +0400
@@ -1,2 +1,3 @@
 obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
+obj-$(CONFIG_SEQUOIA)	+= sequoia.o
diff -ruN linux.orig/arch/powerpc/platforms/44x/sequoia.c linux/arch/powerpc/platforms/44x/sequoia.c
--- linux.orig/arch/powerpc/platforms/44x/sequoia.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/arch/powerpc/platforms/44x/sequoia.c	2007-07-27 20:44:26.000000000 +0400
@@ -0,0 +1,66 @@
+/*
+ * Sequoia board specific routines
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004-2007 MontaVista Software Inc.
+ *
+ * Rewritten and ported to the merged powerpc tree:
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright 2007 IBM Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/of_platform.h>
+#include "44x.h"
+
+static struct of_device_id sequoia_of_bus[] = {
+	{ .compatible = "ibm,plb", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init sequoia_device_probe(void)
+{
+	if (!machine_is(sequoia))
+		return 0;
+
+	of_platform_bus_probe(NULL, sequoia_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(sequoia_device_probe);
+
+static int __init sequoia_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,sequoia"))
+		return 0;
+
+	return 1;
+}
+
+static void __init sequoia_setup_arch(void)
+{
+}
+
+define_machine(sequoia) {
+	.name 				= "Sequoia",
+	.probe 				= sequoia_probe,
+	.setup_arch			= sequoia_setup_arch,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc44x_reset_system,
+	.calibrate_decr			= generic_calibrate_decr,
+};
