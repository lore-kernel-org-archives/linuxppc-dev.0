Return-Path: <dja@axtens.net>
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com
 [IPv6:2607:f8b0:400e:c02::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC8F61A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:46 +1100 (AEDT)
Received: by pdbcz9 with SMTP id cz9so16995811pdb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:45 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/27] powerpc: ppc_md.pcibios_reset_secondary_bus ->
 pci_controller_ops.reset_secondary_bus
Date: Wed, 25 Mar 2015 16:35:46 +1100
Message-Id: <1427261761-22952-13-git-send-email-dja@axtens.net>
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
 arch/powerpc/include/asm/pci-bridge.h | 17 +++++++++++++++++
 arch/powerpc/kernel/pci-common.c      |  7 +------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index dbd143f..ea9496b 100644
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
 
+static inline void reset_secondary_bus(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (hose->controller_ops.reset_secondary_bus)
+		hose->controller_ops.reset_secondary_bus(dev);
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
index c2bc023..67d4dcb 100644
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
+	reset_secondary_bus(dev);
 }
 
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
-- 
2.1.4
