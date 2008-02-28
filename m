Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0028.austin.hp.com (g1t0028.austin.hp.com [15.216.28.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id A52AFDDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:09:20 +1100 (EST)
Message-Id: <20080228001053.209248743@ldl.fc.hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:42 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 5/6] PARISC: move PERR & SERR enables out of
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

Move PERR and SERR enables from pcibios_enable_resources() to
platform_pci_enable_device() so the former matches other
architectures and can be shared.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work6/arch/parisc/kernel/pci.c
===================================================================
--- work6.orig/arch/parisc/kernel/pci.c	2008-02-27 11:30:02.000000000 -0700
+++ work6/arch/parisc/kernel/pci.c	2008-02-27 11:38:11.000000000 -0700
@@ -281,9 +281,7 @@
  * A driver is enabling the device.  We make sure that all the appropriate
  * bits are set to allow the device to operate as the driver is expecting.
  * We enable the port IO and memory IO bits if the device has any BARs of
- * that type, and we enable the PERR and SERR bits unconditionally.
- * Drivers that do not need parity (eg graphics and possibly networking)
- * can clear these bits if they want.
+ * that type.
  */
 int pcibios_enable_resources(struct pci_dev *dev, int mask)
 {
@@ -305,8 +303,6 @@
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 
-	cmd |= (PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
-
 #if 0
 	/* If bridge/bus controller has FBB enabled, child must too. */
 	if (dev->bus->bridge_ctl & PCI_BRIDGE_CTL_FAST_BACK)
@@ -317,9 +313,38 @@
 	return 0;
 }
 
+/*
+ * A driver is enabling the device.  We enable the PERR and SERR bits
+ * unconditionally.  Drivers that do not need parity (eg graphics and
+ * possibly networking) can clear these bits if they want.
+ */
+static int platform_pci_enable_device(struct pci_dev *dev)
+{
+	u16 cmd, old_cmd;
+	int idx;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+
+	cmd |= (PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
+
+	if (cmd != old_cmd) {
+		dev_info(&dev->dev, "enabling SERR and PARITY (%04x -> %04x)\n",
+			old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+
+	return 0;
+}
+
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
 
 /* PA-RISC specific */

-- 
