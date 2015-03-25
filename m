Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 007FD1A0680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:14 +1100 (AEDT)
Received: by pabxg6 with SMTP id xg6so17387535pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:13 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 21/27] powerpc: Remove shim for
 pci_controller_ops.window_alignment
Date: Wed, 25 Mar 2015 16:35:55 +1100
Message-Id: <1427261761-22952-22-git-send-email-dja@axtens.net>
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
 arch/powerpc/include/asm/pci-bridge.h | 18 ------------------
 arch/powerpc/kernel/pci-common.c      | 12 +++++++++++-
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 9d4a067..f1476b8 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -244,9 +244,6 @@ struct machdep_calls {
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
 
-	/* Called during PCI resource reassignment */
-	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
-
 	/* Reset the secondary bus of bridge */
 	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
 
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ea9496b..b62e043 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -327,24 +327,6 @@ static inline bool enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
-static inline resource_size_t pci_window_alignment(struct pci_bus *bus,
-						   unsigned long type)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-
-	if (hose->controller_ops.window_alignment)
-		return hose->controller_ops.window_alignment(bus, type);
-	if (ppc_md.pcibios_window_alignment)
-		return ppc_md.pcibios_window_alignment(bus, type);
-
-	/*
-	 * PCI core will figure out the default
-	 * alignment: 4KiB for I/O and 1MiB for
-	 * memory window.
-	 */
-	return 1;
-}
-
 static inline void reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 67d4dcb..9edb479 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -109,7 +109,17 @@ void pcibios_free_controller(struct pci_controller *phb)
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type)
 {
-	return pci_window_alignment(bus, type);
+	struct pci_controller *hose = pci_bus_to_host(bus);
+
+	if (hose->controller_ops.window_alignment)
+		return hose->controller_ops.window_alignment(bus, type);
+
+	/*
+	 * PCI core will figure out the default
+	 * alignment: 4KiB for I/O and 1MiB for
+	 * memory window.
+	 */
+	return 1;
 }
 
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
-- 
2.1.4
