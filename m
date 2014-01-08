Return-Path: <Minghuan.Lian@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5EF482C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 16:02:14 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 09/12][v4] pci: fsl: update PCI PM driver
Date: Wed, 8 Jan 2014 13:02:00 +0800
Message-ID: <1389157323-3088-9-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch updates PCI PM driver, uses fsl_pci instead of
pci_controller.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v4:
no change
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 drivers/pci/host/pci-fsl-common.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index d608550..e3696eb 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -702,19 +702,12 @@ static int fsl_pci_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int fsl_pci_resume(struct device *dev)
 {
-	struct pci_controller *hose;
-	struct resource pci_rsrc;
+	struct fsl_pci *pci = dev_get_drvdata(dev);
 
-	hose = pci_find_hose_for_OF_device(dev->of_node);
-	if (!hose)
+	if (!pci)
 		return -ENODEV;
 
-	if (of_address_to_resource(dev->of_node, 0, &pci_rsrc)) {
-		dev_err(dev, "Get pci register base failed.");
-		return -ENODEV;
-	}
-
-	setup_pci_atmu(hose);
+	setup_pci_atmu(pci);
 
 	return 0;
 }
-- 
1.8.1.2
