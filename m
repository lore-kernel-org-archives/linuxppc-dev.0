Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC5F8B6FEF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 20:00:26 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V3 1/6] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Fri, 8 Jun 2012 17:42:02 +0800
Message-ID: <1339148527-16911-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1339148527-16911-1-git-send-email-B38951@freescale.com>
References: <1339148527-16911-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: R65777@freescale.com, b38951@freescale.com, B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We unified the Freescale pci/pcie initialization by changing the fsl_pci
to a platform driver.

In previous version pci/pcie initialization is in platform code which
Initialize pci bridge base on EP/RC or host/agent settings.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   61 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h |    1 +
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6073288..4c3d130 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -807,3 +807,64 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 
 	return 0;
 }
+
+#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
+static const struct of_device_id pci_ids[] = {
+	{ .compatible = "fsl,mpc8540-pci", },
+	{ .compatible = "fsl,mpc8548-pcie", },
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
+int primary_phb_addr;
+static int __devinit fsl_pci_probe(struct platform_device *pdev)
+{
+	struct pci_controller *hose;
+	int ret;
+	bool is_primary;
+
+	if (of_match_node(pci_ids, pdev->dev.of_node)) {
+		struct resource rsrc;
+		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
+		is_primary = ((rsrc.start & 0xfffff) == primary_phb_addr);
+		ret = fsl_add_bridge(pdev->dev.of_node, is_primary);
+
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
+		}
+#endif
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
+}
+arch_initcall(fsl_pci_init);
+#endif
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..df9fc44 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -88,6 +88,7 @@ struct ccsr_pci {
 	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
 };
 
+extern int primary_phb_addr;
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
-- 
1.7.5.1
