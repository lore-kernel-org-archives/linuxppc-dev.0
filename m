Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 11 Nov 2006 17:24:58 +1100
Subject: [PATCH 13/32] powerpc: Native cell support for MPIC in southbridge
In-Reply-To: <1163226282.72526.823314634857.qpush@butch>
Message-Id: <20061111062528.78EEA6833F@ozlabs.org>
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

 arch/powerpc/Kconfig                |    1 
 arch/powerpc/platforms/cell/setup.c |   44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-11-06 15:05:40.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2006-11-06 15:15:45.000000000 +1100
@@ -461,6 +461,7 @@ config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL
 	select PPC_DCR_MMIO
+	select MPIC
 	default n
 
 config PPC_IBM_CELL_BLADE
Index: linux-cell/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/setup.c	2006-11-06 15:02:21.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/setup.c	2006-11-06 15:05:44.000000000 +1100
@@ -50,6 +50,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/udbg.h>
+#include <asm/mpic.h>
 
 #include "interrupt.h"
 #include "iommu.h"
@@ -80,10 +81,53 @@ static void cell_progress(char *s, unsig
 	printk("*** %04x : %s\n", hex, s ? s : "");
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
