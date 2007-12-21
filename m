Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 15:39:28 +1100
Subject: [PATCH 9/21] [POWERPC] Add PCI to Walnut platform
Message-Id: <20071221043931.D7C69DDEE7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
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

 arch/powerpc/boot/dts/walnut.dts   |   39 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/40x/Kconfig |    1 
 2 files changed, 40 insertions(+)

--- linux-merge.orig/arch/powerpc/boot/dts/walnut.dts	2007-12-21 14:10:33.000000000 +1100
+++ linux-merge/arch/powerpc/boot/dts/walnut.dts	2007-12-21 14:12:36.000000000 +1100
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
+			dma-ranges = <42000000 0 0 0 0 80000000>;
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
Index: linux-merge/arch/powerpc/platforms/40x/Kconfig
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/40x/Kconfig	2007-12-21 14:12:52.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/40x/Kconfig	2007-12-21 14:12:55.000000000 +1100
@@ -59,6 +59,7 @@ config WALNUT
 	depends on 40x
 	default y
 	select 405GP
+	select PCI
 	help
 	  This option enables support for the IBM PPC405GP evaluation board.
 
