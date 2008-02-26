Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Feb 2008 11:43:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Start removing linux,network-index in favour of aliases
Message-ID: <20080226004320.GB24382@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch alters the bootwrapper for a number of machines (roubhly
all 4xx based cuboot or treeboot platforms) to use aliases instead of
the linux,network-index hack to work out which MAC address to attach
to which ethernet device node.

The now obsolete linux,network-index properties are removed from the
corresponding device trees.  This won't break backwards compatiblity,
because in cases where this fixup code is relevant, the device tree is
part of the kernel image.

The references to linux,network-index are removed from
booting-without-of.txt.  Not only is it now deprecated, but as a hack
applicable only when the device tree blob and fixup code were in the
same image, this property never belonged in booting-without-of.txt
which describes the interface between the kernel and firmware or
bootloaders which produce a device tree.  By the time the device tree
reaches the kernel, all the MAC addresses must be fully filled in.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

Subsumes my earlier Ebony-only patch.  Tested on Ebony, could do with
testing on Taishan, Bamboo, Sequoia, Warp, Rainier and Walnut.

Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ebony.c	2008-02-26 11:34:26.000000000 +1100
@@ -75,7 +75,8 @@ static void ebony_fixups(void)
 
 	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
 	ibm4xx_sdram_fixup_memsize();
-	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
+	dt_fixup_mac_address_by_alias("ethernet0", ebony_mac0);
+	dt_fixup_mac_address_by_alias("ethernet1", ebony_mac1);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	ebony_flashsel_fixup();
 }
Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2008-02-26 11:34:26.000000000 +1100
@@ -243,7 +243,6 @@
 			};
 
 			EMAC0: ethernet@40000800 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
@@ -263,7 +262,6 @@
 				zmii-channel = <0>;
 			};
 			EMAC1: ethernet@40000900 {
-				linux,network-index = <1>;
 				device_type = "network";
 				compatible = "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
Index: working-2.6/arch/powerpc/boot/cuboot-taishan.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-taishan.c	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-taishan.c	2008-02-26 11:34:26.000000000 +1100
@@ -38,7 +38,8 @@ static void taishan_fixups(void)
 
 	ibm4xx_sdram_fixup_memsize();
 
-	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
 
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 }
Index: working-2.6/arch/powerpc/boot/dts/taishan.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/taishan.dts	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/taishan.dts	2008-02-26 11:34:26.000000000 +1100
@@ -239,7 +239,6 @@
 
 			EMAC0: ethernet@40000800 {
 				unused = <1>;
-				linux,network-index = <2>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
@@ -260,7 +259,6 @@
 			};
 		 	EMAC1: ethernet@40000900 {
 				unused = <1>;
-				linux,network-index = <3>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
@@ -281,7 +279,6 @@
 			};
 
 		 	EMAC2: ethernet@40000c00 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
@@ -304,7 +301,6 @@
 			};
 
 		 	EMAC3: ethernet@40000e00 {
-				linux,network-index = <1>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
Index: working-2.6/arch/powerpc/boot/bamboo.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/bamboo.c	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/bamboo.c	2008-02-26 11:34:26.000000000 +1100
@@ -33,7 +33,8 @@ static void bamboo_fixups(void)
 	ibm440ep_fixup_clocks(sysclk, 11059200, 25000000);
 	ibm4xx_sdram_fixup_memsize();
 	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
-	dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);
+	dt_fixup_mac_address_by_alias("ethernet0", bamboo_mac0);
+	dt_fixup_mac_address_by_alias("ethernet1", bamboo_mac1);
 }
 
 void bamboo_init(void *mac0, void *mac1)
Index: working-2.6/arch/powerpc/boot/cuboot-sequoia.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-sequoia.c	2008-02-26 11:34:26.000000000 +1100
@@ -42,7 +42,8 @@ static void sequoia_fixups(void)
 	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	ibm4xx_denali_fixup_memsize();
-	dt_fixup_mac_addresses(&bd.bi_enetaddr, &bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
 }
 
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
Index: working-2.6/arch/powerpc/boot/cuboot-warp.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-warp.c	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-warp.c	2008-02-26 11:34:26.000000000 +1100
@@ -23,7 +23,7 @@ static void warp_fixups(void)
 	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
 	ibm4xx_sdram_fixup_memsize();
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
-	dt_fixup_mac_addresses(&bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
 }
 
 
Index: working-2.6/arch/powerpc/boot/dts/bamboo.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/bamboo.dts	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/bamboo.dts	2008-02-26 11:34:26.000000000 +1100
@@ -207,7 +207,6 @@
 			};
 
 			EMAC0: ethernet@ef600e00 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
@@ -228,7 +227,6 @@
 			};
 
 			EMAC1: ethernet@ef600f00 {
-				linux,network-index = <1>;
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
Index: working-2.6/arch/powerpc/boot/dts/warp.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/warp.dts	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/warp.dts	2008-02-26 11:34:26.000000000 +1100
@@ -204,7 +204,6 @@
 			};
 
 			EMAC0: ethernet@ef600e00 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
Index: working-2.6/arch/powerpc/boot/dts/sequoia.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/sequoia.dts	2008-02-26 11:34:26.000000000 +1100
@@ -273,7 +273,6 @@
 			};
 
 			EMAC0: ethernet@ef600e00 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
@@ -303,7 +302,6 @@
 			};
 
 			EMAC1: ethernet@ef600f00 {
-				linux,network-index = <1>;
 				device_type = "network";
 				compatible = "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
Index: working-2.6/arch/powerpc/boot/cuboot-rainier.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-rainier.c	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-rainier.c	2008-02-26 11:34:26.000000000 +1100
@@ -42,7 +42,8 @@ static void rainier_fixups(void)
 	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	ibm4xx_denali_fixup_memsize();
-	dt_fixup_mac_addresses(&bd.bi_enetaddr, &bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
 }
 
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
Index: working-2.6/arch/powerpc/boot/dts/rainier.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/rainier.dts	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/rainier.dts	2008-02-26 11:34:26.000000000 +1100
@@ -258,7 +258,6 @@
 			};
 
 			EMAC0: ethernet@ef600e00 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440grx", "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
@@ -288,7 +287,6 @@
 			};
 
 			EMAC1: ethernet@ef600f00 {
-				linux,network-index = <1>;
 				device_type = "network";
 				compatible = "ibm,emac-440grx", "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
Index: working-2.6/arch/powerpc/boot/dts/walnut.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/walnut.dts	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/walnut.dts	2008-02-26 11:34:26.000000000 +1100
@@ -125,7 +125,6 @@
 			};
 
 			EMAC: ethernet@ef600800 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-405gp", "ibm,emac";
 				interrupt-parent = <&UIC0>;
Index: working-2.6/arch/powerpc/boot/treeboot-walnut.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/treeboot-walnut.c	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/arch/powerpc/boot/treeboot-walnut.c	2008-02-26 11:34:26.000000000 +1100
@@ -68,7 +68,7 @@ static void walnut_fixups(void)
 	ibm4xx_quiesce_eth((u32 *)0xef600800, NULL);
 	ibm4xx_fixup_ebc_ranges("/plb/ebc");
 	walnut_flashsel_fixup();
-	dt_fixup_mac_addresses((u8 *) WALNUT_OPENBIOS_MAC_OFF);
+	dt_fixup_mac_address_by_alias("ethernet0", (u8 *) WALNUT_OPENBIOS_MAC_OFF);
 }
 
 void platform_init(void)
Index: working-2.6/Documentation/powerpc/booting-without-of.txt
===================================================================
--- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2008-02-26 11:30:30.000000000 +1100
+++ working-2.6/Documentation/powerpc/booting-without-of.txt	2008-02-26 11:34:26.000000000 +1100
@@ -1269,10 +1269,6 @@ platforms are moved over to use the flat
 
   Recommended properties:
 
-    - linux,network-index : This is the intended "index" of this
-      network device.  This is used by the bootwrapper to interpret
-      MAC addresses passed by the firmware when no information other
-      than indices is available to associate an address with a device.
     - phy-connection-type : a string naming the controller/PHY interface type,
       i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", "sgmii",
       "tbi", or "rtbi".  This property is only really needed if the connection
@@ -1667,10 +1663,6 @@ platforms are moved over to use the flat
    - phy-handle : The phandle for the PHY connected to this controller.
 
    Recommended properties:
-   - linux,network-index : This is the intended "index" of this
-     network device.  This is used by the bootwrapper to interpret
-     MAC addresses passed by the firmware when no information other
-     than indices is available to associate an address with a device.
    - phy-connection-type : a string naming the controller/PHY interface type,
      i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id" (Internal
      Delay), "rgmii-txid" (delay on TX only), "rgmii-rxid" (delay on RX only),
@@ -1995,7 +1987,6 @@ platforms are moved over to use the flat
 		interrupts = <20 8>;
 		interrupt-parent = <&PIC>;
 		phy-handle = <&PHY0>;
-		linux,network-index = <0>;
 		fsl,cpm-command = <12000300>;
 	};
 
@@ -2217,12 +2208,6 @@ platforms are moved over to use the flat
 			  EMAC, that is the content of the current (bogus) "phy-port"
 			  property.
 
-    Recommended properties:
-    - linux,network-index : This is the intended "index" of this
-      network device.  This is used by the bootwrapper to interpret
-      MAC addresses passed by the firmware when no information other
-      than indices is available to associate an address with a device.
-
     Optional properties:
     - phy-address       : 1 cell, optional, MDIO address of the PHY. If absent,
 			  a search is performed.
@@ -2246,7 +2231,6 @@ platforms are moved over to use the flat
     Example:
 
 	EMAC0: ethernet@40000800 {
-		linux,network-index = <0>;
 		device_type = "network";
 		compatible = "ibm,emac-440gp", "ibm,emac";
 		interrupt-parent = <&UIC1>;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
