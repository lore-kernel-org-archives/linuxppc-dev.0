Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D2F2DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 03:41:54 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SGfqoS007559
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:41:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SGfpaN160792
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:41:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SGfpr0006611
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:41:51 -0700
Received: from dyn9047017100.beaverton.ibm.com
	(dyn9047017100.beaverton.ibm.com [9.47.17.100])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1SGfpPh006582
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:41:51 -0700
Subject: [PATCH 2/3] generic __remove_pages() support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 08:45:06 -0800
Message-Id: <1204217106.28696.13.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Generic helper function to remove section mappings and sysfs entries
for the section of the memory we are removing.  offline_pages() correctly 
adjusted zone and marked the pages reserved.

Issue: If mem_map, usemap allocation could come from different places -
kmalloc, vmalloc, alloc_pages or bootmem. There is no easy way
to find and free up properly. Especially for bootmem, we need to
know which node the allocation came from.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

---
 include/linux/memory_hotplug.h |    4 +++
 mm/memory_hotplug.c            |   44 +++++++++++++++++++++++++++++++++++++++++
 mm/sparse.c                    |   43 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 88 insertions(+), 3 deletions(-)

Index: linux-2.6.25-rc2/mm/memory_hotplug.c
===================================================================
--- linux-2.6.25-rc2.orig/mm/memory_hotplug.c	2008-02-27 12:58:17.000000000 -0800
+++ linux-2.6.25-rc2/mm/memory_hotplug.c	2008-02-27 16:06:50.000000000 -0800
@@ -102,6 +102,21 @@ static int __add_section(struct zone *zo
 	return register_new_memory(__pfn_to_section(phys_start_pfn));
 }
 
+static int __remove_section(struct zone *zone, struct mem_section *ms)
+{
+	int ret = -EINVAL;
+
+	if (!valid_section(ms))
+		return ret;
+
+	ret = unregister_memory_section(ms);
+	if (ret)
+		return ret;
+
+	sparse_remove_one_section(zone, ms);
+	return 0;
+}
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -135,6 +150,35 @@ int __add_pages(struct zone *zone, unsig
 }
 EXPORT_SYMBOL_GPL(__add_pages);
 
+int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
+		 unsigned long nr_pages)
+{
+	unsigned long i, ret = 0;
+	int sections_to_remove;
+	unsigned long flags;
+	struct pglist_data *pgdat = zone->zone_pgdat;
+
+	/*
+	 * We can only remove entire sections
+	 */
+	BUG_ON(phys_start_pfn & ~PAGE_SECTION_MASK);
+	BUG_ON(nr_pages % PAGES_PER_SECTION);
+
+	release_mem_region(phys_start_pfn << PAGE_SHIFT, nr_pages * PAGE_SIZE);
+
+	sections_to_remove = nr_pages / PAGES_PER_SECTION;
+	for (i = 0; i < sections_to_remove; i++) {
+		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
+		pgdat_resize_lock(pgdat, &flags);
+		ret = __remove_section(zone, __pfn_to_section(pfn));
+		pgdat_resize_unlock(pgdat, &flags);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__remove_pages);
+
 static void grow_zone_span(struct zone *zone,
 		unsigned long start_pfn, unsigned long end_pfn)
 {
Index: linux-2.6.25-rc2/mm/sparse.c
===================================================================
--- linux-2.6.25-rc2.orig/mm/sparse.c	2008-02-15 12:57:20.000000000 -0800
+++ linux-2.6.25-rc2/mm/sparse.c	2008-02-27 13:02:51.000000000 -0800
@@ -198,12 +198,13 @@ static unsigned long sparse_encode_mem_m
 }
 
 /*
- * We need this if we ever free the mem_maps.  While not implemented yet,
- * this function is included for parity with its sibling.
+ * Decode mem_map from the coded memmap
  */
-static __attribute((unused))
+static
 struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pnum)
 {
+	/* mask off the extra low bits of information */
+	coded_mem_map &= SECTION_MAP_MASK;
 	return ((struct page *)coded_mem_map) + section_nr_to_pfn(pnum);
 }
 
@@ -363,6 +364,26 @@ static void __kfree_section_memmap(struc
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+static void free_section_usemap(struct page *memmap, unsigned long *usemap)
+{
+	if (!usemap)
+		return;
+
+	/*
+	 * Check to see if allocation came from hot-plug-add
+	 */
+	if (PageSlab(virt_to_page(usemap))) {
+		kfree(usemap);
+		if (memmap)
+			__kfree_section_memmap(memmap, PAGES_PER_SECTION);
+		return;
+	}
+
+	/*
+	 * Allocations came from bootmem - how do I free up ?
+	 */
+}
+
 /*
  * returns the number of sections whose mem_maps were properly
  * set.  If this is <=0, then that means that the passed-in
@@ -415,4 +436,20 @@ out:
 	}
 	return ret;
 }
+
+void sparse_remove_one_section(struct zone *zone, struct mem_section *ms)
+{
+	struct page *memmap = NULL;
+	unsigned long *usemap = NULL;
+
+	if (ms->section_mem_map) {
+		usemap = ms->pageblock_flags;
+		memmap = sparse_decode_mem_map(ms->section_mem_map,
+						__section_nr(ms));
+		ms->section_mem_map = 0;
+		ms->pageblock_flags = NULL;
+	}
+
+	free_section_usemap(memmap, usemap);
+}
 #endif
Index: linux-2.6.25-rc2/include/linux/memory_hotplug.h
===================================================================
--- linux-2.6.25-rc2.orig/include/linux/memory_hotplug.h	2008-02-27 12:58:17.000000000 -0800
+++ linux-2.6.25-rc2/include/linux/memory_hotplug.h	2008-02-27 13:00:04.000000000 -0800
@@ -8,6 +8,7 @@
 struct page;
 struct zone;
 struct pglist_data;
+struct mem_section;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
@@ -64,6 +65,8 @@ extern int offline_pages(unsigned long, 
 /* reasonably generic interface to expand the physical pages in a zone  */
 extern int __add_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages);
+extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages);
 
 /*
  * Walk thorugh all memory which is registered as resource.
@@ -188,5 +191,6 @@ extern int arch_add_memory(int nid, u64 
 extern int remove_memory(u64 start, u64 size);
 extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
 								int nr_pages);
+extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms);
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
