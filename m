Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8D301A0545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:02:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 27 Aug 2015 16:02:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B9B71357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:02:18 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R629BA61931752
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:02:18 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R61ihQ011847
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:01:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH kernel] powerpc/iommu: Set default DMA offset in dma_dev_setup
Date: Thu, 27 Aug 2015 16:01:16 +1000
Message-Id: <1440655276-6596-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"powerpc/iommu: Cleanup setting of DMA base/offset" expects that
the default DMA offset is set from pnv_ioda_setup_bus_dma() which
is correct unless it is SRIOV where the code flow is different - at
the moment when pnv_ioda_setup_bus_dma() is called, there is no PE for
the just created VF.

This adds missing set_dma_offset() to pnv_pci_ioda_dma_dev_setup()
to cover the case of SRIOV.

Note that we still need set_dma_offset() in pnv_ioda_setup_bus_dma()
as at the boot time pnv_pci_ioda_dma_dev_setup() is called when no PE
was created yet, this happens at the PHB fixup stage.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Makes sense to squash it to "powerpc/iommu: Cleanup setting of DMA base/offset".


---
 arch/powerpc/platforms/powernv/pci-ioda.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2c286b57..af875c1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1590,6 +1590,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
+	set_dma_offset(&pdev->dev, pe->tce_bypass_base);
 	set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
 	/*
 	 * Note: iommu_add_device() will fail here as
-- 
2.4.0.rc3.8.gfb3e7d5
