Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BC3EBDDFC0
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 17:07:51 +1100 (EST)
Date: Sun, 4 Mar 2007 17:02:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/6] [POWERPC] create and use get_pci_dma_ops(
Message-Id: <20070304170241.816f9802.sfr@canb.auug.org.au>
In-Reply-To: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
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

This allows us to hide pci_dma_ops.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c          |    9 +++++++--
 arch/powerpc/platforms/cell/iommu.c   |    4 ++--
 arch/powerpc/platforms/celleb/iommu.c |    2 +-
 include/asm-powerpc/pci.h             |   10 ++++++----
 4 files changed, 16 insertions(+), 9 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 73d5093..db1d40e 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -61,8 +61,7 @@ void iSeries_pcibios_init(void);
 
 LIST_HEAD(hose_list);
 
-struct dma_mapping_ops *pci_dma_ops;
-EXPORT_SYMBOL(pci_dma_ops);
+static struct dma_mapping_ops *pci_dma_ops;
 
 int global_phb_number;		/* Global phb counter */
 
@@ -75,6 +74,12 @@ void set_pci_dma_ops(struct dma_mapping_ops *dma_ops)
 	pci_dma_ops = dma_ops;
 }
 
+struct dma_mapping_ops *get_pci_dma_ops(void)
+{
+	return pci_dma_ops;
+}
+EXPORT_SYMBOL(get_pci_dma_ops);
+
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
 	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index d0e02ea..7c953cc 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -496,7 +496,7 @@ static void cell_dma_dev_setup(struct device *dev)
 	struct dev_archdata *archdata = &dev->archdata;
 
 	/* If we run without iommu, no need to do anything */
-	if (pci_dma_ops == &dma_direct_ops)
+	if (get_pci_dma_ops() == &dma_direct_ops)
 		return;
 
 	/* Current implementation uses the first window available in that
@@ -530,7 +530,7 @@ static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
 		return 0;
 
 	/* We use the PCI DMA ops */
-	dev->archdata.dma_ops = pci_dma_ops;
+	dev->archdata.dma_ops = get_pci_dma_ops();
 
 	cell_dma_dev_setup(dev);
 
diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
index fecc4ff..e94de6a 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -80,7 +80,7 @@ static int celleb_of_bus_notify(struct notifier_block *nb,
 	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	dev->archdata.dma_ops = pci_dma_ops;
+	dev->archdata.dma_ops = get_pci_dma_ops();
 
 	return 0;
 }
diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index ebf31f1..ce0f13e 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -71,17 +71,18 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 #define PCI_DISABLE_MWI
 
 #ifdef CONFIG_PCI
-extern struct dma_mapping_ops *pci_dma_ops;
-
 extern void set_pci_dma_ops(struct dma_mapping_ops *dma_ops);
+extern struct dma_mapping_ops *get_pci_dma_ops(void);
 
 /* For DAC DMA, we currently don't support it by default, but
  * we let 64-bit platforms override this.
  */
 static inline int pci_dac_dma_supported(struct pci_dev *hwdev,u64 mask)
 {
-	if (pci_dma_ops && pci_dma_ops->dac_dma_supported)
-		return pci_dma_ops->dac_dma_supported(&hwdev->dev, mask);
+	struct dma_mapping_ops *d = get_pci_dma_ops();
+
+	if (d && d->dac_dma_supported)
+		return d->dac_dma_supported(&hwdev->dev, mask);
 	return 0;
 }
 
@@ -103,6 +104,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 }
 #else	/* CONFIG_PCI */
 #define set_pci_dma_ops(d)
+#define get_pci_dma_ops()	NULL
 #endif
 
 extern int pci_domain_nr(struct pci_bus *bus);
-- 
1.5.0.1
