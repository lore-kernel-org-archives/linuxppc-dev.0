Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkKzX73TMzDqZc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:40 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SiTS130218
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:29 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2978e6au2r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:29 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:36:26 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7aE3I28049530
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7ZnGF009427
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:35:50 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 02/13] powerpc/powernv: Autoload IMC device driver module
Date: Thu, 16 Mar 2017 13:04:56 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-3-git-send-email-maddy@linux.vnet.ibm.com>
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

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/opal-imc.c | 117 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c     |  13 ++++
 3 files changed, 131 insertions(+), 1 deletion(-)
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
index 000000000000..1b99c4e2f3f8
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -0,0 +1,117 @@
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
+	u32 reg[4], pages, nest_offset, nest_size, idx;
+	int i = 0;
+	const char *node_name;
+
+	if (!pdev || !pdev->dev.of_node)
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
+		/* reg property will have four u32 cells. */
+		if (of_property_read_u32_array(child, "reg", reg, 4))
+			goto err;
+
+		pcni = &nest_perchip_info[idx];
+
+		/* Fetch the homer region base address */
+		pcni->pbase = reg[0];
+		pcni->pbase = pcni->pbase << 32 | reg[1];
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
index e0f856bfbfe8..2c90c570953d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -30,6 +30,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/imc-pmu.h>
 
 #include "powernv.h"
 
@@ -631,6 +632,15 @@ static void opal_pdev_init(const char *compatible)
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
@@ -704,6 +714,9 @@ static int __init opal_init(void)
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
