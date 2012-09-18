Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 884322C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 20:32:24 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl-pci: fix warning when CONFIG_SWIOTLB is disabled
Date: Tue, 18 Sep 2012 17:57:48 +0800
Message-ID: <1347962268-25136-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mikey@neuling.org, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the following warning:
arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_probe':
arch/powerpc/sysdev/fsl_pci.c:867:25: error: unused variable 'hose'

Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 2ff3576..3d6f4d8 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -864,7 +864,9 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct device_node *node;
+#ifdef CONFIG_SWIOTLB
 	struct pci_controller *hose;
+#endif
 
 	node = pdev->dev.of_node;
 	ret = fsl_add_bridge(node, fsl_pci_primary == node);
-- 
1.7.5.1
