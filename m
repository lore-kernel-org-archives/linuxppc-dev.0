Return-Path: <B36685@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 356EC2C0337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 16:28:50 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
 MSI/INTx interrupt
Date: Wed, 18 Jul 2012 14:06:54 +0800
Message-ID: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
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
generated in RC mode. In this case, we have to use other interrupt(e.g.
system shared interrupt) for port service irq to have AER, Hot-plug, etc,
services to work.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/pci/pcie/portdrv_core.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 75915b3..49acf72 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -200,10 +200,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
 	int i, irq = -1;
 
-	/* We have to use INTx if MSI cannot be used for PCIe PME or pciehp. */
+	/*
+	 * We have to use INTx or other interrupts(e.g. system shared interrupt)
+	 * if MSI cannot be used for PCIe PME or pciehp.
+	 */
 	if (((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) ||
 	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
-		if (dev->pin)
+		if (dev->irq)
 			irq = dev->irq;
 		goto no_msi;
 	}
@@ -212,8 +215,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
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
