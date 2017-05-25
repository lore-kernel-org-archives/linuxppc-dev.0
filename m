Return-Path: <srs0=ecaq=47=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYJ4x5HrgzDqgV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:40:17 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wYJ4x21Bhz8wV3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:40:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wYJ4v4WJlz9sCZ
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 15:40:15 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4P5dO5S098647
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:40:10 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2anh96syah-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:40:09 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 25 May 2017 01:40:09 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 03/10] VAS: Define vas_init() and vas_exit()
Date: Wed, 24 May 2017 22:39:43 -0700
In-Reply-To: <1495690790-12172-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1495690790-12172-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1495690790-12172-4-git-send-email-sukadev@linux.vnet.ibm.com>
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
 .../devicetree/bindings/powerpc/ibm,vas.txt        |  24 +++
 MAINTAINERS                                        |   8 +
 arch/powerpc/platforms/powernv/Kconfig             |  14 ++
 arch/powerpc/platforms/powernv/Makefile            |   1 +
 arch/powerpc/platforms/powernv/vas-window.c        |  19 +++
 arch/powerpc/platforms/powernv/vas.c               | 183 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h               |  10 +-
 7 files changed, 257 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,vas.txt
 create mode 100644 arch/powerpc/platforms/powernv/vas-window.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.c

diff --git a/Documentation/devicetree/bindings/powerpc/ibm,vas.txt b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
new file mode 100644
index 0000000..8468a3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
@@ -0,0 +1,24 @@
+* IBM Powerpc Virtual Accelerator Switchboard (VAS)
+
+VAS is a hardware mechanism that allows ekrnel subsystems and user processes
+to directly submit compression and other requests to Nest accelerators (NX)
+or other coprocessors functions.
+
+Required properties:
+- compatible : should be "ibm,vas" or "ibm,power9-vas"
+- ibm,vas-id : A unique identifier for each instance of VAS in the system
+- reg : Should contain 4 pairs of 64-bit fields specifying the Hypervisor
+  window context start and length, OS/User window context start and length,
+  "Paste address" start and length, "Paste window id" start bit and number
+  of bits)
+- name : "vas"
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
index 9e98464..4c4f05e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6331,6 +6331,14 @@ F:	drivers/crypto/nx/nx.*
 F:	drivers/crypto/nx/nx_csbcpb.h
 F:	drivers/crypto/nx/nx_debugfs.h
 
+IBM Power Virtual Accelerator Switchboard
+M:	Sukadev Bhattiprolu
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	arch/powerpc/platforms/powernv/vas*
+F:	arch/powerpc/include/asm/vas.h
+F:	arch/powerpc/include/uapi/asm/vas.h
+
 IBM Power 842 compression accelerator
 M:	Haren Myneni <haren@us.ibm.com>
 S:	Supported
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6a6f4ef..f565454 100644
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
+	default n
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
index 0000000..6156fbe
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas-window.c
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
index 0000000..556156b
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -0,0 +1,183 @@
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
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+
+#include "vas.h"
+
+static bool init_done;
+LIST_HEAD(vas_instances);
+
+static int init_vas_instance(struct platform_device *pdev)
+{
+	int rc, vasid;
+	struct vas_instance *vinst;
+	struct device_node *dn = pdev->dev.of_node;
+	struct resource *res;
+
+	rc = of_property_read_u32(dn, "ibm,vas-id", &vasid);
+	if (rc) {
+		pr_err("VAS: No ibm,vas-id property for %s?\n", pdev->name);
+		return -ENODEV;
+	}
+
+	if (pdev->num_resources != 4) {
+		pr_err("VAS: Unexpected DT configuration for [%s, %d]\n",
+				pdev->name, vasid);
+		return -ENODEV;
+	}
+
+	vinst = kcalloc(1, sizeof(*vinst), GFP_KERNEL);
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
+	vinst->hvwc_bar_len = res->end - res->start + 1;
+
+	res = &pdev->resource[1];
+	vinst->uwc_bar_start = res->start;
+	vinst->uwc_bar_len = res->end - res->start + 1;
+
+	res = &pdev->resource[2];
+	vinst->paste_base_addr = res->start;
+
+	res = &pdev->resource[3];
+	vinst->paste_win_id_shift = 63 - res->end;
+
+	pr_devel("VAS: Initialized instance [%s, %d], paste_base 0x%llx, "
+			"paste_win_id_shift 0x%llx\n", pdev->name, vasid,
+			vinst->paste_base_addr, vinst->paste_win_id_shift);
+
+	vinst->ready = true;
+	list_add(&vinst->node, &vas_instances);
+
+	dev_set_drvdata(&pdev->dev, vinst);
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
+	struct list_head *ent;
+	struct vas_instance *vinst;
+
+	list_for_each(ent, &vas_instances) {
+		vinst = list_entry(ent, struct vas_instance, node);
+		if (vinst->vas_id == vasid)
+			return vinst;
+	}
+
+	pr_devel("VAS: Instance %d not found\n", vasid);
+	return NULL;
+}
+
+bool vas_initialized(void)
+{
+	return init_done;
+}
+
+static int vas_probe(struct platform_device *pdev)
+{
+	if (!pdev || !pdev->dev.of_node)
+		return -ENODEV;
+
+	return init_vas_instance(pdev);
+}
+
+static void free_inst(struct vas_instance *vinst)
+{
+	list_del(&vinst->node);
+
+	kfree(vinst);
+}
+
+static int vas_remove(struct platform_device *pdev)
+{
+	struct vas_instance *vinst;
+
+	vinst = dev_get_drvdata(&pdev->dev);
+
+	pr_devel("VAS: Removed instance [%s, %d]\n", pdev->name,
+				vinst->vas_id);
+	free_inst(vinst);
+
+	return 0;
+}
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
+	.remove = vas_remove,
+};
+
+module_platform_driver(vas_driver);
+
+int vas_init(void)
+{
+	int found = 0;
+	struct device_node *dn;
+
+	for_each_compatible_node(dn, NULL, "ibm,vas") {
+		of_platform_device_create(dn, NULL, NULL);
+		found++;
+	}
+
+	if (!found)
+		return -ENODEV;
+
+	pr_devel("VAS: Found %d instances\n", found);
+	init_done = true;
+
+	return 0;
+}
+
+void vas_exit(void)
+{
+	struct list_head *ent;
+	struct vas_instance *vinst;
+
+	list_for_each(ent, &vas_instances) {
+		vinst = list_entry(ent, struct vas_instance, node);
+		of_platform_depopulate(&vinst->pdev->dev);
+	}
+
+	init_done = false;
+}
+
+module_init(vas_init);
+module_exit(vas_exit);
+MODULE_DESCRIPTION("Bare metal IBM Virtual Accelerator Switchboard");
+MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
+MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index c6bcc0c..12c6380 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -291,14 +291,17 @@ enum vas_notify_after_count {
  */
 struct vas_instance {
 	int vas_id;
+	bool ready;
 	struct ida ida;
+	struct list_head node;
+	struct platform_device *pdev;
 
 	u64 hvwc_bar_start;
 	u64 hvwc_bar_len;
 	u64 uwc_bar_start;
 	u64 uwc_bar_len;
-	u64 win_base_addr;
-	u64 win_id_shift;
+	u64 paste_base_addr;
+	u64 paste_win_id_shift;
 
 	struct mutex mutex;
 	struct vas_window *rxwin[VAS_COP_TYPE_MAX];
@@ -376,4 +379,7 @@ struct vas_winctx {
 	enum vas_notify_after_count notify_after_count;
 };
 
+extern bool vas_initialized(void);
+extern struct vas_instance *find_vas_instance(int vasid);
+
 #endif /* _VAS_H */
-- 
2.7.4
