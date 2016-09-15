Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZX092cSQzDsW4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:39:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv/pci: Fix missed TCE invalidations that should
 fallback to OPAL
Date: Thu, 15 Sep 2016 18:39:34 +1000
Message-Id: <1473928774-22519-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit f0228c413011 ("powerpc/powernv/pci: Fallback to OPAL for TCE
invalidations"), we added logic to fallback to OPAL for doing TCE
invalidations if we can't do it in Linux.

Ben sent a v2 of the patch, containing these additional call sites, but
I had already applied v1 and didn't notice. So fix them now.

Fixes: f0228c413011 ("powerpc/powernv/pci: Fallback to OPAL for TCE invalidations")
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index da5da11a6223..bc0c91e84ca0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2217,7 +2217,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 
 	pnv_pci_link_table_and_group(phb->hose->node, num,
 			tbl, &pe->table_group);
-	pnv_pci_phb3_tce_invalidate_pe(pe);
+	pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	return 0;
 }
@@ -2355,7 +2355,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 	if (ret)
 		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
 	else
-		pnv_pci_phb3_tce_invalidate_pe(pe);
+		pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
 
-- 
2.7.4
