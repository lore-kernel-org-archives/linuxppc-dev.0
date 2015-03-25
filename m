Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13C161A025A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:12 +1100 (AEDT)
Received: by pacwe9 with SMTP id we9so17265254pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:10 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/27] powerpc: move find_and_init_phbs() to pSeries specific
 code
Date: Wed, 25 Mar 2015 16:35:35 +1100
Message-Id: <1427261761-22952-2-git-send-email-dja@axtens.net>
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

Previously, find_and_init_phbs() was used in both PowerNV and pSeries
setup. However, since RTAS support has been dropped from PowerNV, we
can move it into a platform-specific file.

This patch depends on the patch to drop RTAS support from PowerNV:
http://patchwork.ozlabs.org/patch/449316/

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/ppc-pci.h     |  3 ---
 arch/powerpc/kernel/rtas_pci.c         | 47 ----------------------------------
 arch/powerpc/platforms/pseries/setup.c | 47 ++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index db1e2b8..83f7e8e 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -23,8 +23,6 @@ extern void pci_setup_phb_io_dynamic(struct pci_controller *hose, int primary);
 
 extern struct list_head hose_list;
 
-extern void find_and_init_phbs(void);
-
 extern struct pci_dev *isa_bridge_pcidev;	/* may be NULL if no ISA bus */
 
 /** Bus Unit ID macros; get low and hi 32-bits of the 64-bit BUID */
@@ -76,7 +74,6 @@ static inline const char *eeh_driver_name(struct pci_dev *pdev)
 #endif /* CONFIG_EEH */
 
 #else /* CONFIG_PCI */
-static inline void find_and_init_phbs(void) { }
 static inline void init_pci_config_tokens(void) { }
 #endif /* !CONFIG_PCI */
 
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index ce230da..42db314 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -277,50 +277,3 @@ int rtas_setup_phb(struct pci_controller *phb)
 
 	return 0;
 }
-
-void __init find_and_init_phbs(void)
-{
-	struct device_node *node;
-	struct pci_controller *phb;
-	struct device_node *root = of_find_node_by_path("/");
-
-	for_each_child_of_node(root, node) {
-		if (node->type == NULL || (strcmp(node->type, "pci") != 0 &&
-					   strcmp(node->type, "pciex") != 0))
-			continue;
-
-		phb = pcibios_alloc_controller(node);
-		if (!phb)
-			continue;
-		rtas_setup_phb(phb);
-		pci_process_bridge_OF_ranges(phb, node, 0);
-		isa_bridge_find_early(phb);
-	}
-
-	of_node_put(root);
-	pci_devs_phb_init();
-
-	/*
-	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
-	 * in chosen.
-	 */
-	if (of_chosen) {
-		const int *prop;
-
-		prop = of_get_property(of_chosen,
-				"linux,pci-probe-only", NULL);
-		if (prop) {
-			if (*prop)
-				pci_add_flags(PCI_PROBE_ONLY);
-			else
-				pci_clear_flags(PCI_PROBE_ONLY);
-		}
-
-#ifdef CONFIG_PPC32 /* Will be made generic soon */
-		prop = of_get_property(of_chosen,
-				"linux,pci-assign-all-buses", NULL);
-		if (prop && *prop)
-			pci_add_flags(PCI_REASSIGN_ALL_BUS);
-#endif /* CONFIG_PPC32 */
-	}
-}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e445b67..1a5f884 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -461,6 +461,53 @@ static long pseries_little_endian_exceptions(void)
 }
 #endif
 
+static void __init find_and_init_phbs(void)
+{
+	struct device_node *node;
+	struct pci_controller *phb;
+	struct device_node *root = of_find_node_by_path("/");
+
+	for_each_child_of_node(root, node) {
+		if (node->type == NULL || (strcmp(node->type, "pci") != 0 &&
+					   strcmp(node->type, "pciex") != 0))
+			continue;
+
+		phb = pcibios_alloc_controller(node);
+		if (!phb)
+			continue;
+		rtas_setup_phb(phb);
+		pci_process_bridge_OF_ranges(phb, node, 0);
+		isa_bridge_find_early(phb);
+	}
+
+	of_node_put(root);
+	pci_devs_phb_init();
+
+	/*
+	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
+	 * in chosen.
+	 */
+	if (of_chosen) {
+		const int *prop;
+
+		prop = of_get_property(of_chosen,
+				"linux,pci-probe-only", NULL);
+		if (prop) {
+			if (*prop)
+				pci_add_flags(PCI_PROBE_ONLY);
+			else
+				pci_clear_flags(PCI_PROBE_ONLY);
+		}
+
+#ifdef CONFIG_PPC32 /* Will be made generic soon */
+		prop = of_get_property(of_chosen,
+				"linux,pci-assign-all-buses", NULL);
+		if (prop && *prop)
+			pci_add_flags(PCI_REASSIGN_ALL_BUS);
+#endif /* CONFIG_PPC32 */
+	}
+}
+
 static void __init pSeries_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
-- 
2.1.4
