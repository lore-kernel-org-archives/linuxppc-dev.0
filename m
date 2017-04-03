Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxZv66zckzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 00:56:50 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33Esbnm076721
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 10:56:40 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29kqbmw770-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 10:56:39 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 00:56:35 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v33EuOfq48037964
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v33EttFA026138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:55:56 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v6 02/11] powerpc/powernv: Autoload IMC device driver module
Date: Mon,  3 Apr 2017 20:24:59 +0530
In-Reply-To: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491231308-15282-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

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

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/opal-imc.c | 126 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c     |  14 ++++
 3 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb3f482..44909fec1121 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o
+obj-y			+= opal-kmsg.o opal-imc.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
new file mode 100644
index 000000000000..c476d596c6a8
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -0,0 +1,126 @@
+/*
+ * OPAL IMC interface detection driver
+ * Supported on POWERNV platform
+ *
+ * Copyright	(C) 2016 Madhavan Srinivasan, IBM Corporation.
+ *		(C) 2016 Hemant K Shaw, IBM Corporation.
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
+static int opal_imc_counters_probe(struct platform_device *pdev)
+{
+	struct device_node *child, *imc_dev, *rm_node = NULL;
+	struct perchip_nest_info *pcni;
+	u32 pages, nest_offset, nest_size, idx;
+	int i = 0;
+	const char *node_name;
+	const __be32 *addrp;
+	u64 reg_addr, reg_size;
+
+	if (!pdev || !pdev->dev.of_node)
+		return -ENODEV;
+
+	/*
+	 * Check whether this kdump kernel. If yes, just return.
+	 */
+	if (is_kdump_kernel())
+		return -ENODEV;
+
+	imc_dev = pdev->dev.of_node;
+
+	/*
+	 * nest_offset : where the nest-counters' data start.
+	 * size : size of the entire nest-counters region
+	 */
+	if (of_property_read_u32(imc_dev, "imc-nest-offset", &nest_offset))
+		goto err;
+
+	if (of_property_read_u32(imc_dev, "imc-nest-size", &nest_size))
+		goto err;
+
+	/* Find the "homer region" for each chip */
+	rm_node = of_find_node_by_path("/reserved-memory");
+	if (!rm_node)
+		goto err;
+
+	for_each_child_of_node(rm_node, child) {
+		if (of_property_read_string_index(child, "name", 0,
+						  &node_name))
+			continue;
+		if (strncmp("ibm,homer-image", node_name,
+			    strlen("ibm,homer-image")))
+			continue;
+
+		/* Get the chip id to which the above homer region belongs to */
+		if (of_property_read_u32(child, "ibm,chip-id", &idx))
+			goto err;
+
+		pcni = &nest_perchip_info[idx];
+		addrp = of_get_address(child, 0, &reg_size, NULL);
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
+		do {
+			pages = PAGE_SIZE * i;
+			pcni->vbase[i++] = (u64)phys_to_virt(pcni->pbase +
+							     pages);
+		} while (i < (pcni->size / PAGE_SIZE));
+	}
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
index e0f856bfbfe8..85ea1296f030 100644
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
 
@@ -631,6 +633,15 @@ static void opal_pdev_init(const char *compatible)
 		of_platform_device_create(np, NULL, NULL);
 }
 
+static void opal_imc_init_dev(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, IMC_DTB_COMPAT);
+	if (np)
+		of_platform_device_create(np, NULL, NULL);
+}
+
 static int kopald(void *unused)
 {
 	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
@@ -704,6 +715,9 @@ static int __init opal_init(void)
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
+	/* Detect IMC pmu counters support and create PMUs */
+	opal_imc_init_dev();
+
 	/* Create leds platform devices */
 	leds = of_find_node_by_path("/ibm,opal/leds");
 	if (leds) {
-- 
2.7.4
