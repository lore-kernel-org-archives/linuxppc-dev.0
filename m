Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Support for MPIC on native cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 17:45:07 +1000
Message-Id: <1160984707.22522.64.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for southbridges using the MPIC interrupt controller to
the native cell platforms.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-10-16 14:48:22.000000000 +1000
+++ linux-cell/arch/powerpc/Kconfig	2006-10-16 14:48:27.000000000 +1000
@@ -461,6 +461,7 @@ config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL
 	select PPC_DCR_MMIO
+	select MPIC
 	default n
 
 config PPC_IBM_CELL_BLADE
Index: linux-cell/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/setup.c	2006-10-16 14:46:50.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/setup.c	2006-10-16 14:48:27.000000000 +1000
@@ -50,6 +50,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/udbg.h>
+#include <asm/mpic.h>
 
 #include "interrupt.h"
 #include "iommu.h"
@@ -88,10 +89,53 @@ static void __init cell_pcibios_fixup(vo
 		pci_read_irq_line(dev);
 }
 
+static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct mpic *mpic = desc->handler_data;
+	unsigned int virq;
+
+	virq = mpic_get_one_irq(mpic);
+	if (virq != NO_IRQ)
+		generic_handle_irq(virq);
+	desc->chip->eoi(irq);
+}
+
+static void __init mpic_init_IRQ(void)
+{
+	struct device_node *dn;
+	struct mpic *mpic;
+	unsigned int virq;
+
+	for (dn = NULL;
+	     (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
+		if (!device_is_compatible(dn, "CBEA,platform-open-pic"))
+			continue;
+
+		/* The MPIC driver will get everything it needs from the
+		 * device-tree, just pass 0 to all arguments
+		 */
+		mpic = mpic_alloc(dn, 0, 0, 0, 0, " MPIC     ");
+		if (mpic == NULL)
+			continue;
+		mpic_init(mpic);
+
+		virq = irq_of_parse_and_map(dn, 0);
+		if (virq == NO_IRQ)
+			continue;
+
+		printk(KERN_INFO "%s : hooking up to IRQ %d\n",
+		       dn->full_name, virq);
+		set_irq_data(virq, mpic);
+		set_irq_chained_handler(virq, cell_mpic_cascade);
+	}
+}
+
+
 static void __init cell_init_irq(void)
 {
 	iic_init_IRQ();
 	spider_init_IRQ();
+	mpic_init_IRQ();
 }
 
 static void __init cell_setup_arch(void)
