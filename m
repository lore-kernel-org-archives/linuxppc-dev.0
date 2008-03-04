Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id F33B5DDF68
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 05:56:16 +1100 (EST)
Message-Id: <20080304185820.325773560@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:49 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 03/16] arm: use generic pci_enable_resources()
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
    - checks PCI_NUM_RESOURCES (11), not 6, resources
    - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
    - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
    - checks for resource collisions with "!r->parent"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/arm/kernel/bios32.c
===================================================================
--- work8.orig/arch/arm/kernel/bios32.c	2008-03-04 09:59:24.000000000 -0700
+++ work8/arch/arm/kernel/bios32.c	2008-03-04 10:01:40.000000000 -0700
@@ -660,28 +660,15 @@
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	int err;
 	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
+
+	err = pci_enable_resources(dev, mask);
+	if (err < 0)
+		return err;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx = 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = dev->resource + idx;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because"
-			       " of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
 
 	/*
 	 * Bridges (eg, cardbus bridges) need to be fully enabled
@@ -690,8 +677,8 @@
 		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
 
 	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
+		dev_info(&dev->dev, "enabling bridge device (%04x -> %04x)\n",
+		       old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;

-- 
