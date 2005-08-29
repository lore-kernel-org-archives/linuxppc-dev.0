Return-Path: <jirislaby@gmail.com>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 336836813C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2005 08:35:43 +1000 (EST)
Date: Tue, 30 Aug 2005 00:26:45 +0200
Message-Id: <200508292226.j7TMQjMo020005@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] arch: pci_find_device remove
	(ppc/platforms/85xx/mpc85xx_cds_common.c)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 mpc85xx_cds_common.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -354,10 +354,10 @@ mpc85xx_cds_fixup_via(struct pci_control
 void __init
 mpc85xx_cds_pcibios_fixup(void)
 {
-        struct pci_dev *dev = NULL;
+        struct pci_dev *dev;
 	u_char		c;
 
-        if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
                                         PCI_DEVICE_ID_VIA_82C586_1, NULL))) {
                 /*
                  * U-Boot does not set the enable bits
@@ -374,21 +374,24 @@ mpc85xx_cds_pcibios_fixup(void)
 		 */
                 dev->irq = 14;
                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		pci_dev_put(dev);
         }
 
 	/*
 	 * Force legacy USB interrupt routing
 	 */
-        if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
                                         PCI_DEVICE_ID_VIA_82C586_2, NULL))) {
                 dev->irq = 10;
                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
+		pci_dev_put(dev);
         }
 
-        if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
                                         PCI_DEVICE_ID_VIA_82C586_2, dev))) {
                 dev->irq = 11;
                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+		pci_dev_put(dev);
         }
 }
 #endif /* CONFIG_PCI */
