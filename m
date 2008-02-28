Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 9B4AEDDE3D
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:09:21 +1100 (EST)
Message-Id: <20080228001053.404893334@ldl.fc.hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:43 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 6/6] PCI: consolidate several pcibios_enable_resources()
	implementations
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

There are many implementations of pcibios_enable_resources() that differ
in minor ways that look more like bugs than architectural differences.

This patch consolidates most of them to use the version annotated below.
This is the original x86 version, except that it uses the resource
collision check from powerpc at (5):

    int pcibios_enable_resources(struct pci_dev *dev, int mask)
    {
	u16 cmd, old_cmd;
	int i;
	struct resource *r;

  (0)
	pci_read_config_word(dev, PCI_COMMAND, &cmd);
	old_cmd = cmd;

  (1)	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
  (2)		if (!(mask & (1 << i)))
			continue;

		r = &dev->resource[i];

  (3)		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
			continue;

  (4)		if ((i == PCI_ROM_RESOURCE) &&
				(!(r->flags & IORESOURCE_ROM_ENABLE)))
			continue;

  (5)		if (!r->parent) {
			dev_err(&dev->dev, "device not available because of "
				"BAR %d [%llx:%llx] collisions\n", i,
				(unsigned long long) r->start,
				(unsigned long long) r->end);
			return -EINVAL;
		}

		if (r->flags & IORESOURCE_IO)
			cmd |= PCI_COMMAND_IO;
		if (r->flags & IORESOURCE_MEM)
			cmd |= PCI_COMMAND_MEMORY;
	}

  (6)
  (7)	if (cmd != old_cmd) {
		dev_info(&dev->dev, "enabling device (%04x -> %04x)\n",
			 old_cmd, cmd);
		pci_write_config_word(dev, PCI_COMMAND, cmd);
	}
	return 0;
    }

Compared with the above version, other architectures have the following
functional differences:

    alpha: ignores mask at (2), has no PCI_ROM_RESOURCE check at (4),
	has no collision check at (5)

    arm: checks only 6 resources at (1), has no PCI_ROM_RESOURCE check at (4), 
	always fully enables bridges at (6)

    cris: checks only 6 resources at (1), has a different ROM
	resource check at (4) and (6) that ignores IORESOURCE_ROM_ENABLE

    frv: checks only 6 resources at (1), has a different ROM
	resource check at (4) and (6) that ignores IORESOURCE_ROM_ENABLE

    ia64: checks for NULL dev at (0)

    mips: has no IORESOURCE_{IO,MEM} check at (3), has a different
	ROM resource check at (4) and (6) that ignores IORESOURCE_ROM_ENABLE

    mn10300: checks only 6 resources at (1), has no IORESOURCE_{IO,MEM}
	check at (3), has a different ROM resource check at (4) and (6)
	that ignores IORESOURCE_ROM_ENABLE

    parisc: checks DEVICE_COUNT_RESOURCE (12) instead of PCI_NUM_RESOURCES (11)
	resources at (1), has no IORESOURCE_{IO,MEM} check at (3),
	has no PCI_ROM_RESOURCE check at (4), has no collision check at (5)
	always turns on PCI_COMMAND_SERR | PCI_COMMAND_PARITY at (6),
	writes cmd even if unchanged at (7)

    powerpc: has a different collision check at (5)

    ppc: checks only 6 resources at (1), has no IORESOURCE_{IO,MEM} check
	at (3), has a different ROM resource check at (4) and (6) that
	ignores IORESOURCE_ROM_ENABLE, has a different collision check using
	IORESOURCE_UNSET at (5)

    sh: checks only 6 resources at (1), has no IORESOURCE_{IO,MEM} check
	at (3), has a different ROM resource check at (4) and (6) that
	ignores IORESOURCE_ROM_ENABLE

    sparc64: has no IORESOURCE_{IO,MEM} check at (3), has no PCI_ROM_RESOURCE
	check at (4)

    v850: checks only 6 resources at (1), has no IORESOURCE_{IO,MEM} check
	at (3), has no PCI_ROM_RESOURCE check at (4)

    xtensa: checks only 6 resources at (1), has no IORESOURCE_{IO,MEM} check
	at (3), has a different ROM resource check at (4) and (6) that
	ignores IORESOURCE_ROM_ENABLE

    x86: has a different collision check at (5)

The mips/pmc-sierra implementation of pcibios_enable_resources() is
cluttered with a bunch of titan stuff, so I can't immediately consolidate
it with the others.  So I made the generic version "weak" so pmc-sierra
can override it.

Not-Yet-Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

---
 arch/alpha/kernel/pci.c                 |   27 --------------------
 arch/arm/kernel/bios32.c                |   37 ----------------------------
 arch/cris/arch-v32/drivers/pci/bios.c   |   32 ------------------------
 arch/frv/mb93090-mb00/pci-frv.c         |   32 ------------------------
 arch/ia64/pci/pci.c                     |   42 --------------------------------
 arch/mips/pci/pci.c                     |   32 ------------------------
 arch/mn10300/unit-asb2305/pci-asb2305.c |   39 -----------------------------
 arch/parisc/kernel/pci.c                |   37 ----------------------------
 arch/powerpc/kernel/pci-common.c        |   36 ---------------------------
 arch/ppc/kernel/pci.c                   |   33 -------------------------
 arch/sh/drivers/pci/pci.c               |   32 ------------------------
 arch/sparc64/kernel/pci.c               |   30 ----------------------
 arch/v850/kernel/rte_mb_a_pci.c         |   28 ---------------------
 arch/x86/pci/i386.c                     |   38 ----------------------------
 arch/x86/pci/pci.h                      |    1 
 arch/xtensa/kernel/pci.c                |   31 -----------------------
 drivers/pci/setup-res.c                 |   42 ++++++++++++++++++++++++++++++++
 include/linux/pci.h                     |    1 
 18 files changed, 43 insertions(+), 507 deletions(-)

Index: work6/arch/alpha/kernel/pci.c
===================================================================
--- work6.orig/arch/alpha/kernel/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/alpha/kernel/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -370,33 +370,6 @@
 #endif
 
 int
-pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
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
-}
-
-int
 pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	return pcibios_enable_resources(dev, mask);
Index: work6/arch/arm/kernel/bios32.c
===================================================================
--- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/arm/kernel/bios32.c	2008-02-27 14:40:34.000000000 -0700
@@ -654,43 +654,6 @@
 	res->start = (start + align - 1) & ~(align - 1);
 }
 
-/**
- * pcibios_enable_resources - Enable I/O and memory.
- * @dev: PCI device to be enabled
- */
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
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
-
-	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 static int platform_pci_enable_device(struct pci_dev *dev)
 {
 	u16 cmd, old_cmd;
Index: work6/arch/cris/arch-v32/drivers/pci/bios.c
===================================================================
--- work6.orig/arch/cris/arch-v32/drivers/pci/bios.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/cris/arch-v32/drivers/pci/bios.c	2008-02-27 14:40:34.000000000 -0700
@@ -55,38 +55,6 @@
 	}
 }
 
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 int pcibios_enable_irq(struct pci_dev *dev)
 {
 	dev->irq = EXT_INTR_VECT;
Index: work6/arch/frv/mb93090-mb00/pci-frv.c
===================================================================
--- work6.orig/arch/frv/mb93090-mb00/pci-frv.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/frv/mb93090-mb00/pci-frv.c	2008-02-27 14:40:34.000000000 -0700
@@ -231,38 +231,6 @@
 	pcibios_assign_resources();
 }
 
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain crappy BIOSes forget to set it properly.
Index: work6/arch/ia64/pci/pci.c
===================================================================
--- work6.orig/arch/ia64/pci/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/ia64/pci/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -499,48 +499,6 @@
 	/* ??? FIXME -- record old value for shutdown.  */
 }
 
-static inline int
-pcibios_enable_resources (struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
-
-	if (!dev)
-		return -EINVAL;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx=0; idx<PCI_NUM_RESOURCES; idx++) {
-		/* Only set up the desired resources.  */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!(r->flags & type_mask))
-			continue;
-		if ((idx == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-			continue;
-		if (!r->start && r->end) {
-			printk(KERN_ERR
-			       "PCI: Device %s not available because of resource collisions\n",
-			       pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 int
 pcibios_enable_device (struct pci_dev *dev, int mask)
 {
Index: work6/arch/mips/pci/pci.c
===================================================================
--- work6.orig/arch/mips/pci/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/mips/pci/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -163,38 +163,6 @@
 
 subsys_initcall(pcibios_init);
 
-static int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain crappy BIOSes forget to set it properly.
Index: work6/arch/mn10300/unit-asb2305/pci-asb2305.c
===================================================================
--- work6.orig/arch/mn10300/unit-asb2305/pci-asb2305.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/mn10300/unit-asb2305/pci-asb2305.c	2008-02-27 14:40:34.000000000 -0700
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
Index: work6/arch/parisc/kernel/pci.c
===================================================================
--- work6.orig/arch/parisc/kernel/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/parisc/kernel/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -276,43 +276,6 @@
 	/* The caller updates the end field, we don't.  */
 }
 
-
-/*
- * A driver is enabling the device.  We make sure that all the appropriate
- * bits are set to allow the device to operate as the driver is expecting.
- * We enable the port IO and memory IO bits if the device has any BARs of
- * that type.
- */
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd;
-	int idx;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-
-	for (idx = 0; idx < DEVICE_COUNT_RESOURCE; idx++) {
-		struct resource *r = &dev->resource[idx];
-
-		/* only setup requested resources */
-		if (!(mask & (1<<idx)))
-			continue;
-
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-#if 0
-	/* If bridge/bus controller has FBB enabled, child must too. */
-	if (dev->bus->bridge_ctl & PCI_BRIDGE_CTL_FAST_BACK)
-		cmd |= PCI_COMMAND_FAST_BACK;
-#endif
-	DBGC("PCIBIOS: Enabling device %s cmd 0x%04x\n", pci_name(dev), cmd);
-	pci_write_config_word(dev, PCI_COMMAND, cmd);
-	return 0;
-}
-
 /*
  * A driver is enabling the device.  We enable the PERR and SERR bits
  * unconditionally.  Drivers that do not need parity (eg graphics and
Index: work6/arch/powerpc/kernel/pci-common.c
===================================================================
--- work6.orig/arch/powerpc/kernel/pci-common.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/powerpc/kernel/pci-common.c	2008-02-27 14:40:34.000000000 -0700
@@ -1153,42 +1153,6 @@
 EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
 #endif /* CONFIG_HOTPLUG */
 
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
-		r = &dev->resource[idx];
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if ((idx == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-			continue;
-		if (r->parent == NULL) {
-			printk(KERN_ERR "PCI: Device %s not available because"
-			       " of resource collisions\n", pci_name(dev));
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
-	return 0;
-}
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	if (ppc_md.pcibios_enable_device_hook)
Index: work6/arch/ppc/kernel/pci.c
===================================================================
--- work6.orig/arch/ppc/kernel/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/ppc/kernel/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -578,39 +578,6 @@
 }
 
 
-int
-pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx=0; idx<6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
-			continue;
-	
-		r = &dev->resource[idx];
-		if (r->flags & IORESOURCE_UNSET) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 static int next_controller_index;
 
 struct pci_controller * __init
Index: work6/arch/sh/drivers/pci/pci.c
===================================================================
--- work6.orig/arch/sh/drivers/pci/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/sh/drivers/pci/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -131,38 +131,6 @@
 	}
 }
 
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
-		if (!(mask & (1 << idx)))
-			continue;
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
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		printk(KERN_INFO "PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	return pcibios_enable_resources(dev, mask);
Index: work6/arch/sparc64/kernel/pci.c
===================================================================
--- work6.orig/arch/sparc64/kernel/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/sparc64/kernel/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -946,36 +946,6 @@
 {
 }
 
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, oldcmd;
-	int i;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	oldcmd = cmd;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<i)))
-			continue;
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	return pcibios_enable_resources(dev, mask);
Index: work6/arch/v850/kernel/rte_mb_a_pci.c
===================================================================
--- work6.orig/arch/v850/kernel/rte_mb_a_pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/v850/kernel/rte_mb_a_pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -217,34 +217,6 @@
 }
 
 
-int __nomods_init pcibios_enable_resources (struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx = 0; idx < 6; idx++) {
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
-	return 0;
-}
-
 int __nomods_init pcibios_enable_device (struct pci_dev *dev, int mask)
 {
 	return pcibios_enable_resources(dev, mask);
Index: work6/arch/x86/pci/i386.c
===================================================================
--- work6.orig/arch/x86/pci/i386.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/x86/pci/i386.c	2008-02-27 14:40:34.000000000 -0700
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
Index: work6/arch/x86/pci/pci.h
===================================================================
--- work6.orig/arch/x86/pci/pci.h	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/x86/pci/pci.h	2008-02-27 14:40:34.000000000 -0700
@@ -44,7 +44,6 @@
 extern unsigned int pcibios_max_latency;
 
 void pcibios_resource_survey(void);
-int pcibios_enable_resources(struct pci_dev *, int);
 
 /* pci-pc.c */
 
Index: work6/arch/xtensa/kernel/pci.c
===================================================================
--- work6.orig/arch/xtensa/kernel/pci.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/arch/xtensa/kernel/pci.c	2008-02-27 14:40:34.000000000 -0700
@@ -91,37 +91,6 @@
 	}
 }
 
-int
-pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
-		r = &dev->resource[idx];
-		if (!r->start && r->end) {
-			printk (KERN_ERR "PCI: Device %s not available because "
-				"of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-			pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 struct pci_controller * __init pcibios_alloc_controller(void)
 {
 	struct pci_controller *pci_ctrl;
Index: work6/drivers/pci/setup-res.c
===================================================================
--- work6.orig/drivers/pci/setup-res.c	2008-02-27 14:37:14.000000000 -0700
+++ work6/drivers/pci/setup-res.c	2008-02-27 16:53:59.000000000 -0700
@@ -263,3 +263,47 @@
 		}
 	}
 }
+
+int __attribute__ ((weak)) pcibios_enable_resources(struct pci_dev *dev,
+						    int mask)
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
Index: work6/include/linux/pci.h
===================================================================
--- work6.orig/include/linux/pci.h	2008-02-27 14:37:14.000000000 -0700
+++ work6/include/linux/pci.h	2008-02-27 14:40:34.000000000 -0700
@@ -616,6 +616,7 @@
 void pci_assign_unassigned_resources(void);
 void pdev_enable_device(struct pci_dev *);
 void pdev_sort_resources(struct pci_dev *, struct resource_list *);
+int pcibios_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2

-- 
