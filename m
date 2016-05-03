Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWR57FDzDqml
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:27 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 198682CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:25 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UHNf57213048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:24 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436TqxP023305
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:52 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 5/7] mm/memremap: Export pfn_first, pfn_end,
 find_pagemap functions
Date: Tue,  3 May 2016 11:59:24 +0530
Message-Id: <1462256966-19321-6-git-send-email-khandual@linux.vnet.ibm.com>
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

This change exports two existing functions pfn_first, pfn_end and also
defines a new one called find_pagemap. These functions are required to
navigate through the memory which is hotplugged into the ZONE_DEVICE as
device memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 include/linux/memremap.h | 18 ++++++++++++++++++
 kernel/memremap.c        | 15 +++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index bcaa634..b193044 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -28,11 +28,29 @@ void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
 
 #if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_ZONE_DEVICE)
 struct vmem_altmap *to_vmem_altmap(unsigned long memmap_start);
+struct page_map *find_pagemap(resource_size_t phys);
+unsigned long pfn_first(struct page_map *pgmap);
+unsigned long pfn_end(struct page_map *pgmap);
 #else
 static inline struct vmem_altmap *to_vmem_altmap(unsigned long memmap_start)
 {
 	return NULL;
 }
+
+static inline struct page_map *find_pagemap(resource_size_t phys)
+{
+	return NULL;
+}
+
+unsigned long pfn_first(struct page_map *pgmap)
+{
+	return 0;
+}
+
+unsigned long pfn_end(struct page_map *pgmap)
+{
+	return 0;
+}
 #endif
 
 /**
diff --git a/kernel/memremap.c b/kernel/memremap.c
index a6d3823..3c21051 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -207,7 +207,7 @@ static void pgmap_radix_release(struct resource *res)
 	mutex_unlock(&pgmap_lock);
 }
 
-static unsigned long pfn_first(struct page_map *page_map)
+unsigned long pfn_first(struct page_map *page_map)
 {
 	struct dev_pagemap *pgmap = &page_map->pgmap;
 	const struct resource *res = &page_map->res;
@@ -220,7 +220,7 @@ static unsigned long pfn_first(struct page_map *page_map)
 	return pfn;
 }
 
-static unsigned long pfn_end(struct page_map *page_map)
+unsigned long pfn_end(struct page_map *page_map)
 {
 	const struct resource *res = &page_map->res;
 
@@ -262,6 +262,17 @@ struct dev_pagemap *find_dev_pagemap(resource_size_t phys)
 	return page_map ? &page_map->pgmap : NULL;
 }
 
+struct page_map *find_pagemap(resource_size_t phys)
+{
+	struct page_map *page_map;
+
+	rcu_read_lock();
+	page_map = radix_tree_lookup(&pgmap_radix, phys >> PA_SECTION_SHIFT);
+	rcu_read_unlock();
+
+	return page_map;
+}
+
 /**
  * devm_memremap_pages - remap and provide memmap backing for the given resource
  * @dev: hosting device for @res
-- 
1.8.3.1
