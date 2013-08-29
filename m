Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 27D432C056F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 16:57:38 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7T6vXCq011235
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 01:57:34 -0500
Message-ID: <1377759453.4028.27.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Add scom support under OPALv3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 29 Aug 2013 16:57:33 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL v3 provides interfaces to access the chips XSCOM, expose
this via the existing scom infrastructure.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/Kconfig      |   1 +
 arch/powerpc/platforms/powernv/Makefile     |   1 +
 arch/powerpc/platforms/powernv/opal-xscom.c | 105 ++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/opal-xscom.c

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6fae5eb..7f39da0 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -9,6 +9,7 @@ config PPC_POWERNV
 	select EPAPR_BOOT
 	select PPC_INDIRECT_PIO
 	select PPC_UDBG_16550
+	select PPC_SCOM
 	default y
 
 config POWERNV_MSI
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 300c437..02dc1f5 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -4,3 +4,4 @@ obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
+obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
new file mode 100644
index 0000000..3ed5c64
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -0,0 +1,105 @@
+/*
+ * PowerNV LPC bus handling.
+ *
+ * Copyright 2013 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/bug.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+
+#include <asm/machdep.h>
+#include <asm/firmware.h>
+#include <asm/opal.h>
+#include <asm/scom.h>
+
+/*
+ * We could probably fit that inside the scom_map_t
+ * which is a void* after all but it's really too ugly
+ * so let's kmalloc it for now
+ */
+struct opal_scom_map {
+	uint32_t chip;
+	uint32_t addr;
+};
+
+static scom_map_t opal_scom_map(struct device_node *dev, u64 reg, u64 count)
+{
+	struct opal_scom_map *m;
+	const __be32 *gcid;
+
+	if (!of_get_property(dev, "scom-controller", NULL)) {
+		pr_err("%s: device %s is not a SCOM controller\n",
+			__func__, dev->full_name);
+		return SCOM_MAP_INVALID;
+	}
+	gcid = of_get_property(dev, "ibm,chip-id", NULL);
+	if (!gcid) {
+		pr_err("%s: device %s has no ibm,chip-id\n",
+			__func__, dev->full_name);
+		return SCOM_MAP_INVALID;
+	}
+	m = kmalloc(sizeof(struct opal_scom_map), GFP_KERNEL);
+	if (!m)
+		return NULL;
+	m->chip = be32_to_cpup(gcid);
+	m->addr = reg;
+
+	return (scom_map_t)m;
+}
+
+static void opal_scom_unmap(scom_map_t map)
+{
+	kfree(map);
+}
+
+static int opal_xscom_err_xlate(int64_t rc)
+{
+	switch(rc) {
+	case 0:
+		return 0;
+	/* Add more translations if necessary */
+	default:
+		return -EIO;
+	}
+}
+
+static int opal_scom_read(scom_map_t map, u32 reg, u64 *value)
+{
+	struct opal_scom_map *m = map;
+	int64_t rc;
+
+	rc = opal_xscom_read(m->chip, m->addr + reg, (uint64_t *)__pa(value));
+	return opal_xscom_err_xlate(rc);
+}
+
+static int opal_scom_write(scom_map_t map, u32 reg, u64 value)
+{
+	struct opal_scom_map *m = map;
+	int64_t rc;
+
+	rc = opal_xscom_write(m->chip, m->addr + reg, value);
+	return opal_xscom_err_xlate(rc);
+}
+
+static const struct scom_controller opal_scom_controller = {
+	.map	= opal_scom_map,
+	.unmap	= opal_scom_unmap,
+	.read	= opal_scom_read,
+	.write	= opal_scom_write
+};
+
+static int opal_xscom_init(void)
+{
+	if (firmware_has_feature(FW_FEATURE_OPALv3))
+		scom_init(&opal_scom_controller);
+	return 0;
+}
+arch_initcall(opal_xscom_init);
