Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Nov 2007 17:16:32 +1100
Subject: [RFC/PATCH 14/14] powerpc: Add PCI to Walnut platform
In-Reply-To: <1195625777.579001.269266058699.qpush@grosgo>
Message-Id: <20071121061722.2FCB7DDE45@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This wires up the 4xx PCI support & device-tree bits for the
405GP based Walnut platform.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This one is untested, haven't had time to dig my walnut and put it
back into working condition. Josh, can you verify that IRQs are
working (routing is correct ?) Thanks !

 arch/powerpc/boot/dts/walnut.dts    |   39 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/40x/walnut.c |    7 ++++++
 2 files changed, 46 insertions(+)

Index: linux-work/arch/powerpc/boot/dts/walnut.dts
===================================================================
--- linux-work.orig/arch/powerpc/boot/dts/walnut.dts	2007-11-21 16:24:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/dts/walnut.dts	2007-11-21 16:26:25.000000000 +1100
@@ -190,6 +190,45 @@
 				virtual-reg = <f0300005>;
 			};
 		};
+
+		PCI0: pci@ec000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb405gp-pci", "ibm,plb-pci";
+			primary;
+			reg = <eec00000 8	/* Config space access */
+			       eed80000 4	/* IACK */
+			       eed80000 4	/* Special cycle */
+			       ef480000 40>;	/* Internal registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed. Chip supports a second
+			 * IO range but we don't use it for now
+			 */
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e8000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-window = <42000000 0 0 0 80000000>;
+
+			/* Walnut has all 4 IRQ pins tied together per slot */
+			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map = <
+				/* IDSEL 1 */
+				0800 0 0 0 &UIC0 1c 8
+
+				/* IDSEL 2 */
+				1000 0 0 0 &UIC0 1d 8
+
+				/* IDSEL 3 */
+				1800 0 0 0 &UIC0 1e 8
+
+				/* IDSEL 4 */
+				2000 0 0 0 &UIC0 1f 8
+			>;
+		};
 	};
 
 	chosen {
Index: linux-work/arch/powerpc/platforms/40x/walnut.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/40x/walnut.c	2007-11-21 16:23:28.000000000 +1100
+++ linux-work/arch/powerpc/platforms/40x/walnut.c	2007-11-21 16:24:01.000000000 +1100
@@ -43,6 +43,12 @@ static int __init walnut_device_probe(vo
 }
 device_initcall(walnut_device_probe);
 
+static void __init walnut_setup_arch(void)
+{
+	/* Create PCI bridges */
+	ppc4xx_pci_find_bridges();
+}
+
 static int __init walnut_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -56,6 +62,7 @@ static int __init walnut_probe(void)
 define_machine(walnut) {
 	.name			= "Walnut",
 	.probe			= walnut_probe,
+	.setup_arch		= walnut_setup_arch,
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
