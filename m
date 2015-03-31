Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0772B1A07BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:33 +1100 (AEDT)
Received: by pdrw1 with SMTP id w1so211198pdr.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:31 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 04/19] powerpc: Create pci_controller_ops.dma_dev_setup and
 shim
Date: Tue, 31 Mar 2015 16:00:42 +1100
Message-Id: <1427778057-9505-5-git-send-email-dja@axtens.net>
In-Reply-To: <1427778057-9505-1-git-send-email-dja@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduces the pci_controller_ops structure.
Add pci_controller_ops.dma_dev_setup, shadowing ppc_md.pci_dma_dev_setup.
Add a shim, and change the callsites to use the shim.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Better commit message
 - Use phb in favour of hose
 - Make shim name match ppc_md name, not pci_controller_ops name.
---
 arch/powerpc/include/asm/pci-bridge.h | 21 +++++++++++++++++++++
 arch/powerpc/kernel/pci-common.c      |  3 +--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 546d036..347d49d 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -15,6 +15,13 @@
 struct device_node;
 
 /*
+ * PCI controller operations
+ */
+struct pci_controller_ops {
+	void		(*dma_dev_setup)(struct pci_dev *dev);
+};
+
+/*
  * Structure of a PCI controller (host bridge)
  */
 struct pci_controller {
@@ -46,6 +53,7 @@ struct pci_controller {
 	resource_size_t	isa_mem_phys;
 	resource_size_t	isa_mem_size;
 
+	struct pci_controller_ops controller_ops;
 	struct pci_ops *ops;
 	unsigned int __iomem *cfg_addr;
 	void __iomem *cfg_data;
@@ -258,5 +266,18 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 }
 #endif	/* CONFIG_PCI */
 
+/*
+ * Shims to prefer pci_controller version over ppc_md where available.
+ */
+static inline void pci_dma_dev_setup(struct pci_dev *dev)
+{
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if (phb->controller_ops.dma_dev_setup)
+		phb->controller_ops.dma_dev_setup(dev);
+	else if (ppc_md.pci_dma_dev_setup)
+		ppc_md.pci_dma_dev_setup(dev);
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 3d07d81..bce6356 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -969,8 +969,7 @@ static void pcibios_setup_device(struct pci_dev *dev)
 	set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
 
 	/* Additional platform DMA/iommu setup */
-	if (ppc_md.pci_dma_dev_setup)
-		ppc_md.pci_dma_dev_setup(dev);
+	pci_dma_dev_setup(dev);
 
 	/* Read default IRQs and fixup if necessary */
 	pci_read_irq_line(dev);
-- 
2.1.4
