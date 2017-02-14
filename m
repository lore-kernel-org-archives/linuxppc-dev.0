Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN1hw2XD4zDqqQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:20:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Fix build break when CMA=n && SPAPR_TCE_IOMMU=y
Date: Tue, 14 Feb 2017 23:20:26 +1100
Message-Id: <1487074826-17027-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the build breaks if CMA=n and SPAPR_TCE_IOMMU=y:

  arch/powerpc/mm/mmu_context_iommu.c: In function ‘mm_iommu_get’:
  arch/powerpc/mm/mmu_context_iommu.c:193:42: error: ‘MIGRATE_CMA’ undeclared (first use in this function)
  if (get_pageblock_migratetype(page) == MIGRATE_CMA) {
  ^~~~~~~~~~~

Fix it by using the existing is_migrate_cma_page(), which evaulates to
false when CMA=n.

Fixes: 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate pinned pages out of CMA")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/mmu_context_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 104bad029ce9..7de7124ac91b 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -184,7 +184,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		 * of the CMA zone if possible. NOTE: faulting in + migration
 		 * can be expensive. Batching can be considered later
 		 */
-		if (get_pageblock_migratetype(page) == MIGRATE_CMA) {
+		if (is_migrate_cma_page(page)) {
 			if (mm_iommu_move_page_from_cma(page))
 				goto populate;
 			if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
-- 
2.7.4
