Return-Path: <dja@axtens.net>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70A131A088D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:34 +1100 (AEDT)
Received: by pacwe9 with SMTP id we9so17273475pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:32 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/27] powerpc: ppc_md.pci_dma_bus_setup ->
 pci_controller_ops.dma_bus_setup
Date: Wed, 25 Mar 2015 16:35:42 +1100
Message-Id: <1427261761-22952-9-git-send-email-dja@axtens.net>
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
 arch/powerpc/include/asm/pci-bridge.h | 11 +++++++++++
 arch/powerpc/kernel/pci-common.c      |  3 +--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 2474f29..680a46d 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -19,6 +19,7 @@ struct device_node;
  */
 struct pci_controller_ops {
 	void		(*dma_dev_setup)(struct pci_dev *dev);
+	void		(*dma_bus_setup)(struct pci_bus *bus);
 };
 
 /*
@@ -279,5 +280,15 @@ static inline void dma_dev_setup(struct pci_dev *dev)
 		ppc_md.pci_dma_dev_setup(dev);
 }
 
+static inline void dma_bus_setup(struct pci_bus *bus)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+
+	if (hose->controller_ops.dma_bus_setup)
+		hose->controller_ops.dma_bus_setup(bus);
+	else if (ppc_md.pci_dma_bus_setup)
+		ppc_md.pci_dma_bus_setup(bus);
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 3ce6d0c..f5280ec 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -953,8 +953,7 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pcibios_fixup_bus(bus);
 
 	/* Setup bus DMA mappings */
-	if (ppc_md.pci_dma_bus_setup)
-		ppc_md.pci_dma_bus_setup(bus);
+	dma_bus_setup(bus);
 }
 
 static void pcibios_setup_device(struct pci_dev *dev)
-- 
2.1.4
