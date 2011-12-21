Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6568DB72AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 18:58:31 +1100 (EST)
Received: from mail170-tx2 (localhost [127.0.0.1])	by
 mail170-tx2-R.bigfish.com (Postfix) with ESMTP id 1AAFB320172	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 07:58:48 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.235])	by
 mail170-tx2.bigfish.com (Postfix) with ESMTP id 94DA9700044	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 07:58:47 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH SDK1.2 2/3] powerpc/fsl-pci: Only scan PCI bus if configured
 as a host
Date: Wed, 21 Dec 2011 15:10:57 +0800
Message-ID: <1324451458-4644-3-git-send-email-B38951@freescale.com>
In-Reply-To: <1324451458-4644-1-git-send-email-B38951@freescale.com>
References: <1324451458-4644-1-git-send-email-B38951@freescale.com>
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

If we're an agent/end-point or fsl_add_bridge doesn't succeed due to some
resource failure we should not scan the PCI bus. We change fsl_add_bridge()
to return -ENODEV in the case we're an agent/end-point.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a0f305d..e318e9d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -370,7 +370,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 			iounmap(hose->cfg_data);
 		iounmap(hose->cfg_addr);
 		pcibios_free_controller(hose);
-		return 0;
+		return -ENODEV;
 	}
 
 	setup_pci_cmd(hose);
@@ -723,29 +723,33 @@ static const struct of_device_id pci_ids[] = {
 static int __devinit fsl_pci_probe(struct platform_device *pdev)
 {
 	struct pci_controller *hose;
+	int ret;
 
 	if (of_match_node(pci_ids, pdev->dev.of_node)) {
 		struct resource rsrc;
 		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
 		if ((rsrc.start & 0xfffff) == 8000)
-			fsl_add_bridge(pdev->dev.of_node, 1);
+			ret = fsl_add_bridge(pdev->dev.of_node, 1);
 		else
-			fsl_add_bridge(pdev->dev.of_node, 0);
+			ret = fsl_add_bridge(pdev->dev.of_node, 0);
 
+		if (ret == 0) {
 #ifdef CONFIG_SWIOTLB
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
+			hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
+			/*
+			 * if we couldn't map all of DRAM via the dma windows
+			 * we need SWIOTLB to handle buffers located outside of
+			 * dma capable memory region
+			 */
+			if (memblock_end_of_DRAM() > hose->dma_window_base_cur
+					+ hose->dma_window_size) {
+				ppc_swiotlb_enable = 1;
+				set_pci_dma_ops(&swiotlb_dma_ops);
+				ppc_md.pci_dma_dev_setup =
+					pci_dma_dev_setup_swiotlb;
+			}
 #endif
+		}
 
 	}
 
-- 
1.7.5.1
