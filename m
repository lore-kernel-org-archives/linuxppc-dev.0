Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 19 Nov 2007 19:25:08 +1100
Subject: [RFC/PATCH 9/9] powerpc: PCI support for 4xx Ebony board
In-Reply-To: <1195460700.350036.781662541765.qpush@grosgo>
Message-Id: <20071119082555.B1F53DDE30@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on the previous patch, this hooks up PCI for Ebony.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/dts/ebony.dts    |   39 ++++++++++++++++++++++++++++++++-----
 arch/powerpc/platforms/44x/ebony.c |    7 ++++++
 2 files changed, 41 insertions(+), 5 deletions(-)

Index: linux-work/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- linux-work.orig/arch/powerpc/boot/dts/ebony.dts	2007-11-19 15:01:08.000000000 +1100
+++ linux-work/arch/powerpc/boot/dts/ebony.dts	2007-11-19 15:01:17.000000000 +1100
@@ -284,12 +284,41 @@
 
 		};
 
-		PCIX0: pci@1234 {
+		PCIX0: pci@20ec00000 {
 			device_type = "pci";
-			/* FIXME */
-			reg = <2 0ec00000 8
-			       2 0ec80000 f0
-			       2 0ec80100 fc>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb440gp-pcix", "ibm,plb-pcix";
+			primary;
+			reg = <2 0ec00000 8	/* Config space access */
+			       2 0ec80000 f0	/* Internal registers */
+			       2 0ec80100 fc>;	/* Internal messaging registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 00000003 80000000 0 80000000
+				  01000000 0 00000000 00000002 08000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-window = <42000000 0 0 0 80000000>;
+
+			/* Ebony has all 4 IRQ pins tied together per slot */
+			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map = <
+				/* IDSEL 1 */
+				0800 0 0 0 &UIC0 17 8
+
+				/* IDSEL 2 */
+				1000 0 0 0 &UIC0 18 8
+
+				/* IDSEL 3 */
+				1800 0 0 0 &UIC0 19 8
+
+				/* IDSEL 4 */
+				2000 0 0 0 &UIC0 1a 8
+			>;
 		};
 	};
 
Index: linux-work/arch/powerpc/platforms/44x/ebony.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/ebony.c	2007-11-19 15:01:08.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/ebony.c	2007-11-19 15:01:17.000000000 +1100
@@ -23,6 +23,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/of_platform.h>
+#include <asm/pci-bridge.h>
 
 #include "44x.h"
 
@@ -44,6 +45,11 @@ static int __init ebony_device_probe(voi
 }
 device_initcall(ebony_device_probe);
 
+static void __init ebony_setup_arch(void)
+{
+	ppc4xx_pci_find_bridges();
+}
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -60,6 +66,7 @@ static int __init ebony_probe(void)
 define_machine(ebony) {
 	.name			= "Ebony",
 	.probe			= ebony_probe,
+	.setup_arch		= ebony_setup_arch,
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
