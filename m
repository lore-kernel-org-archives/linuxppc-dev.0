Return-Path: <B36685@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CC8D2C0159
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 12:57:38 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: use dev->irq instead of dev->pin to enable non MSI/INTx
 interrupt
Date: Tue, 17 Jul 2012 10:35:51 +0800
Message-ID: <1342492551-13766-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some platforms, root port has neither MSI/MSI-X nor INTx interrupt
generated in RC mode. In this case, we have to use other interrupt(i.e.
system shared interrupt) for port service irq to have AER, Hot-plug, etc,
services to work.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/pci/pcie/portdrv_core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 75915b3..a855254 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -212,8 +212,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if (!pcie_port_enable_msix(dev, irqs, mask))
 		return 0;
 
-	/* We're not going to use MSI-X, so try MSI and fall back to INTx */
-	if (!pci_enable_msi(dev) || dev->pin)
+	/*
+	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
+	 * If neither MSI/MSI-X nor INTx available, try other interrupt. (On
+	 * some platforms, root port doesn't support generating MSI/MSI-X/INTx
+	 * in RC mode)
+	 */
+	if (!pci_enable_msi(dev) || dev->irq)
 		irq = dev->irq;
 
  no_msi:
-- 
1.6.4
