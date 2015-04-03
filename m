Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD47E1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 14:11:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/cell: Fix cell iommu after it_page_shift changes
Date: Fri,  3 Apr 2015 14:11:54 +1100
Message-Id: <1428030714-24989-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1428030714-24989-1-git-send-email-mpe@ellerman.id.au>
References: <1428030714-24989-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch to add it_page_shift incorrectly changed the increment of
uaddr to use it_page_shift, rather then (1 << it_page_shift).

This broke booting on at least some Cell blades, as the iommu was
basically non-functional.

Fixes: 3a553170d35d ("powerpc/iommu: Add it_page_shift field to determine iommu page size")
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index c7c8720aa39f..63db1b03e756 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -197,7 +197,7 @@ static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 
 	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
 
-	for (i = 0; i < npages; i++, uaddr += tbl->it_page_shift)
+	for (i = 0; i < npages; i++, uaddr += (1 << tbl->it_page_shift))
 		io_pte[i] = base_pte | (__pa(uaddr) & CBE_IOPTE_RPN_Mask);
 
 	mb();
-- 
2.1.0
