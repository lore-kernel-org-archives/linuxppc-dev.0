Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g5t0006.atlanta.hp.com (g5t0006.atlanta.hp.com [15.192.0.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 31156DE1B9
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 05:56:30 +1100 (EST)
Message-Id: <20080304185821.554040328@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:55 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 09/16] parisc: use generic pci_enable_resources()
Cc: Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the generic pci_enable_resources() instead of the arch-specific code.

Unlike this arch-specific code, the generic version:
    - checks PCI_NUM_RESOURCES (11), not DEVICE_COUNT_RESOURCE (12), resources
    - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
    - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
    - checks for resource collisions with "!r->parent"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/parisc/kernel/pci.c
===================================================================
--- work8.orig/arch/parisc/kernel/pci.c	2008-03-04 10:06:11.000000000 -0700
+++ work8/arch/parisc/kernel/pci.c	2008-03-04 10:07:54.000000000 -0700
@@ -287,23 +287,15 @@
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd;
-	int idx;
+	int err;
+	u16 cmd, old_cmd;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-
-	for (idx = 0; idx < DEVICE_COUNT_RESOURCE; idx++) {
-		struct resource *r = &dev->resource[idx];
+	err = pci_enable_resources(dev, mask);
+	if (err < 0)
+		return err;
 
-		/* only setup requested resources */
-		if (!(mask & (1<<idx)))
-			continue;
-
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
 
 	cmd |= (PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
 
@@ -312,8 +304,12 @@
 	if (dev->bus->bridge_ctl & PCI_BRIDGE_CTL_FAST_BACK)
 		cmd |= PCI_COMMAND_FAST_BACK;
 #endif
-	DBGC("PCIBIOS: Enabling device %s cmd 0x%04x\n", pci_name(dev), cmd);
-	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+	if (cmd != old_cmd) {
+		dev_info(&dev->dev, "enabling SERR and PARITY (%04x -> %04x)\n",
+			old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
 	return 0;
 }
 

-- 
