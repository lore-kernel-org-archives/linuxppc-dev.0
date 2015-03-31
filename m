Return-Path: <dja@axtens.net>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E5041A060B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:27 +1100 (AEDT)
Received: by pacgg7 with SMTP id gg7so8186622pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:25 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 02/19] powerpc/powermac: move pmac_pci_probe_mode from
 setup.c to pci.c
Date: Tue, 31 Mar 2015 16:00:40 +1100
Message-Id: <1427778057-9505-3-git-send-email-dja@axtens.net>
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

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powermac/pci.c   | 17 +++++++++++++++++
 arch/powerpc/platforms/powermac/pmac.h  |  4 ++++
 arch/powerpc/platforms/powermac/setup.c | 18 ------------------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index f4071a6..a792f45 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -1223,3 +1223,20 @@ static void fixup_u4_pcie(struct pci_dev* dev)
 	pci_write_config_dword(dev, PCI_PREF_MEMORY_BASE, 0);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_U4_PCIE, fixup_u4_pcie);
+
+#ifdef CONFIG_PPC64
+int pmac_pci_probe_mode(struct pci_bus *bus)
+{
+	struct device_node *node = pci_bus_to_OF_node(bus);
+
+	/* We need to use normal PCI probing for the AGP bus,
+	 * since the device for the AGP bridge isn't in the tree.
+	 * Same for the PCIe host on U4 and the HT host bridge.
+	 */
+	if (bus->self == NULL && (of_device_is_compatible(node, "u3-agp") ||
+				  of_device_is_compatible(node, "u4-pcie") ||
+				  of_device_is_compatible(node, "u3-ht")))
+		return PCI_PROBE_NORMAL;
+	return PCI_PROBE_DEVTREE;
+}
+#endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 8327cce..46d2193 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -39,4 +39,8 @@ extern void low_cpu_die(void) __attribute__((noreturn));
 extern int pmac_nvram_init(void);
 extern void pmac_pic_init(void);
 
+#ifdef CONFIG_PPC64
+extern int pmac_pci_probe_mode(struct pci_bus *bus);
+#endif
+
 #endif /* __PMAC_H__ */
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 713d36d..efe172d 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -637,24 +637,6 @@ static int __init pmac_probe(void)
 	return 1;
 }
 
-#ifdef CONFIG_PPC64
-/* Move that to pci.c */
-static int pmac_pci_probe_mode(struct pci_bus *bus)
-{
-	struct device_node *node = pci_bus_to_OF_node(bus);
-
-	/* We need to use normal PCI probing for the AGP bus,
-	 * since the device for the AGP bridge isn't in the tree.
-	 * Same for the PCIe host on U4 and the HT host bridge.
-	 */
-	if (bus->self == NULL && (of_device_is_compatible(node, "u3-agp") ||
-				  of_device_is_compatible(node, "u4-pcie") ||
-				  of_device_is_compatible(node, "u3-ht")))
-		return PCI_PROBE_NORMAL;
-	return PCI_PROBE_DEVTREE;
-}
-#endif /* CONFIG_PPC64 */
-
 define_machine(powermac) {
 	.name			= "PowerMac",
 	.probe			= pmac_probe,
-- 
2.1.4
