Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com
 [IPv6:2607:f8b0:400e:c02::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59E6F1A09AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:47 +1100 (AEDT)
Received: by pdbni2 with SMTP id ni2so8530053pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:45 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 09/19] powerpc: Create
 pci_controller_ops.reset_secondary_bus and shim
Date: Tue, 31 Mar 2015 16:00:47 +1100
Message-Id: <1427778057-9505-10-git-send-email-dja@axtens.net>
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

Add pci_controller_ops.reset_secondary_bus,
shadowing ppc_md.pcibios_reset_secondary_bus.
Add a shim, and changes the callsites to use the shim.

Use pcibios_reset_secondary_bus_shim, as both
pcibios_reset_secondary_bus and pci_reset_secondary_bus
are already taken.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Better commit message
 - Use phb in favour of hose
 - Make shim name namespaced, not the raw pci_controller_ops name.
---
 arch/powerpc/include/asm/pci-bridge.h | 17 +++++++++++++++++
 arch/powerpc/kernel/pci-common.c      |  7 +------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index cc91bc0..d2cba2f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -34,6 +34,7 @@ struct pci_controller_ops {
 
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
+	void		(*reset_secondary_bus)(struct pci_dev *dev);
 };
 
 /*
@@ -344,5 +345,21 @@ static inline resource_size_t pci_window_alignment(struct pci_bus *bus,
 	return 1;
 }
 
+static inline void pcibios_reset_secondary_bus_shim(struct pci_dev *dev)
+{
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if (phb->controller_ops.reset_secondary_bus)
+		phb->controller_ops.reset_secondary_bus(dev);
+	else if (ppc_md.pcibios_reset_secondary_bus)
+		ppc_md.pcibios_reset_secondary_bus(dev);
+	else
+		/*
+		 * Fallback to the generic function if no
+		 * platform-specific one is provided
+		 */
+		pci_reset_secondary_bus(dev);
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f1512b5..8b3616a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -114,12 +114,7 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
-	if (ppc_md.pcibios_reset_secondary_bus) {
-		ppc_md.pcibios_reset_secondary_bus(dev);
-		return;
-	}
-
-	pci_reset_secondary_bus(dev);
+	pcibios_reset_secondary_bus_shim(dev);
 }
 
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
-- 
2.1.4
