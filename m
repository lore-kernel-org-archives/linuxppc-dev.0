Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EFF51A0D33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 29 Jan 2015 19:22:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A62E62BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:24 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0T9MOQL11665478
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:24 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0T9MM91023269
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:23 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 20/24] powerpc/powernv: Change prototypes to receive iommu
Date: Thu, 29 Jan 2015 20:22:01 +1100
Message-Id: <1422523325-1389-21-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes few functions to receive a powerpc_iommu pointer
rather than PE as they are going to be a part of upcoming
powerpc_iommu_ops callback set.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f542819..29bd7a4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1360,10 +1360,12 @@ static __be64 *pnv_alloc_tce_table(int nid,
 	return addr;
 }
 
-static long pnv_pci_ioda2_create_table(struct pnv_ioda_pe *pe,
+static long pnv_pci_ioda2_create_table(struct powerpc_iommu *iommu,
 		__u32 page_shift, __u32 window_shift, __u32 levels,
 		struct iommu_table *tbl)
 {
+	struct pnv_ioda_pe *pe = container_of(iommu, struct pnv_ioda_pe,
+						iommu);
 	int nid = pe->phb->hose->node;
 	void *addr;
 	unsigned long tce_table_size, left;
@@ -1419,9 +1421,11 @@ static void pnv_pci_ioda2_free_table(struct iommu_table *tbl)
 	iommu_reset_table(tbl, "ioda2");
 }
 
-static long pnv_pci_ioda2_set_window(struct pnv_ioda_pe *pe,
+static long pnv_pci_ioda2_set_window(struct powerpc_iommu *iommu,
 		struct iommu_table *tbl)
 {
+	struct pnv_ioda_pe *pe = container_of(iommu, struct pnv_ioda_pe,
+						iommu);
 	struct pnv_phb *phb = pe->phb;
 	const __be64 *swinvp;
 	int64_t rc;
@@ -1554,12 +1558,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
-
 	end = (1 << ilog2(phb->ioda.m32_pci_base));
 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
 		end);
 
-	rc = pnv_pci_ioda2_create_table(pe, IOMMU_PAGE_SHIFT_4K,
+	rc = pnv_pci_ioda2_create_table(&pe->iommu, IOMMU_PAGE_SHIFT_4K,
 			ilog2(phb->ioda.m32_pci_base),
 			POWERPC_IOMMU_DEFAULT_LEVELS, tbl);
 	if (rc) {
@@ -1571,7 +1574,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe->iommu.tables[0].it_iommu = &pe->iommu;
 	pe->iommu.ops = &pnv_pci_ioda2_ops;
 
-	rc = pnv_pci_ioda2_set_window(pe, tbl);
+	rc = pnv_pci_ioda2_set_window(&pe->iommu, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
-- 
2.0.0
