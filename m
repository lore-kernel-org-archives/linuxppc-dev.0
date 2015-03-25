Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02CC71A0A08
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:21 +1100 (AEDT)
Received: by padcy3 with SMTP id cy3so17203262pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:19 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 23/27] powerpc: Remove shim for
 pci_controller_ops.enable_device_hook
Date: Wed, 25 Mar 2015 16:35:57 +1100
Message-Id: <1427261761-22952-24-git-send-email-dja@axtens.net>
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
 arch/powerpc/include/asm/machdep.h    |  4 ----
 arch/powerpc/include/asm/pci-bridge.h | 11 -----------
 arch/powerpc/kernel/pci-common.c      |  7 +++++--
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index f178cf1..5549b6c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -237,10 +237,6 @@ struct machdep_calls {
 	/* Called for each PCI bus in the system when it's probed */
 	void (*pcibios_fixup_bus)(struct pci_bus *);
 
-	/* Called when pci_enable_device() is called. Returns true to
-	 * allow assignment/enabling of the device. */
-	bool (*pcibios_enable_device_hook)(struct pci_dev *);
-
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
 
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b08db93..029def0 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -316,16 +316,5 @@ static inline int probe_mode(struct pci_bus *bus)
 	return PCI_PROBE_NORMAL;
 }
 
-static inline bool enable_device_hook(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (hose->controller_ops.enable_device_hook)
-		return hose->controller_ops.enable_device_hook(dev);
-	if (ppc_md.pcibios_enable_device_hook)
-		return ppc_md.pcibios_enable_device_hook(dev);
-	return true;
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a535d31..5b90e99c 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1452,8 +1452,11 @@ EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	if (!enable_device_hook(dev))
-		return -EINVAL;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (hose->controller_ops.enable_device_hook)
+		if (!hose->controller_ops.enable_device_hook(dev))
+			return -EINVAL;
 
 	return pci_enable_resources(dev, mask);
 }
-- 
2.1.4
