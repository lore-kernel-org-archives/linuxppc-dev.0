Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 11 Nov 2006 17:25:00 +1100
Subject: [PATCH 15/32] powerpc: Hook of_platform_bus_probe with cell
In-Reply-To: <1163226282.72526.823314634857.qpush@butch>
Message-Id: <20061111062531.EB06367FB9@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hook up of_platform_bus_probe with the cell platform in order to publish
the non-PCI devices in the device-tree of cell blades as of_platform_device(s)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/cell/setup.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-cell/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/setup.c	2006-10-26 16:41:49.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/setup.c	2006-10-26 16:42:30.000000000 +1000
@@ -51,6 +51,7 @@
 #include <asm/spu_priv1.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/of_platform.h>
 
 #include "interrupt.h"
 #include "iommu.h"
@@ -81,6 +82,14 @@ static void cell_progress(char *s, unsig
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
+static int __init cell_publish_devices(void)
+{
+	if (machine_is(cell))
+		of_platform_bus_probe(NULL, NULL, NULL);
+	return 0;
+}
+device_initcall(cell_publish_devices);
+
 static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	struct mpic *mpic = desc->handler_data;
