Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC4D01A0682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:17 +1100 (AEDT)
Received: by pagj7 with SMTP id j7so17266109pag.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:16 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/27] powerpc: Remove shim for
 pci_controller_ops.reset_secondary_bus
Date: Wed, 25 Mar 2015 16:35:56 +1100
Message-Id: <1427261761-22952-23-git-send-email-dja@axtens.net>
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
 arch/powerpc/include/asm/machdep.h    |  3 ---
 arch/powerpc/include/asm/pci-bridge.h | 16 ----------------
 arch/powerpc/kernel/pci-common.c      |  9 ++++++++-
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index f1476b8..f178cf1 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -244,9 +244,6 @@ struct machdep_calls {
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
 
-	/* Reset the secondary bus of bridge */
-	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
-
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b62e043..b08db93 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -327,21 +327,5 @@ static inline bool enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
-static inline void reset_secondary_bus(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (hose->controller_ops.reset_secondary_bus)
-		hose->controller_ops.reset_secondary_bus(dev);
-	else if (ppc_md.pcibios_reset_secondary_bus)
-		ppc_md.pcibios_reset_secondary_bus(dev);
-	else
-		/*
-		 * Fallback to the generic function if no
-		 * platform-specific one is provided
-		 */
-		pci_reset_secondary_bus(dev);
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 9edb479..a535d31 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -124,7 +124,14 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
-	reset_secondary_bus(dev);
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (hose->controller_ops.reset_secondary_bus) {
+		hose->controller_ops.reset_secondary_bus(dev);
+		return;
+	}
+
+	pci_reset_secondary_bus(dev);
 }
 
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
-- 
2.1.4
