Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMdW73PYyzDvdk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:27 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAL68b8w021544
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:25 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26utqghf3p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:25 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 16:10:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6BE982BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:20 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAL6AKTk56557646
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:20 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAL6AJA5030461
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:20 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 stewart@linux.vnet.ibm.com, dja@axtens.net, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v2 2/6] powerpc/powernv: Autoload IMA device driver module
Date: Mon, 21 Nov 2016 11:40:01 +0530
In-Reply-To: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
Message-Id: <1479708605-10238-3-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch does three things :
 - Enables "opal.c" to create a platform device for the IMA interface
   according to the appropriate compatibility string.
 - Find the reserved-memory region details from the system device tree
   and get the base address of HOMER region address for each chip.
 - We also get the Nest PMU counter data offsets (in the HOMER region)
   and their sizes. The offsets for the counters' data are fixed and
   won't change from chip to chip.

The device tree parsing logic is separated from the PMU creation
functions (which is done in subsequent patches). Right now, only Nest
units are taken care of.

Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/opal-ima.c | 117 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c     |  13 ++++
 3 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-ima.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..ee28528 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o
+obj-y			+= opal-kmsg.o opal-ima.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-ima.c b/arch/powerpc/platforms/powernv/opal-ima.c
new file mode 100644
index 0000000..446e7bc
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-ima.c
@@ -0,0 +1,117 @@
+/*
+ * OPAL IMA interface detection driver
+ * Supported on POWERNV platform
+ *
+ * Copyright  (C) 2016 Madhavan Srinivasan, IBM Corporation.
+ *	       (C) 2016 Hemant K Shaw, IBM Corporation.
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
+#include <asm/ima-pmu.h>
+
+struct perchip_nest_info nest_perchip_info[IMA_MAX_CHIPS];
+
+static int opal_ima_counters_probe(struct platform_device *pdev)
+{
+	struct device_node *child, *ima_dev, *rm_node = NULL;
+	struct perchip_nest_info *pcni;
+	u32 reg[4], pages, nest_offset, nest_size, idx;
+	int i = 0;
+	const char *node_name;
+
+	if (!pdev || !pdev->dev.of_node)
+		return -ENODEV;
+
+	ima_dev = pdev->dev.of_node;
+
+	/*
+	 * nest_offset : where the nest-counters' data start.
+	 * size : size of the entire nest-counters region
+	 */
+	if (of_property_read_u32(ima_dev, "ima-nest-offset", &nest_offset))
+		goto err;
+	if (of_property_read_u32(ima_dev, "ima-nest-size", &nest_size))
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
+		/* Add the nest IMA Base offset */
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
+static const struct of_device_id opal_ima_match[] = {
+	{ .compatible = IMA_DTB_COMPAT },
+	{},
+};
+
+static struct platform_driver opal_ima_driver = {
+	.driver = {
+		.name = "opal-ima-counters",
+		.of_match_table = opal_ima_match,
+	},
+	.probe = opal_ima_counters_probe,
+};
+
+MODULE_DEVICE_TABLE(of, opal_ima_match);
+module_platform_driver(opal_ima_driver);
+MODULE_DESCRIPTION("PowerNV OPAL IMA driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 6c9a65b..118cab0 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -30,6 +30,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/ima-pmu.h>
 
 #include "powernv.h"
 
@@ -650,6 +651,15 @@ static void opal_i2c_create_devs(void)
 		of_platform_device_create(np, NULL, NULL);
 }
 
+static void opal_ima_init_dev(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, IMA_DTB_COMPAT);
+	if (np)
+		of_platform_device_create(np, NULL, NULL);
+}
+
 static int kopald(void *unused)
 {
 	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
@@ -723,6 +733,9 @@ static int __init opal_init(void)
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
+	/* Detect IMA pmu counters support and create PMUs */
+	opal_ima_init_dev();
+
 	/* Create leds platform devices */
 	leds = of_find_node_by_path("/ibm,opal/leds");
 	if (leds) {
-- 
2.7.4
