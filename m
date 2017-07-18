Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtmV4gR2zDrJZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:37:30 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6ILaJMK040927
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 17:37:29 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bsqhvfheh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 17:37:28 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 07:37:26 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6ILbNeY29556736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:37:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6ILbFEL018796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:37:15 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v13 2/5] powerpc/platform/powernv: Detect and create IMC device
Date: Wed, 19 Jul 2017 03:06:33 +0530
In-Reply-To: <1500413796-18340-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1500413796-18340-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1500413796-18340-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code to create platform device for the In-Memory Collection (IMC) counters.
Paltform devices are created based on the IMC compatibility. New header
file created to contain the data structures and macros needed for
In-Memory Collection (IMC) counter pmu devices.

The device tree for IMC counters starts at the node "imc-counters".
This node contains all the IMC PMU nodes and event nodes for
these IMC PMUs. Device probe() parses the device to locate three possible
IMC device types (Nest/Core/Thread). Function then branch to parse
each unit nodes to populate vital information such as device
memory sizes, event nodes information, base address for reserve
memory access (if any) and so on. Simple bare-minimum sutdown
function added which only "stops" the engines.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        | 128 +++++++++++++++++
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/opal-imc.c | 221 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c     |  14 ++
 4 files changed, 364 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/imc-pmu.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
new file mode 100644
index 000000000000..e87aa041d16d
--- /dev/null
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -0,0 +1,128 @@
+#ifndef __ASM_POWERPC_IMC_PMU_H
+#define __ASM_POWERPC_IMC_PMU_H
+
+/*
+ * IMC Nest Performance Monitor counter support.
+ *
+ * Copyright (C) 2017 Madhavan Srinivasan, IBM Corporation.
+ *           (C) 2017 Anju T Sudhakar, IBM Corporation.
+ *           (C) 2017 Hemant K Shaw, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or later version.
+ */
+
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <asm/opal.h>
+
+/*
+ * For static allocation of some of the structures.
+ */
+#define IMC_MAX_PMUS			32
+
+/*
+ *Compatbility macros for IMC devices
+ */
+#define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
+#define IMC_DTB_UNIT_COMPAT		"ibm,imc-counters"
+
+
+/*
+ * LDBAR: Counter address and Enable/Disable macro.
+ * perf/imc-pmu.c has the LDBAR layout information.
+ */
+#define THREAD_IMC_LDBAR_MASK           0x0003ffffffffe000ULL
+#define THREAD_IMC_ENABLE               0x8000000000000000ULL
+
+/*
+ * Structure to hold memory address information for imc units.
+ */
+struct imc_mem_info {
+	u64 *vbase;
+	u32 id;
+};
+
+/*
+ * Place holder for nest pmu events and values.
+ */
+struct imc_events {
+	u32 value;
+	char *name;
+	char *unit;
+	char *scale;
+};
+
+/* Event attribute array index */
+#define IMC_FORMAT_ATTR		0
+#define IMC_EVENT_ATTR		1
+#define IMC_CPUMASK_ATTR	2
+#define IMC_NULL_ATTR		3
+
+/* PMU Format attribute macros */
+#define IMC_EVENT_OFFSET_MASK	0xffffffffULL
+
+/*
+ * Device tree parser code detects IMC pmu support and
+ * registers new IMC pmus. This structure will hold the
+ * pmu functions, events, counter memory information
+ * and attrs for each imc pmu and will be referenced at
+ * the time of pmu registration.
+ */
+struct imc_pmu {
+	struct pmu pmu;
+	struct imc_mem_info *mem_info;
+	struct imc_events **events;
+	/*
+	 * Attribute groups for the PMU. Slot 0 used for
+	 * format attribute, slot 1 used for cpusmask attribute,
+	 * slot 2 used for event attribute. Slot 3 keep as
+	 * NULL.
+	 */
+	const struct attribute_group *attr_groups[4];
+	u32 counter_mem_size;
+	int domain;
+	/*
+	 * flag to notify whether the memory is mmaped
+	 * or allocated by kernel.
+	 */
+	bool imc_counter_mmaped;
+};
+
+/*
+ * Structure to hold id, lock and reference count for the imc events which
+ * are inited.
+ */
+struct imc_pmu_ref {
+       struct mutex lock;
+       unsigned int id;
+       int refc;
+};
+
+/*
+ * In-Memory Collection Counters type.
+ * Data comes from Device tree.
+ * Three device type are supported.
+ */
+
+enum {
+	IMC_TYPE_THREAD		= 0x1,
+	IMC_TYPE_CORE		= 0x4,
+	IMC_TYPE_CHIP           = 0x10,
+};
+
+/*
+ * Domains for IMC PMUs
+ */
+#define IMC_DOMAIN_NEST		1
+#define IMC_DOMAIN_CORE		2
+#define IMC_DOMAIN_THREAD	3
+
+extern int init_imc_pmu(struct device_node *parent,
+				struct imc_pmu *pmu_ptr, int pmu_id);
+extern void thread_imc_disable(void);
+#endif /* __ASM_POWERPC_IMC_PMU_H */
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
index 000000000000..f57a6fbd3f57
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -0,0 +1,221 @@
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
+ */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/crash_dump.h>
+#include <asm/opal.h>
+#include <asm/io.h>
+#include <asm/imc-pmu.h>
+#include <asm/cputhreads.h>
+
+/*
+ * imc_get_mem_addr_nest: Function to get nest counter memory region
+ * for each chip
+ */
+static int imc_get_mem_addr_nest(struct device_node *node,
+				 struct imc_pmu *pmu_ptr,
+				 u32 offset)
+{
+	int nr_chips = 0, i;
+	u64 *base_addr_arr, baddr;
+	u32 *chipid_arr;
+
+	nr_chips = of_property_count_u32_elems(node, "chip-id");
+	if (nr_chips <= 0)
+		return -ENODEV;
+
+	base_addr_arr = kcalloc(nr_chips, sizeof(u64), GFP_KERNEL);
+	if (!base_addr_arr)
+		return -ENOMEM;
+
+	chipid_arr = kcalloc(nr_chips, sizeof(u32), GFP_KERNEL);
+	if (!chipid_arr)
+		return -ENOMEM;
+
+	if (of_property_read_u32_array(node, "chip-id", chipid_arr, nr_chips))
+		goto error;
+
+	if (of_property_read_u64_array(node, "base-addr", base_addr_arr,
+								nr_chips))
+		goto error;
+
+	pmu_ptr->mem_info = kcalloc(nr_chips, sizeof(struct imc_mem_info),
+								GFP_KERNEL);
+	if (!pmu_ptr->mem_info)
+		goto error;
+
+	for (i = 0; i < nr_chips; i++) {
+		pmu_ptr->mem_info[i].id = chipid_arr[i];
+		baddr = base_addr_arr[i] + offset;
+		pmu_ptr->mem_info[i].vbase = phys_to_virt(baddr);
+	}
+
+	pmu_ptr->imc_counter_mmaped = true;
+	kfree(base_addr_arr);
+	kfree(chipid_arr);
+	return 0;
+
+error:
+	kfree(pmu_ptr->mem_info);
+	kfree(base_addr_arr);
+	kfree(chipid_arr);
+	return -1;
+}
+
+/*
+ * imc_pmu_create : Takes the parent device which is the pmu unit, pmu_index
+ *		    and domain as the inputs.
+ * Allocates memory for the struct imc_pmu, sets up its domain, size and offsets
+ */
+static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
+{
+	int ret = 0;
+	struct imc_pmu *pmu_ptr;
+	u32 offset;
+
+	/* memory for pmu */
+	pmu_ptr = kzalloc(sizeof(struct imc_pmu), GFP_KERNEL);
+	if (!pmu_ptr)
+		return -ENOMEM;
+
+	/* Set the domain */
+	pmu_ptr->domain = domain;
+
+	ret = of_property_read_u32(parent, "size", &pmu_ptr->counter_mem_size);
+	if (ret) {
+		ret = -EINVAL;
+		goto free_pmu;
+	}
+
+	if (!of_property_read_u32(parent, "offset", &offset)) {
+		if (imc_get_mem_addr_nest(parent, pmu_ptr, offset)) {
+			ret = -EINVAL;
+			goto free_pmu;
+		}
+	}
+
+	return 0;
+
+free_pmu:
+	kfree(pmu_ptr);
+	return ret;
+}
+
+static void disable_nest_pmu_counters(void)
+{
+	int nid, cpu;
+	struct cpumask *l_cpumask;
+
+	get_online_cpus();
+	for_each_online_node(nid) {
+		l_cpumask = cpumask_of_node(nid);
+		cpu = cpumask_first(l_cpumask);
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
+				       get_hard_smp_processor_id(cpu));
+	}
+	put_online_cpus();
+}
+
+static void disable_core_pmu_counters(void)
+{
+	cpumask_t cores_map;
+	int cpu, rc;
+
+	get_online_cpus();
+	/* Disable the IMC Core functions */
+	cores_map = cpu_online_cores_map();
+	for_each_cpu(cpu, &cores_map) {
+		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
+					    get_hard_smp_processor_id(cpu));
+		if (rc)
+			pr_err("%s: Failed to stop Core (cpu = %d)\n",
+				__FUNCTION__, cpu);
+	}
+	put_online_cpus();
+}
+
+static int opal_imc_counters_probe(struct platform_device *pdev)
+{
+	struct device_node *imc_dev = pdev->dev.of_node;
+	int pmu_count = 0, domain;
+	u32 type;
+
+	/*
+	 * Check whether this is kdump kernel. If yes, force the engines to
+	 * stop and return.
+	 */
+	if (is_kdump_kernel()) {
+		disable_nest_pmu_counters();
+		disable_core_pmu_counters();
+		return -ENODEV;
+	}
+
+	for_each_compatible_node(imc_dev, NULL, IMC_DTB_UNIT_COMPAT) {
+		if (of_property_read_u32(imc_dev, "type", &type)) {
+			pr_warn("IMC Device without type property\n");
+			continue;
+		}
+
+		switch (type) {
+		case IMC_TYPE_CHIP:
+			domain = IMC_DOMAIN_NEST;
+			break;
+		case IMC_TYPE_CORE:
+			domain =IMC_DOMAIN_CORE;
+			break;
+		case IMC_TYPE_THREAD:
+			domain = IMC_DOMAIN_THREAD;
+			break;
+		default:
+			pr_warn("IMC Unknown Device type \n");
+			domain = -1;
+			break;
+		}
+
+		if (!imc_pmu_create(imc_dev, pmu_count, domain))
+			pmu_count++;
+	}
+
+	return 0;
+}
+
+static void opal_imc_counters_shutdown(struct platform_device *pdev)
+{
+	/*
+	 * Function only stops the engines which is bare minimum.
+	 * TODO: Need to handle proper memory cleanup and pmu
+	 * unregister.
+	 */
+	disable_nest_pmu_counters();
+	disable_core_pmu_counters();
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
+	.shutdown = opal_imc_counters_shutdown,
+};
+
+builtin_platform_driver(opal_imc_driver);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 9b87abb178f0..85a9015c4126 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/slab.h>
@@ -30,6 +31,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/imc-pmu.h>
 
 #include "powernv.h"
 
@@ -720,6 +722,15 @@ static void opal_pdev_init(const char *compatible)
 		of_platform_device_create(np, NULL, NULL);
 }
 
+static void __init opal_imc_init_dev(void)
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
@@ -793,6 +804,9 @@ static int __init opal_init(void)
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
+	/* Detect In-Memory Collection counters and create devices*/
+	opal_imc_init_dev();
+
 	/* Create leds platform devices */
 	leds = of_find_node_by_path("/ibm,opal/leds");
 	if (leds) {
-- 
2.7.4
