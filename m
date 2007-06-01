Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53183DE016
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 18:06:22 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5186B97024728
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 01:06:11 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l518697g010919
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 03:06:10 -0500 (CDT)
Subject: [patch] powerpc: Remove redundant pci_read_irq_line() function for
	85xx platform
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1180685138.17196.55.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 01 Jun 2007 16:05:38 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Remove redundant pci_read_irq_line() function for 
85xx CDS board.
This function has been realized in common pci_32.c.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   76 +++++++++++++----------------
 1 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 1490eb3..27b81ff 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -78,52 +78,44 @@ static int mpc85xx_exclude_device(u_char bus, u_char devfn)
 		return PCIBIOS_SUCCESSFUL;
 }
 
-static void __init mpc85xx_cds_pcibios_fixup(void)
+static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 {
-	struct pci_dev *dev;
-	u_char		c;
-
-	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
-					PCI_DEVICE_ID_VIA_82C586_1, NULL))) {
+	u_char c;
+	if (dev->vendor == PCI_VENDOR_ID_VIA) {
+		switch (dev->device) {
+		case PCI_DEVICE_ID_VIA_82C586_1:
+			/*
+			 * U-Boot does not set the enable bits
+			 * for the IDE device. Force them on here.
+			 */
+			pci_read_config_byte(dev, 0x40, &c);
+			c |= 0x03; /* IDE: Chip Enable Bits */
+			pci_write_config_byte(dev, 0x40, c);
+
+			/*
+			 * Since only primary interface works, force the
+			 * IDE function to standard primary IDE interrupt
+			 * w/ 8259 offset
+			 */
+			dev->irq = 14;
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+			break;
 		/*
-		 * U-Boot does not set the enable bits
-		 * for the IDE device. Force them on here.
+		 * Force legacy USB interrupt routing
 		 */
-		pci_read_config_byte(dev, 0x40, &c);
-		c |= 0x03; /* IDE: Chip Enable Bits */
-		pci_write_config_byte(dev, 0x40, c);
-
-		/*
-		 * Since only primary interface works, force the
-		 * IDE function to standard primary IDE interrupt
-		 * w/ 8259 offset
+		case PCI_DEVICE_ID_VIA_82C586_2:
+		/* There are two USB controllers.
+		 * Identify them by functon number
 		 */
-		dev->irq = 14;
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-		pci_dev_put(dev);
-	}
-
-	/*
-	 * Force legacy USB interrupt routing
-	 */
-	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
-					PCI_DEVICE_ID_VIA_82C586_2, NULL))) {
-		dev->irq = 10;
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
-		pci_dev_put(dev);
-	}
-
-	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
-					PCI_DEVICE_ID_VIA_82C586_2, dev))) {
-		dev->irq = 11;
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
-		pci_dev_put(dev);
+			if (PCI_FUNC(dev->devfn))
+				dev->irq = 11;
+			else
+				dev->irq = 10;
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		default:
+			break;
+		}
 	}
-
-	/* Now map all the PCI irqs */
-	dev = NULL;
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
 }
 
 #ifdef CONFIG_PPC_I8259
@@ -259,7 +251,7 @@ static void __init mpc85xx_cds_setup_arch(void)
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
-	ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
+	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
-- 
1.5.1
