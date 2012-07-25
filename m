Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E45C42C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 19:50:30 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V2 1/6] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 25 Jul 2012 17:26:56 +0800
Message-ID: <1343208421-5552-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We unified the Freescale pci/pcie initialization by changing the fsl_pci
to a platform driver. In previous PCI code architecture the initialization
is called at board_setup_arch stage. Now the initialization is done in
probe function which is architectural better. Also It's convenient for
adding PM support for PCI controller in later patch.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
Changed for V2:
- Rebase the patch set on the latest tree
- Add missing pci compatible "fsl,mpc8610-pci"

 arch/powerpc/sysdev/fsl_pci.c |   80 ++++++++++++++++++----------------------
 arch/powerpc/sysdev/fsl_pci.h |    9 +----
 2 files changed, 37 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a7b2a60..3ebbcec 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -823,56 +823,48 @@ static const struct of_device_id pci_ids[] = {
 	{},
 };
 
-struct device_node *fsl_pci_primary;
-
-void __devinit fsl_pci_init(void)
+int primary_phb_addr;
+static int __devinit fsl_pci_probe(struct platform_device *pdev)
 {
-	struct device_node *node;
 	struct pci_controller *hose;
-	dma_addr_t max = 0xffffffff;
-
-	/* Callers can specify the primary bus using other means. */
-	if (!fsl_pci_primary) {
-		/* If a PCI host bridge contains an ISA node, it's primary. */
-		node = of_find_node_by_type(NULL, "isa");
-		while ((fsl_pci_primary = of_get_parent(node))) {
-			of_node_put(node);
-			node = fsl_pci_primary;
-
-			if (of_match_node(pci_ids, node))
-				break;
-		}
-	}
+	bool is_primary;
 
-	node = NULL;
-	for_each_node_by_type(node, "pci") {
-		if (of_match_node(pci_ids, node)) {
-			/*
-			 * If there's no PCI host bridge with ISA, arbitrarily
-			 * designate one as primary.  This can go away once
-			 * various bugs with primary-less systems are fixed.
-			 */
-			if (!fsl_pci_primary)
-				fsl_pci_primary = node;
+	if (of_match_node(pci_ids, pdev->dev.of_node)) {
+		struct resource rsrc;
+		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
+		is_primary = ((rsrc.start & 0xfffff) == primary_phb_addr);
+		fsl_add_bridge(pdev->dev.of_node, is_primary);
 
-			fsl_add_bridge(node, fsl_pci_primary == node);
-			hose = pci_find_hose_for_OF_device(node);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
+#ifdef CONFIG_SWIOTLB
+		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
+		/*
+		 * if we couldn't map all of DRAM via the dma windows
+		 * we need SWIOTLB to handle buffers located outside of
+		 * dma capable memory region
+		 */
+		if (memblock_end_of_DRAM() > hose->dma_window_base_cur
+				+ hose->dma_window_size) {
+			ppc_swiotlb_enable = 1;
+			set_pci_dma_ops(&swiotlb_dma_ops);
+			ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
 		}
+#endif
 	}
 
-#ifdef CONFIG_SWIOTLB
-	/*
-	 * if we couldn't map all of DRAM via the dma windows
-	 * we need SWIOTLB to handle buffers located outside of
-	 * dma capable memory region
-	 */
-	if (memblock_end_of_DRAM() - 1 > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	return 0;
+}
+
+static struct platform_driver fsl_pci_driver = {
+	.driver = {
+		.name = "fsl-pci",
+		.of_match_table = pci_ids,
+	},
+	.probe = fsl_pci_probe,
+};
+
+static int __init fsl_pci_init(void)
+{
+	return platform_driver_register(&fsl_pci_driver);
 }
+arch_initcall(fsl_pci_init);
 #endif
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index baa0fd1..df9fc44 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -88,18 +88,11 @@ struct ccsr_pci {
 	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
 };
 
+extern int primary_phb_addr;
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
-extern struct device_node *fsl_pci_primary;
-
-#ifdef CONFIG_FSL_PCI
-void fsl_pci_init(void);
-#else
-static inline void fsl_pci_init(void) {}
-#endif
-
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.7.5.1
