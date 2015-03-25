Return-Path: <dja@axtens.net>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 971561A0A0C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:30 +1100 (AEDT)
Received: by pabxg6 with SMTP id xg6so17393574pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 26/27] powerpc: Remove shim for
 pci_controller_ops.dma_bus_setup
Date: Wed, 25 Mar 2015 16:36:00 +1100
Message-Id: <1427261761-22952-27-git-send-email-dja@axtens.net>
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
 arch/powerpc/include/asm/machdep.h    |  2 --
 arch/powerpc/include/asm/pci-bridge.h | 14 --------------
 arch/powerpc/kernel/pci-common.c      |  5 ++++-
 arch/powerpc/sysdev/dart_iommu.c      |  3 ---
 4 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2f7b319..92b085b 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -103,8 +103,6 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
-
 	/* Platform set_dma_mask and dma_get_required_mask overrides */
 	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
 	u64		(*dma_get_required_mask)(struct device *dev);
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index e578f67..4f39ef9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -277,19 +277,5 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 }
 #endif	/* CONFIG_PCI */
 
-/*
- * Shims to prefer pci_controller version over ppc_md where available.
- */
-
-static inline void dma_bus_setup(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-
-	if (hose->controller_ops.dma_bus_setup)
-		hose->controller_ops.dma_bus_setup(bus);
-	else if (ppc_md.pci_dma_bus_setup)
-		ppc_md.pci_dma_bus_setup(bus);
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 433b387..7447b10 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -946,6 +946,7 @@ static void pcibios_fixup_bridge(struct pci_bus *bus)
 
 void pcibios_setup_bus_self(struct pci_bus *bus)
 {
+	struct pci_controller *hose;
 	/* Fix up the bus resources for P2P bridges */
 	if (bus->self != NULL)
 		pcibios_fixup_bridge(bus);
@@ -957,7 +958,9 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pcibios_fixup_bus(bus);
 
 	/* Setup bus DMA mappings */
-	dma_bus_setup(bus);
+	hose = pci_bus_to_host(bus);
+	if (hose->controller_ops.dma_bus_setup)
+		hose->controller_ops.dma_bus_setup(bus);
 }
 
 static void pcibios_setup_device(struct pci_dev *dev)
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index ca38b1e..87b8000 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -398,8 +398,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 	if (controller_ops) {
 		controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
 		controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
-	} else {
-		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
 	}
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
@@ -411,7 +409,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 		controller_ops->dma_dev_setup = NULL;
 		controller_ops->dma_bus_setup = NULL;
 	}
-	ppc_md.pci_dma_bus_setup = NULL;
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_direct_ops);
-- 
2.1.4
