Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E41C82C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 03:54:14 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 27 Jan 2014 22:24:11 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B4BBF1258051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 22:25:52 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0RGs6Q546924024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 22:24:07 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0RGs8C2007196
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 22:24:08 +0530
Received: from localhost.localdomain (dhcp-9-41-149-101.austin.ibm.com
 [9.41.149.101])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s0RGs7jw007095
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 22:24:08 +0530
Message-ID: <52E68F2E.4030907@linux.vnet.ibm.com>
Date: Mon, 27 Jan 2014 10:54:06 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/pseries Use remove_memory() to remove memory
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The memory remove code for powerpc/pseries should call remove_memory()
so that we are holding the hotplug_memory lock during memory remove
operations.

This patch updates the memory node remove handler to call remove_memory()
and adds a ppc_md.remove_memory() entry to handle pseries specific work
that is called from arch_remove_memory().

During memory remove in pseries_remove_memblock() we have to stay with
removing memory one section at a time. This is needed because of how memory
resources are handled. During memory add for pseries (via the probe file in
sysfs) we add memory one section at a time which gives us a memory resource
for each section. Future patches will aim to address this so will not have
to remove memory one section at a time.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h              |    4 +
 arch/powerpc/mm/mem.c                           |    7 +
 arch/powerpc/platforms/pseries/hotplug-memory.c |   85 +++++++++++-------------
 3 files changed, 50 insertions(+), 46 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2014-01-27 08:47:19.000000000 -0600
+++ powerpc/arch/powerpc/platforms/pseries/hotplug-memory.c	2014-01-27 09:21:54.000000000 -0600
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
+#include <linux/memory_hotplug.h>
 
 #include <asm/firmware.h>
 #include <asm/machdep.h>
@@ -75,13 +76,27 @@
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
+static int pseries_remove_memory(u64 start, u64 size)
 {
-	unsigned long start, start_pfn;
-	struct zone *zone;
 	int ret;
-	unsigned long section;
-	unsigned long sections_to_remove;
+
+	/* Remove htab bolted mappings for this section of memory */
+	start = (unsigned long)__va(start);
+	ret = remove_section_mapping(start, start + size);
+
+	/* Ensure all vmalloc mappings are flushed in case they also
+	 * hit that section of memory
+	 */
+	vm_unmap_aliases();
+
+	return ret;
+}
+
+static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
+{
+	unsigned long block_sz, start_pfn;
+	int sections_per_block;
+	int i, nid;
 
 	start_pfn = base >> PAGE_SHIFT;
 
@@ -90,45 +105,21 @@
 		return 0;
 	}
 
-	zone = page_zone(pfn_to_page(start_pfn));
-
-	/*
-	 * Remove section mappings and sysfs entries for the
-	 * section of the memory we are removing.
-	 *
-	 * NOTE: Ideally, this should be done in generic code like
-	 * remove_memory(). But remove_memory() gets called by writing
-	 * to sysfs "state" file and we can't remove sysfs entries
-	 * while writing to it. So we have to defer it to here.
-	 */
-	sections_to_remove = (memblock_size >> PAGE_SHIFT) / PAGES_PER_SECTION;
-	for (section = 0; section < sections_to_remove; section++) {
-		unsigned long pfn = start_pfn + section * PAGES_PER_SECTION;
-		ret = __remove_pages(zone, pfn, PAGES_PER_SECTION);
-		if (ret)
-			return ret;
+	block_sz = memory_block_size_bytes();
+	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
+	nid = memory_add_physaddr_to_nid(base);
+
+	for (i = 0; i < sections_per_block; i++) {
+		remove_memory(nid, base, MIN_MEMORY_BLOCK_SIZE);
+		base += MIN_MEMORY_BLOCK_SIZE;
 	}
 
-	/*
-	 * Update memory regions for memory remove
-	 */
+	/* Update memory regions for memory remove */
 	memblock_remove(base, memblock_size);
-
-	/*
-	 * Remove htab bolted mappings for this section of memory
-	 */
-	start = (unsigned long)__va(base);
-	ret = remove_section_mapping(start, start + memblock_size);
-
-	/* Ensure all vmalloc mappings are flushed in case they also
-	 * hit that section of memory
-	 */
-	vm_unmap_aliases();
-
-	return ret;
+	return 0;
 }
 
-static int pseries_remove_memory(struct device_node *np)
+static int pseries_remove_mem_node(struct device_node *np)
 {
 	const char *type;
 	const unsigned int *regs;
@@ -153,8 +144,8 @@
 	base = *(unsigned long *)regs;
 	lmb_size = regs[3];
 
-	ret = pseries_remove_memblock(base, lmb_size);
-	return ret;
+	pseries_remove_memblock(base, lmb_size);
+	return 0;
 }
 #else
 static inline int pseries_remove_memblock(unsigned long base,
@@ -162,13 +153,13 @@
 {
 	return -EOPNOTSUPP;
 }
-static inline int pseries_remove_memory(struct device_node *np)
+static inline int pseries_remove_mem_node(struct device_node *np)
 {
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int pseries_add_memory(struct device_node *np)
+static int pseries_add_mem_node(struct device_node *np)
 {
 	const char *type;
 	const unsigned int *regs;
@@ -254,10 +245,10 @@
 
 	switch (action) {
 	case OF_RECONFIG_ATTACH_NODE:
-		err = pseries_add_memory(node);
+		err = pseries_add_mem_node(node);
 		break;
 	case OF_RECONFIG_DETACH_NODE:
-		err = pseries_remove_memory(node);
+		err = pseries_remove_mem_node(node);
 		break;
 	case OF_RECONFIG_UPDATE_PROPERTY:
 		pr = (struct of_prop_reconfig *)node;
@@ -277,6 +268,10 @@
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		of_reconfig_notifier_register(&pseries_mem_nb);
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	ppc_md.remove_memory = pseries_remove_memory;
+#endif
+
 	return 0;
 }
 machine_device_initcall(pseries, pseries_memory_hotplug_init);
Index: powerpc/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/machdep.h	2014-01-27 08:47:18.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/machdep.h	2014-01-27 08:48:31.000000000 -0600
@@ -279,6 +279,10 @@
 #ifdef CONFIG_ARCH_RANDOM
 	int (*get_random_long)(unsigned long *v);
 #endif
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	int (*remove_memory)(u64, u64);
+#endif
 };
 
 extern void e500_idle(void);
Index: powerpc/arch/powerpc/mm/mem.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/mem.c	2014-01-27 08:47:18.000000000 -0600
+++ powerpc/arch/powerpc/mm/mem.c	2014-01-27 08:48:31.000000000 -0600
@@ -139,9 +139,14 @@
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct zone *zone;
+	int ret;
 
 	zone = page_zone(pfn_to_page(start_pfn));
-	return __remove_pages(zone, start_pfn, nr_pages);
+	ret = __remove_pages(zone, start_pfn, nr_pages);
+	if (!ret && (ppc_md.remove_memory))
+		ret = ppc_md.remove_memory(start, size);
+
+	return ret;
 }
 #endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
