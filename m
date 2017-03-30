Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0082.hostedemail.com
 [216.40.44.82])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv0x45Fs6zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 21:19:36 +1100 (AEDT)
From: Joe Perches <joe@perches.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powernv/ioda2: Add __printf format/argument
 verification
Date: Thu, 30 Mar 2017 03:19:25 -0700
Message-Id: <f4003df27f480c533b311dc9515f13fdaa962563.1490869145.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix fallout too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 31 ++++++++++++++++---------------
 arch/powerpc/platforms/powernv/pci.h      |  2 ++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7461322f0a1a..b1f027354f6b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -848,11 +848,11 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 	rc = opal_pci_set_peltv(phb->opal_id, pe->pe_number,
 				pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
 	if (rc)
-		pe_warn(pe, "OPAL error %ld remove self from PELTV\n", rc);
+		pe_warn(pe, "OPAL error %lld remove self from PELTV\n", rc);
 	rc = opal_pci_set_pe(phb->opal_id, pe->pe_number, pe->rid,
 			     bcomp, dcomp, fcomp, OPAL_UNMAP_PE);
 	if (rc)
-		pe_err(pe, "OPAL error %ld trying to setup PELT table\n", rc);
+		pe_err(pe, "OPAL error %lld trying to setup PELT table\n", rc);
 
 	pe->pbus = NULL;
 	pe->pdev = NULL;
@@ -1159,11 +1159,12 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	pe->rid = bus->busn_res.start << 8;
 
 	if (all)
-		pe_info(pe, "Secondary bus %d..%d associated with PE#%x\n",
-			bus->busn_res.start, bus->busn_res.end, pe->pe_number);
+		pe_info(pe, "Secondary bus %pad..%pad associated with PE#%x\n",
+			&bus->busn_res.start, &bus->busn_res.end,
+			pe->pe_number);
 	else
-		pe_info(pe, "Secondary bus %d associated with PE#%x\n",
-			bus->busn_res.start, pe->pe_number);
+		pe_info(pe, "Secondary bus %pad associated with PE#%x\n",
+			&bus->busn_res.start, pe->pe_number);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
 		/* XXX What do we do here ? */
@@ -1417,7 +1418,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	tbl = pe->table_group.tables[0];
 	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (rc)
-		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
+		pe_warn(pe, "OPAL error %lld release DMA window\n", rc);
 
 	pnv_pci_ioda2_set_bypass(pe, false);
 	if (pe->table_group.group) {
@@ -2165,8 +2166,8 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 					      __pa(addr) + tce32_segsz * i,
 					      tce32_segsz, IOMMU_PAGE_SIZE_4K);
 		if (rc) {
-			pe_err(pe, " Failed to configure 32-bit TCE table,"
-			       " err %ld\n", rc);
+			pe_err(pe, " Failed to configure 32-bit TCE table, err %lld\n",
+			       rc);
 			goto fail;
 		}
 	}
@@ -2219,9 +2220,9 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
 	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
 
-	pe_info(pe, "Setting up window#%d %llx..%llx pg=%x\n", num,
-			start_addr, start_addr + win_size - 1,
-			IOMMU_PAGE_SIZE(tbl));
+	pe_info(pe, "Setting up window#%d %llx..%llx pg=%lx\n",
+		num, start_addr, start_addr + win_size - 1,
+		IOMMU_PAGE_SIZE(tbl));
 
 	/*
 	 * Map TCE table through TVT. The TVE index is the PE number
@@ -2235,7 +2236,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 			size << 3,
 			IOMMU_PAGE_SIZE(tbl));
 	if (rc) {
-		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
+		pe_err(pe, "Failed to configure TCE table, err %lld\n", rc);
 		return rc;
 	}
 
@@ -3421,7 +3422,7 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 #ifdef CONFIG_IOMMU_API
 	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (rc)
-		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
+		pe_warn(pe, "OPAL error %lld release DMA window\n", rc);
 #endif
 
 	pnv_pci_ioda2_set_bypass(pe, false);
@@ -3456,7 +3457,7 @@ static void pnv_ioda_free_pe_seg(struct pnv_ioda_pe *pe,
 					phb->ioda.reserved_pe_idx, win, 0, idx);
 
 		if (rc != OPAL_SUCCESS)
-			pe_warn(pe, "Error %ld unmapping (%d) segment#%d\n",
+			pe_warn(pe, "Error %lld unmapping (%d) segment#%d\n",
 				rc, win, idx);
 
 		map[idx] = IODA_INVALID_PE;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index e1d3e5526b54..139df2478f7e 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -1,6 +1,7 @@
 #ifndef __POWERNV_PCI_H
 #define __POWERNV_PCI_H
 
+#include <linux/compiler.h>		/* for __printf */
 #include <linux/iommu.h>
 #include <asm/iommu.h>
 #include <asm/msi_bitmap.h>
@@ -218,6 +219,7 @@ extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
 extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
 extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
 
+__printf(3, 4)
 extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...);
 #define pe_err(pe, fmt, ...)					\
-- 
2.10.0.rc2.1.g053435c
