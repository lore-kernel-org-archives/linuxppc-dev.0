Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wy4zn4WJSzDr3d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 11:32:53 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id z6so6851952pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 18:32:53 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v4 2/6] powerpc/vmemmap: Reshuffle vmemmap_free()
Date: Wed, 28 Jun 2017 11:32:32 +1000
Message-Id: <20170628013236.413-2-oohall@gmail.com>
In-Reply-To: <20170628013236.413-1-oohall@gmail.com>
References: <20170628013236.413-1-oohall@gmail.com>
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

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v1 -> v2: Remove broken initialiser
---
 arch/powerpc/mm/init_64.c | 48 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index ec84b31c6c86..8851e4f5dbab 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -234,13 +234,15 @@ static unsigned long vmemmap_list_free(unsigned long start)
 void __ref vmemmap_free(unsigned long start, unsigned long end)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
+	unsigned long page_order = get_order(page_size);
 
 	start = _ALIGN_DOWN(start, page_size);
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
 
 	for (; start < end; start += page_size) {
-		unsigned long addr;
+		unsigned long nr_pages, addr;
+		struct page *page;
 
 		/*
 		 * the section has already be marked as invalid, so
@@ -251,29 +253,29 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
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
2.9.4
