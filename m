Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8E3D67DB9
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 16:40:51 +1000 (EST)
Subject: [PATCH] powerpc: Don't get PCI IRQ from OF for devices with no IRQ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 16:40:41 +1000
Message-Id: <1160030441.22232.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds checking of the PCI_INTERRUPT_PIN register before
using standard OF parsing to retreive PCI interrupts. The reason is
that some PCI devices may have no PCI interrupt, though they may have
interrupts attached via other means. In this case, we shall not use
irq->pdev, but device-specific code can later retreive those interrupts
instead.

Without that patch, Maple and derivatives don't get the right interrupt
for the second IDE channel as the linux IDE code fallsback to the PCI
irq instead of trying to use the legacy ones for the on-board controller
(which has no PCI_INTERRUPT_PIN). Having no PCI IRQ assign to it (as it
doesn't request any) fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_parse.c	2006-10-03 12:41:03.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom_parse.c	2006-10-05 16:33:25.000000000 +1000
@@ -914,6 +914,17 @@ int of_irq_map_pci(struct pci_dev *pdev,
 	u8 pin;
 	int rc;
 
+	/* We need to first check if the PCI device has a PCI interrupt at all
+	 * since we have cases where the device-node might expose non-PCI
+	 * interrupts, but the device has no PCI interrupt to it
+	 */
+	rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
+	if (rc != 0)
+		return rc;
+	/* No pin, exit */
+	if (pin == 0)
+		return -ENODEV;
+
 	/* Check if we have a device node, if yes, fallback to standard OF
 	 * parsing
 	 */
@@ -925,12 +936,6 @@ int of_irq_map_pci(struct pci_dev *pdev,
 	 * interrupt spec.  we assume #interrupt-cells is 1, which is standard
 	 * for PCI. If you do different, then don't use that routine.
 	 */
-	rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
-	if (rc != 0)
-		return rc;
-	/* No pin, exit */
-	if (pin == 0)
-		return -ENODEV;
 
 	/* Now we walk up the PCI tree */
 	lspec = pin;
