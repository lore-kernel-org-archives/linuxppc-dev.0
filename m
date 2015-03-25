Return-Path: <dja@axtens.net>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6DAF1A0A0A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:08 +1100 (AEDT)
Received: by pdbcz9 with SMTP id cz9so17004668pdb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:07 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/27] powerpc: fsl_pci,
 swiotlb: Move controller ops from ppc_md to controller_ops
Date: Wed, 25 Mar 2015 16:35:53 +1100
Message-Id: <1427261761-22952-20-git-send-email-dja@axtens.net>
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

This moves the setup out of swiotlb's subsys init call, and into an

fsl_pci.c is the only thing that checks the ppc_swiotlb_enable global,
so we can be confident that patching it will cover all the PCI
implementations affected by the changes to dma-swiotlb.c.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/dma-swiotlb.c | 11 ++++-------
 arch/powerpc/sysdev/fsl_pci.c     | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index d06491b..6e8d764 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -116,16 +116,13 @@ void __init swiotlb_detect_4g(void)
 	}
 }
 
-static int __init swiotlb_subsys_init(void)
+static int __init check_swiotlb_enabled(void)
 {
-	if (ppc_swiotlb_enable) {
+	if (ppc_swiotlb_enable)
 		swiotlb_print_info();
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	} else {
+	else
 		swiotlb_free();
-	}
 
 	return 0;
 }
-subsys_initcall(swiotlb_subsys_init);
+subsys_initcall(check_swiotlb_enabled);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 7071feb..ca13b7f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -111,6 +111,22 @@ static struct pci_ops fsl_indirect_pcie_ops =
 #define MAX_PHYS_ADDR_BITS	40
 static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
 
+#ifdef CONFIG_SWIOTLB
+static struct pci_controller_ops swiotlb_pci_controller_ops = {
+	.dma_dev_setup = pci_dma_dev_setup_swiotlb,
+};
+
+static void setup_swiotlb_ops(struct pci_controller *hose)
+{
+	if (ppc_swiotlb_enable) {
+		hose->controller_ops = swiotlb_pci_controller_ops;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+	}
+}
+#else
+static inline void setup_swiotlb_ops(struct pci_controller *hose) {}
+#endif
+
 static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
@@ -492,6 +508,9 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
+	/* Set up controller operations */
+	setup_swiotlb_ops(hose);
+
 	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
 		 (u64)rsrc.start, (u64)resource_size(&rsrc));
 
-- 
2.1.4
