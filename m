Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 67AAEDDE2E
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 11:46:41 +1000 (EST)
Date: Sun, 14 Oct 2007 20:52:32 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] pasemi: process i2c device tree entries at boot
Message-ID: <20071015015232.GA4641@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Setup i2c_board_info based on device tree contents. This has to be
a device_initcall since we need PCI to be probed by the time we
run it, but before the actual driver is initialized.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: k.org/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- k.org.orig/arch/powerpc/platforms/pasemi/Makefile
+++ k.org/arch/powerpc/platforms/pasemi/Makefile
@@ -1,4 +1,4 @@
-obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o
+obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o misc.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
 obj-$(CONFIG_ELECTRA_IDE) += electra_ide.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ) += cpufreq.o
Index: k.org/arch/powerpc/platforms/pasemi/misc.c
===================================================================
--- /dev/null
+++ k.org/arch/powerpc/platforms/pasemi/misc.c
@@ -0,0 +1,94 @@
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
+
+#ifdef CONFIG_I2C_BOARDINFO
+/* The below is from fsl_soc.c.  It's copied because since there are no
+ * official bus bindings at this time it doesn't make sense to share across
+ * the platforms, even though they happen to be common.
+ */
+struct i2c_driver_device {
+	char    *of_device;
+	char    *i2c_driver;
+	char    *i2c_type;
+};
+
+static struct i2c_driver_device i2c_devices[] __initdata = {
+	{"dallas,ds1338",  "rtc-ds1307",  "ds1338"},
+};
+
+static int __init find_i2c_driver(struct device_node *node,
+				     struct i2c_board_info *info)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
+		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
+			continue;
+		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
+			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
+		    strlcpy(info->type, i2c_devices[i].i2c_type,
+			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+			return -ENOMEM;
+		return 0;
+	}
+	return -ENODEV;
+}
+
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
+			if (find_i2c_driver(node, &info) < 0)
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
