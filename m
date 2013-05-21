Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D693B2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 22:05:53 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/fsl-pci: enable SWIOTLB in function setup_pci_atmu
Date: Tue, 21 May 2013 20:05:00 +0800
Message-ID: <1369137900-5748-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function contains all the stuff we need to check if SWIOTLB
should be enabled or not. So it is more convenient to enable
the SWIOTLB here than later.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 3833c8f..793e64d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -381,7 +381,9 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	}
 
 	if (hose->dma_window_size < mem) {
-#ifndef CONFIG_SWIOTLB
+#ifdef CONFIG_SWIOTLB
+		ppc_swiotlb_enable = 1;
+#else
 		pr_err("%s: ERROR: Memory size exceeds PCI ATMU ability to "
 			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n",
 			 name);
@@ -934,28 +936,10 @@ static int fsl_pci_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct device_node *node;
-#ifdef CONFIG_SWIOTLB
-	struct pci_controller *hose;
-#endif
 
 	node = pdev->dev.of_node;
 	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
 
-#ifdef CONFIG_SWIOTLB
-	if (ret == 0) {
-		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
-
-		/*
-		 * if we couldn't map all of DRAM via the dma windows
-		 * we need SWIOTLB to handle buffers located outside of
-		 * dma capable memory region
-		 */
-		if (memblock_end_of_DRAM() - 1 > hose->dma_window_base_cur +
-				hose->dma_window_size)
-			ppc_swiotlb_enable = 1;
-	}
-#endif
-
 	mpc85xx_pci_err_probe(pdev);
 
 	return 0;
-- 
1.8.1.4
