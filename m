Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 746E1DDE20
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 03:33:05 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l85HVo2G027816
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 21:31:50 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l85HVoMS027813
	for linuxppc-dev@ozlabs.org; Wed, 5 Sep 2007 21:31:50 +0400
Date: Wed, 5 Sep 2007 21:31:50 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PCI e100 interrupt quirk fix
Message-ID: <20070905173150.GA27798@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PCI memory space may have a 64-bit offset on some architectures
and the actual PCI memory address has to fixed up before remapping.
So, pci_iomap should be used instead of reading and remapping PCI BAR
directly.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---

--- linux-2.6.orig/drivers/pci/quirks.c	2007-09-04 21:15:43.000000000 +0400
+++ linux-2.6.bld/drivers/pci/quirks.c	2007-09-05 20:46:14.000000000 +0400
@@ -1432,9 +1432,9 @@
 static void __devinit quirk_e100_interrupt(struct pci_dev *dev)
 {
 	u16 command;
-	u32 bar;
 	u8 __iomem *csr;
 	u8 cmd_hi;
+	int rc;
 
 	switch (dev->device) {
 	/* PCI IDs taken from drivers/net/e100.c */
@@ -1464,16 +1464,17 @@
 	 * re-enable them when it's ready.
 	 */
 	pci_read_config_word(dev, PCI_COMMAND, &command);
-	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &bar);
 
-	if (!(command & PCI_COMMAND_MEMORY) || !bar)
+	rc = pci_request_region(dev, 0, "e100_quirk");
+
+	if (!(command & PCI_COMMAND_MEMORY) || (rc < 0))
 		return;
 
-	csr = ioremap(bar, 8);
+	csr = pci_iomap(dev, 0, 8);
 	if (!csr) {
 		printk(KERN_WARNING "PCI: Can't map %s e100 registers\n",
 			pci_name(dev));
-		return;
+		goto e100_quirk_exit;
 	}
 
 	cmd_hi = readb(csr + 3);
@@ -1483,7 +1484,9 @@
 		writeb(1, csr + 3);
 	}
 
-	iounmap(csr);
+	pci_iounmap(dev, csr);
+e100_quirk_exit:
+	pci_release_region(dev, 0);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_e100_interrupt);
 
