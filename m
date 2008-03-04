Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0026.austin.hp.com (g1t0026.austin.hp.com [15.216.28.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 873A0DDF3B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 05:56:15 +1100 (EST)
Message-Id: <20080304185820.125200297@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:48 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 02/16] alpha: use generic pci_enable_resources()
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
    - skips resources unless requested in "mask"
    - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
    - checks for resource collisions with "!r->parent"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/alpha/kernel/pci.c
===================================================================
--- work8.orig/arch/alpha/kernel/pci.c	2008-03-04 09:58:07.000000000 -0700
+++ work8/arch/alpha/kernel/pci.c	2008-03-04 09:58:54.000000000 -0700
@@ -372,28 +372,7 @@
 int
 pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, oldcmd;
-	int i;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	oldcmd = cmd;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		else if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-		/* Enable the appropriate bits in the PCI command register.  */
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
+	return pci_enable_resources(dev, mask);
 }
 
 /*

-- 
