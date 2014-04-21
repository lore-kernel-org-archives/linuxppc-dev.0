Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E2E314008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 12:25:44 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 21 Apr 2014 12:25:34 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F12D3578055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 12:25:32 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3L24Wk043253864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 12:04:32 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3L2PU1k002987
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 12:25:31 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernc: revert part of commit d905c5df(PPC:
 POWERNV: move iommu_add_device earlier)
Date: Mon, 21 Apr 2014 10:25:19 +0800
Message-Id: <1398047119-6861-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is a draft call flow:

pci_device_add
   pcibios_add_device
      pci_dma_dev_setup
         pnv_pci_dma_dev_setup
            pnv_pci_ioda_dma_dev_setup
               set_iommu_table_base_and_group <--- here
device_add

When set_iommu_table_base_and_group() is invoked int
pnv_pci_ioda_dma_dev_setup(), the dev->kobj->sd is not initialized. The
dev->kobj->sd is initialized in device_add().

After applying this patch, the error
    iommu_tce: 0003:05:00.0 has not been added, ret=-14
is cleared.

This patch revert the change for pnv_pci_ioda_dma_dev_setup() from commit
d905c5df(PPC: POWERNV: move iommu_add_device earlier).

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fc4edda..b5d8f73 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1425,7 +1425,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
+	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
 }
 
 static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
-- 
1.7.9.5
