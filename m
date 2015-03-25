Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54CE01A0741
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:15 +1100 (AEDT)
Received: by pdbop1 with SMTP id op1so17015505pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:13 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/27] powerpc/powermac: move pmac_pci_probe_mode from setup.c
 to pci.c
Date: Wed, 25 Mar 2015 16:35:36 +1100
Message-Id: <1427261761-22952-3-git-send-email-dja@axtens.net>
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
