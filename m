Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB7692C007B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 21:10:32 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>
Subject: [PATCH] PCI: Add pcie_irq=other to enable non MSI/INTx interrupt for
 port service driver
Date: Mon, 9 Jul 2012 18:49:30 +0800
Message-ID: <1341830970-12779-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some platforms, in RC mode, root port has neither MSI/MSI-X nor INTx
interrupt generated, which are available only in EP mode on those platform.
In this case, we try to use other interrupt if supported (i.e. there is the
shared error interrupt on platform P1010, P3041, P4080, etc) to have AER,
Hot-plug, etc, services to work.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/pci/pcie/portdrv_core.c     |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a92c5eb..af97c81 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2218,6 +2218,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
+	pcie_irq=	[PCIE] Native PCIe root port interrupt options:
+		other	Try to use other interrupt when root port has
+			neither MSI/MSI-X nor INTx support.
+
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
 	pd.		[PARIDE]
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 75915b3..653679e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -30,6 +30,17 @@ static int __init pciehp_setup(char *str)
 }
 __setup("pcie_hp=", pciehp_setup);
 
+bool port_other_interrupt_enabled;
+
+static int __init portservice_setup(char *str)
+{
+	if (!strncmp(str, "other", 5))
+		port_other_interrupt_enabled = true;
+
+	return 1;
+}
+__setup("pcie_irq=", portservice_setup);
+
 /**
  * release_pcie_device - free PCI Express port service device structure
  * @dev: Port service device to release
@@ -216,6 +227,14 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if (!pci_enable_msi(dev) || dev->pin)
 		irq = dev->irq;
 
+	/*
+	 * On some platforms, root port has neither MSI/MSI-X nor INTx
+	 * interrupt support in RC mode, so try to use other interrupt(i.e.
+	 * shared interrupt if supported).
+	 */
+	else if (port_other_interrupt_enabled && dev->irq)
+		irq = dev->irq;
+
  no_msi:
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
 		irqs[i] = irq;
-- 
1.6.4
