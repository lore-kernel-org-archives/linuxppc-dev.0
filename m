Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6rz54qggzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 03:02:25 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3IGwkxf088993
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:02:13 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29w4jamd09-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:02:12 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 18 Apr 2017 22:32:06 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3IH0dGh18939982
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:30:39 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3IH20bM024636
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:32:02 +0530
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v7 02/10] powerpc/powernv: Autoload IMC device driver module
Date: Tue, 18 Apr 2017 22:31:42 +0530
In-Reply-To: <1492534910-7991-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1492534910-7991-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1492534910-7991-3-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch does three things :
 - Enables "opal.c" to create a platform device for the IMC interface
   according to the appropriate compatibility string.
 - Find the reserved-memory region details from the system device tree
   and get the base address of HOMER (Reserved memory) region address for each chip.
 - We also get the Nest PMU counter data offsets (in the HOMER region)
   and their sizes. The offsets for the counters' data are fixed and
   won't change from chip to chip.

The device tree parsing logic is separated from the PMU creation
functions (which is done in subsequent patches).

Patch also adds a CONFIG_HV_PERF_IMC_CTRS for the IMC driver.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Kconfig    |  10 +++
 arch/powerpc/platforms/powernv/Makefile   |   1 +
 arch/powerpc/platforms/powernv/opal-imc.c | 140 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c     |  18 ++++
 4 files changed, 169 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 3a07e4d..1b90a98 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -27,3 +27,13 @@ config OPAL_PRD
 	help
 	  This enables the opal-prd driver, a facility to run processor
 	  recovery diagnostics on OpenPower machines
+
+config HV_PERF_IMC_CTRS
+       bool "Hypervisor supplied In Memory Collection PMU events (Nest & Core)"
+       default y
+       depends on PERF_EVENTS && PPC_POWERNV
+       help
+	  Enable access to hypervisor supplied in-memory collection counters
+	  in perf. IMC counters are available from Power9 systems.
+
+          If unsure, select Y.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..715e531 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
+obj-$(CONFIG_HV_PERF_IMC_CTRS) += opal-imc.o
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
new file mode 100644
index 0000000..3a87000
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -0,0 +1,140 @@
+/*
+ * OPAL IMC interface detection driver
+ * Supported on POWERNV platform
+ *
+ * Copyright	(C) 2017 Madhavan Srinivasan, IBM Corporation.
+ *		(C) 2017 Anju T Sudhakar, IBM Corporation.
+ *		(C) 2017 Hemant K Shaw, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/poll.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/crash_dump.h>
+#include <asm/opal.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/cputable.h>
+#include <asm/imc-pmu.h>
+
+struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
+
+/*
+ * imc_pmu_setup : Setup the IMC PMUs (children of "parent").
+ */
+static void __init imc_pmu_setup(struct device_node *parent)
+{
+	if (!parent)
+		return;
+}
+
+static int opal_imc_counters_probe(struct platform_device *pdev)
+{
+	struct device_node *imc_dev, *dn, *rm_node = NULL;
+	struct perchip_nest_info *pcni;
+	u32 pages, nest_offset, nest_size, chip_id;
+	int i = 0;
+	const __be32 *addrp;
+	u64 reg_addr, reg_size;
+
+	if (!pdev || !pdev->dev.of_node)
+		return -ENODEV;
+
+	/*
+	 * Check whether this is kdump kernel. If yes, just return.
+	 */
+	if (is_kdump_kernel())
+		return -ENODEV;
+
+	imc_dev = pdev->dev.of_node;
+
+	/*
+	 * Nest counter data are saved in a reserved memory called HOMER.
+	 * "imc-nest-offset" identifies the counter data location within HOMER.
+	 * size : size of the entire nest-counters region
+	 */
+	if (of_property_read_u32(imc_dev, "imc-nest-offset", &nest_offset))
+		goto err;
+
+	if (of_property_read_u32(imc_dev, "imc-nest-size", &nest_size))
+		goto err;
+
+	/* Sanity check */
+	if ((nest_size/PAGE_SIZE) > IMC_NEST_MAX_PAGES)
+		goto err;
+
+	/* Find the "HOMER region" for each chip */
+	rm_node = of_find_node_by_path("/reserved-memory");
+	if (!rm_node)
+		goto err;
+
+	/*
+	 * We need to look for the "ibm,homer-image" node in the
+	 * "/reserved-memory" node.
+	 */
+	for (dn = of_find_node_by_name(rm_node, "ibm,homer-image"); dn;
+			dn = of_find_node_by_name(dn, "ibm,homer-image")) {
+
+		/* Get the chip id to which the above homer region belongs to */
+		if (of_property_read_u32(dn, "ibm,chip-id", &chip_id))
+			goto err;
+
+		pcni = &nest_perchip_info[chip_id];
+		addrp = of_get_address(dn, 0, &reg_size, NULL);
+		if (!addrp)
+			goto err;
+
+		/* Fetch the homer region base address */
+		reg_addr = of_read_number(addrp, 2);
+		pcni->pbase = reg_addr;
+		/* Add the nest IMC Base offset */
+		pcni->pbase = pcni->pbase + nest_offset;
+		/* Fetch the size of the homer region */
+		pcni->size = nest_size;
+
+		for (i = 0; i < (pcni->size / PAGE_SIZE); i++) {
+			pages = PAGE_SIZE * i;
+			pcni->vbase[i] = (u64)phys_to_virt(pcni->pbase + pages);
+		}
+	}
+
+	imc_pmu_setup(imc_dev);
+
+	return 0;
+err:
+	return -ENODEV;
+}
+
+static const struct of_device_id opal_imc_match[] = {
+	{ .compatible = IMC_DTB_COMPAT },
+	{},
+};
+
+static struct platform_driver opal_imc_driver = {
+	.driver = {
+		.name = "opal-imc-counters",
+		.of_match_table = opal_imc_match,
+	},
+	.probe = opal_imc_counters_probe,
+};
+
+MODULE_DEVICE_TABLE(of, opal_imc_match);
+module_platform_driver(opal_imc_driver);
+MODULE_DESCRIPTION("PowerNV OPAL IMC driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e0f856b..b06f896 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -14,6 +14,7 @@
 #include <linux/printk.h>
 #include <linux/types.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
@@ -30,6 +31,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/imc-pmu.h>
 
 #include "powernv.h"
 
@@ -631,6 +633,17 @@ static void opal_pdev_init(const char *compatible)
 		of_platform_device_create(np, NULL, NULL);
 }
 
+#ifdef CONFIG_HV_PERF_IMC_CTRS
+static void __init opal_imc_init_dev(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, IMC_DTB_COMPAT);
+	if (np)
+		of_platform_device_create(np, NULL, NULL);
+}
+#endif
+
 static int kopald(void *unused)
 {
 	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
@@ -704,6 +717,11 @@ static int __init opal_init(void)
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
+#ifdef CONFIG_HV_PERF_IMC_CTRS
+	/* Detect IMC pmu counters support and create PMUs */
+	opal_imc_init_dev();
+#endif
+
 	/* Create leds platform devices */
 	leds = of_find_node_by_path("/ibm,opal/leds");
 	if (leds) {
-- 
2.7.4
