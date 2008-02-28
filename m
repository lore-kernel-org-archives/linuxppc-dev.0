Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 5E3C0DDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:09:18 +1100 (EST)
Message-Id: <20080228001053.013269726@ldl.fc.hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:41 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 4/6] ARM: move bridge enable out of pcibios_enable_resources()
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

Move bridge enable from pcibios_enable_resources() to
platform_pci_enable_device() so the former matches other
architectures and can be shared.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work6/arch/arm/kernel/bios32.c
===================================================================
--- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 11:25:29.000000000 -0700
+++ work6/arch/arm/kernel/bios32.c	2008-02-27 11:55:59.000000000 -0700
@@ -683,15 +683,32 @@
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 
+	if (cmd != old_cmd) {
+		printk("PCI: enabling device %s (%04x -> %04x)\n",
+		       pci_name(dev), old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
+static int platform_pci_enable_device(struct pci_dev *dev)
+{
+	u16 cmd, old_cmd;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+
 	/*
-	 * Bridges (eg, cardbus bridges) need to be fully enabled
+	 * Bridges (eg, cardbus bridges) need to be fully enabled.
+	 * Most architectures do this in pci_enable_bridges(), not
+	 * in the pci_enable_device() path.
 	 */
 	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
 		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
 
 	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
+		dev_info(&dev->dev, "enabling bridge device (%04x -> %04x)\n",
+		       old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
@@ -699,7 +716,12 @@
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	return pcibios_enable_resources(dev, mask);
+	int err;
+
+	if ((err = pcibios_enable_resources(dev, mask)) < 0)
+		return err;
+
+	return platform_pci_enable_device(dev);
 }
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,

-- 
