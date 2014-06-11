Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425E61A089F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:24:08 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 13:54:05 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8A346E0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:55:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8OtIe56426568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:54:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B8O0Iu018241
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:54:01 +0530
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc: implement vmemmap_free()
Date: Wed, 11 Jun 2014 16:23:38 +0800
Message-Id: <1402475019-19699-3-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vmemmap_free() does the opposite of vmemap_populate().
This patch also puts vmemmap_free() and vmemmap_list_free() into
 CONFIG_MEMMORY_HOTPLUG.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c |   85 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 69203c8..4963790 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -298,6 +298,37 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
 	vmemmap_list = vmem_back;
 }
 
+int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
+{
+	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
+
+	/* Align to the page size of the linear mapping. */
+	start = _ALIGN_DOWN(start, page_size);
+
+	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
+
+	for (; start < end; start += page_size) {
+		void *p;
+
+		if (vmemmap_populated(start, page_size))
+			continue;
+
+		p = vmemmap_alloc_block(page_size, node);
+		if (!p)
+			return -ENOMEM;
+
+		vmemmap_list_populate(__pa(p), start, node);
+
+		pr_debug("      * %016lx..%016lx allocated at %p\n",
+			 start, start + page_size, p);
+
+		vmemmap_create_mapping(start, page_size, __pa(p));
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
 static unsigned long vmemmap_list_free(unsigned long start)
 {
 	struct vmemmap_backing *vmem_back, *vmem_back_prev;
@@ -330,40 +361,52 @@ static unsigned long vmemmap_list_free(unsigned long start)
 	return vmem_back->phys;
 }
 
-int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
+void __ref vmemmap_free(unsigned long start, unsigned long end)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 
-	/* Align to the page size of the linear mapping. */
 	start = _ALIGN_DOWN(start, page_size);
 
-	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
+	pr_debug("vmemmap_free %lx...%lx\n", start, end);
 
 	for (; start < end; start += page_size) {
-		void *p;
+		unsigned long addr;
 
+		/*
+		 * the section has already be marked as invalid, so
+		 * vmemmap_populated() true means some other sections still
+		 * in this page, so skip it.
+		 */
 		if (vmemmap_populated(start, page_size))
 			continue;
 
-		p = vmemmap_alloc_block(page_size, node);
-		if (!p)
-			return -ENOMEM;
-
-		vmemmap_list_populate(__pa(p), start, node);
-
-		pr_debug("      * %016lx..%016lx allocated at %p\n",
-			 start, start + page_size, p);
-
-		vmemmap_create_mapping(start, page_size, __pa(p));
+		addr = vmemmap_list_free(start);
+		if (addr) {
+			struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
+
+			if (PageReserved(page)) {
+				/* allocated from bootmem */
+				if (page_size < PAGE_SIZE) {
+					/*
+					 * this shouldn't happen, but if it is
+					 * the case, leave the memory there
+					 */
+					WARN_ON_ONCE(1);
+				} else {
+					unsigned int nr_pages =
+						1 << get_order(page_size);
+					while (nr_pages--)
+						free_reserved_page(page++);
+				}
+			} else
+				free_pages((unsigned long)(__va(addr)),
+							get_order(page_size));
+
+			vmemmap_remove_mapping(start, page_size);
+		}
 	}
-
-	return 0;
-}
-
-void vmemmap_free(unsigned long start, unsigned long end)
-{
 }
-
+#endif
 void register_page_bootmem_memmap(unsigned long section_nr,
 				  struct page *start_page, unsigned long size)
 {
-- 
1.7.9.5
