Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C54161007F0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 05:55:58 +1000 (EST)
Date: Tue, 8 Jun 2010 23:55:57 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/85xx: Cleanup QE initialization for MPC85xxMDS
	boards
Message-ID: <20100608195557.GC11446@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpc85xx_mds_setup_arch() function is incomprehensible
and unmaintainable. Factor out all QE specific stuff into
mpc85xx_mds_qe_init() and mpc85xx_mds_reset_ucc_phys().

Also move QE stuff out of mpc85xx_mds_pic_init().

The diff is unreadable, but only because the code was so. ;-)
It should be better now, and less indented.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |  272 +++++++++++++++--------------
 1 files changed, 143 insertions(+), 129 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 9dadcff..c8be7b5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -177,63 +177,89 @@ static void __init mpc85xx_publish_qe_devices(void)
 
 	of_platform_bus_probe(NULL, mpc85xx_qe_ids, NULL);
 }
-#else
-static void __init mpc85xx_publish_qe_devices(void) { }
-#endif /* CONFIG_QUICC_ENGINE */
 
-static void __init mpc85xx_mds_setup_arch(void)
+static void __init mpc85xx_mds_reset_ucc_phys(void)
 {
 	struct device_node *np;
-	static u8 __iomem *bcsr_regs = NULL;
-#ifdef CONFIG_PCI
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc85xx_mds_setup_arch()", 0);
+	static u8 __iomem *bcsr_regs;
 
 	/* Map BCSR area */
 	np = of_find_node_by_name(NULL, "bcsr");
-	if (np != NULL) {
-		struct resource res;
+	if (!np)
+		return;
 
-		of_address_to_resource(np, 0, &res);
-		bcsr_regs = ioremap(res.start, res.end - res.start +1);
-		of_node_put(np);
-	}
+	bcsr_regs = of_iomap(np, 0);
+	of_node_put(np);
+	if (!bcsr_regs)
+		return;
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0x8000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
+	if (machine_is(mpc8568_mds)) {
+#define BCSR_UCC1_GETH_EN	(0x1 << 7)
+#define BCSR_UCC2_GETH_EN	(0x1 << 7)
+#define BCSR_UCC1_MODE_MSK	(0x3 << 4)
+#define BCSR_UCC2_MODE_MSK	(0x3 << 0)
 
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
+		/* Turn off UCC1 & UCC2 */
+		clrbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
+		clrbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
+
+		/* Mode is RGMII, all bits clear */
+		clrbits8(&bcsr_regs[11], BCSR_UCC1_MODE_MSK |
+					 BCSR_UCC2_MODE_MSK);
+
+		/* Turn UCC1 & UCC2 on */
+		setbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
+		setbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
+	} else if (machine_is(mpc8569_mds)) {
+#define BCSR7_UCC12_GETHnRST	(0x1 << 2)
+#define BCSR8_UEM_MARVELL_RST	(0x1 << 1)
+#define BCSR_UCC_RGMII		(0x1 << 6)
+#define BCSR_UCC_RTBI		(0x1 << 5)
+		/*
+		 * U-Boot mangles interrupt polarity for Marvell PHYs,
+		 * so reset built-in and UEM Marvell PHYs, this puts
+		 * the PHYs into their normal state.
+		 */
+		clrbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
+		setbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
+
+		setbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
+		clrbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
+
+		for (np = NULL; (np = of_find_compatible_node(np,
+						"network",
+						"ucc_geth")) != NULL;) {
+			const unsigned int *prop;
+			int ucc_num;
+
+			prop = of_get_property(np, "cell-index", NULL);
+			if (prop == NULL)
+				continue;
+
+			ucc_num = *prop - 1;
+
+			prop = of_get_property(np, "phy-connection-type", NULL);
+			if (prop == NULL)
+				continue;
+
+			if (strcmp("rtbi", (const char *)prop) == 0)
+				clrsetbits_8(&bcsr_regs[7 + ucc_num],
+					BCSR_UCC_RGMII, BCSR_UCC_RTBI);
 		}
+	} else if (machine_is(p1021_mds)) {
+#define BCSR11_ENET_MICRST     (0x1 << 5)
+		/* Reset Micrel PHY */
+		clrbits8(&bcsr_regs[11], BCSR11_ENET_MICRST);
+		setbits8(&bcsr_regs[11], BCSR11_ENET_MICRST);
 	}
-#endif
 
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
+	iounmap(bcsr_regs);
+}
 
-#ifdef CONFIG_SWIOTLB
-	if (lmb_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+static void __init mpc85xx_mds_qe_init(void)
+{
+	struct device_node *np;
 
-#ifdef CONFIG_QUICC_ENGINE
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (!np) {
 		np = of_find_node_by_name(NULL, "qe");
@@ -260,70 +286,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 			par_io_of_config(ucc);
 	}
 
-	if (bcsr_regs) {
-		if (machine_is(mpc8568_mds)) {
-#define BCSR_UCC1_GETH_EN	(0x1 << 7)
-#define BCSR_UCC2_GETH_EN	(0x1 << 7)
-#define BCSR_UCC1_MODE_MSK	(0x3 << 4)
-#define BCSR_UCC2_MODE_MSK	(0x3 << 0)
-
-			/* Turn off UCC1 & UCC2 */
-			clrbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
-			clrbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
-
-			/* Mode is RGMII, all bits clear */
-			clrbits8(&bcsr_regs[11], BCSR_UCC1_MODE_MSK |
-						 BCSR_UCC2_MODE_MSK);
-
-			/* Turn UCC1 & UCC2 on */
-			setbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
-			setbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
-		} else if (machine_is(mpc8569_mds)) {
-#define BCSR7_UCC12_GETHnRST	(0x1 << 2)
-#define BCSR8_UEM_MARVELL_RST	(0x1 << 1)
-#define BCSR_UCC_RGMII		(0x1 << 6)
-#define BCSR_UCC_RTBI		(0x1 << 5)
-			/*
-			 * U-Boot mangles interrupt polarity for Marvell PHYs,
-			 * so reset built-in and UEM Marvell PHYs, this puts
-			 * the PHYs into their normal state.
-			 */
-			clrbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
-			setbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
-
-			setbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
-			clrbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
-
-			for (np = NULL; (np = of_find_compatible_node(np,
-							"network",
-							"ucc_geth")) != NULL;) {
-				const unsigned int *prop;
-				int ucc_num;
-
-				prop = of_get_property(np, "cell-index", NULL);
-				if (prop == NULL)
-					continue;
-
-				ucc_num = *prop - 1;
-
-				prop = of_get_property(np, "phy-connection-type", NULL);
-				if (prop == NULL)
-					continue;
-
-				if (strcmp("rtbi", (const char *)prop) == 0)
-					clrsetbits_8(&bcsr_regs[7 + ucc_num],
-						BCSR_UCC_RGMII, BCSR_UCC_RTBI);
-			}
-
-		} else if (machine_is(p1021_mds)) {
-#define BCSR11_ENET_MICRST     (0x1 << 5)
-			/* Reset Micrel PHY */
-			clrbits8(&bcsr_regs[11], BCSR11_ENET_MICRST);
-			setbits8(&bcsr_regs[11], BCSR11_ENET_MICRST);
-		}
-
-		iounmap(bcsr_regs);
-	}
+	mpc85xx_mds_reset_ucc_phys();
 
 	if (machine_is(p1021_mds)) {
 #define MPC85xx_PMUXCR_OFFSET           0x60
@@ -358,7 +321,79 @@ static void __init mpc85xx_mds_setup_arch(void)
 		}
 
 	}
+}
+
+static void __init mpc85xx_mds_qeic_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
+
+	if (machine_is(p1021_mds))
+		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
+				qe_ic_cascade_high_mpic);
+	else
+		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
+	of_node_put(np);
+}
+#else
+static void __init mpc85xx_publish_qe_devices(void) { }
+static void __init mpc85xx_mds_qe_init(void) { }
+static void __init mpc85xx_mds_qeic_init(void) { }
 #endif	/* CONFIG_QUICC_ENGINE */
+
+static void __init mpc85xx_mds_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct pci_controller *hose;
+#endif
+	dma_addr_t max = 0xffffffff;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc85xx_mds_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == 0x8000)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+
+			hose = pci_find_hose_for_OF_device(np);
+			max = min(max, hose->dma_window_base_cur +
+					hose->dma_window_size);
+		}
+	}
+#endif
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+
+	mpc85xx_mds_qe_init();
+
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
 }
 
 
@@ -465,28 +500,7 @@ static void __init mpc85xx_mds_pic_init(void)
 	of_node_put(np);
 
 	mpic_init(mpic);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return;
-	}
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-
-	if (machine_is(p1021_mds))
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-	else
-		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
-	of_node_put(np);
-#endif				/* CONFIG_QUICC_ENGINE */
+	mpc85xx_mds_qeic_init();
 }
 
 static int __init mpc85xx_mds_probe(void)
-- 
1.7.0.5
