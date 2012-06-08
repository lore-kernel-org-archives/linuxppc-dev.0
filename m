Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CA8BB6FF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 20:00:38 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V3 3/6] powerpc/fsl-pci: Only scan PCI bus if configured as a
 host
Date: Fri, 8 Jun 2012 17:42:04 +0800
Message-ID: <1339148527-16911-4-git-send-email-B38951@freescale.com>
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

If we're an agent/end-point or fsl_add_bridge doesn't succeed due to some
resource failure we should not scan the PCI bus. We change fsl_add_bridge()
to return -ENODEV in the case we're an agent/end-point.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4c3d130..a5e573c 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -465,7 +465,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 			iounmap(hose->cfg_data);
 		iounmap(hose->cfg_addr);
 		pcibios_free_controller(hose);
-		return 0;
+		return -ENODEV;
 	}
 
 	setup_pci_cmd(hose);
@@ -836,17 +836,20 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 		ret = fsl_add_bridge(pdev->dev.of_node, is_primary);
 
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
+		if (ret == 0) {
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
 		}
 #endif
 	}
-- 
1.7.5.1
