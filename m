Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vsfWL2xHgzDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 16:26:04 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Balbir Singh <bsingharora@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH kernel] powerpc/iommu: Do not call PageTransHuge() on tail
 pages
Date: Tue, 28 Mar 2017 16:25:59 +1100
Message-Id: <20170328052559.12912-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CMA pages migration code does not support compound pages at
the moment so it performs few tests before proceeding to actual page
migration.

One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
it should be called on head pages. Since we also test for PageCompound(),
and it contains PageTail(), we can simply move PageCompound() in front
of PageTransHuge() and therefore avoid possible VM_BUG_ON_PAGE.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Some of actual POWER8 systems do crash on that BUG_ON.
---
 arch/powerpc/mm/mmu_context_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 497130c5c742..ba7fccf993b3 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -81,7 +81,7 @@ struct page *new_iommu_non_cma_page(struct page *page, unsigned long private,
 	gfp_t gfp_mask = GFP_USER;
 	struct page *new_page;
 
-	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
+	if (PageCompound(page) || PageHuge(page) || PageTransHuge(page))
 		return NULL;
 
 	if (PageHighMem(page))
@@ -100,7 +100,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
 	LIST_HEAD(cma_migrate_pages);
 
 	/* Ignore huge pages for now */
-	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
+	if (PageCompound(page) || PageHuge(page) || PageTransHuge(page))
 		return -EBUSY;
 
 	lru_add_drain();
-- 
2.11.0
