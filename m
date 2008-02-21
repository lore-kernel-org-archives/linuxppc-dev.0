Return-Path: <olof@lixom.net>
Date: Wed, 20 Feb 2008 20:25:54 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [2.6.25] [POWERPC] pasemi: register i2c devices at boot
Message-ID: <20080221022554.GA2666@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org
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


---

This patch was posted previously, but not merged (by myself) then because
Jon Smirl was working on his automatic probing of i2c devices. There
were also some comments to the fact that it should be made common between
the fsl_soc and pasemi platforms.

This time I'm posting it for inclusion in 2.6.25, because Jon's work has
been delayed to .26, and this is really needed for basic functionality on
the pasemi platform (i.e. to get the RTC probed properly). I expect this
to be removed once Jon's work is in, but until then it is needed. I also
don't see any need for extra churn of common code to abstract out the
fsl_soc i2c_board_info building for the same reason: this is throw-away
temporary code.

Paul, please apply for 2.6.25.


Thanks,

Olof

Index: 2.6.25/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- 2.6.25.orig/arch/powerpc/platforms/pasemi/Makefile
+++ 2.6.25/arch/powerpc/platforms/pasemi/Makefile
@@ -1,3 +1,3 @@
-obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o dma_lib.o
+obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o dma_lib.o misc.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ) += cpufreq.o
Index: 2.6.25/arch/powerpc/platforms/pasemi/misc.c
===================================================================
--- /dev/null
+++ 2.6.25/arch/powerpc/platforms/pasemi/misc.c
@@ -0,0 +1,97 @@
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
