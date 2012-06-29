Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 512ACB70A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:12:00 +1000 (EST)
Date: Fri, 29 Jun 2012 15:10:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH v2 1/3] powerpc/fsl-pci: get PCI init out of board files
Message-ID: <20120629201037.GA28391@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, Jia Hongtao <b38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As an alternative incremental starting point to Jia Hongtao's patchset,
get the FSL PCI init out of the board files, but do not yet convert to a
platform driver.

Rather than having each board supply a magic register offset for
determining the "primary" bus, we look for which PCI host bridge
contains an ISA node within its subtree.  If there is no ISA node,
normally that would mean there is no primary bus, but until certain
bugs are fixed we arbitrarily designate a primary in this case.

Conversion to a platform driver and related improvements can happen
after this, as the ordering issues are sorted out.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: Honor existing fsl_pci_primary if non-NULL, and update copyright year
No change to the rest of the patchset.

 arch/powerpc/sysdev/fsl_pci.c |   71 ++++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_pci.h |    8 +++++
 2 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6073288..fcc9370 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,7 +1,7 @@
 /*
  * MPC83xx/85xx/86xx PCI/PCIE support routing.
  *
- * Copyright 2007-2011 Freescale Semiconductor, Inc.
+ * Copyright 2007-2012 Freescale Semiconductor, Inc.
  * Copyright 2008-2009 MontaVista Software, Inc.
  *
  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
@@ -807,3 +807,72 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 
 	return 0;
 }
+
+#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
+static const struct of_device_id pci_ids[] = {
+	{ .compatible = "fsl,mpc8540-pci", },
+	{ .compatible = "fsl,mpc8548-pcie", },
+	{ .compatible = "fsl,mpc8610-pci", },
+	{ .compatible = "fsl,mpc8641-pcie", },
+	{ .compatible = "fsl,p1022-pcie", },
+	{ .compatible = "fsl,p1010-pcie", },
+	{ .compatible = "fsl,p1023-pcie", },
+	{ .compatible = "fsl,p4080-pcie", },
+	{ .compatible = "fsl,qoriq-pcie-v2.3", },
+	{ .compatible = "fsl,qoriq-pcie-v2.2", },
+	{},
+};
+
+struct device_node *fsl_pci_primary;
+
+void __devinit fsl_pci_init(void)
+{
+	struct device_node *node;
+	struct pci_controller *hose;
+	dma_addr_t max = 0xffffffff;
+
+	/* Callers can specify the primary bus using other means. */
+	if (!fsl_pci_primary) {
+		/* If a PCI host bridge contains an ISA node, it's primary. */
+		node = of_find_node_by_type(NULL, "isa");
+		while ((fsl_pci_primary = of_get_parent(node))) {
+			of_node_put(node);
+			node = fsl_pci_primary;
+
+			if (of_match_node(pci_ids, node))
+				break;
+		}
+	}
+
+	node = NULL;
+	for_each_node_by_type(node, "pci") {
+		if (of_match_node(pci_ids, node)) {
+			/*
+			 * If there's no PCI host bridge with ISA, arbitrarily
+			 * designate one as primary.  This can go away once
+			 * various bugs with primary-less systems are fixed.
+			 */
+			if (!fsl_pci_primary)
+				fsl_pci_primary = node;
+
+			fsl_add_bridge(node, fsl_pci_primary == node);
+			hose = pci_find_hose_for_OF_device(node);
+			max = min(max, hose->dma_window_base_cur +
+					hose->dma_window_size);
+		}
+	}
+
+#ifdef CONFIG_SWIOTLB
+	/*
+	 * if we couldn't map all of DRAM via the dma windows
+	 * we need SWIOTLB to handle buffers located outside of
+	 * dma capable memory region
+	 */
+	if (memblock_end_of_DRAM() - 1 > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
+}
+#endif
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..baa0fd1 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -93,5 +93,13 @@ extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
+extern struct device_node *fsl_pci_primary;
+
+#ifdef CONFIG_FSL_PCI
+void fsl_pci_init(void);
+#else
+static inline void fsl_pci_init(void) {}
+#endif
+
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.7.5.4
