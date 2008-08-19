Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id AEE5ADE8A1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:41:36 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1678anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:41:36 -0700 (PDT)
Message-Id: <496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:25:15 -0400
Subject: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a common board file for almost all of the "simple" PowerPC 44x
boards that exist today.  This is intended to be a single place to add
support for boards that do not differ in platform support from most of the
evaluation boards that are used as reference platforms.  Boards that have
specific requirements or custom hardware setup should still have their own
board.c file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig         |    7 +++
 arch/powerpc/platforms/44x/Makefile        |    1 +
 arch/powerpc/platforms/44x/ppc44x_simple.c |   81 ++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/ppc44x_simple.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 249ba01..97c634c 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -127,6 +127,13 @@ config XILINX_VIRTEX440_GENERIC_BOARD
 	  Most Virtex 5 designs should use this unless it needs to do some
 	  special configuration at board probe time.
 
+config PPC44x_SIMPLE
+	bool "Simple PowerPC 44x board support"
+	depends on 44x
+	default n
+	help
+	  This option enables the simple PowerPC 44x platform support.
+
 # 44x specific CPU modules, selected based on the board above.
 config 440EP
 	bool
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 8d0b1a1..73c1df5 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_44x)	:= misc_44x.o idle.o
+obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_BAMBOO)	+= bamboo.o
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
new file mode 100644
index 0000000..067cddb
--- /dev/null
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -0,0 +1,81 @@
+/*
+ * Generic PowerPC 44x platform support
+ *
+ * Copyright 2008 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ *
+ * This implements simple platform support for PowerPC 44x chips.  This is
+ * mostly used for eval boards or other simple and "generic" 44x boards.  If
+ * your board has custom functions or hardware, then you will likely want to
+ * implement your own board.c file to accommodate it.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
+
+static __initdata struct of_device_id ppc44x_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init ppc44x_device_probe(void)
+{
+	of_platform_bus_probe(NULL, ppc44x_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(ppc44x_simple, ppc44x_device_probe);
+
+static char *board[] __initdata = {
+	"amcc,bamboo",
+	"amcc,cayonlands",
+	"ibm,ebony",
+	"amcc,katmai",
+	"amcc,rainier",
+	"amcc,sequoia",
+	"amcc,taishan",
+	NULL
+};
+
+static int __init ppc44x_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	int i = 0;
+
+	while (board[i]) {
+		if (of_flat_dt_is_compatible(root, board[i]))
+			break;
+		i++;
+	}
+
+	if (board[i] != NULL) {
+		ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(ppc44x_simple) {
+	.name = "PowerPC 44x Platform",
+	.probe = ppc44x_probe,
+	.progress = udbg_progress,
+	.init_IRQ = uic_init_tree,
+	.get_irq = uic_get_irq,
+	.restart = ppc4xx_reset_system,
+	.calibrate_decr = generic_calibrate_decr,
+};
-- 
1.5.5.1
