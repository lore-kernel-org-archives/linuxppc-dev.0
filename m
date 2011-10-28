Return-Path: <B38951@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E17801007DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 20:15:28 +1100 (EST)
Received: from mail30-va3 (localhost [127.0.0.1])	by mail30-va3-R.bigfish.com
 (Postfix) with ESMTP id 961FDE00A9	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 28 Oct 2011 09:14:51 +0000 (UTC)
Received: from VA3EHSMHS008.bigfish.com (unknown [10.7.14.250])	by
 mail30-va3.bigfish.com (Postfix) with ESMTP id 37048480045	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 09:14:51 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] Unify pci/pcie initialization code
Date: Fri, 28 Oct 2011 16:03:42 +0800
Message-ID: <1319789023-8924-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B11780@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In previous version pci/pcie initialization is in platform code which
Initialize PCI bridge base on EP/RC or host/agent settings.
We unified pci/pcie initialization as common APIs named fsl_pci_setup
which can be called by platform code.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
We only changed MPC85xxDS board as an example.
If no problem in the review we will change other boards also.

 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   30 ++-----------------
 arch/powerpc/sysdev/fsl_pci.c            |   48 ++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h            |    5 +++
 3 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 10e7db0..7188c0b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -157,33 +157,12 @@ extern void __init mpc85xx_smp_init(void);
 #endif
 static void __init mpc85xx_ds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
-		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
-		}
-	}
+	fsl_pci_setup(primary_phb_addr);
 
+#ifdef CONFIG_PCI
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
@@ -192,11 +171,8 @@ static void __init mpc85xx_ds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 80b8b7a..4d4536f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -402,6 +402,54 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 }
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
+static struct of_device_id pci_ids[] = {
+	{ .compatible = "fsl,mpc8540-pci", },
+	{ .compatible = "fsl,mpc8548-pcie", },
+	{},
+};
+
+/**
+ * fsl_pci_setup - Initialization for PCI
+ * @primary_phb_addr: primary bus address
+ *
+ * Add bridge if pci controller is a host
+ */
+void fsl_pci_setup(int primary_phb_addr)
+{
+	struct device_node *np;
+	struct pci_controller *hose;
+	dma_addr_t min_dma_addr = 0xffffffff;
+
+	for_each_node_by_type(np, "pci") {
+		if (of_match_node(pci_ids, np)) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == primary_phb_addr)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+
+			hose = pci_find_hose_for_OF_device(np);
+			min_dma_addr = min(min_dma_addr,
+					hose->dma_window_base_cur
+					+ hose->dma_window_size);
+
+		}
+	}
+
+#ifdef CONFIG_SWIOTLB
+	/*
+	 * if we couldn't map all of DRAM via the dma windows we need SWIOTLB
+	 * to handle buffers located outside of dma capable memory region
+	 */
+	if (memblock_end_of_DRAM() > min_dma_addr) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
+}
+
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..775ea21 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -89,6 +89,11 @@ struct ccsr_pci {
 };
 
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
+#ifndef CONFIG_PCI
+#define fsl_pci_setup(p)
+#else
+extern void fsl_pci_setup(int primary_phb_addr);
+#endif
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
-- 
1.7.5.1
