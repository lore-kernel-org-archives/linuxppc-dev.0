Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B38492C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 22:07:43 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V4 1/3] powerpc/fsl-pci: Only scan PCI bus if configured as a
 host
Date: Thu, 2 Aug 2012 19:42:19 +0800
Message-ID: <1343907741-20589-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1343907741-20589-1-git-send-email-B38951@freescale.com>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We change fsl_add_bridge to return -ENODEV if the controller is working in
agent mode. Then check the return value of fsl_add_bridge to guarantee
that only successfully added host bus will be scanned.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 50a38b3..6938792 100644
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
@@ -828,6 +828,7 @@ struct device_node *fsl_pci_primary;
 
 void __devinit fsl_pci_init(void)
 {
+	int ret;
 	struct device_node *node;
 	struct pci_controller *hose;
 	dma_addr_t max = 0xffffffff;
@@ -856,10 +857,12 @@ void __devinit fsl_pci_init(void)
 			if (!fsl_pci_primary)
 				fsl_pci_primary = node;
 
-			fsl_add_bridge(node, fsl_pci_primary == node);
-			hose = pci_find_hose_for_OF_device(node);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
+			ret = fsl_add_bridge(node, fsl_pci_primary == node);
+			if (ret == 0) {
+				hose = pci_find_hose_for_OF_device(node);
+				max = min(max, hose->dma_window_base_cur +
+						hose->dma_window_size);
+			}
 		}
 	}
 
-- 
1.7.5.1
