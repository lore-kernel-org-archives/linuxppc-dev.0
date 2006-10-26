Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6862367CBA
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 16:56:58 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id k9Q6uqLx000543
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 01:56:54 -0500
Subject: [PATCH] powerpc: Remove old pci_map_irq and pci_swizzle_irq from
	ppc_md
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 16:56:52 +1000
Message-Id: <1161845812.5299.25.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes ppc_md.pci_map_irq and ppc_md.pci_swizzle for ARCH=powerpc.

These were inherited from ARCH=ppc, but are not needed since parsing of interrupts
should be done via the of_* functions (who can do swizzling). If we ever need to
do non-standard swizzling on bridges without a device-node, then we might add
back a slightly different version of ppc_md.pci_swizzle but for now, that is not
the case.

I removed the couple of calls for these in 83xx. If that breaks something, then
there is a problem with the device-tree on these.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

It's of course totally untested on 83xx hardware, so please let me know
before we merge :)

Index: linux-cell/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_32.c	2006-10-26 16:47:07.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/pci_32.c	2006-10-26 16:50:13.000000000 +1000
@@ -1282,10 +1282,6 @@ pcibios_init(void)
 	if (pci_assign_all_buses && have_of)
 		pcibios_make_OF_bus_map();
 
-	/* Do machine dependent PCI interrupt routing */
-	if (ppc_md.pci_swizzle && ppc_md.pci_map_irq)
-		pci_fixup_irqs(ppc_md.pci_swizzle, ppc_md.pci_map_irq);
-
 	/* Call machine dependent fixup */
 	if (ppc_md.pcibios_fixup)
 		ppc_md.pcibios_fixup();
@@ -1308,25 +1304,6 @@ pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-unsigned char __init
-common_swizzle(struct pci_dev *dev, unsigned char *pinp)
-{
-	struct pci_controller *hose = dev->sysdata;
-
-	if (dev->bus->number != hose->first_busno) {
-		u8 pin = *pinp;
-		do {
-			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
-			/* Move up the chain of bridges. */
-			dev = dev->bus->self;
-		} while (dev->bus->self);
-		*pinp = pin;
-
-		/* The slot is the idsel of the last bridge. */
-	}
-	return PCI_SLOT(dev->devfn);
-}
-
 unsigned long resource_fixup(struct pci_dev * dev, struct resource * res,
 			     unsigned long start, unsigned long size)
 {
Index: linux-cell/arch/powerpc/platforms/83xx/mpc832x_mds.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/83xx/mpc832x_mds.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/83xx/mpc832x_mds.c	2006-10-26 16:48:24.000000000 +1000
@@ -96,8 +96,6 @@ static void __init mpc832x_sys_setup_arc
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
-
-	ppc_md.pci_swizzle = common_swizzle;
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
Index: linux-cell/arch/powerpc/platforms/83xx/mpc8360e_pb.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/83xx/mpc8360e_pb.c	2006-10-23 14:41:37.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/83xx/mpc8360e_pb.c	2006-10-26 16:48:35.000000000 +1000
@@ -102,8 +102,6 @@ static void __init mpc8360_sys_setup_arc
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
-
-	ppc_md.pci_swizzle = common_swizzle;
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
Index: linux-cell/include/asm-powerpc/machdep.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/machdep.h	2006-10-26 16:47:07.000000000 +1000
+++ linux-cell/include/asm-powerpc/machdep.h	2006-10-26 16:47:39.000000000 +1000
@@ -199,10 +199,6 @@ struct machdep_calls {
 	 * Returns 0 to allow assignment/enabling of the device. */
 	int  (*pcibios_enable_device_hook)(struct pci_dev *, int initial);
 
-	/* For interrupt routing */
-	unsigned char (*pci_swizzle)(struct pci_dev *, unsigned char *);
-	int (*pci_map_irq)(struct pci_dev *, unsigned char, unsigned char);
-
 	/* Called in indirect_* to avoid touching devices */
 	int (*pci_exclude_device)(unsigned char, unsigned char);
 
