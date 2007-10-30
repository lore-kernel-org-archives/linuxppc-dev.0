Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E0C9DE3AD
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 03:58:56 +1100 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l9UGvd7t022142
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 19:57:39 +0300
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l9UGvdMN022139
	for linuxppc-dev@ozlabs.org; Tue, 30 Oct 2007 19:57:39 +0300
Date: Tue, 30 Oct 2007 19:57:39 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] PowerPC: 440GRx Rainier board support.
Message-ID: <20071030165739.GA22126@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071030164511.GA21973@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 440GRx Rainier board support.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/platforms/44x/Kconfig   |   16 ++++++++-
 arch/powerpc/platforms/44x/Makefile  |    3 +
 arch/powerpc/platforms/44x/rainier.c |   61 +++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 2 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig linux-2.6/arch/powerpc/platforms/44x/Kconfig
--- linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig	2007-10-30 17:44:42.000000000 +0300
+++ linux-2.6/arch/powerpc/platforms/44x/Kconfig	2007-10-30 18:04:28.000000000 +0300
@@ -22,6 +22,14 @@ config SEQUOIA
 	help
 	  This option enables support for the AMCC PPC440EPX evaluation board.
 
+config RAINIER
+	bool "Rainier"
+	depends on 44x
+	default n
+	select 440GRX
+	help
+	  This option enables support for the AMCC PPC440GRX evaluation board.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
@@ -52,6 +60,12 @@ config 440EPX
 	select IBM_NEW_EMAC_RGMII
 	select IBM_NEW_EMAC_ZMII
 
+config 440GRX
+	bool
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
+
 config 440GP
 	bool
 	select IBM_NEW_EMAC_ZMII
@@ -64,7 +78,7 @@ config 440SP
 
 config 440A
 	bool
-	depends on 440GX || 440EPX
+	depends on 440GX || 440EPX || 440GRX
 	default y
 
 # 44x errata/workaround config symbols, selected by the CPU models above
diff -pruN linux-2.6.orig/arch/powerpc/platforms/44x/Makefile linux-2.6/arch/powerpc/platforms/44x/Makefile
--- linux-2.6.orig/arch/powerpc/platforms/44x/Makefile	2007-10-30 17:44:42.000000000 +0300
+++ linux-2.6/arch/powerpc/platforms/44x/Makefile	2007-10-30 18:00:15.000000000 +0300
@@ -1,4 +1,5 @@
 obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
-obj-$(CONFIG_BAMBOO) += bamboo.o
+obj-$(CONFIG_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
+obj-$(CONFIG_RAINIER)	+= rainier.o
diff -pruN linux-2.6.orig/arch/powerpc/platforms/44x/rainier.c linux-2.6/arch/powerpc/platforms/44x/rainier.c
--- linux-2.6.orig/arch/powerpc/platforms/44x/rainier.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/arch/powerpc/platforms/44x/rainier.c	2007-10-30 18:00:15.000000000 +0300
@@ -0,0 +1,61 @@
+/*
+ * Rainier board specific routines
+ *
+ * Valentine Barshak <vbarshak@ru.mvista.com>
+ * Copyright 2007 MontaVista Software Inc.
+ *
+ * Based on the Bamboo code by
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
+static struct of_device_id rainier_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init rainier_device_probe(void)
+{
+	if (!machine_is(rainier))
+		return 0;
+
+	of_platform_bus_probe(NULL, rainier_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(rainier_device_probe);
+
+static int __init rainier_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,rainier"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(rainier) {
+	.name 				= "Rainier",
+	.probe 				= rainier_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc44x_reset_system,
+	.calibrate_decr			= generic_calibrate_decr,
+};
