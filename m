Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 15 May 2009 16:16:47 +1000
Subject: [PATCH] powerpc: Fix PCI ROM access
Message-Id: <20090515061654.E5CC3DE09D@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A couple of issues crept in since about 2.6.27 related to accessing PCI
device ROMs on various powerpc machines.

First, historically, we don't allocate the ROM resource in the resource
tree. I'm not entirely certain of why, I susepct they often contained
garbage on x86 but it's hard to tell. This causes the current generic
code to always call pci_assign_resource() when trying to access the said
ROM from sysfs, which will try to re-assign some new address regardless
of what the ROM BAR was already set to at boot time. This can be a
problem on hypervisor platforms like pSeries where we aren't supposed
to move PCI devices around (and in fact probably can't).

Second, our code that generates the PCI tree from the OF device-tree
(instead of doing config space probing) which we mostly use on pseries
at the moment, didn't set the (new) flag IORESOURCE_SIZEALIGN on any
resource. That means that any attempt at re-assigning such a resource
with pci_assign_resource() would fail due to resource_alignment()
returning 0.

This fixes this by doing these two things:

 - The code that calculates resource flags based on the OF device-node
is improved to set IORESOURCE_SIZEALIGN on any valid BAR, and while at
it also set IORESOURCE_READONLY for ROMs since we were lacking that too

 - We now allocate ROM resources as part of the resource tree. However
to limit the chances of nasty conflicts due to busted firmwares, we
only do it on the second pass of our two-passes allocation scheme,
so that all valid and enabled BARs get precedence.

This brings pSeries back the ability to access PCI ROMs via sysfs (and
thus initialize various video cards from X etc...).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   21 ++++++++++++++-------
 arch/powerpc/kernel/pci_64.c     |   15 ++++++++++++---
 2 files changed, 26 insertions(+), 10 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2009-05-15 15:47:21.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci_64.c	2009-05-15 16:00:35.000000000 +1000
@@ -64,7 +64,7 @@ static u32 get_int_prop(struct device_no
 	return def;
 }
 
-static unsigned int pci_parse_of_flags(u32 addr0)
+static unsigned int pci_parse_of_flags(u32 addr0, int bridge)
 {
 	unsigned int flags = 0;
 
@@ -75,8 +75,17 @@ static unsigned int pci_parse_of_flags(u
 		if (addr0 & 0x40000000)
 			flags |= IORESOURCE_PREFETCH
 				 | PCI_BASE_ADDRESS_MEM_PREFETCH;
+		/* Note: We don't know whether the ROM has been left enabled
+		 * by the firmware or not. We mark it as disabled (ie, we do
+		 * not set the IORESOURCE_ROM_ENABLE flag) for now rather than
+		 * do a config space read, it will be force-enabled if needed
+		 */
+		if (!bridge && (addr0 & 0xff) == 0x30)
+			flags |= IORESOURCE_READONLY;
 	} else if (addr0 & 0x01000000)
 		flags = IORESOURCE_IO | PCI_BASE_ADDRESS_SPACE_IO;
+	if (flags)
+		flags |= IORESOURCE_SIZEALIGN;
 	return flags;
 }
 
@@ -95,7 +104,7 @@ static void pci_parse_of_addrs(struct de
 		return;
 	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
 	for (; proplen >= 20; proplen -= 20, addrs += 5) {
-		flags = pci_parse_of_flags(addrs[0]);
+		flags = pci_parse_of_flags(addrs[0], 0);
 		if (!flags)
 			continue;
 		base = of_read_number(&addrs[1], 2);
@@ -293,7 +302,7 @@ void __devinit of_scan_pci_bridge(struct
 	}
 	i = 1;
 	for (; len >= 32; len -= 32, ranges += 8) {
-		flags = pci_parse_of_flags(ranges[0]);
+		flags = pci_parse_of_flags(ranges[0], 1);
 		size = of_read_number(&ranges[6], 2);
 		if (flags == 0 || size == 0)
 			continue;
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2009-05-15 15:51:43.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2009-05-15 16:00:28.000000000 +1000
@@ -1366,12 +1366,17 @@ static void __init pcibios_allocate_reso
 
 	for_each_pci_dev(dev) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
-		for (idx = 0; idx < 6; idx++) {
+		for (idx = 0; idx <= PCI_ROM_RESOURCE; idx++) {
 			r = &dev->resource[idx];
 			if (r->parent)		/* Already allocated */
 				continue;
 			if (!r->flags || (r->flags & IORESOURCE_UNSET))
 				continue;	/* Not assigned at all */
+			/* We only allocate ROMs on pass 1 just in case they
+			 * have been screwed up by firmware
+			 */
+			if (idx == PCI_ROM_RESOURCE )
+				disabled = 1;
 			if (r->flags & IORESOURCE_IO)
 				disabled = !(command & PCI_COMMAND_IO);
 			else
@@ -1382,17 +1387,19 @@ static void __init pcibios_allocate_reso
 		if (pass)
 			continue;
 		r = &dev->resource[PCI_ROM_RESOURCE];
-		if (r->flags & IORESOURCE_ROM_ENABLE) {
+		if (r->flags) {
 			/* Turn the ROM off, leave the resource region,
 			 * but keep it unregistered.
 			 */
 			u32 reg;
-			pr_debug("PCI: Switching off ROM of %s\n",
-				 pci_name(dev));
-			r->flags &= ~IORESOURCE_ROM_ENABLE;
 			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
-			pci_write_config_dword(dev, dev->rom_base_reg,
-					       reg & ~PCI_ROM_ADDRESS_ENABLE);
+			if (reg & PCI_ROM_ADDRESS_ENABLE) {
+				pr_debug("PCI: Switching off ROM of %s\n",
+					 pci_name(dev));
+				r->flags &= ~IORESOURCE_ROM_ENABLE;
+				pci_write_config_dword(dev, dev->rom_base_reg,
+						       reg & ~PCI_ROM_ADDRESS_ENABLE);
+			}
 		}
 	}
 }
