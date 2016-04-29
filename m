Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx7H02VkyzDr4S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:11:24 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 19:11:23 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5AA812CE805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:11:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T9AiQr63045690
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:11:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T9AEPQ007949
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:10:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v4 06/11] powerpc/powernv/npu: Use the correct IOMMU
 page size
Date: Fri, 29 Apr 2016 18:55:19 +1000
Message-Id: <1461920124-21719-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses the page size from iommu_table instead of hard-coded 4K.
This should cause no change in behavior.

While we are here, move bits around to prepare for further rework
which will define and use iommu_table_group_ops.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 778570c..5bd5fee 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -204,8 +204,7 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
 	struct pnv_phb *phb = npe->phb;
 	struct pci_dev *gpdev;
 	struct pnv_ioda_pe *gpe;
-	void *addr;
-	unsigned int size;
+	struct iommu_table *tbl;
 	int64_t rc;
 
 	/*
@@ -219,11 +218,11 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
 	if (!gpe)
 		return;
 
-	addr = (void *)gpe->table_group.tables[0]->it_base;
-	size = gpe->table_group.tables[0]->it_size << 3;
+	tbl = gpe->table_group.tables[0];
 	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
-					npe->pe_number, 1, __pa(addr),
-					size, 0x1000);
+					npe->pe_number, 1, __pa(tbl->it_base),
+					tbl->it_size << 3,
+					IOMMU_PAGE_SIZE(tbl));
 	if (rc != OPAL_SUCCESS)
 		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
 			__func__, rc, phb->hose->global_number, npe->pe_number);
-- 
2.5.0.rc3
