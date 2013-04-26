Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 231C42C0126
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 15:21:16 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 23:21:14 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7B17A3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 23:20:58 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q5LCdw136200
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 23:21:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q5LBI9032320
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 23:21:12 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/powernv: Build DMA space for PE on PHB3
Date: Fri, 26 Apr 2013 13:21:01 +0800
Message-Id: <1366953662-9473-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366953662-9473-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366953662-9473-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to build 32-bits DMA space for individual PEs on
PHB3. The TVE# is recognized by the combo of PE# and fixed bits
from DMA address, which is zero for 32-bits DMA space.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   99 +++++++++++++++++++++++++++--
 1 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1c7e808..04a37dc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -600,9 +600,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		 */
 		tbl->it_busno = 0;
 		tbl->it_index = (unsigned long)ioremap(be64_to_cpup(swinvp), 8);
-		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
-		if (phb->type == PNV_PHB_IODA1)
-			tbl->it_type |= TCE_PCI_SWINV_PAIR;
+		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE |
+			       TCE_PCI_SWINV_PAIR;
 	}
 	iommu_init_table(tbl, phb->hose->node);
 
@@ -620,6 +619,81 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
 
+static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
+				       struct pnv_ioda_pe *pe)
+{
+	struct page *tce_mem = NULL;
+	void *addr;
+	const __be64 *swinvp;
+	struct iommu_table *tbl;
+	unsigned int tce_table_size, end;
+	int64_t rc;
+
+	/* We shouldn't already have a 32-bit DMA associated */
+	if (WARN_ON(pe->tce32_seg >= 0))
+		return;
+
+	/* The PE will reserve all possible 32-bits space */
+	pe->tce32_seg = 0;
+	end = (1 << ilog2(phb->ioda.m32_pci_base));
+	tce_table_size = (end / 0x1000) * 8;
+	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
+		end);
+
+	/* Allocate TCE table */
+	tce_mem = alloc_pages_node(phb->hose->node, GFP_KERNEL,
+				   get_order(tce_table_size));
+	if (!tce_mem) {
+		pe_err(pe, "Failed to allocate a 32-bit TCE memory\n");
+		goto fail;
+	}
+	addr = page_address(tce_mem);
+	memset(addr, 0, tce_table_size);
+
+	/*
+	 * Map TCE table through TVT. The TVE index is the PE number
+	 * shifted by 1 bit for 32-bits DMA space.
+	 */
+	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+					pe->pe_number << 1, 1, __pa(addr),
+					tce_table_size, 0x1000);
+	if (rc) {
+		pe_err(pe, "Failed to configure 32-bit TCE table,"
+		       " err %ld\n", rc);
+		goto fail;
+	}
+
+	/* Setup linux iommu table */
+	tbl = &pe->tce32_table;
+	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0);
+
+	/* OPAL variant of PHB3 invalidated TCEs */
+	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
+	if (swinvp) {
+		/* We need a couple more fields -- an address and a data
+		 * to or.  Since the bus is only printed out on table free
+		 * errors, and on the first pass the data will be a relative
+		 * bus number, print that out instead.
+		 */
+		tbl->it_busno = 0;
+		tbl->it_index = (unsigned long)ioremap(be64_to_cpup(swinvp), 8);
+		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
+	}
+	iommu_init_table(tbl, phb->hose->node);
+
+	if (pe->pdev)
+		set_iommu_table_base(&pe->pdev->dev, tbl);
+	else
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+
+	return;
+fail:
+	if (pe->tce32_seg >= 0)
+		pe->tce32_seg = -1;
+	if (tce_mem)
+		__free_pages(tce_mem, get_order(tce_table_size));
+}
+
 static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 {
 	struct pci_controller *hose = phb->hose;
@@ -662,9 +736,22 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 			if (segs > remaining)
 				segs = remaining;
 		}
-		pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
-			pe->dma_weight, segs);
-		pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
+
+		/*
+		 * For IODA2 compliant PHB3, we needn't care about the weight.
+		 * The all available 32-bits DMA space will be assigned to
+		 * the specific PE.
+		 */
+		if (phb->type == PNV_PHB_IODA1) {
+			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
+				pe->dma_weight, segs);
+			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
+		} else {
+			pe_info(pe, "Assign DMA32 space\n");
+			segs = 0;
+			pnv_pci_ioda2_setup_dma_pe(phb, pe);
+		}
+
 		remaining -= segs;
 		base += segs;
 	}
-- 
1.7.5.4
