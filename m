Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C6C25DDE2E
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 17:07:50 +1100 (EST)
Date: Sun, 4 Mar 2007 16:58:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/6] [POWERPC] create and use set_pci_dma_ops
Message-Id: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will allow us to build without PCI easier.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c           |    5 +++++
 arch/powerpc/platforms/cell/iommu.c    |    4 ++--
 arch/powerpc/platforms/celleb/iommu.c  |    2 +-
 arch/powerpc/platforms/iseries/iommu.c |    2 +-
 arch/powerpc/platforms/pasemi/iommu.c  |    4 ++--
 arch/powerpc/platforms/pseries/iommu.c |    4 ++--
 arch/powerpc/sysdev/dart_iommu.c       |    4 ++--
 include/asm-powerpc/pci.h              |    6 +++++-
 8 files changed, 20 insertions(+), 11 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 7e97d71..73d5093 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -70,6 +70,11 @@ int global_phb_number;		/* Global phb counter */
 struct pci_dev *ppc64_isabridge_dev = NULL;
 EXPORT_SYMBOL_GPL(ppc64_isabridge_dev);
 
+void set_pci_dma_ops(struct dma_mapping_ops *dma_ops)
+{
+	pci_dma_ops = dma_ops;
+}
+
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
 	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 67d617b..d0e02ea 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -646,7 +646,7 @@ static int __init cell_iommu_init_disabled(void)
 	unsigned long base = 0, size;
 
 	/* When no iommu is present, we use direct DMA ops */
-	pci_dma_ops = &dma_direct_ops;
+	set_pci_dma_ops(&dma_direct_ops);
 
 	/* First make sure all IOC translation is turned off */
 	cell_disable_iommus();
@@ -734,7 +734,7 @@ static int __init cell_iommu_init(void)
 	}
 
 	/* Setup default PCI iommu ops */
-	pci_dma_ops = &dma_iommu_ops;
+	set_pci_dma_ops(&dma_iommu_ops);
 
  bail:
 	/* Register callbacks on OF platform device addition/removal
diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
index f63b94c..fecc4ff 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -95,7 +95,7 @@ static int __init celleb_init_iommu(void)
 		return -ENODEV;
 
 	celleb_init_direct_mapping();
-	pci_dma_ops = &dma_direct_ops;
+	set_pci_dma_ops(&dma_direct_ops);
 	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
 
 	return 0;
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index d7a756d..7df2902 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -194,5 +194,5 @@ void iommu_init_early_iSeries(void)
 	ppc_md.tce_build = tce_build_iSeries;
 	ppc_md.tce_free  = tce_free_iSeries;
 
-	pci_dma_ops = &dma_iommu_ops;
+	set_pci_dma_ops(&dma_iommu_ops);
 }
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 459a53b..4587c1d 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -255,7 +255,7 @@ void iommu_init_early_pasemi(void)
 		/* Direct I/O, IOMMU off */
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_null;
 		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_null;
-		pci_dma_ops = &dma_direct_ops;
+		set_pci_dma_ops(&dma_direct_ops);
 
 		return;
 	}
@@ -266,7 +266,7 @@ void iommu_init_early_pasemi(void)
 	ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pasemi;
 	ppc_md.tce_build = iobmap_build;
 	ppc_md.tce_free  = iobmap_free;
-	pci_dma_ops = &dma_iommu_ops;
+	set_pci_dma_ops(&dma_iommu_ops);
 }
 
 void __init alloc_iobmap_l2(void)
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e6653a8..9322f74 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -562,7 +562,7 @@ void iommu_init_early_pSeries(void)
 		/* Direct I/O, IOMMU off */
 		ppc_md.pci_dma_dev_setup = NULL;
 		ppc_md.pci_dma_bus_setup = NULL;
-		pci_dma_ops = &dma_direct_ops;
+		set_pci_dma_ops(&dma_direct_ops);
 		return;
 	}
 
@@ -588,6 +588,6 @@ void iommu_init_early_pSeries(void)
 
 	pSeries_reconfig_notifier_register(&iommu_reconfig_nb);
 
-	pci_dma_ops = &dma_iommu_ops;
+	set_pci_dma_ops(&dma_iommu_ops);
 }
 
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 1488535..336186d 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -333,7 +333,7 @@ void iommu_init_early_dart(void)
 		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
 
 		/* Setup pci_dma ops */
-		pci_dma_ops = &dma_iommu_ops;
+		set_pci_dma_ops(&dma_iommu_ops);
 		return;
 	}
 
@@ -343,7 +343,7 @@ void iommu_init_early_dart(void)
 	ppc_md.pci_dma_bus_setup = NULL;
 
 	/* Setup pci_dma ops */
-	pci_dma_ops = &dma_direct_ops;
+	set_pci_dma_ops(&dma_direct_ops);
 }
 
 
diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index ac656ee..ebf31f1 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -70,8 +70,11 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
  */
 #define PCI_DISABLE_MWI
 
+#ifdef CONFIG_PCI
 extern struct dma_mapping_ops *pci_dma_ops;
 
+extern void set_pci_dma_ops(struct dma_mapping_ops *dma_ops);
+
 /* For DAC DMA, we currently don't support it by default, but
  * we let 64-bit platforms override this.
  */
@@ -82,7 +85,6 @@ static inline int pci_dac_dma_supported(struct pci_dev *hwdev,u64 mask)
 	return 0;
 }
 
-#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -99,6 +101,8 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 	*strat = PCI_DMA_BURST_MULTIPLE;
 	*strategy_parameter = cacheline_size;
 }
+#else	/* CONFIG_PCI */
+#define set_pci_dma_ops(d)
 #endif
 
 extern int pci_domain_nr(struct pci_bus *bus);
-- 
1.5.0.1
