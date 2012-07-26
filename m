Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEBAE2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 22:54:08 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Thu, 26 Jul 2012 20:30:23 +0800
Message-ID: <1343305827-26734-1-git-send-email-B38951@freescale.com>
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
routine is called at board_setup_arch stage. Now the initialization is done
in probe function which is architectural better. Also It's convenient for
adding PM support for PCI controller in later patch.

One issue introduced by this architecture is the timing of swiotlb_init.
During PCI initialization the need of swiotlb is determined and this should
be done before swiotlb_init. So a new function to determine swiotlb by
parsing pci ranges is made. This function is called at board_setup_arch
stage which is earlier than swiotlb_init.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
Changed for V3:
- Rebase the patch set on the latest tree
- merge PCI unify and swiotlb patch into one

 arch/powerpc/sysdev/fsl_pci.c |  155 ++++++++++++++++++++++++++++++++---------
 arch/powerpc/sysdev/fsl_pci.h |    9 +--
 2 files changed, 125 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a7b2a60..5228b6b 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -823,56 +823,143 @@ static const struct of_device_id pci_ids[] = {
 	{},
 };
 
-struct device_node *fsl_pci_primary;
-
-void __devinit fsl_pci_init(void)
+#ifdef CONFIG_SWIOTLB
+void pci_determine_swiotlb(void)
 {
+	const u32 *ranges;
+	int rlen;
+	int pna;
+	int np;
 	struct device_node *node;
-	struct pci_controller *hose;
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
+	int memno;
+	u32 pci_space;
+	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
+	unsigned long long pci_addr_lo = ULLONG_MAX;
+	unsigned long long pci_addr_hi = 0x0;
+	dma_addr_t pci_dma_sz;
 
-	node = NULL;
 	for_each_node_by_type(node, "pci") {
 		if (of_match_node(pci_ids, node)) {
-			/*
-			 * If there's no PCI host bridge with ISA, arbitrarily
-			 * designate one as primary.  This can go away once
-			 * various bugs with primary-less systems are fixed.
-			 */
-			if (!fsl_pci_primary)
-				fsl_pci_primary = node;
-
-			fsl_add_bridge(node, fsl_pci_primary == node);
-			hose = pci_find_hose_for_OF_device(node);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
+			memno = 0;
+			pna = of_n_addr_cells(node);
+			np = pna + 5;
+			/* Get ranges property */
+			ranges = of_get_property(node, "ranges", &rlen);
+			if (ranges == NULL)
+				return;
+
+			/* Parse outbound MEM window range */
+			while ((rlen -= np * 4) >= 0) {
+				/* Read next ranges element */
+				pci_space = ranges[0];
+				if (!((pci_space >> 24) & 0x2)) {
+					ranges += np;
+					break;
+				}
+				pci_addr = of_read_number(ranges + 1, 2);
+				cpu_addr = of_translate_address(
+						node, ranges + 3);
+				size = of_read_number(ranges + pna + 3, 2);
+				ranges += np;
+
+				/*
+				 * If we failed translation or got a zero-sized
+				 * region (some FW try to feed us with non
+				 * sensical zero sized regions such as power3
+				 * which look like some kind of attempt at
+				 * exposing the VGA memory hole)
+				 */
+				if (cpu_addr == OF_BAD_ADDR || size == 0)
+					continue;
+
+				/*
+				 * Now consume following elements while they
+				 * are contiguous
+				 */
+				for (; rlen >= np * sizeof(u32);
+						ranges += np, rlen -= np * 4) {
+					if (ranges[0] != pci_space)
+						break;
+					pci_next = of_read_number(ranges + 1,
+							2);
+					cpu_next = of_translate_address(node,
+							ranges + 3);
+					if (pci_next != pci_addr + size ||
+						cpu_next != cpu_addr + size)
+						break;
+					size += of_read_number(
+							ranges + pna + 3, 2);
+				}
+
+				/* We support only 3 memory ranges */
+				if (memno >= 3) {
+					printk(KERN_INFO
+							" \\--> Skipped (too many) !\n");
+					continue;
+				}
+
+				pci_addr_lo = min(pci_addr, pci_addr_lo);
+				pci_addr_hi = max(pci_addr + size, pci_addr_hi);
+				memno++;
+			}
 		}
 	}
 
-#ifdef CONFIG_SWIOTLB
+	/* Get PEXCSRBAR size (equal to CCSR size) */
+	node = of_find_node_by_type(NULL, "soc");
+	ranges = of_get_property(node, "ranges", &rlen);
+	if (ranges == NULL)
+		return;
+
+	size = of_read_number(ranges + 3, 1);
+	of_node_put(node);
+
+	if (pci_addr_hi < (0x100000000ull - size))
+		pci_dma_sz = pci_addr_lo;
+	else
+		pci_dma_sz = pci_addr_lo - size;
+
 	/*
 	 * if we couldn't map all of DRAM via the dma windows
 	 * we need SWIOTLB to handle buffers located outside of
 	 * dma capable memory region
 	 */
-	if (memblock_end_of_DRAM() - 1 > max) {
+	if (memblock_end_of_DRAM() > pci_dma_sz) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+		ppc_md.pci_dma_dev_setup =
+			pci_dma_dev_setup_swiotlb;
 	}
+}
 #endif
+
+int primary_phb_addr;
+static int __devinit fsl_pci_probe(struct platform_device *pdev)
+{
+	struct pci_controller *hose;
+	bool is_primary;
+
+	if (of_match_node(pci_ids, pdev->dev.of_node)) {
+		struct resource rsrc;
+		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
+		is_primary = ((rsrc.start & 0xfffff) == primary_phb_addr);
+		fsl_add_bridge(pdev->dev.of_node, is_primary);
+	}
+
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
index baa0fd1..095392d 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -88,17 +88,16 @@ struct ccsr_pci {
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
+#ifdef CONFIG_SWIOTLB
+extern void pci_determine_swiotlb(void);
 #else
-static inline void fsl_pci_init(void) {}
+static inline void pci_determine_swiotlb(void) {}
 #endif
 
 #endif /* __POWERPC_FSL_PCI_H */
-- 
1.7.5.1
