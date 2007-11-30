Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9348EDDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 14:26:03 +1100 (EST)
Date: Thu, 29 Nov 2007 21:29:23 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] [POWERPC] pasemi: Register i2c_board_info
Message-ID: <20071130032923.GB25580@lixom.net>
References: <20071130032645.GA25580@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071130032645.GA25580@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Register i2c_board_info

Setup i2c_board_info based on device tree contents. This has to be
a device_initcall since we need PCI to be probed by the time we
run it, but before the actual driver is initialized.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6.24/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- 2.6.24.orig/arch/powerpc/platforms/pasemi/Makefile
+++ 2.6.24/arch/powerpc/platforms/pasemi/Makefile
@@ -1,4 +1,4 @@
-obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o
+obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o misc.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
 obj-$(CONFIG_ELECTRA_IDE) += electra_ide.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ) += cpufreq.o
Index: 2.6.24/arch/powerpc/platforms/pasemi/misc.c
===================================================================
--- /dev/null
+++ 2.6.24/arch/powerpc/platforms/pasemi/misc.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2007 PA Semi, Inc
+ *
+ * Parts based on arch/powerpc/sysdev/fsl_soc.c:
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <asm/i2c_of.h>
+
+#ifdef CONFIG_I2C_BOARDINFO
+static int __init pasemi_register_i2c_devices(void)
+{
+	struct pci_dev *pdev;
+	struct device_node *adap_node;
+	struct device_node *node;
+
+	pdev = NULL;
+	while ((pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa003, pdev))) {
+		adap_node = pci_device_to_OF_node(pdev);
+
+		if (!adap_node)
+			continue;
+
+		node = NULL;
+		while ((node = of_get_next_child(adap_node, node))) {
+			struct i2c_board_info info = {};
+			const u32 *addr;
+			int len;
+
+			addr = of_get_property(node, "reg", &len);
+			if (!addr || len < sizeof(int) ||
+			    *addr > (1 << 10) - 1) {
+				printk(KERN_WARNING
+					"pasemi_register_i2c_devices: "
+					"invalid i2c device entry\n");
+				continue;
+			}
+
+			info.irq = irq_of_parse_and_map(node, 0);
+			if (info.irq == NO_IRQ)
+				info.irq = -1;
+
+			if (of_fill_i2c_info(node, &info) < 0)
+				continue;
+
+			info.addr = *addr;
+
+			i2c_register_board_info(PCI_FUNC(pdev->devfn), &info,
+						1);
+		}
+	}
+	return 0;
+}
+device_initcall(pasemi_register_i2c_devices);
+#endif
