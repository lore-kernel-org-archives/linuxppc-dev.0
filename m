Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 15:39:29 +1100
Subject: [PATCH 11/21] [POWERPC] Wire up PCI on Bamboo board
Message-Id: <20071221043933.7115ADDEEB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the device-tree bits & call to ppc4xx_pci_find_bridges()
to make PCI work on the Bamboo board

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/dts/bamboo.dts   |   40 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/44x/Kconfig |    1 
 2 files changed, 40 insertions(+), 1 deletion(-)

--- linux-merge.orig/arch/powerpc/boot/dts/bamboo.dts	2007-12-21 14:10:33.000000000 +1100
+++ linux-merge/arch/powerpc/boot/dts/bamboo.dts	2007-12-21 14:13:20.000000000 +1100
@@ -239,10 +239,48 @@
 				zmii-channel = <1>;
 			};
 		};
+
+		PCI0: pci@ec000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
+			primary;
+			reg = <0 eec00000 8	/* Config space access */
+			       0 eed00000 4	/* IACK */
+			       0 eed00000 4	/* Special cycle */
+			       0 ef400000 40>;	/* Internal registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed. Chip supports a second
+			 * IO range but we don't use it for now
+			 */
+			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
+				  01000000 0 00000000 0 e8000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* Bamboo has all 4 IRQ pins tied together per slot */
+			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map = <
+				/* IDSEL 1 */
+				0800 0 0 0 &UIC0 1c 8
+
+				/* IDSEL 2 */
+				1000 0 0 0 &UIC0 1b 8
+
+				/* IDSEL 3 */
+				1800 0 0 0 &UIC0 1a 8
+
+				/* IDSEL 4 */
+				2000 0 0 0 &UIC0 19 8
+			>;
+		};
 	};
 
 	chosen {
 		linux,stdout-path = "/plb/opb/serial@ef600300";
-		bootargs = "console=ttyS0,115200";
 	};
 };
Index: linux-merge/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/44x/Kconfig	2007-12-21 14:13:33.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/44x/Kconfig	2007-12-21 14:13:38.000000000 +1100
@@ -3,6 +3,7 @@ config BAMBOO
 	depends on 44x
 	default n
 	select 440EP
+	select PCI
 	help
 	  This option enables support for the IBM PPC440EP evaluation board.
 
