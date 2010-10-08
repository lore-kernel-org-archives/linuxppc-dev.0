Return-Path: <nacc@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5172D100B72
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:33:48 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HTYYK028885
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:29:34 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98HXbJE020172
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o98HXb81022212
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:37 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 09/11] ppc/iommu: pass phb only to
	iommu_table_setparms_lpar
Date: Fri,  8 Oct 2010 10:33:10 -0700
Message-Id: <1286559192-10898-10-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	Paul Mackerras <paulus@samba.org>,
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
index d8bb9be..8ec81df 100644
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
@@ -493,8 +492,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
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
