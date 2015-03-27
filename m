Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1F1C1A0706
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:56:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 282942CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REujRB41091196
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuJkv027593
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:19 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 23/31] powerpc/powernv: Change prototypes to receive
 iommu
Date: Sat, 28 Mar 2015 01:55:07 +1100
Message-Id: <1427468115-2224-24-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes few functions to receive a iommu_table_group pointer
rather than PE as they are going to be a part of upcoming
iommu_table_group_ops callback set.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 74e119c..80ea84d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1408,10 +1408,12 @@ static __be64 *pnv_alloc_tce_table(int nid,
 	return addr;
 }
 
-static long pnv_pci_ioda2_create_table(struct pnv_ioda_pe *pe,
+static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 		__u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table *tbl)
 {
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+						table_group);
 	int nid = pe->phb->hose->node;
 	void *addr;
 	unsigned long tce_table_size, left;
@@ -1462,9 +1464,11 @@ static void pnv_pci_free_table(struct iommu_table *tbl)
 	iommu_reset_table(tbl, "ioda2");
 }
 
-static long pnv_pci_ioda2_set_window(struct pnv_ioda_pe *pe,
+static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 		struct iommu_table *tbl)
 {
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
 	struct pnv_phb *phb = pe->phb;
 	const __be64 *swinvp;
 	int64_t rc;
@@ -1599,12 +1603,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
-
 	end = (1 << ilog2(phb->ioda.m32_pci_base));
 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
 		end);
 
-	rc = pnv_pci_ioda2_create_table(pe, IOMMU_PAGE_SHIFT_4K,
+	rc = pnv_pci_ioda2_create_table(&pe->table_group, IOMMU_PAGE_SHIFT_4K,
 			phb->ioda.m32_pci_base,
 			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
 	if (rc) {
@@ -1619,7 +1622,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 #endif
 
-	rc = pnv_pci_ioda2_set_window(pe, tbl);
+	rc = pnv_pci_ioda2_set_window(&pe->table_group, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
-- 
2.0.0
