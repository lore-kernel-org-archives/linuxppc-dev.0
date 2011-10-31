Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 60737B731B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 18:07:15 +1100 (EST)
Received: from mail39-ch1 (localhost.localdomain [127.0.0.1])	by
 mail39-ch1-R.bigfish.com (Postfix) with ESMTP id 893CA9281E1	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 07:07:03 +0000 (UTC)
Received: from CH1EHSMHS008.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.242])	by mail39-ch1.bigfish.com (Postfix) with ESMTP id
 4A361398051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 07:07:03 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/fsl-pci: Only scan PCI bus if configured as a host
Date: Mon, 31 Oct 2011 13:54:52 +0800
Message-ID: <1320040492-6407-3-git-send-email-B38951@freescale.com>
In-Reply-To: <1320040492-6407-1-git-send-email-B38951@freescale.com>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
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
 arch/powerpc/sysdev/fsl_pci.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4d4536f..11c1e23 100644
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
@@ -418,6 +418,8 @@ void fsl_pci_setup(int primary_phb_addr)
 {
 	struct device_node *np;
 	struct pci_controller *hose;
+	int ret;
+	int has_host = 0;
 	dma_addr_t min_dma_addr = 0xffffffff;
 
 	for_each_node_by_type(np, "pci") {
@@ -425,14 +427,17 @@ void fsl_pci_setup(int primary_phb_addr)
 			struct resource rsrc;
 			of_address_to_resource(np, 0, &rsrc);
 			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
+				ret = fsl_add_bridge(np, 1);
 			else
-				fsl_add_bridge(np, 0);
-
-			hose = pci_find_hose_for_OF_device(np);
-			min_dma_addr = min(min_dma_addr,
-					hose->dma_window_base_cur
-					+ hose->dma_window_size);
+				ret = fsl_add_bridge(np, 0);
+
+			if (ret == 0) {
+				has_host = 1;
+				hose = pci_find_hose_for_OF_device(np);
+				min_dma_addr = min(min_dma_addr,
+						hose->dma_window_base_cur
+						+ hose->dma_window_size);
+			}
 
 		}
 	}
@@ -442,7 +447,7 @@ void fsl_pci_setup(int primary_phb_addr)
 	 * if we couldn't map all of DRAM via the dma windows we need SWIOTLB
 	 * to handle buffers located outside of dma capable memory region
 	 */
-	if (memblock_end_of_DRAM() > min_dma_addr) {
+	if (has_host && memblock_end_of_DRAM() > min_dma_addr) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-- 
1.7.5.1
