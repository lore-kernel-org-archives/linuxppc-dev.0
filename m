Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E21FDDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 03:43:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SGgr1T010372
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:42:53 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SGgq81181998
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:42:52 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SGgqge003308
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:42:52 -0700
Received: from dyn9047017100.beaverton.ibm.com
	(dyn9047017100.beaverton.ibm.com [9.47.17.100])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1SGgpCY003248
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:42:52 -0700
Subject: [PATCH 3/3] ppc64-specific memory notifier support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 08:46:06 -0800
Message-Id: <1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hotplug memory notifier for ppc64. This gets invoked by writing
the device-node that needs to be removed to /proc/ppc64/ofdt.
We need to adjust the sections and remove sysfs entries by
calling __remove_pages(). Then call arch specific code to
get rid of htab mappings for the section of memory.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/hotplug-memory.c |   98 ++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

Index: linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-02-28 08:20:14.000000000 -0800
@@ -0,0 +1,98 @@
+/*
+ * pseries Memory Hotplug infrastructure.
+ *
+ * Copyright (C) 2008 Badari Pulavarty, IBM Corporation
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/prom.h>
+#include <asm/firmware.h>
+#include <asm/machdep.h>
+#include <asm/pSeries_reconfig.h>
+
+static int pseries_remove_memory(struct device_node *np)
+{
+	const char *type;
+	const unsigned int *my_index;
+	const unsigned int *regs;
+	u64 start_pfn, start;
+	struct zone *zone;
+	int ret = -EINVAL;
+
+	/*
+	 * Check to see if we are actually removing memory
+	 */
+	type = of_get_property(np, "device_type", NULL);
+	if (type == NULL || strcmp(type, "memory") != 0)
+		return 0;
+
+	/*
+	 * Find the memory index and size of the removing section
+	 */
+	my_index = of_get_property(np, "ibm,my-drc-index", NULL);
+	if (!my_index)
+		return ret;
+
+	regs = of_get_property(np, "reg", NULL);
+	if (!regs)
+		return ret;
+
+	start_pfn = section_nr_to_pfn(*my_index & 0xffff);
+	zone = page_zone(pfn_to_page(start_pfn));
+
+	/*
+	 * Remove section mappings and sysfs entries for the
+	 * section of the memory we are removing.
+	 *
+	 * NOTE: Ideally, this should be done in generic code like
+	 * remove_memory(). But remove_memory() gets called by writing
+	 * to sysfs "state" file and we can't remove sysfs entries
+	 * while writing to it. So we have to defer it to here.
+	 */
+	ret = __remove_pages(zone, start_pfn, regs[3] >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Remove htab bolted mappings for this section of memory
+	 */
+ 	start = (unsigned long)__va(start_pfn << PAGE_SHIFT);
+ 	ret = remove_section_mapping(start, start + regs[3]);
+	return ret;
+}
+
+static int pseries_memory_notifier(struct notifier_block *nb,
+				unsigned long action, void *node)
+{
+	int err = NOTIFY_OK;
+
+	switch (action) {
+	case PSERIES_RECONFIG_ADD:
+		break;
+	case PSERIES_RECONFIG_REMOVE:
+		if (pseries_remove_memory(node))
+			err = NOTIFY_BAD;
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block pseries_smp_nb = {
+	.notifier_call = pseries_memory_notifier,
+};
+
+static int __init pseries_memory_hotplug_init(void)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		pSeries_reconfig_notifier_register(&pseries_smp_nb);
+
+	return 0;
+}
+arch_initcall(pseries_memory_hotplug_init);
Index: linux-2.6.25-rc2/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- linux-2.6.25-rc2.orig/arch/powerpc/platforms/pseries/Makefile	2008-02-28 08:15:53.000000000 -0800
+++ linux-2.6.25-rc2/arch/powerpc/platforms/pseries/Makefile	2008-02-28 08:17:57.000000000 -0800
@@ -14,6 +14,7 @@ obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PCI_MSI)	+= msi.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
+obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
 
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
