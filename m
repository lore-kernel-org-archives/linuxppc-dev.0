Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0028.austin.hp.com (g1t0028.austin.hp.com [15.216.28.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 17E31DDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:09:18 +1100 (EST)
Message-Id: <20080228001052.812275985@ldl.fc.hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:40 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 3/6] xtensa: make pcibios_enable_device() use
	pcibios_enable_resources()
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

pcibios_enable_device() has an almost verbatim copy of
pcibios_enable_resources(), (the only difference is that
pcibios_enable_resources() turns on PCI_COMMAND_MEMORY if
there's a ROM resource).

The duplication might be intentional, but I don't see any callers
of pcibios_enable_resources() on xtensa, so I think it's more
likely a historical accident copied from ppc.

This patch removes the duplication, making pcibios_enable_device()
simply call pcibios_enable_resources() as x86 does.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work6/arch/xtensa/kernel/pci.c
===================================================================
--- work6.orig/arch/xtensa/kernel/pci.c	2008-02-18 10:43:50.000000000 -0700
+++ work6/arch/xtensa/kernel/pci.c	2008-02-18 11:32:12.000000000 -0700
@@ -238,31 +238,7 @@
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx=0; idx<6; idx++) {
-		r = &dev->resource[idx];
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because "
-			       "of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-
-	return 0;
+	return pcibios_enable_resources(dev, mask);
 }
 
 #ifdef CONFIG_PROC_FS

-- 
