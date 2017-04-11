Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2ZCK30PWzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:43:09 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 79so696146pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:43:09 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, bsingharora@gmail.com, linux-nvdimm@lists.01.org,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 5/9] powerpc/vmemmap: Add altmap support
Date: Wed, 12 Apr 2017 03:42:29 +1000
Message-Id: <20170411174233.21902-6-oohall@gmail.com>
In-Reply-To: <20170411174233.21902-1-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support to powerpc for the altmap feature of ZONE_DEVICE memory. An
altmap is a driver provided region that is used to provide the backing
storage for the struct pages of ZONE_DEVICE memory. In situations where
large amount of ZONE_DEVICE memory is being added to the system the
altmap reduces pressure on main system memory by allowing the mm/
metadata to be stored on the device itself rather in main memory.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/init_64.c | 20 +++++++++++++++-----
 arch/powerpc/mm/mem.c     | 16 +++++++++++++---
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index f8124edb6ffa..225fbb8034e6 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/memremap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -171,13 +172,17 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
 
 	for (; start < end; start += page_size) {
+		struct vmem_altmap *altmap;
 		void *p;
 		int rc;
 
 		if (vmemmap_populated(start, page_size))
 			continue;
 
-		p = vmemmap_alloc_block(page_size, node);
+		/* altmap lookups only work at section boundaries */
+		altmap = to_vmem_altmap(SECTION_ALIGN_DOWN(start));
+
+		p =  __vmemmap_alloc_block_buf(page_size, node, altmap);
 		if (!p)
 			return -ENOMEM;
 
@@ -241,9 +246,10 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
 
 	for (; start < end; start += page_size) {
-		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
-		unsigned int nr_pages;
-		unsigned long addr;
+		unsigned long nr_pages, addr;
+		struct vmem_altmap *altmap;
+		struct page *section_base;
+		struct page *page;
 
 		/*
 		 * the section has already be marked as invalid, so
@@ -258,9 +264,13 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
 			continue;
 
 		page = pfn_to_page(addr >> PAGE_SHIFT);
+		section_base = pfn_to_page(vmemmap_section_start(start));
 		nr_pages = 1 << page_order;
 
-		if (PageReserved(page)) {
+		altmap = to_vmem_altmap((unsigned long) section_base);
+		if (altmap) {
+			vmem_altmap_free(altmap, nr_pages);
+		} else if (PageReserved(page)) {
 			/* allocated from bootmem */
 			if (page_size < PAGE_SIZE) {
 				/*
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3bbba178b464..6f7b64eaa9d8 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/memremap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -176,7 +177,8 @@ int arch_remove_memory(u64 start, u64 size, enum memory_type type)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct zone *zone;
+	struct vmem_altmap *altmap;
+	struct page *page;
 	int ret;
 
 	/*
@@ -193,8 +195,16 @@ int arch_remove_memory(u64 start, u64 size, enum memory_type type)
 		return -EINVAL;
 	}
 
-	zone = page_zone(pfn_to_page(start_pfn));
-	ret = __remove_pages(zone, start_pfn, nr_pages);
+	/*
+	 * If we have an altmap then we need to skip over any reserved PFNs
+	 * when querying the zone.
+	 */
+	page = pfn_to_page(start_pfn);
+	altmap = to_vmem_altmap((unsigned long) page);
+	if (altmap)
+		page += vmem_altmap_offset(altmap);
+
+	ret = __remove_pages(page_zone(page), start_pfn, nr_pages);
 	if (ret)
 		return ret;
 
-- 
2.9.3
