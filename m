Return-Path: <B38951@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C548510091C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 20:15:32 +1100 (EST)
Received: from mail85-am1 (localhost.localdomain [127.0.0.1])	by
 mail85-am1-R.bigfish.com (Postfix) with ESMTP id 82BD7E800D5	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 09:15:22 +0000 (UTC)
Received: from AM1EHSMHS007.bigfish.com (unknown [10.3.201.248])	by
 mail85-am1.bigfish.com (Postfix) with ESMTP id 51C14108804E	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 09:15:22 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/fsl-pci: Only scan PCI bus if configured as a host
Date: Fri, 28 Oct 2011 16:03:43 +0800
Message-ID: <1319789023-8924-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1319789023-8924-1-git-send-email-B38951@freescale.com>
References: <1319789023-8924-1-git-send-email-B38951@freescale.com>
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
 arch/powerpc/sysdev/fsl_pci.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4d4536f..caa7801 100644
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
@@ -418,6 +418,7 @@ void fsl_pci_setup(int primary_phb_addr)
 {
 	struct device_node *np;
 	struct pci_controller *hose;
+	int ret;
 	dma_addr_t min_dma_addr = 0xffffffff;
 
 	for_each_node_by_type(np, "pci") {
@@ -425,14 +426,16 @@ void fsl_pci_setup(int primary_phb_addr)
 			struct resource rsrc;
 			of_address_to_resource(np, 0, &rsrc);
 			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
+				ret = fsl_add_bridge(np, 1);
 			else
-				fsl_add_bridge(np, 0);
+				ret = fsl_add_bridge(np, 0);
 
-			hose = pci_find_hose_for_OF_device(np);
-			min_dma_addr = min(min_dma_addr,
-					hose->dma_window_base_cur
-					+ hose->dma_window_size);
+			if (ret == 0) {
+				hose = pci_find_hose_for_OF_device(np);
+				min_dma_addr = min(min_dma_addr,
+						hose->dma_window_base_cur
+						+ hose->dma_window_size);
+			}
 
 		}
 	}
-- 
1.7.5.1
