Return-Path: <tpearson@raptorengineering.com>
Received: from mail.rptsys.com (mail.rptsys.com [192.119.205.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Csvy3cklzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 10:03:26 +1000 (AEST)
Date: Sat, 23 Jun 2018 18:54:16 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <225890156.2569252.1529798056341.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 5/7] powerpc/powernv/pci: Export
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 pnv_pci_ioda2_tce_invalidate_pe

Pseudo DMA support requires a method to invalidate the TCE cache
Export pnv_pci_ioda2_tce_invalidate_pe for use by the pseudo DMA
mapper.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 arch/powerpc/platforms/powernv/pci.h      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 55f0f7b885bc..a6097dd323f8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2102,7 +2102,7 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
 	}
 }
 
-static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
+void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 {
 	struct pnv_phb *phb = pe->phb;
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 83492aba90f1..8d3849e76be3 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -264,6 +264,7 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
+extern void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe);
 extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
 extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		struct iommu_table *tbl);
-- 
2.17.1
