Return-Path: <dja@axtens.net>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 217CB1A08B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:31 +1100 (AEDT)
Received: by padcy3 with SMTP id cy3so17184541pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/27] powerpc: ppc_md.pci_dma_dev_setup ->
 pci_controller_ops.dma_dev_setup
Date: Wed, 25 Mar 2015 16:35:41 +1100
Message-Id: <1427261761-22952-8-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/pci-bridge.h | 14 ++++++++++++++
 arch/powerpc/kernel/pci-common.c      |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 3ab8a2d..2474f29 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -18,6 +18,7 @@ struct device_node;
  * PCI controller operations
  */
 struct pci_controller_ops {
+	void		(*dma_dev_setup)(struct pci_dev *dev);
 };
 
 /*
@@ -265,5 +266,18 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 }
 #endif	/* CONFIG_PCI */
 
+/*
+ * Shims to prefer pci_controller version over ppc_md where available.
+ */
+static inline void dma_dev_setup(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (hose->controller_ops.dma_dev_setup)
+		hose->controller_ops.dma_dev_setup(dev);
+	else if (ppc_md.pci_dma_dev_setup)
+		ppc_md.pci_dma_dev_setup(dev);
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 3d07d81..3ce6d0c 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -969,8 +969,7 @@ static void pcibios_setup_device(struct pci_dev *dev)
 	set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
 
 	/* Additional platform DMA/iommu setup */
-	if (ppc_md.pci_dma_dev_setup)
-		ppc_md.pci_dma_dev_setup(dev);
+	dma_dev_setup(dev);
 
 	/* Read default IRQs and fixup if necessary */
 	pci_read_irq_line(dev);
-- 
2.1.4
