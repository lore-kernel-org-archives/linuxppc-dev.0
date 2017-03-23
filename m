Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq22R0g16zDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 09:55:26 +1100 (AEDT)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.or
Subject: [v1 4/5] mm: zero struct pages during initialization
Date: Thu, 23 Mar 2017 19:01:52 -0400
Message-Id: <1490310113-824438-5-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
References: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When deferred struct page initialization is enabled, do not expect that
the memory that was allocated for struct pages was zeroed by the
allocator. Zero it when "struct pages" are initialized.

Also, a defined boolean VMEMMAP_ZERO is provided to tell platforms whether
they should zero memory or can deffer it.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 include/linux/mm.h |    9 +++++++++
 mm/page_alloc.c    |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 54df194..eb052f6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2427,6 +2427,15 @@ int vmemmap_populate_basepages(unsigned long start, unsigned long end,
 #ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end);
 #endif
+/*
+ * Don't zero "struct page"es during early boot, and zero only when they are
+ * initialized in parallel.
+ */
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+#define VMEMMAP_ZERO	false
+#else
+#define VMEMMAP_ZERO	true
+#endif
 void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
 				  unsigned long size);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f202f8b..02945e4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1168,6 +1168,9 @@ static void free_one_page(struct zone *zone,
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+	memset(page, 0, sizeof(struct page));
+#endif
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
-- 
1.7.1
