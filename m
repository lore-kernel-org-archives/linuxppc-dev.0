Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F6C31A09BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:44 +1100 (AEDT)
Received: by patj18 with SMTP id j18so8084258pat.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:42 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/19] powerpc: Create pci_controller_ops.window_alignment
 and shim
Date: Tue, 31 Mar 2015 16:00:46 +1100
Message-Id: <1427778057-9505-9-git-send-email-dja@axtens.net>
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

Add pci_controller_ops.window_alignment,
shadowing ppc_md.pcibios_window_alignment.
Add a shim, and changes the callsites to use the shim.

Here, we use pci_window_alignment, as pcibios_window_alignment is
already taken.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Better commit message
 - Use phb in favour of hose
---
 arch/powerpc/include/asm/pci-bridge.h | 21 +++++++++++++++++++++
 arch/powerpc/kernel/pci-common.c      | 10 +---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ece38e2..cc91bc0 100644
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
@@ -323,5 +326,23 @@ static inline bool pcibios_enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
+static inline resource_size_t pci_window_alignment(struct pci_bus *bus,
+						   unsigned long type)
+{
+	struct pci_controller *phb = pci_bus_to_host(bus);
+
+	if (phb->controller_ops.window_alignment)
+		return phb->controller_ops.window_alignment(bus, type);
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
index fe8c893..f1512b5 100644
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
