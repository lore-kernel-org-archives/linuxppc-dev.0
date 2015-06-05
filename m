Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AA651A1A9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:38:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 5 Jun 2015 16:38:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7AB4D3578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:38:13 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t556aoas40763514
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:58 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556aPMt012993
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:26 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel v12 29/34] powerpc/powernv/ioda2: Use new helpers to do
 proper cleanup on PE release
Date: Fri,  5 Jun 2015 16:35:21 +1000
Message-Id: <1433486126-23551-30-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing code programmed TVT#0 with some address and then
immediately released that memory.

This makes use of pnv_pci_ioda2_unset_window() and
pnv_pci_ioda2_set_bypass() which do correct resource release and
TVT update.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ace0302..612ab23 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1288,34 +1288,21 @@ m64_failed:
 	return -EBUSY;
 }
 
+static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
+		int num);
+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
+
 static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
 {
-	struct pci_bus        *bus;
-	struct pci_controller *hose;
-	struct pnv_phb        *phb;
 	struct iommu_table    *tbl;
-	unsigned long         addr;
 	int64_t               rc;
 
-	bus = dev->bus;
-	hose = pci_bus_to_host(bus);
-	phb = hose->private_data;
 	tbl = pe->table_group.tables[0];
-	addr = tbl->it_base;
-
-	opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-				   pe->pe_number << 1, 1, __pa(addr),
-				   0, 0x1000);
-
-	rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
-				        pe->pe_number,
-				        (pe->pe_number << 1) + 1,
-				        pe->tce_bypass_base,
-				        0);
+	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (rc)
 		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
 
-	pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
+	pnv_pci_ioda2_set_bypass(pe, false);
 	if (pe->table_group.group) {
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
-- 
2.4.0.rc3.8.gfb3e7d5
