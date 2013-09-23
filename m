Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 27/39] powerpc/powernv: Fix endian issues in powernv PCI code
Date: Mon, 23 Sep 2013 12:05:01 +1000
Message-Id: <1379901913-5945-28-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 31 +++++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci.c      | 27 +++++++++++++--------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9a903ed..f9cb6c5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -457,7 +457,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 					 u64 *startp, u64 *endp)
 {
-	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
+	__be64 __iomem *invalidate = (__be64 __iomem *)tbl->it_index;
 	unsigned long start, end, inc;
 
 	start = __pa(startp);
@@ -484,7 +484,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 
         mb(); /* Ensure above stores are visible */
         while (start <= end) {
-                __raw_writeq(start, invalidate);
+                __raw_writeq(cpu_to_be64(start), invalidate);
                 start += inc;
         }
 
@@ -499,7 +499,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 					 u64 *startp, u64 *endp)
 {
 	unsigned long start, end, inc;
-	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
+	__be64 __iomem *invalidate = (__be64 __iomem *)tbl->it_index;
 
 	/* We'll invalidate DMA address in PE scope */
 	start = 0x2ul << 60;
@@ -515,7 +515,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	mb();
 
 	while (start <= end) {
-		__raw_writeq(start, invalidate);
+		__raw_writeq(cpu_to_be64(start), invalidate);
 		start += inc;
 	}
 }
@@ -786,8 +786,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	struct irq_data *idata;
 	struct irq_chip *ichip;
 	unsigned int xive_num = hwirq - phb->msi_base;
-	uint64_t addr64;
-	uint32_t addr32, data;
+	__be32 data;
 	int rc;
 
 	/* No PE assigned ? bail out ... no MSI for you ! */
@@ -811,6 +810,8 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	}
 
 	if (is_64) {
+		__be64 addr64;
+
 		rc = opal_get_msi_64(phb->opal_id, pe->mve_number, xive_num, 1,
 				     &addr64, &data);
 		if (rc) {
@@ -818,9 +819,11 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				pci_name(dev), rc);
 			return -EIO;
 		}
-		msg->address_hi = addr64 >> 32;
-		msg->address_lo = addr64 & 0xfffffffful;
+		msg->address_hi = be64_to_cpu(addr64) >> 32;
+		msg->address_lo = be64_to_cpu(addr64) & 0xfffffffful;
 	} else {
+		__be32 addr32;
+
 		rc = opal_get_msi_32(phb->opal_id, pe->mve_number, xive_num, 1,
 				     &addr32, &data);
 		if (rc) {
@@ -829,9 +832,9 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 			return -EIO;
 		}
 		msg->address_hi = 0;
-		msg->address_lo = addr32;
+		msg->address_lo = be32_to_cpu(addr32);
 	}
-	msg->data = data;
+	msg->data = be32_to_cpu(data);
 
 	/*
 	 * Change the IRQ chip for the MSI interrupts on PHB3.
@@ -1107,7 +1110,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	struct pnv_phb *phb;
 	unsigned long size, m32map_off, iomap_off, pemap_off;
 	const __be64 *prop64;
-	const u32 *prop32;
+	const __be32 *prop32;
 	int len;
 	u64 phb_id;
 	void *aux;
@@ -1142,8 +1145,8 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	spin_lock_init(&phb->lock);
 	prop32 = of_get_property(np, "bus-range", &len);
 	if (prop32 && len == 8) {
-		hose->first_busno = prop32[0];
-		hose->last_busno = prop32[1];
+		hose->first_busno = be32_to_cpu(prop32[0]);
+		hose->last_busno = be32_to_cpu(prop32[1]);
 	} else {
 		pr_warn("  Broken <bus-range> on %s\n", np->full_name);
 		hose->first_busno = 0;
@@ -1175,7 +1178,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (!prop32)
 		phb->ioda.total_pe = 1;
 	else
-		phb->ioda.total_pe = *prop32;
+		phb->ioda.total_pe = be32_to_cpup(prop32);
 
 	phb->ioda.m32_size = resource_size(&hose->mem_resources[0]);
 	/* FW Has already off top 64k of M32 space (MSI space) */
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 9122215..2f73e0d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -236,7 +236,7 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 {
 	s64	rc;
 	u8	fstate;
-	u16	pcierr;
+	__be16	pcierr;
 	u32	pe_no;
 
 	/*
@@ -283,16 +283,16 @@ int pnv_pci_cfg_read(struct device_node *dn,
 		break;
 	}
 	case 2: {
-		u16 v16;
+		__be16 v16;
 		rc = opal_pci_config_read_half_word(phb->opal_id, bdfn, where,
 						   &v16);
-		*val = (rc == OPAL_SUCCESS) ? v16 : 0xffff;
+		*val = (rc == OPAL_SUCCESS) ? be16_to_cpu(v16) : 0xffff;
 		break;
 	}
 	case 4: {
-		u32 v32;
+		__be32 v32;
 		rc = opal_pci_config_read_word(phb->opal_id, bdfn, where, &v32);
-		*val = (rc == OPAL_SUCCESS) ? v32 : 0xffffffff;
+		*val = (rc == OPAL_SUCCESS) ? be32_to_cpu(v32) : 0xffffffff;
 		break;
 	}
 	default:
@@ -404,7 +404,7 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			 struct dma_attrs *attrs)
 {
 	u64 proto_tce;
-	u64 *tcep, *tces;
+	__be64 *tcep, *tces;
 	u64 rpn;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
@@ -416,7 +416,7 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	rpn = __pa(uaddr) >> TCE_SHIFT;
 
 	while (npages--)
-		*(tcep++) = proto_tce | (rpn++ << TCE_RPN_SHIFT);
+		*(tcep++) = cpu_to_be64(proto_tce | (rpn++ << TCE_RPN_SHIFT));
 
 	/* Some implementations won't cache invalid TCEs and thus may not
 	 * need that flush. We'll probably turn it_type into a bit mask
@@ -430,12 +430,12 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 
 static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
-	u64 *tcep, *tces;
+	__be64 *tcep, *tces;
 
 	tces = tcep = ((u64 *)tbl->it_base) + index - tbl->it_offset;
 
 	while (npages--)
-		*(tcep++) = 0;
+		*(tcep++) = cpu_to_be64(0);
 
 	if (tbl->it_type & TCE_PCI_SWINV_FREE)
 		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1);
@@ -462,8 +462,8 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 {
 	struct iommu_table *tbl;
-	const __be64 *basep;
-	const __be32 *sizep, *swinvp;
+	const __be64 *basep, *swinvp;
+	const __be32 *sizep;
 
 	basep = of_get_property(hose->dn, "linux,tce-base", NULL);
 	sizep = of_get_property(hose->dn, "linux,tce-size", NULL);
@@ -484,9 +484,8 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 	swinvp = of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
 				 NULL);
 	if (swinvp) {
-		tbl->it_busno = of_read_ulong(&swinvp[1], 2);
-		tbl->it_index =
-			(unsigned long)ioremap(of_read_number(swinvp, 2), 8);
+		tbl->it_busno = swinvp[1];
+		tbl->it_index = (unsigned long)ioremap(be64_to_cpup(swinvp), 8);
 		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
 	}
 	return tbl;
-- 
1.8.1.2
