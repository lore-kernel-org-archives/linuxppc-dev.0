Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g5t0006.atlanta.hp.com (g5t0006.atlanta.hp.com [15.192.0.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 65865DE06A
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 05:56:27 +1100 (EST)
Message-Id: <20080304185821.354198782@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:54 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 08/16] mn10300: use generic pci_enable_resources()
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

Index: work8/arch/mn10300/unit-asb2305/pci-asb2305.c
===================================================================
--- work8.orig/arch/mn10300/unit-asb2305/pci-asb2305.c	2008-03-04 10:05:27.000000000 -0700
+++ work8/arch/mn10300/unit-asb2305/pci-asb2305.c	2008-03-04 10:05:36.000000000 -0700
@@ -218,45 +218,6 @@
 	pcibios_allocate_resources(1);
 }
 
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-
-	for (idx = 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = &dev->resource[idx];
-
-		if (!r->start && r->end) {
-			printk(KERN_ERR
-			       "PCI: Device %s not available because of"
-			       " resource collisions\n",
-			       pci_name(dev));
-			return -EINVAL;
-		}
-
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-
-	if (cmd != old_cmd)
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-
-	return 0;
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain crappy BIOSes forget to set it properly.
Index: work8/arch/mn10300/unit-asb2305/pci-asb2305.h
===================================================================
--- work8.orig/arch/mn10300/unit-asb2305/pci-asb2305.h	2008-03-04 10:05:41.000000000 -0700
+++ work8/arch/mn10300/unit-asb2305/pci-asb2305.h	2008-03-04 10:05:45.000000000 -0700
@@ -36,7 +36,6 @@
 extern unsigned int pcibios_max_latency;
 
 extern void pcibios_resource_survey(void);
-extern int pcibios_enable_resources(struct pci_dev *dev, int mask);
 
 /* pci.c */
 
Index: work8/arch/mn10300/unit-asb2305/pci.c
===================================================================
--- work8.orig/arch/mn10300/unit-asb2305/pci.c	2008-03-04 10:05:49.000000000 -0700
+++ work8/arch/mn10300/unit-asb2305/pci.c	2008-03-04 10:05:54.000000000 -0700
@@ -440,7 +440,7 @@
 {
 	int err;
 
-	err = pcibios_enable_resources(dev, mask);
+	err = pci_enable_resources(dev, mask);
 	if (err == 0)
 		pcibios_enable_irq(dev);
 	return err;

-- 
