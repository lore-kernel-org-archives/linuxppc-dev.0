Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2ZCG3RJ6zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:43:06 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g2so674704pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:43:06 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, bsingharora@gmail.com, linux-nvdimm@lists.01.org,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 4/9] powerpc/mm: Reshuffle vmemmap_free()
Date: Wed, 12 Apr 2017 03:42:28 +1000
Message-Id: <20170411174233.21902-5-oohall@gmail.com>
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

Removes an indentation level and shuffles some code around to make the
following patch cleaner. No functional changes.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/init_64.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index ec84b31c6c86..f8124edb6ffa 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -234,12 +234,15 @@ static unsigned long vmemmap_list_free(unsigned long start)
 void __ref vmemmap_free(unsigned long start, unsigned long end)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
+	unsigned long page_order = get_order(page_size);
 
 	start = _ALIGN_DOWN(start, page_size);
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
 
 	for (; start < end; start += page_size) {
+		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
+		unsigned int nr_pages;
 		unsigned long addr;
 
 		/*
@@ -251,29 +254,29 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
 			continue;
 
 		addr = vmemmap_list_free(start);
-		if (addr) {
-			struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
-
-			if (PageReserved(page)) {
-				/* allocated from bootmem */
-				if (page_size < PAGE_SIZE) {
-					/*
-					 * this shouldn't happen, but if it is
-					 * the case, leave the memory there
-					 */
-					WARN_ON_ONCE(1);
-				} else {
-					unsigned int nr_pages =
-						1 << get_order(page_size);
-					while (nr_pages--)
-						free_reserved_page(page++);
-				}
-			} else
-				free_pages((unsigned long)(__va(addr)),
-							get_order(page_size));
-
-			vmemmap_remove_mapping(start, page_size);
+		if (!addr)
+			continue;
+
+		page = pfn_to_page(addr >> PAGE_SHIFT);
+		nr_pages = 1 << page_order;
+
+		if (PageReserved(page)) {
+			/* allocated from bootmem */
+			if (page_size < PAGE_SIZE) {
+				/*
+				 * this shouldn't happen, but if it is
+				 * the case, leave the memory there
+				 */
+				WARN_ON_ONCE(1);
+			} else {
+				while (nr_pages--)
+					free_reserved_page(page++);
+			}
+		} else {
+			free_pages((unsigned long)(__va(addr)), page_order);
 		}
+
+		vmemmap_remove_mapping(start, page_size);
 	}
 }
 #endif
-- 
2.9.3
