Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38F641A021F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:51 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 142653578066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:47 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFedpp43385070
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:47 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeErI002079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 29/34] powerpc/powernv/ioda2: Use new helpers to do
 proper cleanup on PE release
Date: Tue, 12 May 2015 01:39:18 +1000
Message-Id: <1431358763-24371-30-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c1d1aef..14d4f34 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1287,33 +1287,21 @@ m64_failed:
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
 
+	pnv_pci_ioda2_set_bypass(pe, false);
 	pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
 	if (pe->table_group.group) {
 		iommu_group_put(pe->table_group.group);
-- 
2.4.0.rc3.8.gfb3e7d5
