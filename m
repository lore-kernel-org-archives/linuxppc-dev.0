Return-Path: <srs0=ey7g=22=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkrYl1zppzDqbX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:35 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vkrYl1FNfz8xX3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:35 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vkrYk4SQKz9s2Q
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 14:34:34 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H3TXZj077609
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:29 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297xku5svd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:29 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 23:34:28 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v3 03/10] VAS: Define vas_init() and vas_exit()
Date: Thu, 16 Mar 2017 20:33:55 -0700
In-Reply-To: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1489721642-5657-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement vas_init() and vas_exit() functions for a new VAS module.
This VAS module is essentially a library for other device drivers
and kernel users of the NX coprocessors like NX-842 and NX-GZIP.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v3]:
	- Zero vas_instances memory on allocation
	- [Haren Myneni] Fix description in Kconfig
Changelog[v2]:
	- Get HVWC, UWC and window address parameters from device tree.
---
 MAINTAINERS                     |   8 ++-
 arch/powerpc/include/asm/reg.h  |   1 +
 drivers/misc/Kconfig            |   1 +
 drivers/misc/Makefile           |   1 +
 drivers/misc/vas/Kconfig        |  21 ++++++
 drivers/misc/vas/Makefile       |   3 +
 drivers/misc/vas/vas-internal.h |   3 +
 drivers/misc/vas/vas-window.c   |  19 +++++
 drivers/misc/vas/vas.c          | 155 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 210 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/vas/Kconfig
 create mode 100644 drivers/misc/vas/Makefile
 create mode 100644 drivers/misc/vas/vas-window.c
 create mode 100644 drivers/misc/vas/vas.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a910c9..4037252 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3673,8 +3673,6 @@ F:	arch/powerpc/platforms/powernv/pci-cxl.c
 F:	drivers/misc/cxl/
 F:	include/misc/cxl*
 F:	include/uapi/misc/cxl.h
-F:	Documentation/powerpc/cxl.txt
-F:	Documentation/ABI/testing/sysfs-class-cxl
 
 CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
 M:	Manoj N. Kumar <manoj@linux.vnet.ibm.com>
@@ -3686,6 +3684,12 @@ F:	drivers/scsi/cxlflash/
 F:	include/uapi/scsi/cxlflash_ioctls.h
 F:	Documentation/powerpc/cxlflash.txt
 
+VAS (IBM Virtual Accelerator Switch) DRIVER
+M:	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	drivers/misc/vas/
+
 STMMAC ETHERNET DRIVER
 M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
 M:	Alexandre Torgue <alexandre.torgue@st.com>
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index fc879fd..7a45ff7 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1225,6 +1225,7 @@
 #define PVR_POWER8E	0x004B
 #define PVR_POWER8NVL	0x004C
 #define PVR_POWER8	0x004D
+#define PVR_POWER9	0x004E
 #define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
 
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c290990..97d652e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -783,4 +783,5 @@ source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+source "drivers/misc/vas/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7a3ea89..5201ffd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_VAS)		+= vas/
 obj-$(CONFIG_PANEL)             += panel.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
diff --git a/drivers/misc/vas/Kconfig b/drivers/misc/vas/Kconfig
new file mode 100644
index 0000000..43cedda
--- /dev/null
+++ b/drivers/misc/vas/Kconfig
@@ -0,0 +1,21 @@
+#
+# IBM Virtual Accelarator Switchboard (VAS) compatible devices
+#depends on PPC_POWERNV && PCI_MSI && EEH
+#
+
+config VAS
+	tristate "Support for IBM Virtual Accelerator Switchboard (VAS)"
+	depends on PPC_POWERNV
+	default n
+	help
+	  Select this option to enable driver support for IBM Virtual
+	  Accelerator Switchboard (VAS).
+
+	  VAS allows accelerators in co processors like NX-842 to be
+	  directly available to a user process. This driver enables
+	  userspace programs to access these accelerators via device
+	  nodes like /dev/crypto/nx-gzip.
+
+	  VAS adapters are found in POWER9 based systems.
+
+	  If unsure, say N.
diff --git a/drivers/misc/vas/Makefile b/drivers/misc/vas/Makefile
new file mode 100644
index 0000000..7dd7139
--- /dev/null
+++ b/drivers/misc/vas/Makefile
@@ -0,0 +1,3 @@
+ccflags-y			:= $(call cc-disable-warning, unused-const-variable)
+ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
+obj-$(CONFIG_VAS)		+= vas.o vas-window.o
diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-internal.h
index ce48f14..15b62e0 100644
--- a/drivers/misc/vas/vas-internal.h
+++ b/drivers/misc/vas/vas-internal.h
@@ -389,4 +389,7 @@ struct vas_winctx {
 	enum vas_notify_after_count notify_after_count;
 };
 
+extern int vas_initialized;
+extern int vas_window_reset(struct vas_instance *vinst, int winid);
+extern struct vas_instance *find_vas_instance(int vasid);
 #endif
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
new file mode 100644
index 0000000..468f3bf
--- /dev/null
+++ b/drivers/misc/vas/vas-window.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <asm/vas.h>
+#include "vas-internal.h"
+
+/* stub for now */
+int vas_window_reset(struct vas_instance *vinst, int winid)
+{
+	return 0;
+}
diff --git a/drivers/misc/vas/vas.c b/drivers/misc/vas/vas.c
new file mode 100644
index 0000000..75e55f9
--- /dev/null
+++ b/drivers/misc/vas/vas.c
@@ -0,0 +1,155 @@
+/*
+ * Copyright 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <asm/vas.h>
+#include "vas-internal.h"
+
+int vas_initialized;
+int vas_num_instances;
+struct vas_instance *vas_instances;
+
+static void init_vas_chip(struct vas_instance *vinst)
+{
+	int i;
+
+	for (i = 0; i < VAS_MAX_WINDOWS_PER_CHIP; i++)
+		vas_window_reset(vinst, i);
+}
+
+static int init_vas_instance(struct device_node *dn,
+				struct vas_instance *vinst)
+{
+	int rc;
+	const __be32 *p;
+
+	ida_init(&vinst->ida);
+	mutex_init(&vinst->mutex);
+
+	p = of_get_property(dn, "vas-id", NULL);
+	if (!p) {
+		pr_err("VAS: NULL vas-id? %p\n", p);
+		return -ENODEV;
+	}
+
+	vinst->vas_id = of_read_number(p, 1);
+
+	rc = of_property_read_u64(dn, "hvwc-bar-start", &vinst->hvwc_bar_start);
+	if (rc)
+		return rc;
+
+	rc = of_property_read_u64(dn, "hvwc-bar-size", &vinst->hvwc_bar_len);
+	if (rc)
+		return rc;
+
+	rc = of_property_read_u64(dn, "uwc-bar-start", &vinst->uwc_bar_start);
+	if (rc)
+		return rc;
+
+	rc = of_property_read_u64(dn, "uwc-bar-size", &vinst->uwc_bar_len);
+	if (rc)
+		return rc;
+
+	rc = of_property_read_u64(dn, "window-base", &vinst->win_base_addr);
+	if (rc)
+		return rc;
+
+	rc = of_property_read_u64(dn, "window-shift", &vinst->win_id_shift);
+	if (rc)
+		return rc;
+
+	init_vas_chip(vinst);
+
+	return 0;
+}
+
+/*
+ * Although this is read/used multiple times, it is written to only
+ * during initialization.
+ */
+struct vas_instance *find_vas_instance(int vasid)
+{
+	int i;
+	struct vas_instance *vinst;
+
+	for (i = 0; i < vas_num_instances; i++) {
+		vinst = &vas_instances[i];
+		if (vinst->vas_id == vasid)
+			return vinst;
+	}
+	pr_err("VAS instance for vas-id %d not found\n", vasid);
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+
+int vas_init(void)
+{
+	int rc;
+	struct device_node *dn;
+	struct vas_instance *vinst;
+
+	if (!pvr_version_is(PVR_POWER9))
+		return -ENODEV;
+
+	vas_num_instances = 0;
+	for_each_node_by_name(dn, "vas")
+		vas_num_instances++;
+
+	if (!vas_num_instances)
+		return -ENODEV;
+
+	vas_instances = kcalloc(vas_num_instances, sizeof(*vinst), GFP_KERNEL);
+	if (!vas_instances)
+		return -ENOMEM;
+
+	vinst = &vas_instances[0];
+	for_each_node_by_name(dn, "vas") {
+		rc = init_vas_instance(dn, vinst);
+		if (rc) {
+			pr_err("Error %d initializing VAS instance %ld\n", rc,
+					(vinst-&vas_instances[0]));
+			goto cleanup;
+		}
+		vinst++;
+	}
+
+	rc = -ENODEV;
+	if (vinst == &vas_instances[0]) {
+		/* Should not happen as we saw some above. */
+		pr_err("VAS: Did not find any VAS DT nodes now!\n");
+		goto cleanup;
+	}
+
+	pr_devel("VAS: Initialized %d instances\n", vas_num_instances);
+	vas_initialized = 1;
+
+	return 0;
+
+cleanup:
+	kfree(vas_instances);
+	return rc;
+}
+
+void vas_exit(void)
+{
+	vas_initialized = 0;
+	kfree(vas_instances);
+}
+
+module_init(vas_init);
+module_exit(vas_exit);
+MODULE_DESCRIPTION("IBM Virtual Accelerator Switchboard");
+MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4
