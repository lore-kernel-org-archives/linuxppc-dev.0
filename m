Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA2221A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 13:16:01 +1000 (AEST)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E5B9F140218
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 13:15:59 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so7989980pac.1
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Apr 2015 20:15:58 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 16/19] powerpc: fsl_pci,
 swiotlb: Move controller ops from ppc_md to controller_ops
Date: Fri, 10 Apr 2015 13:15:47 +1000
Message-Id: <1428635747-9754-1-git-send-email-dja@axtens.net>
In-Reply-To: <1428624718-13564-1-git-send-email-dja@axtens.net>
References: <1428624718-13564-1-git-send-email-dja@axtens.net>
Cc: Scott Wood <scottwood@freescale.com>, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the installation of DMA operations out of swiotlb's subsys
initcall, and into the generic PCI controller operations struct.

These ops are installed conditionally, based on the ppc_swiotlb_enable
global. The global can be set in two places:
 - swiotlb_detect_4g, which is always called at the arch initcall level
 - setup_pci_atmu, which is called as part of the fsl_add_bridge and
fsl_pci_syscore_do_resume.

fsl_pci_syscore_do_resume is called late enough that any changes as a
result of that call will have no effect.

As such, if we test the global and set the operations as part of
fsl_add_bridge, after the call to setup_pci_atmu, we can be confident
that it will cover all the PCI implementations affected by the changes
to dma-swiotlb.c.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Move the setup call to after setup_pci_atmu().

v2 --> v3:
 - Only set the affected op, not the entire structure. Thanks mpe.

v3 --> v4:
 - Improved commit message, thanks Scott Wood.
---
 arch/powerpc/kernel/dma-swiotlb.c | 11 ++++-------
 arch/powerpc/sysdev/fsl_pci.c     | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 7359797..6e8d764 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -116,16 +116,13 @@ void __init swiotlb_detect_4g(void)
 	}
 }
 
-static int __init swiotlb_late_init(void)
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
-subsys_initcall(swiotlb_late_init);
+subsys_initcall(check_swiotlb_enabled);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4b74c27..9a8fcf0 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -111,6 +111,18 @@ static struct pci_ops fsl_indirect_pcie_ops =
 #define MAX_PHYS_ADDR_BITS	40
 static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
 
+#ifdef CONFIG_SWIOTLB
+static void setup_swiotlb_ops(struct pci_controller *hose)
+{
+	if (ppc_swiotlb_enable) {
+		hose->controller_ops.dma_dev_setup = pci_dma_dev_setup_swiotlb;
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
@@ -548,6 +560,9 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	/* Setup PEX window registers */
 	setup_pci_atmu(hose);
 
+	/* Set up controller operations */
+	setup_swiotlb_ops(hose);
+
 	return 0;
 
 no_bridge:
-- 
2.1.4
