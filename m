Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 40xxpg1chZzDrp0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 18:10:35 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel 1/2] powerpc/powernv: Reuse existing TCE code for
 sketchy bypass
Date: Fri,  1 Jun 2018 18:10:27 +1000
Message-Id: <20180601081028.29401-2-aik@ozlabs.ru>
In-Reply-To: <20180601081028.29401-1-aik@ozlabs.ru>
References: <20180601081028.29401-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing sketchy bypass ignores the existing default 32bit TCE table
(created by default for every PE at boot time or after being used by
VFIO) and it allocates another table instead without updating PE DMA
config (pe->table_group). So if we decide to use such device for VFIO
later, this new table will also leak memory.

This replaces adhoc table allocation and programming with the existing
API which handles memory leaks.

This programs the default 32bit table back to TVE#0 if configuring
the new table failed for some reason.

While we are at it, switch from the hardcoded 256MB TCEs to the biggest
size supported by the hardware and reported by the firmware. This allows
the sketchy bypass (originally made for POWER8 only) to work on POWER9
too assuming that PHB4 type is defined and pnv_pci_ioda_dma_64bit_bypass()
is called (coming next).

This does not call iommu_init_table() for the new table as the caller
will use &dma_nommu_ops and therefore ::it_map is not needed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Tested with:
 	if (pe->tce_bypass_enabled) {
 		top = pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
-		bypass = (dma_mask >= top);
+		bypass = false;//(dma_mask >= top);
 	}
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 71 +++++++++++++++++--------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ceb7e64..9239142 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1791,54 +1791,61 @@ static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
  *
  * Currently this will only work on PHB3 (POWER8).
  */
+static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table **ptbl);
+
+static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
+		int num, struct iommu_table *tbl);
+
+static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb);
+
 static int pnv_pci_ioda_dma_64bit_bypass(struct pnv_ioda_pe *pe)
 {
-	u64 window_size, table_size, tce_count, addr;
-	struct page *table_pages;
-	u64 tce_order = 28; /* 256MB TCEs */
-	__be64 *tces;
+	u64 window_size;
 	s64 rc;
+	struct iommu_table *tbl, *oldtbl = NULL;
+	unsigned long shift, offset;
 
 	/*
 	 * Window size needs to be a power of two, but needs to account for
 	 * shifting memory by the 4GB offset required to skip 32bit space.
 	 */
-	window_size = roundup_pow_of_two(memory_hotplug_max() + (1ULL << 32));
-	tce_count = window_size >> tce_order;
-	table_size = tce_count << 3;
-
-	if (table_size < PAGE_SIZE)
-		table_size = PAGE_SIZE;
+	window_size = roundup_pow_of_two(memory_hotplug_max() + SZ_4G);
+	shift = ilog2(pnv_ioda_parse_tce_sizes(pe->phb));
+	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0, shift, window_size,
+			POWERNV_IOMMU_DEFAULT_LEVELS, &tbl);
+	if (rc) {
+		pe_err(pe, "Failed to create 64-bypass TCE table, err %ld", rc);
+		return rc;
+	}
 
-	table_pages = alloc_pages_node(pe->phb->hose->node, GFP_KERNEL,
-				       get_order(table_size));
-	if (!table_pages)
+	offset = SZ_4G >> shift;
+	rc = tbl->it_ops->set(tbl, offset, tbl->it_size - offset,
+			0 /* uaddr */, DMA_BIDIRECTIONAL, 0 /* attrs */);
+	if (rc)
 		goto err;
 
-	tces = page_address(table_pages);
-	if (!tces)
+	if (pe->table_group.tables[0]) {
+		oldtbl = pe->table_group.tables[0];
+		pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+	}
+
+	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
+	if (rc != OPAL_SUCCESS) {
+		rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, oldtbl);
 		goto err;
+	}
 
-	memset(tces, 0, table_size);
+	if (oldtbl)
+		iommu_tce_table_put(oldtbl);
 
-	for (addr = 0; addr < memory_hotplug_max(); addr += (1 << tce_order)) {
-		tces[(addr + (1ULL << 32)) >> tce_order] =
-			cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
-	}
+	pe_info(pe, "Using 64-bit DMA iommu bypass (through TVE#0)\n");
+	return 0;
 
-	rc = opal_pci_map_pe_dma_window(pe->phb->opal_id,
-					pe->pe_number,
-					/* reconfigure window 0 */
-					(pe->pe_number << 1) + 0,
-					1,
-					__pa(tces),
-					table_size,
-					1 << tce_order);
-	if (rc == OPAL_SUCCESS) {
-		pe_info(pe, "Using 64-bit DMA iommu bypass (through TVE#0)\n");
-		return 0;
-	}
 err:
+	iommu_tce_table_put(tbl);
+
 	pe_err(pe, "Error configuring 64-bit DMA bypass\n");
 	return -EIO;
 }
-- 
2.11.0
