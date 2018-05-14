Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 40kwdY3xlYzF2lK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 19:39:28 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v3] powerpc/ioda: Use ibm,
 supported-tce-sizes for IOMMU page size mask
Date: Mon, 14 May 2018 19:39:22 +1000
Message-Id: <20180514093922.27179-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment we assume that IODA2 and newer PHBs can always do 4K/64K/16M
IOMMU pages, however this is not the case for POWER9 and now skiboot
advertises the supported sizes via the device so we use that instead
of hard coding the mask.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* use modern device tree accessors

v2:
* added quirk for POWER8 to advertise 16M if skiboot has not provided info
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3f9c69d..9731098 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2910,6 +2910,34 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
 			tbl->it_indirect_levels);
 }
 
+static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
+{
+	struct pci_controller *hose = phb->hose;
+	struct device_node *dn = hose->dn;
+	unsigned long mask = 0;
+	int i, rc, count;
+	u32 val;
+
+	count = of_property_count_u32_elems(dn, "ibm,supported-tce-sizes");
+	if (count <= 0) {
+		mask = SZ_4K | SZ_64K;
+		/* Add 16M for POWER8 by default */
+		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
+				!cpu_has_feature(CPU_FTR_ARCH_300))
+			mask |= SZ_16M;
+		return mask;
+	}
+
+	for (i = 0; i < count; i++) {
+		rc = of_property_read_u32_index(dn, "ibm,supported-tce-sizes",
+						i, &val);
+		if (rc == 0)
+			mask |= 1ULL << val;
+	}
+
+	return mask;
+}
+
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
@@ -2934,7 +2962,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe->table_group.max_dynamic_windows_supported =
 			IOMMU_TABLE_GROUP_MAX_TABLES;
 	pe->table_group.max_levels = POWERNV_IOMMU_MAX_LEVELS;
-	pe->table_group.pgsizes = SZ_4K | SZ_64K | SZ_16M;
+	pe->table_group.pgsizes = pnv_ioda_parse_tce_sizes(phb);
 #ifdef CONFIG_IOMMU_API
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 #endif
-- 
2.11.0
