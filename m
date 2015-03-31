Return-Path: <dja@axtens.net>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BADE41A0736
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:35 +1100 (AEDT)
Received: by pacgg7 with SMTP id gg7so8190198pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:34 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/19] powerpc: Create pci_controller_ops.dma_bus_setup and
 shim
Date: Tue, 31 Mar 2015 16:00:43 +1100
Message-Id: <1427778057-9505-6-git-send-email-dja@axtens.net>
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

Add pci_controller_ops.dma_bus_setup, shadowing ppc_md.pci_dma_bus_setup.
Add a shim, and changes the callsites to use the shim.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Better commit message
 - Use phb in favour of hose
 - Make shim name match ppc_md name, not pci_controller_ops name.
---
 arch/powerpc/include/asm/pci-bridge.h | 11 +++++++++++
 arch/powerpc/kernel/pci-common.c      |  3 +--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 347d49d..44305ac 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -19,6 +19,7 @@ struct device_node;
  */
 struct pci_controller_ops {
 	void		(*dma_dev_setup)(struct pci_dev *dev);
+	void		(*dma_bus_setup)(struct pci_bus *bus);
 };
 
 /*
@@ -279,5 +280,15 @@ static inline void pci_dma_dev_setup(struct pci_dev *dev)
 		ppc_md.pci_dma_dev_setup(dev);
 }
 
+static inline void pci_dma_bus_setup(struct pci_bus *bus)
+{
+	struct pci_controller *phb = pci_bus_to_host(bus);
+
+	if (phb->controller_ops.dma_bus_setup)
+		phb->controller_ops.dma_bus_setup(bus);
+	else if (ppc_md.pci_dma_bus_setup)
+		ppc_md.pci_dma_bus_setup(bus);
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index bce6356..317ed00 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -953,8 +953,7 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pcibios_fixup_bus(bus);
 
 	/* Setup bus DMA mappings */
-	if (ppc_md.pci_dma_bus_setup)
-		ppc_md.pci_dma_bus_setup(bus);
+	pci_dma_bus_setup(bus);
 }
 
 static void pcibios_setup_device(struct pci_dev *dev)
-- 
2.1.4
