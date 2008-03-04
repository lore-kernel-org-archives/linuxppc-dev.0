Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 878DCDDF66
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 05:56:15 +1100 (EST)
Message-Id: <20080304185819.885549413@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:47 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 01/16] PCI: add generic pci_enable_resources()
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

Each architecture has its own pcibios_enable_resources() implementation.
These differ in many minor ways that have nothing to do with actual
architectural differences.  Follow-on patches will make most arches
use this generic version instead.

This version is based on powerpc, which seemed most up-to-date.  The only
functional difference from the x86 version is that this uses "!r->parent"
to check for resource collisions instead of "!r->start && r->end".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pci/setup-res.c
===================================================================
--- work8.orig/drivers/pci/setup-res.c	2008-03-04 09:56:53.000000000 -0700
+++ work8/drivers/pci/setup-res.c	2008-03-04 09:56:56.000000000 -0700
@@ -263,3 +263,46 @@
 		}
 	}
 }
+
+int pci_enable_resources(struct pci_dev *dev, int mask)
+{
+	u16 cmd, old_cmd;
+	int i;
+	struct resource *r;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		if (!(mask & (1 << i)))
+			continue;
+
+		r = &dev->resource[i];
+
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if ((i == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
+
+		if (!r->parent) {
+			dev_err(&dev->dev, "device not available because of "
+				"BAR %d [%llx:%llx] collisions\n", i,
+				(unsigned long long) r->start,
+				(unsigned long long) r->end);
+			return -EINVAL;
+		}
+
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+
+	if (cmd != old_cmd) {
+		dev_info(&dev->dev, "enabling device (%04x -> %04x)\n",
+			 old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
Index: work8/include/linux/pci.h
===================================================================
--- work8.orig/include/linux/pci.h	2008-03-04 09:56:45.000000000 -0700
+++ work8/include/linux/pci.h	2008-03-04 09:56:56.000000000 -0700
@@ -616,6 +616,7 @@
 void pci_assign_unassigned_resources(void);
 void pdev_enable_device(struct pci_dev *);
 void pdev_sort_resources(struct pci_dev *, struct resource_list *);
+int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2

-- 
