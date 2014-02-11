Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF1722C00B9
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Feb 2014 11:38:26 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s1B0cJgK023879
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Feb 2014 18:38:21 -0600
Message-ID: <1392079097.3996.36.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Add iommu DMA bypass support for IODA2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Tue, 11 Feb 2014 11:38:17 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this patch adds the support for to create a direct iommu "bypass"
window on IODA2 bridges (such as Power8) allowing to bypass iommu
page translation completely for 64-bit DMA capable devices, thus
significantly improving DMA performances.

Additionally, this adds a hook to the struct iommu_table so that
the IOMMU API / VFIO can disable the bypass when external ownership
is requested, since in that case, the device will be used by an
environment such as userspace or a KVM guest which must not be
allowed to bypass translations.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is pretty much identical to the old version I posted a while ago,
except that it does have the iommu calls to enable/disable which I had
forgotten to git add before posting the previous one.

 arch/powerpc/include/asm/dma-mapping.h    |  1 +
 arch/powerpc/include/asm/iommu.h          |  1 +
 arch/powerpc/kernel/dma.c                 | 10 ++--
 arch/powerpc/kernel/iommu.c               | 12 +++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 84 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.c      | 10 ++++
 arch/powerpc/platforms/powernv/pci.h      |  6 ++-
 arch/powerpc/platforms/powernv/powernv.h  |  4 ++
 arch/powerpc/platforms/powernv/setup.c    |  9 ++++
 9 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index e27e9ad..150866b 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -134,6 +134,7 @@ static inline int dma_supported(struct device *dev, u64 mask)
 }
 
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
+extern int __dma_set_mask(struct device *dev, u64 dma_mask);
 
 #define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
 
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index f7a8036..42632c7 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -77,6 +77,7 @@ struct iommu_table {
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *it_group;
 #endif
+	void (*set_bypass)(struct iommu_table *tbl, bool enable);
 };
 
 /* Pure 2^n version of get_order */
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 8032b97..ee78f6e 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -191,12 +191,10 @@ EXPORT_SYMBOL(dma_direct_ops);
 
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 
-int dma_set_mask(struct device *dev, u64 dma_mask)
+int __dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
-	if (ppc_md.dma_set_mask)
-		return ppc_md.dma_set_mask(dev, dma_mask);
 	if ((dma_ops != NULL) && (dma_ops->set_dma_mask != NULL))
 		return dma_ops->set_dma_mask(dev, dma_mask);
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
@@ -204,6 +202,12 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 	*dev->dma_mask = dma_mask;
 	return 0;
 }
+int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	if (ppc_md.dma_set_mask)
+		return ppc_md.dma_set_mask(dev, dma_mask);
+	return __dma_set_mask(dev, dma_mask);
+}
 EXPORT_SYMBOL(dma_set_mask);
 
 u64 dma_get_required_mask(struct device *dev)
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index d773dd4..88e3ec6 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1088,6 +1088,14 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	memset(tbl->it_map, 0xff, sz);
 	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 
+	/*
+	 * Disable iommu bypass, otherwise the user can DMA to all of
+	 * our physical memory via the bypass window instead of just
+	 * the pages that has been explicitly mapped into the iommu
+	 */
+	if (tbl->set_bypass)
+		tbl->set_bypass(tbl, false);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_take_ownership);
@@ -1102,6 +1110,10 @@ void iommu_release_ownership(struct iommu_table *tbl)
 	/* Restore bit#0 set by iommu_init_table() */
 	if (tbl->it_offset == 0)
 		set_bit(0, tbl->it_map);
+
+	/* The kernel owns the device now, we can restore the iommu bypass */
+	if (tbl->set_bypass)
+		tbl->set_bypass(tbl, true);
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7d6dcc6..3b2b4fb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/msi.h>
+#include <linux/memblock.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -460,9 +461,39 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 		return;
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
+	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
 	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
 }
 
+static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
+				     struct pci_dev *pdev, u64 dma_mask)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pnv_ioda_pe *pe;
+	uint64_t top;
+	bool bypass = false;
+
+	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+		return -ENODEV;;
+
+	pe = &phb->ioda.pe_array[pdn->pe_number];
+	if (pe->tce_bypass_enabled) {
+		top = pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
+		bypass = (dma_mask >= top);
+	}
+
+	if (bypass) {
+		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
+		set_dma_ops(&pdev->dev, &dma_direct_ops);
+		set_dma_offset(&pdev->dev, pe->tce_bypass_base);
+	} else {
+		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
+		set_dma_ops(&pdev->dev, &dma_iommu_ops);
+		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+	}
+	return 0;
+}
+
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -657,6 +688,56 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
 
+static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
+{
+	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
+					      tce32_table);
+	uint16_t window_id = (pe->pe_number << 1 ) + 1;
+	int64_t rc;
+
+	pe_info(pe, "%sabling 64-bit DMA bypass\n", enable ? "En" : "Dis");
+	if (enable) {
+		phys_addr_t top = memblock_end_of_DRAM();
+
+		top = roundup_pow_of_two(top);
+		rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
+						     pe->pe_number,
+						     window_id,
+						     pe->tce_bypass_base,
+						     top);
+	} else {
+		rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
+						     pe->pe_number,
+						     window_id,
+						     pe->tce_bypass_base,
+						     0);
+
+		/*
+		 * We might want to reset the DMA ops of all devices on
+		 * this PE. However in theory, that shouldn't be necessary
+		 * as this is used for VFIO/KVM pass-through and the device
+		 * hasn't yet been returned to its kernel driver
+		 */
+	}
+	if (rc)
+		pe_err(pe, "OPAL error %lld configuring bypass window\n", rc);
+	else
+		pe->tce_bypass_enabled = enable;
+}
+
+static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
+					  struct pnv_ioda_pe *pe)
+{
+	/* TVE #1 is selected by PCI address bit 59 */
+	pe->tce_bypass_base = 1ull << 59;
+
+	/* Install set_bypass callback for VFIO */
+	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
+
+	/* Enable bypass by default */
+	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
+}
+
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
@@ -727,6 +808,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	else
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 
+	/* Also create a bypass window */
+	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
 	return;
 fail:
 	if (pe->tce32_seg >= 0)
@@ -1286,6 +1369,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
+	phb->dma_set_mask = pnv_pci_ioda_dma_set_mask;
 
 	/* Setup shutdown function for kexec */
 	phb->shutdown = pnv_pci_ioda_shutdown;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b555ebc..95633d7 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -634,6 +634,16 @@ static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 		pnv_pci_dma_fallback_setup(hose, pdev);
 }
 
+int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	if (phb && phb->dma_set_mask)
+		return phb->dma_set_mask(phb, pdev, dma_mask);
+	return __dma_set_mask(&pdev->dev, dma_mask);
+}
+
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 13f1942..cde1694 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -54,7 +54,9 @@ struct pnv_ioda_pe {
 	struct iommu_table	tce32_table;
 	phys_addr_t		tce_inval_reg_phys;
 
-	/* XXX TODO: Add support for additional 64-bit iommus */
+	/* 64-bit TCE bypass region */
+	bool			tce_bypass_enabled;
+	uint64_t		tce_bypass_base;
 
 	/* MSIs. MVE index is identical for for 32 and 64 bit MSI
 	 * and -1 if not supported. (It's actually identical to the
@@ -113,6 +115,8 @@ struct pnv_phb {
 			 unsigned int hwirq, unsigned int virq,
 			 unsigned int is_64, struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
+	int (*dma_set_mask)(struct pnv_phb *phb, struct pci_dev *pdev,
+			    u64 dma_mask);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
 	void (*shutdown)(struct pnv_phb *phb);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index de6819b..213887a 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -7,12 +7,16 @@ extern void pnv_smp_init(void);
 static inline void pnv_smp_init(void) { }
 #endif
 
+struct pci_dev;
+
 #ifdef CONFIG_PCI
 extern void pnv_pci_init(void);
 extern void pnv_pci_shutdown(void);
+extern int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask);
 #else
 static inline void pnv_pci_init(void) { }
 static inline void pnv_pci_shutdown(void) { }
+static inline int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask) { }
 #endif
 
 extern void pnv_lpc_init(void);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 21166f6..110f4fb 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/bug.h>
 #include <linux/cpuidle.h>
+#include <linux/pci.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -141,6 +142,13 @@ static void pnv_progress(char *s, unsigned short hex)
 {
 }
 
+static int pnv_dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	if (dev_is_pci(dev))
+		return pnv_pci_dma_set_mask(to_pci_dev(dev), dma_mask);
+	return __dma_set_mask(dev, dma_mask);
+}
+
 static void pnv_shutdown(void)
 {
 	/* Let the PCI code clear up IODA tables */
@@ -238,6 +246,7 @@ define_machine(powernv) {
 	.machine_shutdown	= pnv_shutdown,
 	.power_save             = powernv_idle,
 	.calibrate_decr		= generic_calibrate_decr,
+	.dma_set_mask		= pnv_dma_set_mask,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
