Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 03C0E2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 19:50:34 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V2 2/6] powerpc/fsl-pci: Check swiotlb enable at board
 setup_arch stage
Date: Wed, 25 Jul 2012 17:26:57 +0800
Message-ID: <1343208421-5552-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1343208421-5552-1-git-send-email-B38951@freescale.com>
References: <1343208421-5552-1-git-send-email-B38951@freescale.com>
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

PCI initialization is called later than swiotlb_init() due to PCI controller is
a platform driver now. So we provide a function which called at board setup_arch
stage to address swiotlb enable by parsing pci ranges.

This patch depends on the following patch:
powerpc/fsl-pci: Unify pci/pcie initialization code

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |  125 ++++++++++++++++++++++++++++++++++++-----
 arch/powerpc/sysdev/fsl_pci.h |    6 ++
 2 files changed, 116 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 3ebbcec..c473206 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -823,6 +823,116 @@ static const struct of_device_id pci_ids[] = {
 	{},
 };
 
+#ifdef CONFIG_SWIOTLB
+void pci_check_swiotlb(void)
+{
+	const u32 *ranges;
+	int rlen;
+	int pna;
+	int np;
+	struct device_node *node;
+	int memno;
+	u32 pci_space;
+	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
+	unsigned long long pci_addr_lo = ULLONG_MAX;
+	unsigned long long pci_addr_hi = 0x0;
+	dma_addr_t pci_dma_sz;
+
+	for_each_node_by_type(node, "pci") {
+		if (of_match_node(pci_ids, node)) {
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
+		}
+	}
+
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
+	/*
+	 * if we couldn't map all of DRAM via the dma windows
+	 * we need SWIOTLB to handle buffers located outside of
+	 * dma capable memory region
+	 */
+	if (memblock_end_of_DRAM() > pci_dma_sz) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup =
+			pci_dma_dev_setup_swiotlb;
+	}
+}
+#endif
+
 int primary_phb_addr;
 static int __devinit fsl_pci_probe(struct platform_device *pdev)
 {
@@ -834,21 +944,6 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
 		is_primary = ((rsrc.start & 0xfffff) == primary_phb_addr);
 		fsl_add_bridge(pdev->dev.of_node, is_primary);
-
-#ifdef CONFIG_SWIOTLB
-		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
-		/*
-		 * if we couldn't map all of DRAM via the dma windows
-		 * we need SWIOTLB to handle buffers located outside of
-		 * dma capable memory region
-		 */
-		if (memblock_end_of_DRAM() > hose->dma_window_base_cur
-				+ hose->dma_window_size) {
-			ppc_swiotlb_enable = 1;
-			set_pci_dma_ops(&swiotlb_dma_ops);
-			ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-		}
-#endif
 	}
 
 	return 0;
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index df9fc44..c2c1de5 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -94,5 +94,11 @@ extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
+#ifdef CONFIG_SWIOTLB
+extern void pci_check_swiotlb(void);
+#else
+static inline void pci_check_swiotlb(void) {}
+#endif
+
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.7.5.1
