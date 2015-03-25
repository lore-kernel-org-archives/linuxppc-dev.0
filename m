Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B8B81A07BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:27 +1100 (AEDT)
Received: by pacwe9 with SMTP id we9so17293658pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:25 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/27] powerpc: Remove shim for
 pci_controller_ops.dma_dev_setup
Date: Wed, 25 Mar 2015 16:35:59 +1100
Message-Id: <1427261761-22952-26-git-send-email-dja@axtens.net>
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
 arch/powerpc/include/asm/machdep.h    | 1 -
 arch/powerpc/include/asm/pci-bridge.h | 9 ---------
 arch/powerpc/kernel/pci-common.c      | 5 ++++-
 arch/powerpc/sysdev/dart_iommu.c      | 2 --
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index dfc8d2b..2f7b319 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -103,7 +103,6 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
 	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
 
 	/* Platform set_dma_mask and dma_get_required_mask overrides */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b5d8631..e578f67 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -280,15 +280,6 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 /*
  * Shims to prefer pci_controller version over ppc_md where available.
  */
-static inline void dma_dev_setup(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (hose->controller_ops.dma_dev_setup)
-		hose->controller_ops.dma_dev_setup(dev);
-	else if (ppc_md.pci_dma_dev_setup)
-		ppc_md.pci_dma_dev_setup(dev);
-}
 
 static inline void dma_bus_setup(struct pci_bus *bus)
 {
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a61ecb4..433b387 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -962,6 +962,7 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
 
 static void pcibios_setup_device(struct pci_dev *dev)
 {
+	struct pci_controller *hose;
 	/* Fixup NUMA node as it may not be setup yet by the generic
 	 * code and is needed by the DMA init
 	 */
@@ -972,7 +973,9 @@ static void pcibios_setup_device(struct pci_dev *dev)
 	set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
 
 	/* Additional platform DMA/iommu setup */
-	dma_dev_setup(dev);
+	hose = pci_bus_to_host(dev->bus);
+	if (hose->controller_ops.dma_dev_setup)
+		hose->controller_ops.dma_dev_setup(dev);
 
 	/* Read default IRQs and fixup if necessary */
 	pci_read_irq_line(dev);
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 120e96a..ca38b1e 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -399,7 +399,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 		controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
 		controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
 	} else {
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_dart;
 		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
 	}
 	/* Setup pci_dma ops */
@@ -412,7 +411,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 		controller_ops->dma_dev_setup = NULL;
 		controller_ops->dma_bus_setup = NULL;
 	}
-	ppc_md.pci_dma_dev_setup = NULL;
 	ppc_md.pci_dma_bus_setup = NULL;
 
 	/* Setup pci_dma ops */
-- 
2.1.4
