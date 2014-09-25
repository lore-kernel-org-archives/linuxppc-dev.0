Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C318D1A009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:25:43 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 25 Sep 2014 17:25:40 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A6C9E3578047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:25:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P77G0M54067306
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:07:24 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P7P4aA009268
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:25:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/powernv: Override dma_get_required_mask()
Date: Thu, 25 Sep 2014 17:24:39 +1000
Message-Id: <1411629879-20270-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using bypass window on IODA2, the incorrect DMA operations
"dma_iommu_ops" is used by devices. The device driver calls
dma_get_required_mask() to determine using 32-bits or 64-bits
bypass DMA window. Unfortunately, the returned DMA mask always
forces the driver to use 32-bits DMA window. The problem was
reported on the device as follows:

0004:03:00.0 0107: 1000:0087 (rev 05)
0004:03:00.0 Serial Attached SCSI controller: LSI Logic / Symbios \
             Logic SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)

The patch fixes above issue by overriding dma_get_required_mask(),
which returns mask corresponding to bypass window base. Otherwise,
"dma_iommu_ops::get_required_mask" will be called to return mask
corresponding to 32-bits DMA window.

Reported-by: Murali N. Iyer <mniyer@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/dma-mapping.h    |  1 +
 arch/powerpc/kernel/dma.c                 | 14 ++++++++++----
 arch/powerpc/platforms/powernv/pci-ioda.c | 23 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.c      | 11 +++++++++++
 arch/powerpc/platforms/powernv/pci.h      |  2 ++
 arch/powerpc/platforms/powernv/powernv.h  |  6 ++++++
 arch/powerpc/platforms/powernv/setup.c    |  9 +++++++++
 7 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 150866b..894d538 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -135,6 +135,7 @@ static inline int dma_supported(struct device *dev, u64 mask)
 
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
 extern int __dma_set_mask(struct device *dev, u64 dma_mask);
+extern u64 __dma_get_required_mask(struct device *dev);
 
 #define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index ee78f6e..210ff9d 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -202,6 +202,7 @@ int __dma_set_mask(struct device *dev, u64 dma_mask)
 	*dev->dma_mask = dma_mask;
 	return 0;
 }
+
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (ppc_md.dma_set_mask)
@@ -210,13 +211,10 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 }
 EXPORT_SYMBOL(dma_set_mask);
 
-u64 dma_get_required_mask(struct device *dev)
+u64 __dma_get_required_mask(struct device *dev)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
-	if (ppc_md.dma_get_required_mask)
-		return ppc_md.dma_get_required_mask(dev);
-
 	if (unlikely(dma_ops == NULL))
 		return 0;
 
@@ -225,6 +223,14 @@ u64 dma_get_required_mask(struct device *dev)
 
 	return DMA_BIT_MASK(8 * sizeof(dma_addr_t));
 }
+
+u64 dma_get_required_mask(struct device *dev)
+{
+	if (ppc_md.dma_get_required_mask)
+		return ppc_md.dma_get_required_mask(dev);
+
+	return __dma_get_required_mask(dev);
+}
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
 static int __init dma_init(void)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 36b1a7a..380ebc9 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -890,6 +890,28 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	return 0;
 }
 
+static u64 pnv_pci_ioda_dma_get_required_mask(struct pnv_phb *phb,
+					      struct pci_dev *pdev)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pnv_ioda_pe *pe;
+	u64 end, mask;
+
+	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+		return 0;
+
+	pe = &phb->ioda.pe_array[pdn->pe_number];
+	if (!pe->tce_bypass_enabled)
+		return __dma_get_required_mask(&pdev->dev);
+
+
+	end = pe->tce_bypass_base + memblock_end_of_DRAM();
+	mask = 1ULL << (fls64(end) - 1);
+	mask += mask - 1;
+
+	return mask;
+}
+
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 				   struct pci_bus *bus,
 				   bool add_to_iommu_group)
@@ -1782,6 +1804,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
 	phb->dma_set_mask = pnv_pci_ioda_dma_set_mask;
+	phb->dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask;
 
 	/* Setup shutdown function for kexec */
 	phb->shutdown = pnv_pci_ioda_shutdown;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b854b57..e9f509b 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -761,6 +761,17 @@ int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	return __dma_set_mask(&pdev->dev, dma_mask);
 }
 
+u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	if (phb && phb->dma_get_required_mask)
+		return phb->dma_get_required_mask(phb, pdev);
+
+	return __dma_get_required_mask(&pdev->dev);
+}
+
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index b54af34..aa95fcb 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -124,6 +124,8 @@ struct pnv_phb {
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
 	int (*dma_set_mask)(struct pnv_phb *phb, struct pci_dev *pdev,
 			    u64 dma_mask);
+	u64 (*dma_get_required_mask)(struct pnv_phb *phb,
+				     struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
 	void (*shutdown)(struct pnv_phb *phb);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 75501bf..6c8e2d1 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -13,6 +13,7 @@ struct pci_dev;
 extern void pnv_pci_init(void);
 extern void pnv_pci_shutdown(void);
 extern int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask);
+extern u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev);
 #else
 static inline void pnv_pci_init(void) { }
 static inline void pnv_pci_shutdown(void) { }
@@ -21,6 +22,11 @@ static inline int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 {
 	return -ENODEV;
 }
+
+static inline u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif
 
 extern void pnv_lpc_init(void);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 5a0e2dc..0cb3a07 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -173,6 +173,14 @@ static int pnv_dma_set_mask(struct device *dev, u64 dma_mask)
 	return __dma_set_mask(dev, dma_mask);
 }
 
+static u64 pnv_dma_get_required_mask(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pnv_pci_dma_get_required_mask(to_pci_dev(dev));
+
+	return __dma_get_required_mask(dev);
+}
+
 static void pnv_shutdown(void)
 {
 	/* Let the PCI code clear up IODA tables */
@@ -335,6 +343,7 @@ define_machine(powernv) {
 	.power_save             = power7_idle,
 	.calibrate_decr		= generic_calibrate_decr,
 	.dma_set_mask		= pnv_dma_set_mask,
+	.dma_get_required_mask	= pnv_dma_get_required_mask,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
-- 
1.8.3.2
