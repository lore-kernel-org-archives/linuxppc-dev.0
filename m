Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w2K9L0YlSzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 17:55:34 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, #@ozlabs.ru,
 v4.9+@ozlabs.ru
Subject: [PATCH kernel v2] powerpc/iommu: Do not call PageTransHuge() on tail
 pages
Date: Tue, 11 Apr 2017 17:54:57 +1000
Message-Id: <20170411075457.28020-1-aik@ozlabs.ru>
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
it is designed to be called on head pages only. Since we also test for
PageCompound(), and it contains PageTail() and PageHead(), we can
simplify the check by leaving just PageCompound() and therefore avoid
possible VM_BUG_ON_PAGE.

Fixes: 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate pinned pages out of CMA")
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Balbir Singh <bsingharora@gmail.com>
---

Changes:
v2:
* instead of moving PageCompound() to the beginning, this just drops
PageHuge() and PageTransHuge()

---
 arch/powerpc/mm/mmu_context_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 497130c5c742..96f835cbf212 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -81,7 +81,7 @@ struct page *new_iommu_non_cma_page(struct page *page, unsigned long private,
 	gfp_t gfp_mask = GFP_USER;
 	struct page *new_page;
 
-	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
+	if (PageCompound(page))
 		return NULL;
 
 	if (PageHighMem(page))
@@ -100,7 +100,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
 	LIST_HEAD(cma_migrate_pages);
 
 	/* Ignore huge pages for now */
-	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
+	if (PageCompound(page))
 		return -EBUSY;
 
 	lru_add_drain();
-- 
2.11.0
