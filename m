Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWV5dVzzDr2Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:30 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CBA593578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:27 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UJ9b38600820
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436TsKq023413
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:55 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 7/7] TEST: Driver to test device memory through ZONE_DEVICE
Date: Tue,  3 May 2016 11:59:26 +0530
Message-Id: <1462256966-19321-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an example driver with little bit of kernel hack to test
ZONE_DEVICE based device memory management on POWER.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c               |  12 ++-
 arch/powerpc/platforms/pseries/Makefile |   2 +-
 arch/powerpc/platforms/pseries/rmem.c   | 186 ++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/rmem.c

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index db73708..5cc286d 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -351,6 +351,17 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+void dump_vmemmap(void)
+{
+	struct vmemmap_backing *vmem_back = vmemmap_list;
+
+	for (; vmem_back; vmem_back = vmem_back->list) {
+		printk("RMEM: vmemmap backing (%lx %lx)\n",
+			vmem_back->virt_addr, vmem_back->phys);
+	}
+}
+EXPORT_SYMBOL(dump_vmemmap);
+
 static unsigned long vmemmap_list_free(unsigned long start)
 {
 	struct vmemmap_backing *vmem_back, *vmem_back_prev;
@@ -482,5 +493,4 @@ struct page *realmode_pfn_to_page(unsigned long pfn)
 	return page;
 }
 EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
-
 #endif /* CONFIG_SPARSEMEM_VMEMMAP/CONFIG_FLATMEM */
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index fedc2ccf0..20a5e23 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -5,7 +5,7 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   of_helpers.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o rng.o \
-			   pci.o pci_dlpar.o eeh_pseries.o msi.o
+			   pci.o pci_dlpar.o eeh_pseries.o msi.o rmem.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
diff --git a/arch/powerpc/platforms/pseries/rmem.c b/arch/powerpc/platforms/pseries/rmem.c
new file mode 100644
index 0000000..8c2287a
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/rmem.c
@@ -0,0 +1,186 @@
+/*
+ * Copyright (C) 2016 Anshuman Khandual (khandual@linux.vnet.ibm.com)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/gfp.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/memremap.h>
+
+#include <asm/firmware.h>
+#include <asm/hvcall.h>
+#include <asm/mmu.h>
+#include <asm/pgalloc.h>
+#include <asm/uaccess.h>
+#include <linux/memory.h>
+#include <asm/plpar_wrappers.h>
+#include <asm/prom.h>
+
+#define DEVM_MAP_SIZE (1UL << PA_SECTION_SHIFT) * 8
+
+extern void dump_vmemmap(void);
+extern struct resmem rmem;
+
+unsigned long devmem_start;
+unsigned long devmem_end;
+
+void driver_test_devmem(void)
+{
+	unsigned long i;
+	unsigned long start = devmem_start >> PAGE_SHIFT;
+	unsigned long end = devmem_end >> PAGE_SHIFT;
+
+	for(i = start; i < end; i++)
+		*(unsigned long *)i = (char)i;
+
+	for(i = start; i < end; i++) {
+		if (*(unsigned long *)i != (char)i)
+			printk("RMEM: Error data miscompare at %lx\n", i);
+	}
+	printk("RMEM: Data integrity test successful\n");
+}
+
+void driver_memory(unsigned long start_pfn, unsigned long end_pfn)
+{
+	printk("RMEM: Driver now owns PFN(%lx....%lx)\n", start_pfn, end_pfn);
+
+	devmem_start = start_pfn;
+	devmem_end = end_pfn;
+	driver_test_devmem();
+}
+
+static void dump_reserved(void)
+{
+	unsigned long i;
+
+	printk("RMEM: Reserved memory sections\n");
+	for (i = 0; i < rmem.nr; i++) {
+		printk("RMEM: Base %llx Size: %llx Node: %llu\n",
+			rmem.mem[i][MEM_BASE], rmem.mem[i][MEM_SIZE],
+			rmem.mem[i][MEM_NODE]);
+	}
+}
+
+static void dump_devmap(resource_size_t start)
+{
+	struct vmem_altmap *altmap;
+	struct dev_pagemap *pgmap;
+	struct page_map *pmap;
+	struct page *page;
+	unsigned long pfn;
+
+	altmap = to_vmem_altmap((unsigned long)pfn_to_page(start >> PAGE_SHIFT));
+	if (altmap) {
+		printk("RMEM: altmap->base_pfn %lu\n", altmap->base_pfn);
+		printk("RMEM: altmap->reserve %lu\n", altmap->reserve);
+		printk("RMEM: altmap->free %lu\n", altmap->free);
+		printk("RMEM: altmap->align %lu\n", altmap->align);
+		printk("RMEM: altmap->alloc %lu\n", altmap->alloc);
+	}
+	pmap = find_pagemap(start);
+	rcu_read_lock();
+	pgmap = find_dev_pagemap(start);
+	rcu_read_unlock();
+	printk("RMEM: pagemap		(%lx)\n", (unsigned long)pmap);
+	printk("RMEM: dev_pagemap	(%lx)\n", (unsigned long)pgmap);
+	printk("RMEM: pfn range (%lx %lx)\n", pfn_first(pmap), pfn_end(pmap));
+
+	for (pfn = pfn_first(pmap); pfn < pfn_end(pmap); pfn++) {
+		page = pfn_to_page(pfn);
+		printk("DEVM: pfn(%lx) page(%lx) pagemap(%lx) flags(%lx)\n",
+			pfn, (unsigned long)page, (unsigned long)page->pgmap,
+			page->flags);
+	}
+	driver_memory(pfn_first(pmap), pfn_end(pmap));
+}
+
+static void simple_translation_test(void __pmem *vaddr)
+{
+	unsigned long i;
+
+	if (vaddr) {
+		unsigned long tmp;
+	
+		for (i = 0; i < DEVM_MAP_SIZE; i++)
+			tmp = *((unsigned long *)vaddr + i);
+
+		printk("RMEM: Read access complete (%lx %lx)\n",
+				(unsigned long)vaddr, DEVM_MAP_SIZE);
+	}
+}
+
+static int rmem_init(void)
+{
+	struct class *class;
+	struct device *dev;
+	struct resource *res;
+	struct percpu_ref *ref;
+	void __pmem *vaddr;
+	struct vmem_altmap *altmap;
+	struct vmem_altmap __altmap = {
+		.base_pfn = rmem.mem[0][0] >> PAGE_SHIFT,
+		.reserve = 0,
+		.free = 0x100,
+		.alloc = 0,
+		.align = 0,
+	};
+
+	printk("RMEM: Driver loaded\n");
+	dump_reserved();
+
+	class = class_create(THIS_MODULE, "rmem");
+	if (!class) {
+		printk("RMEM: class_create() failed\n");
+		goto out;
+	}
+
+	dev = device_create(class, NULL, MKDEV(100, 100), NULL, "rmem");
+	if (!dev) {
+		printk("RMEM: device_create() failed\n");
+		goto out;
+	}
+
+	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		printk("RMEM: devm_kzalloc() failed\n");
+		goto out;
+	}
+
+	ref = devm_kzalloc(dev, sizeof(*ref), GFP_KERNEL);
+	if (!res) {
+		printk("RMEM: devm_kzalloc() failed\n");
+		goto out;
+	}
+
+	dump_vmemmap();
+	altmap = &__altmap;
+	res->start = rmem.mem[0][0];
+	res->end = rmem.mem[0][0] + DEVM_MAP_SIZE;
+	vaddr = devm_memremap_pages(dev, res, ref, altmap);
+	dump_vmemmap();
+	
+	simple_translation_test(vaddr);
+	dump_devmap(res->start);
+	return 0;
+out:
+	return -1;
+}
+
+static void rmem_exit(void)
+{
+	printk("RMEM: rmem driver unloaded\n");
+}
+
+module_init(rmem_init);
+module_exit(rmem_exit);
+
+MODULE_AUTHOR("Anshuman Khandual <khandual@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("Test driver for device memory");
+MODULE_LICENSE("GPL");
-- 
1.8.3.1
