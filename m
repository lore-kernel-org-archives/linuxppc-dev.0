Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <a3b033f72681dd15badb0218b505512ce1c3a9c8.1197873226.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Implement pci_set_dma_mask() in terms of the dma_ops
Date: Mon, 17 Dec 2007 17:35:53 +1100 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc currently doesn't implement pci_set_dma_mask(), which means drivers
calling it will get the generic version in drivers/pci/pci.c.

The Powerpc dma mapping ops include a dma_set_mask() hook, which luckily is
not implemented by anyone - so there is no bug in the fact that the hook
is currently never called.

However in future we'll add implementation(s) of dma_set_mask(), and so we
need pci_set_dma_mask() to call the hook.

To save adding a hook to the dma mapping ops, pci-set_consistent_dma_mask()
simply calls the dma_set_mask() hook and then copies the new mask into
dev.coherenet_dma_mask.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/pci_64.c      |   16 ++++++++++++++++
 include/asm-powerpc/dma-mapping.h |    3 +++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index bf06926..f5c4628 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -69,6 +69,22 @@ struct dma_mapping_ops *get_pci_dma_ops(void)
 }
 EXPORT_SYMBOL(get_pci_dma_ops);
 
+
+int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
+{
+	return dma_set_mask(&dev->dev, mask);
+}
+
+int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
+{
+	int rc;
+
+	rc = dma_set_mask(&dev->dev, mask);
+	dev->dev.coherent_dma_mask = dev->dma_mask;
+
+	return rc;
+}
+
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
 	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index ff52013..e974876 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -87,6 +87,9 @@ static inline int dma_supported(struct device *dev, u64 mask)
 	return dma_ops->dma_supported(dev, mask);
 }
 
+/* We have our own implementation of pci_set_dma_mask() */
+#define HAVE_ARCH_PCI_SET_DMA_MASK
+
 static inline int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-- 
1.5.2.rc1.1884.g59b20
