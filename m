Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyX9H2ThfzDr4b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:57:39 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5SIs9DZ139644
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 14:57:37 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcgk7ccca-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 14:57:36 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 04:57:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5SIvWkq6291730
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:57:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5SIvNFU029571
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:57:24 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v11 02/10] powerpc/powernv: Autoload IMC device driver module
Date: Thu, 29 Jun 2017 00:27:07 +0530
In-Reply-To: <1498676232-23841-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1498676232-23841-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1498676232-23841-3-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code to create platform device for the IMC counters.
Paltform devices are created based on the IMC compatibility
string.

New Config flag "CONFIG_HV_PERF_IMC_CTRS" add to contain the
IMC counter changes.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Kconfig    | 10 +++++
 arch/powerpc/platforms/powernv/Makefile   |  1 +
 arch/powerpc/platforms/powernv/opal-imc.c | 73 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c     | 18 ++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6a6f4ef..543c6cd 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -30,3 +30,13 @@ config OPAL_PRD
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
index 0000000..5b1045c
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -0,0 +1,73 @@
+/*
+ * OPAL IMC interface detection driver
+ * Supported on POWERNV platform
+ *
+ * Copyright	(C) 2017 Madhavan Srinivasan, IBM Corporation.
+ *		(C) 2017 Anju T Sudhakar, IBM Corporation.
+ *		(C) 2017 Hemant K Shaw, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or later version.
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
+static int opal_imc_counters_probe(struct platform_device *pdev)
+{
+	struct device_node *imc_dev = NULL;
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
+	if (!imc_dev)
+		return -ENODEV;
+
+	return 0;
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
index 59684b4..fbdca25 100644
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
 
@@ -705,6 +707,17 @@ static void opal_pdev_init(const char *compatible)
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
@@ -778,6 +791,11 @@ static int __init opal_init(void)
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
