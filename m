Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g5t0009.atlanta.hp.com (g5t0009.atlanta.hp.com [15.192.0.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 545CCDE1BC
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 05:56:34 +1100 (EST)
Message-Id: <20080304185822.741869974@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:57:01 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 15/16] x86: use generic pci_enable_resources()
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
    - checks for resource collisions with "!r->parent"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/x86/pci/common.c
===================================================================
--- work8.orig/arch/x86/pci/common.c	2008-03-04 10:12:42.000000000 -0700
+++ work8/arch/x86/pci/common.c	2008-03-04 10:12:51.000000000 -0700
@@ -527,7 +527,7 @@
 {
 	int err;
 
-	if ((err = pcibios_enable_resources(dev, mask)) < 0)
+	if ((err = pci_enable_resources(dev, mask)) < 0)
 		return err;
 
 	if (!dev->msi_enabled)
Index: work8/arch/x86/pci/i386.c
===================================================================
--- work8.orig/arch/x86/pci/i386.c	2008-03-04 10:12:56.000000000 -0700
+++ work8/arch/x86/pci/i386.c	2008-03-04 10:13:03.000000000 -0700
@@ -238,44 +238,6 @@
  */
 fs_initcall(pcibios_assign_resources);
 
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if ((idx == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-			continue;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available "
-				"because of resource %d collisions\n",
-				pci_name(dev), idx);
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-			pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain crappy BIOSes forget to set it properly.
Index: work8/arch/x86/pci/pci.h
===================================================================
--- work8.orig/arch/x86/pci/pci.h	2008-03-04 10:13:08.000000000 -0700
+++ work8/arch/x86/pci/pci.h	2008-03-04 10:13:12.000000000 -0700
@@ -44,7 +44,6 @@
 extern unsigned int pcibios_max_latency;
 
 void pcibios_resource_survey(void);
-int pcibios_enable_resources(struct pci_dev *, int);
 
 /* pci-pc.c */
 

-- 
