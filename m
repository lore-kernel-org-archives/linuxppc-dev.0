Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s463t0jd8zDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:14 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 04/15] powerpc/powernv/ioda: Fix TCE invalidate to work
 in real mode again
Date: Wed,  3 Aug 2016 18:40:45 +1000
Message-Id: <1470213656-1042-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"powerpc/powernv/pci: Rework accessing the TCE invalidate register"
broke TCE invalidation on IODA2/PHB3 for real mode.

This makes invalidate work again.

Fixes: fd141d1a99a3
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 53b56c0..59c7e7d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1877,7 +1877,7 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
 					unsigned shift, unsigned long index,
 					unsigned long npages)
 {
-	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, false);
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, rm);
 	unsigned long start, end, inc;
 
 	/* We'll invalidate DMA address in PE scope */
@@ -1935,10 +1935,12 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 			pnv_pci_phb3_tce_invalidate(pe, rm, shift,
 						    index, npages);
 		else if (rm)
+		{
 			opal_rm_pci_tce_kill(phb->opal_id,
 					     OPAL_PCI_TCE_KILL_PAGES,
 					     pe->pe_number, 1u << shift,
 					     index << shift, npages);
+		}
 		else
 			opal_pci_tce_kill(phb->opal_id,
 					  OPAL_PCI_TCE_KILL_PAGES,
-- 
2.5.0.rc3
