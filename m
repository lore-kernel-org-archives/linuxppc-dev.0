Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A40D61A004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:15 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2C0F63578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296Tvq61114384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:08 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296TWit009807
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:33 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 05/10] powerpc/powernv/npu: Use the correct IOMMU page
 size
Date: Wed,  9 Mar 2016 17:29:01 +1100
Message-Id: <1457504946-40649-6-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
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
