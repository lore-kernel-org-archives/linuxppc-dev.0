Return-Path: <nacc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C6BCB7126
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 14:36:01 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9R3JfCi009819
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 23:19:41 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9R3Zk7D2052120
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 23:35:46 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9R3Zj5d001965
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2010 01:35:45 -0200
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 6/7 v2] ppc/iommu: pass phb only to
	iommu_table_setparms_lpar
Date: Tue, 26 Oct 2010 20:35:16 -0700
Message-Id: <1288150518-4026-7-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

iommu_table_setparms_lpar needs either the phb or the subbusnumber
(not both), pass the phb to make it similar to iommu_table_setparms.

Note: In cases where a caller was passing bus->number previously to
iommu_table_setparms_lpar() rather than phb->bus->number, this can lead
to a different value in tbl->it_busno. The only example of this was the
removed pci_dma_dev_setup_pSeriesLP(), removed in "ppc/iommu: remove
unneeded pci_dma_dev_setup_pSeriesLP".

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9d564b9..45c6865 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -323,14 +323,13 @@ static void iommu_table_setparms(struct pci_controller *phb,
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct device_node *dn,
 				      struct iommu_table *tbl,
-				      const void *dma_window,
-				      int bussubno)
+				      const void *dma_window)
 {
 	unsigned long offset, size;
 
-	tbl->it_busno  = bussubno;
 	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
 
+	tbl->it_busno = phb->bus->number;
 	tbl->it_base   = 0;
 	tbl->it_blocksize  = 16;
 	tbl->it_type = TCE_PCI;
@@ -534,8 +533,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	if (!pci->iommu_table) {
 		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   pci->phb->node);
-		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window,
-			pci->phb->bus->number);
+		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
 		pr_debug("  created table: %p\n", pci->iommu_table);
 	} else {
-- 
1.7.1
