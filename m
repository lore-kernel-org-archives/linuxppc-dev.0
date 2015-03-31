Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0D711A0739
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:41 +1100 (AEDT)
Received: by pactp5 with SMTP id tp5so8105042pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:39 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/19] powerpc: Create
 pci_controller_ops.enable_device_hook and shim
Date: Tue, 31 Mar 2015 16:00:45 +1100
Message-Id: <1427778057-9505-8-git-send-email-dja@axtens.net>
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

Add pci_controller_ops.enable_device_hook,
shadowing ppc_md.pcibios_enable_device_hook.
Add a shim, and changes the callsites to use the shim.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Better commit message
 - Use phb in favour of hose
 - Make shim name match ppc_md name, not pci_controller_ops name.
---
 arch/powerpc/include/asm/pci-bridge.h | 15 +++++++++++++++
 arch/powerpc/kernel/pci-common.c      |  5 ++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 65ffc16..ece38e2 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -27,6 +27,10 @@ struct pci_controller_ops {
 	void		(*dma_bus_setup)(struct pci_bus *bus);
 
 	int		(*probe_mode)(struct pci_bus *);
+
+	/* Called when pci_enable_device() is called. Returns true to
+	 * allow assignment/enabling of the device. */
+	bool		(*enable_device_hook)(struct pci_dev *);
 };
 
 /*
@@ -308,5 +312,16 @@ static inline int pci_probe_mode(struct pci_bus *bus)
 	return PCI_PROBE_NORMAL;
 }
 
+static inline bool pcibios_enable_device_hook(struct pci_dev *dev)
+{
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if (phb->controller_ops.enable_device_hook)
+		return phb->controller_ops.enable_device_hook(dev);
+	if (ppc_md.pcibios_enable_device_hook)
+		return ppc_md.pcibios_enable_device_hook(dev);
+	return true;
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 977859e..fe8c893 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1448,9 +1448,8 @@ EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	if (ppc_md.pcibios_enable_device_hook)
-		if (!ppc_md.pcibios_enable_device_hook(dev))
-			return -EINVAL;
+	if (!pcibios_enable_device_hook(dev))
+		return -EINVAL;
 
 	return pci_enable_resources(dev, mask);
 }
-- 
2.1.4
