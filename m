Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:48 +1100
Subject: [PATCH 16/31] powerpc: Add DMA ops support for of_plaform_device to
	Cell
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072405.96E9B68286@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a bus device notifier to the of_platform bus type on
cell to setup the DMA operations for of_platform_devices. We currently
use the PCI operations as Cell use a special version of them that
happens to be suitable for our needs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/cell/setup.c |   45 +++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

Index: linux-cell/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/setup.c	2006-10-26 16:42:30.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/setup.c	2006-10-26 16:45:00.000000000 +1000
@@ -30,6 +30,7 @@
 #include <linux/console.h>
 #include <linux/mutex.h>
 #include <linux/memory_hotplug.h>
+#include <linux/notifier.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -82,10 +83,49 @@ static void cell_progress(char *s, unsig
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
+static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct device *dev = data;
+	struct device_ext *dext;
+
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+
+	dext = device_get_ext(dev);
+	if (dext == NULL) {
+		dev_printk(KERN_ERR, dev,
+			   "OF platform device with extension !\n");
+		return 0;
+	}
+
+	/* For now, we just use the PCI DMA ops for everything, though
+	 * we'll need something better when we have a real iommu
+	 * implementation.
+	 */
+	dext->dma_ops = pci_dma_ops;
+
+       return 0;
+}
+
+static struct notifier_block cell_of_bus_notifier = {
+	.notifier_call = cell_of_bus_notify
+};
+
+
 static int __init cell_publish_devices(void)
 {
-	if (machine_is(cell))
-		of_platform_bus_probe(NULL, NULL, NULL);
+	if (!machine_is(cell))
+		return 0;
+
+	/* Register callbacks on OF platform device addition/removal
+	 * to handle linking them to the right DMA operations
+	 */
+	register_bus_notifier(&of_platform_bus_type, &cell_of_bus_notifier);
+
+	/* Publish OF platform devices for southbridge IOs */
+	of_platform_bus_probe(NULL, NULL, NULL);
+
 	return 0;
 }
 device_initcall(cell_publish_devices);
@@ -154,7 +194,6 @@ static void __init cell_setup_arch(void)
 #ifdef CONFIG_SMP
 	smp_init_cell();
 #endif
-
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;
 
