Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:16 +1100
Subject: [PATCH 17/25] powerpc: Add PCI to Walnut platform
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080128.A4D26DDEEB@ozlabs.org>
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

 arch/powerpc/boot/dts/walnut.dts |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

Index: linux-work/arch/powerpc/boot/dts/walnut.dts
===================================================================
--- linux-work.orig/arch/powerpc/boot/dts/walnut.dts	2007-11-13 11:39:44.000000000 +1100
+++ linux-work/arch/powerpc/boot/dts/walnut.dts	2007-11-27 18:28:07.000000000 +1100
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
