Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 822A51A077F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:43 +1100 (AEDT)
Received: by pacwe9 with SMTP id we9so17277104pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:41 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/27] powerpc: ppc_md.pcibios_window_alignment ->
 pci_controller_ops.window_alignment
Date: Wed, 25 Mar 2015 16:35:45 +1100
Message-Id: <1427261761-22952-12-git-send-email-dja@axtens.net>
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

Name the shim pci_window_alignment (rather than window_alignment)
to avoid clashing with window_alignment in drivers/pci/setup-bus.c

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/pci-bridge.h | 21 +++++++++++++++++++++
 arch/powerpc/kernel/pci-common.c      | 10 +---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 5f7e773..dbd143f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -31,6 +31,9 @@ struct pci_controller_ops {
 	/* Called when pci_enable_device() is called. Returns true to
 	 * allow assignment/enabling of the device. */
 	bool		(*enable_device_hook)(struct pci_dev *);
+
+	/* Called during PCI resource reassignment */
+	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
 };
 
 /*
@@ -323,5 +326,23 @@ static inline bool enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
+static inline resource_size_t pci_window_alignment(struct pci_bus *bus,
+						   unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+
+	if (hose->controller_ops.window_alignment)
+		return hose->controller_ops.window_alignment(bus, type);
+	if (ppc_md.pcibios_window_alignment)
+		return ppc_md.pcibios_window_alignment(bus, type);
+
+	/*
+	 * PCI core will figure out the default
+	 * alignment: 4KiB for I/O and 1MiB for
+	 * memory window.
+	 */
+	return 1;
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8f939b0..c2bc023 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -109,15 +109,7 @@ void pcibios_free_controller(struct pci_controller *phb)
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type)
 {
-	if (ppc_md.pcibios_window_alignment)
-		return ppc_md.pcibios_window_alignment(bus, type);
-
-	/*
-	 * PCI core will figure out the default
-	 * alignment: 4KiB for I/O and 1MiB for
-	 * memory window.
-	 */
-	return 1;
+	return pci_window_alignment(bus, type);
 }
 
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
-- 
2.1.4
