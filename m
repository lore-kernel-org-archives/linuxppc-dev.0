Return-Path: <dja@axtens.net>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFA1A1A05CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:52 +1100 (AEDT)
Received: by patj18 with SMTP id j18so8087524pat.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:51 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/19] powerpc/powermac: Move controller ops from ppc_md to
 controller_ops
Date: Tue, 31 Mar 2015 16:00:49 +1100
Message-Id: <1427778057-9505-12-git-send-email-dja@axtens.net>
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

This moves the Power Mac platform to use the pci_controller_ops
structure rather than ppc_md for PCI controller operations.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powermac/pci.c   | 17 +++++++++++++++--
 arch/powerpc/platforms/powermac/pmac.h  |  5 +----
 arch/powerpc/platforms/powermac/setup.c |  4 +---
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 9c89fd2..59ab16f 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -27,6 +27,8 @@
 #include <asm/grackle.h>
 #include <asm/ppc-pci.h>
 
+#include "pmac.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -798,6 +800,7 @@ static int __init pmac_add_bridge(struct device_node *dev)
 		return -ENOMEM;
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	hose->controller_ops = pmac_pci_controller_ops;
 
 	disp_name = NULL;
 
@@ -942,7 +945,7 @@ void __init pmac_pci_init(void)
 }
 
 #ifdef CONFIG_PPC32
-bool pmac_pci_enable_device_hook(struct pci_dev *dev)
+static bool pmac_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct device_node* node;
 	int updatecfg = 0;
@@ -1225,7 +1228,7 @@ static void fixup_u4_pcie(struct pci_dev* dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_U4_PCIE, fixup_u4_pcie);
 
 #ifdef CONFIG_PPC64
-int pmac_pci_probe_mode(struct pci_bus *bus)
+static int pmac_pci_probe_mode(struct pci_bus *bus)
 {
 	struct device_node *node = pci_bus_to_OF_node(bus);
 
@@ -1240,3 +1243,13 @@ int pmac_pci_probe_mode(struct pci_bus *bus)
 	return PCI_PROBE_DEVTREE;
 }
 #endif /* CONFIG_PPC64 */
+
+struct pci_controller_ops pmac_pci_controller_ops = {
+#ifdef CONFIG_PPC64
+	.probe_mode		= pmac_pci_probe_mode,
+#endif
+#ifdef CONFIG_PPC32
+	.enable_device_hook	= pmac_pci_enable_device_hook,
+#endif
+};
+
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index b8d5721..e7f8163 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -25,7 +25,6 @@ extern void pmac_pci_init(void);
 extern void pmac_nvram_update(void);
 extern unsigned char pmac_nvram_read_byte(int addr);
 extern void pmac_nvram_write_byte(int addr, unsigned char val);
-extern bool pmac_pci_enable_device_hook(struct pci_dev *dev);
 extern void pmac_pcibios_after_init(void);
 extern int of_show_percpuinfo(struct seq_file *m, int i);
 
@@ -39,8 +38,6 @@ extern void low_cpu_die(void) __attribute__((noreturn));
 extern int pmac_nvram_init(void);
 extern void pmac_pic_init(void);
 
-#ifdef CONFIG_PPC64
-extern int pmac_pci_probe_mode(struct pci_bus *bus);
-#endif
+extern struct pci_controller_ops pmac_pci_controller_ops;
 
 #endif /* __PMAC_H__ */
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 71a353c..8dd78f4 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -473,7 +473,7 @@ static void __init pmac_init_early(void)
 	udbg_adb_init(!!strstr(boot_command_line, "btextdbg"));
 
 #ifdef CONFIG_PPC64
-	iommu_init_early_dart(NULL);
+	iommu_init_early_dart(&pmac_pci_controller_ops);
 #endif
 
 	/* SMP Init has to be done early as we need to patch up
@@ -656,12 +656,10 @@ define_machine(powermac) {
 	.feature_call		= pmac_do_feature_call,
 	.progress		= udbg_progress,
 #ifdef CONFIG_PPC64
-	.pci_probe_mode		= pmac_pci_probe_mode,
 	.power_save		= power4_idle,
 	.enable_pmcs		= power4_enable_pmcs,
 #endif /* CONFIG_PPC64 */
 #ifdef CONFIG_PPC32
-	.pcibios_enable_device_hook = pmac_pci_enable_device_hook,
 	.pcibios_after_init	= pmac_pcibios_after_init,
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
-- 
2.1.4
