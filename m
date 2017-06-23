Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvBWl5llQzDqvS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 18:32:03 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w12so6444279pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 01:32:03 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bsingharora@gmail.com,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v3 3/6] powerpc/vmemmap: Add altmap support
Date: Fri, 23 Jun 2017 18:31:19 +1000
Message-Id: <20170623083122.5992-3-oohall@gmail.com>
In-Reply-To: <20170623083122.5992-1-oohall@gmail.com>
References: <20170623083122.5992-1-oohall@gmail.com>
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

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/init_64.c | 15 +++++++++++++--
 arch/powerpc/mm/mem.c     | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 8851e4f5dbab..225fbb8034e6 100644
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
 
@@ -242,6 +247,8 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
 
 	for (; start < end; start += page_size) {
 		unsigned long nr_pages, addr;
+		struct vmem_altmap *altmap;
+		struct page *section_base;
 		struct page *page;
 
 		/*
@@ -257,9 +264,13 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
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
index 9ee536ec0739..2c0c16f11eee 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/memremap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -159,11 +160,20 @@ int arch_remove_memory(u64 start, u64 size)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct zone *zone;
+	struct vmem_altmap *altmap;
+	struct page *page;
 	int ret;
 
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
2.9.4
