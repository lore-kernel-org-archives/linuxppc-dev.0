Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 64E6F2C008C
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2013 19:36:28 +1100 (EST)
Message-ID: <1385195773.4882.128.camel@pasglop>
Subject: [RFC,PATCH] powerpc/powernv: Add iommu DMA bypass support for IODA2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Sat, 23 Nov 2013 19:36:13 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the support for to create a direct iommu "bypass"
window on IODA2 bridges (such as Power8) allowing to bypass iommu
page translation completely for 64-bit DMA capable devices.

This is currently enabled unconditionally for any 64-bit device,
we *may* want to make it conditional to a command line argument.

Additionally, this adds a hook to the struct iommu_table so that
the IOMMU API / VFIO can disable the bypass when external ownership
is requested, since in that case, the device will be used by an
environment such as userspace or a KVM guest which must not be
allowed to bypass translations.

It should be possible to do something similar for IODA1 (Power7)
though not all versions of OPALv2/v3 out there support that properly
so for now I won't bother.

Not-yet-signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

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
index c34656a..ed2e582 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -79,6 +79,7 @@ struct iommu_table {
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *it_group;
 #endif
+	void (*set_bypass)(struct iommu_table *tbl, bool enable);
 };
 
 struct scatterlist;
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
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 084cdfa..0425a2e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/msi.h>
+#include <linux/memblock.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -460,7 +461,38 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 		return;
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
-	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+	if (get_dma_ops(&pdev->dev) == &dma_direct_ops)
+		set_dma_offset(&pdev->dev, pe->tce_bypass_base);
+	else
+		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+}
+
+static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
+				     struct pci_dev *pdev, u64 dma_mask)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pnv_ioda_pe *pe;
+	uint64_t top;
+	bool bypass = false;
+
+	if (!WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE)) {
+		pe = &phb->ioda.pe_array[pdn->pe_number];
+		if (pe->tce_bypass_enabled) {
+			top = pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
+			bypass = (dma_mask >= top);
+		}
+	}
+
+	if (bypass) {
+		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
+		set_dma_ops(&pdev->dev, &dma_direct_ops);
+	} else {
+		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
+		set_dma_ops(&pdev->dev, &dma_iommu_ops);
+	}
+	pnv_pci_ioda_dma_dev_setup(phb, pdev);
+
+	return 0;
 }
 
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
@@ -657,6 +689,56 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
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
@@ -726,6 +808,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	else
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 
+	/* Also create a bypass window */
+	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
 	return;
 fail:
 	if (pe->tce32_seg >= 0)
@@ -1286,6 +1370,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
+	phb->dma_set_mask = pnv_pci_ioda_dma_set_mask;
 
 	/* Setup shutdown function for kexec */
 	phb->shutdown = pnv_pci_ioda_shutdown;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4eb33a9..e96af77 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -553,6 +553,16 @@ static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
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
index 911c24e..62ac4ef 100644
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
index 19884b2..f519f55 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -26,6 +26,7 @@
 #include <linux/of_fdt.h>
 #include <linux/interrupt.h>
 #include <linux/bug.h>
+#include <linux/pci.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -140,6 +141,13 @@ static void pnv_progress(char *s, unsigned short hex)
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
@@ -223,6 +231,7 @@ define_machine(powernv) {
 	.show_cpuinfo		= pnv_show_cpuinfo,
 	.progress		= pnv_progress,
 	.machine_shutdown	= pnv_shutdown,
+	.dma_set_mask		= pnv_dma_set_mask,
 	.power_save             = power7_idle,
 	.calibrate_decr		= generic_calibrate_decr,
 #ifdef CONFIG_KEXEC
