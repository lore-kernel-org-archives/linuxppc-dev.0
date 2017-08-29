Return-Path: <srs0=4uxs=77=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJW51lHQzDqVg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xhJW46MsSz8vLq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:00 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xhJW40hQGz9t3f
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 16:23:59 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T6JM0Q079417
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:23:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cn1jynxdj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:23:57 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 02:23:57 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 03/10] powerpc/vas: Define vas_init() and vas_exit()
Date: Mon, 28 Aug 2017 23:23:33 -0700
In-Reply-To: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503987820-31933-4-git-send-email-sukadev@linux.vnet.ibm.com>
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
In the future this will be extended to add support for user space
to access the NX coprocessors.

VAS is currently only supported with 64K page size.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v8]:
	- [Michael Ellerman] VAS should be built-in and not a module;
		drop the vas_exit() and free_vinst() code since its not
		a module and might need some refcounting. Drop init_done,
		->ready and unnecessary "len" fields in vinst; Misc cleanup.

Changelog[v5]:
	- [Ben Herrenschmidt]: Create and use platform device tree nodes,
	  fix up the "reg" properties for the VAS DT node and use the
	  platform device helpers to parse the reg properties; Use linked
	  list of VAS instances (don't assume vasids are sequential);
	  Use CONFIG_PPC_VAS instead of CONFIG_VAS.

Changelog[v4]:
	- [Michael Neuling] Fix some accidental deletions; fix help text
	  in Kconfig; change vas_initialized to a function; move from
	  drivers/misc to arch/powerpc/kernel
	- Drop the vas_window_reset() interface. It is not needed as
	  window will be initialized before each use.
	- Add a "depends on PPC_64K_PAGES"

Changelog[v3]:
	- Zero vas_instances memory on allocation
	- [Haren Myneni] Fix description in Kconfig
Changelog[v2]:
	- Get HVWC, UWC and window address parameters from device tree.
---
 .../devicetree/bindings/powerpc/ibm,vas.txt        |  23 ++++
 MAINTAINERS                                        |   8 ++
 arch/powerpc/platforms/powernv/Kconfig             |  14 ++
 arch/powerpc/platforms/powernv/Makefile            |   1 +
 arch/powerpc/platforms/powernv/vas-window.c        |  19 +++
 arch/powerpc/platforms/powernv/vas.c               | 151 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h               |   2 +
 7 files changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,vas.txt
 create mode 100644 arch/powerpc/platforms/powernv/vas-window.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.c

diff --git a/Documentation/devicetree/bindings/powerpc/ibm,vas.txt b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
new file mode 100644
index 0000000..a096d73
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
@@ -0,0 +1,23 @@
+* IBM Powerpc Virtual Accelerator Switchboard (VAS)
+
+VAS is a hardware mechanism that allows kernel subsystems and user processes
+to directly submit compression and other requests to Nest accelerators (NX)
+or other coprocessors functions.
+
+Required properties:
+- compatible : should be "ibm,vas".
+- ibm,vas-id : A unique identifier for each instance of VAS in the system
+- reg : Should contain 4 pairs of 64-bit fields specifying the Hypervisor
+  window context start and length, OS/User window context start and length,
+  "Paste address" start and length, "Paste window id" start bit and number
+  of bits)
+
+Example:
+
+	vas@6019100000000 {
+		compatible = "ibm,vas", "ibm,power9-vas";
+		reg = <0x6019100000000 0x2000000 0x6019000000000 0x100000000 0x8000000000000 0x100000000 0x20 0x10>;
+		name = "vas";
+		ibm,vas-id = <0x1>;
+	};
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c3feff..ec68732 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6437,6 +6437,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/ibm/ibmvnic.*
 
+IBM Power Virtual Accelerator Switchboard
+M:	Sukadev Bhattiprolu
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	arch/powerpc/platforms/powernv/vas*
+F:	arch/powerpc/include/asm/vas.h
+F:	arch/powerpc/include/uapi/asm/vas.h
+
 IBM Power Virtual Ethernet Device Driver
 M:	Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
 L:	netdev@vger.kernel.org
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6a6f4ef..3e3bbe9 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -30,3 +30,17 @@ config OPAL_PRD
 	help
 	  This enables the opal-prd driver, a facility to run processor
 	  recovery diagnostics on OpenPower machines
+
+config PPC_VAS
+	bool "IBM Virtual Accelerator Switchboard (VAS)"
+	depends on PPC_POWERNV && PPC_64K_PAGES
+	default y
+	help
+	  This enables support for IBM Virtual Accelerator Switchboard (VAS).
+
+	  VAS allows accelerators in co-processors like NX-GZIP and NX-842
+	  to be accessible to kernel subsystems and user processes.
+
+	  VAS adapters are found in POWER9 based systems.
+
+	  If unsure, say N.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..e4db292 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
+obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
new file mode 100644
index 0000000..de21acb
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2016-17 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+
+#include "vas.h"
+
+/* stub for now */
+int vas_win_close(struct vas_window *window)
+{
+	return -1;
+}
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
new file mode 100644
index 0000000..565a487
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright 2016-17 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "vas: " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+
+#include "vas.h"
+
+static DEFINE_MUTEX(vas_mutex);
+static LIST_HEAD(vas_instances);
+
+static int init_vas_instance(struct platform_device *pdev)
+{
+	int rc, vasid;
+	struct resource *res;
+	struct vas_instance *vinst;
+	struct device_node *dn = pdev->dev.of_node;
+
+	rc = of_property_read_u32(dn, "ibm,vas-id", &vasid);
+	if (rc) {
+		pr_err("No ibm,vas-id property for %s?\n", pdev->name);
+		return -ENODEV;
+	}
+
+	if (pdev->num_resources != 4) {
+		pr_err("Unexpected DT configuration for [%s, %d]\n",
+				pdev->name, vasid);
+		return -ENODEV;
+	}
+
+	vinst = kzalloc(sizeof(*vinst), GFP_KERNEL);
+	if (!vinst)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vinst->node);
+	ida_init(&vinst->ida);
+	mutex_init(&vinst->mutex);
+	vinst->vas_id = vasid;
+	vinst->pdev = pdev;
+
+	res = &pdev->resource[0];
+	vinst->hvwc_bar_start = res->start;
+
+	res = &pdev->resource[1];
+	vinst->uwc_bar_start = res->start;
+
+	res = &pdev->resource[2];
+	vinst->paste_base_addr = res->start;
+
+	res = &pdev->resource[3];
+	if (res->end > 62) {
+		pr_err("Bad 'paste_win_id_shift' in DT, %llx\n", res->end);
+		goto free_vinst;
+	}
+
+	vinst->paste_win_id_shift = 63 - res->end;
+
+	pr_devel("Initialized instance [%s, %d], paste_base 0x%llx, "
+			"paste_win_id_shift 0x%llx\n", pdev->name, vasid,
+			vinst->paste_base_addr, vinst->paste_win_id_shift);
+
+	mutex_lock(&vas_mutex);
+	list_add(&vinst->node, &vas_instances);
+	mutex_unlock(&vas_mutex);
+
+	dev_set_drvdata(&pdev->dev, vinst);
+
+	return 0;
+
+free_vinst:
+	kfree(vinst);
+	return -ENODEV;
+
+}
+
+/*
+ * Although this is read/used multiple times, it is written to only
+ * during initialization.
+ */
+struct vas_instance *find_vas_instance(int vasid)
+{
+	struct list_head *ent;
+	struct vas_instance *vinst;
+
+	mutex_lock(&vas_mutex);
+	list_for_each(ent, &vas_instances) {
+		vinst = list_entry(ent, struct vas_instance, node);
+		if (vinst->vas_id == vasid) {
+			mutex_unlock(&vas_mutex);
+			return vinst;
+		}
+	}
+	mutex_unlock(&vas_mutex);
+
+	pr_devel("Instance %d not found\n", vasid);
+	return NULL;
+}
+
+static int vas_probe(struct platform_device *pdev)
+{
+	return init_vas_instance(pdev);
+}
+
+static const struct of_device_id powernv_vas_match[] = {
+	{ .compatible = "ibm,vas",},
+	{},
+};
+
+static struct platform_driver vas_driver = {
+	.driver = {
+		.name = "vas",
+		.of_match_table = powernv_vas_match,
+	},
+	.probe = vas_probe,
+};
+
+static int __init vas_init(void)
+{
+	int found = 0;
+	struct device_node *dn;
+
+	platform_driver_register(&vas_driver);
+
+	for_each_compatible_node(dn, NULL, "ibm,vas") {
+		of_platform_device_create(dn, NULL, NULL);
+		found++;
+	}
+
+	if (!found)
+		return -ENODEV;
+
+	pr_devel("Found %d instances\n", found);
+
+	return 0;
+}
+device_initcall(vas_init);
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index abb545f..650805d 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -379,4 +379,6 @@ struct vas_winctx {
 	enum vas_notify_after_count notify_after_count;
 };
 
+extern struct vas_instance *find_vas_instance(int vasid);
+
 #endif /* _VAS_H */
-- 
2.7.4
