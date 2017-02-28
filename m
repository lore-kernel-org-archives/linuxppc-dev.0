Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXW9c1G5gzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:56:20 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y23so613713pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 23:56:20 -0800 (PST)
Received: from matt.gateway ([2001:8003:181f:fa00:97a:a923:bc9c:c5e4])
 by smtp.gmail.com with ESMTPSA id m74sm2202802pfk.41.2017.02.27.23.56.16
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Feb 2017 23:56:17 -0800 (PST)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Patch v4] powerpc/powernv: add hdat attribute to sysfs
Date: Tue, 28 Feb 2017 18:55:03 +1100
Message-Id: <20170228075503.20387-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The HDAT data area is consumed by skiboot and turned into a device-tree.
In some cases we would like to look directly at the HDAT, so this patch
adds a sysfs node to allow it to be viewed.  This is not possible through
/dev/mem as it is reserved memory which is stopped by the /dev/mem filter.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
Changes between v3 and v4:
	- changed sysfs attribute permissions from 0444 to 0400
	- fixed makefile to be on same line
	- fixed authorship/copyright info
	- re-ordered includes
	- changed hdat_info struct to a static struct

---
 arch/powerpc/include/asm/opal.h            |  1 +
 arch/powerpc/platforms/powernv/Makefile    |  2 +-
 arch/powerpc/platforms/powernv/opal-hdat.c | 60 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c      |  2 +
 4 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-hdat.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5c7db0f..b26944e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -277,6 +277,7 @@ extern int opal_async_comp_init(void);
 extern int opal_sensor_init(void);
 extern int opal_hmi_handler_init(void);
 extern int opal_event_init(void);
+extern void opal_hdat_sysfs_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..3826b70 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o
+obj-y			+= opal-kmsg.o opal-hdat.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c b/arch/powerpc/platforms/powernv/opal-hdat.c
new file mode 100644
index 0000000..19647fd
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-hdat.c
@@ -0,0 +1,60 @@
+/*
+ * PowerNV OPAL HDAT interface
+ *
+ * Copyright 2017, Matt Brown, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/of.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/opal.h>
+
+static struct {
+	char *base;
+	u64 size;
+} hdat_info;
+
+/* Read function for HDAT attribute in sysfs */
+static ssize_t hdat_read(struct file *file, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *to,
+			 loff_t pos, size_t count)
+{
+	if (!hdat_info.base)
+		return -ENODEV;
+
+	return memory_read_from_buffer(to, count, &pos, hdat_info.base,
+					hdat_info.size);
+}
+
+/* HDAT attribute for sysfs */
+static struct bin_attribute hdat_attr = {
+	.attr = {.name = "hdat", .mode = 0400},
+	.read = hdat_read
+};
+
+void __init opal_hdat_sysfs_init(void)
+{
+	u64 hdat_addr[2];
+
+	/* Check for the hdat-map prop in device-tree */
+	if (of_property_read_u64_array(opal_node, "hdat-map", hdat_addr, 2)) {
+		pr_debug("OPAL: Property hdat-map not found.\n");
+		return;
+	}
+
+	/* Print out hdat-map values. [0]: base, [1]: size */
+	pr_debug("OPAL: HDAT Base address: %#llx\n", hdat_addr[0]);
+	pr_debug("OPAL: HDAT Size: %#llx\n", hdat_addr[1]);
+
+	hdat_info.base = phys_to_virt(hdat_addr[0]);
+	hdat_info.size = hdat_addr[1];
+
+	if (sysfs_create_bin_file(opal_kobj, &hdat_attr))
+		pr_debug("OPAL: sysfs file creation for HDAT failed");
+
+}
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2822935..cae3745 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -740,6 +740,8 @@ static int __init opal_init(void)
 		opal_sys_param_init();
 		/* Setup message log sysfs interface. */
 		opal_msglog_sysfs_init();
+		/* Create hdat object under sys/firmware/opal */
+		opal_hdat_sysfs_init();
 	}
 
 	/* Initialize platform devices: IPMI backend, PRD & flash interface */
-- 
2.9.3
