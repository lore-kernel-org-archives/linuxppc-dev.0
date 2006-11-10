Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:44:50 +1100
Subject: [PATCH 8/32] powerpc: Remove ppc_md.pci_map_irq & ppc_swizzle for
	ARCH=powerpc
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074453.DB1E867D87@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These were inherited from ARCH=ppc, but are not needed since parsing of interrupts
should be done via the of_* functions (who can do swizzling). If we ever need to
do non-standard swizzling on bridges without a device-node, then we might add
back a slightly different version of ppc_md.pci_swizzle but for now, that is not
the case.

I removed the couple of calls for these in 83xx. If that breaks something, then
there is a problem with the device-tree on these.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/pci_32.c              |   23 -----------------------
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    2 --
 arch/powerpc/platforms/83xx/mpc8360e_pb.c |    2 --
 include/asm-powerpc/machdep.h             |    4 ----
 4 files changed, 31 deletions(-)

Index: linux-cell/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_32.c	2006-11-06 15:04:50.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/pci_32.c	2006-11-06 15:05:34.000000000 +1100
@@ -1283,10 +1283,6 @@ pcibios_init(void)
 	if (pci_assign_all_buses && have_of)
 		pcibios_make_OF_bus_map();
 
-	/* Do machine dependent PCI interrupt routing */
-	if (ppc_md.pci_swizzle && ppc_md.pci_map_irq)
-		pci_fixup_irqs(ppc_md.pci_swizzle, ppc_md.pci_map_irq);
-
 	/* Call machine dependent fixup */
 	if (ppc_md.pcibios_fixup)
 		ppc_md.pcibios_fixup();
@@ -1309,25 +1305,6 @@ pcibios_init(void)
 
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
--- linux-cell.orig/arch/powerpc/platforms/83xx/mpc832x_mds.c	2006-11-06 15:01:52.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/83xx/mpc832x_mds.c	2006-11-06 15:05:34.000000000 +1100
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
--- linux-cell.orig/arch/powerpc/platforms/83xx/mpc8360e_pb.c	2006-11-06 15:01:52.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/83xx/mpc8360e_pb.c	2006-11-06 15:05:34.000000000 +1100
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
--- linux-cell.orig/include/asm-powerpc/machdep.h	2006-11-06 15:02:21.000000000 +1100
+++ linux-cell/include/asm-powerpc/machdep.h	2006-11-06 15:05:34.000000000 +1100
@@ -199,10 +199,6 @@ struct machdep_calls {
 	 * Returns 0 to allow assignment/enabling of the device. */
 	int  (*pcibios_enable_device_hook)(struct pci_dev *, int initial);
 
-	/* For interrupt routing */
-	unsigned char (*pci_swizzle)(struct pci_dev *, unsigned char *);
-	int (*pci_map_irq)(struct pci_dev *, unsigned char, unsigned char);
-
 	/* Called in indirect_* to avoid touching devices */
 	int (*pci_exclude_device)(unsigned char, unsigned char);
 
