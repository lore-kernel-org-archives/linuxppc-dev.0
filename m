Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1163DE030
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:37:36 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4U1w4Sl072256
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:58:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4U1erti093590
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:40:54 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4U1bLtm009189
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:37:21 +1000
Date: Wed, 30 May 2007 11:37:18 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Fix problems with device tree representation of TSI-1xx bridges
Message-ID: <20070530013718.GB21955@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes some problems with the way the some things
represented in the device tree for the Holly and Taiga boards.  This
means changes both to the dts files, and to the code which
instantiates the tsi108 ethernet platform devices based on the device
tree.

	- First, and most importantly, the ethernet PHYs are given
with an identical 'reg' property.  This reg currently encodes the
accessible register used to initiate mdio interaction with the PHYs,
rather than a meaningful address on the parent bus (mdio in this
case), which is incorrect.  Instead we give the address of these
registers as 'reg' in the mdio node itself, and encode the ID of each
phy in their 'reg' propertyies.
	- Currently the platform device constructor enables a
workaround in the tsi108 ethernet driver based on the compatible
property of the PHY.  This is incorrect, because the workaround in
question is necessary due to the board's wiring of the PHY, not the
model of PHY itself.  This patch alters the constructor to instead
enable the workaround based on a new special property in the PHY node.
	- The compatible properties on a number of nodes in the device
tree are insufficiently precise.  In particular the PHYs give only
"bcm54xx", which is broken, since there are many bcm54xx PHY models,
and they have differences which matter.  The mdio had a compatible
property of "tsi-ethernet" identical to the ethernet MAC nodes, which
doesn't make sense.  The ethernet, i2c, bridge and PCI nodes were
given only as "tsi-*" which is somewhat inprecise, we replace with
"tsi108-*" in the case of Taiga (which has a TSI108 bridge), and
"tsi109-*", "tsi108-*" in the case of Holly (which has a TSI109
bridge).
	- We remove some "model" properties from the ethernets on
Taiga board which were neither useful nor adequately precise.
	- On Holly we change to using a dtc label instead of a full
path to reference the MPIC node, which makes the dts a little more
readable.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/dts/holly.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/holly.dts	2007-05-30 11:01:58.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/holly.dts	2007-05-30 11:05:29.000000000 +1000
@@ -46,7 +46,7 @@
 
   	tsi109@c0000000 {
 		device_type = "tsi-bridge";
-		compatible = "tsi-bridge";
+		compatible = "tsi109-bridge", "tsi108-bridge";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <00000000 c0000000 00010000>;
@@ -54,52 +54,55 @@
 
 		i2c@7000 {
 			device_type = "i2c";
-			compatible  = "tsi-i2c";
-			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			compatible  = "tsi109-i2c", "tsi108-i2c";
+			interrupt-parent = <&MPIC>;
 			interrupts = <e 2>;
 			reg = <7000 400>;
 		};
 
-		mdio@6000 {
+		MDIO: mdio@6000 {
 			device_type = "mdio";
-			compatible = "tsi-ethernet";
+			compatible = "tsi109-mdio", "tsi108-mdio";
+			reg = <6000 50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-			PHY1: ethernet-phy@6000 {
-				device_type = "ethernet-phy";
-				compatible = "bcm54xx";
-				reg = <6000 50>;
-				phy-id = <1>;
+			PHY1: ethernet-phy@1 {
+				compatible = "bcm5461a";
+				reg = <1>;
+				txc-rxc-delay-disable;
 			};
 
-			PHY2: ethernet-phy@6400 {
-				device_type = "ethernet-phy";
-				compatible = "bcm54xx";
-				reg = <6000 50>;
-				phy-id = <2>;
+			PHY2: ethernet-phy@2 {
+				compatible = "bcm5461a";
+				reg = <2>;
+				txc-rxc-delay-disable;
 			};
 		};
 
 		ethernet@6200 {
 			device_type = "network";
-			compatible = "tsi-ethernet";
+			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6000 200>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupt-parent = <&MPIC>;
 			interrupts = <10 2>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&PHY1>;
 		};
 
 		ethernet@6600 {
 			device_type = "network";
-			compatible = "tsi-ethernet";
+			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6400 200>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupt-parent = <&MPIC>;
 			interrupts = <11 2>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&PHY2>;
 		};
 
@@ -110,7 +113,7 @@
 			virtual-reg = <c0007808>;
 			clock-frequency = <3F9C6000>;
 			current-speed = <1c200>;
-			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupt-parent = <&MPIC>;
 			interrupts = <c 2>;
 		};
 
@@ -121,7 +124,7 @@
 			virtual-reg = <c0007c08>;
 			clock-frequency = <3F9C6000>;
 			current-speed = <1c200>;
-			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupt-parent = <&MPIC>;
 			interrupts = <d 2>;
 		};
 
@@ -136,7 +139,7 @@
 
 		pci@1000 {
 			device_type = "pci";
-			compatible = "tsi109";
+			compatible = "tsi109-pci", "tsi108-pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
@@ -150,7 +153,7 @@
 			ranges = <02000000 0 40000000 40000000 0 10000000
 				  01000000 0 00000000 7e000000 0 00010000>;
 			clock-frequency = <7f28154>;
-			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupt-parent = <&MPIC>;
 			interrupts = <17 2>;
 			interrupt-map-mask = <f800 0 0 7>;
 			/*----------------------------------------------------+
@@ -186,7 +189,7 @@
  				#address-cells = <0>;
  				#interrupt-cells = <2>;
  				interrupts = <17 2>;
-				interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+				interrupt-parent = <&MPIC>;
 			};
 		};
 	};
Index: working-2.6/arch/powerpc/sysdev/tsi108_dev.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/tsi108_dev.c	2007-05-08 14:58:06.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/tsi108_dev.c	2007-05-30 11:08:38.000000000 +1000
@@ -72,12 +72,11 @@ static int __init tsi108_eth_of_init(voi
 	int ret;
 
 	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "network", "tsi-ethernet")) != NULL;
+	     (np = of_find_compatible_node(np, "network", "tsi108-ethernet")) != NULL;
 	     i++) {
 		struct resource r[2];
-		struct device_node *phy;
+		struct device_node *phy, *mdio;
 		hw_info tsi_eth_data;
-		const unsigned int *id;
 		const unsigned int *phy_id;
 		const void *mac_addr;
 		const phandle *ph;
@@ -111,6 +110,13 @@ static int __init tsi108_eth_of_init(voi
 		if (mac_addr)
 			memcpy(tsi_eth_data.mac_addr, mac_addr, 6);
 
+		ph = of_get_property(np, "mdio-handle", NULL);
+		mdio = of_find_node_by_phandle(*ph);
+		ret = of_address_to_resource(mdio, 0, &res);
+		of_node_put(mdio);
+		if (ret)
+			goto unreg;
+
 		ph = of_get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
 
@@ -119,20 +125,25 @@ static int __init tsi108_eth_of_init(voi
 			goto unreg;
 		}
 
-		id = of_get_property(phy, "reg", NULL);
-		phy_id = of_get_property(phy, "phy-id", NULL);
-		ret = of_address_to_resource(phy, 0, &res);
-		if (ret) {
-			of_node_put(phy);
-			goto unreg;
-		}
+		phy_id = of_get_property(phy, "reg", NULL);
+
 		tsi_eth_data.regs = r[0].start;
 		tsi_eth_data.phyregs = res.start;
 		tsi_eth_data.phy = *phy_id;
 		tsi_eth_data.irq_num = irq_of_parse_and_map(np, 0);
-		if (of_device_is_compatible(phy, "bcm54xx"))
+
+		/* Some boards with the TSI108 bridge (e.g. Holly)
+		 * have a miswiring of the ethernet PHYs which
+		 * requires a workaround.  The special
+		 * "txc-rxc-delay-disable" property enables this
+		 * workaround.  FIXME: Need to port the tsi108_eth
+		 * driver itself to phylib and use a non-misleading
+		 * name for the workaround flag - it's not actually to
+		 * do with the model of PHY in use */
+		if (of_get_property(phy, "txc-rxc-delay-disable", NULL))
 			tsi_eth_data.phy_type = TSI108_PHY_BCM54XX;
 		of_node_put(phy);
+
 		ret =
 		    platform_device_add_data(tsi_eth_dev, &tsi_eth_data,
 					     sizeof(hw_info));
Index: working-2.6/arch/powerpc/boot/dts/mpc7448hpc2.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/mpc7448hpc2.dts	2007-05-21 12:47:17.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/mpc7448hpc2.dts	2007-05-30 11:04:05.000000000 +1000
@@ -45,7 +45,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
-		device_type = "tsi-bridge";
+		device_type = "tsi108-bridge";
 		ranges = <00000000 c0000000 00010000>;
 		reg = <c0000000 00010000>;
 		bus-frequency = <0>;
@@ -55,27 +55,26 @@
 			interrupts = <E 0>;
 			reg = <7000 400>;
 			device_type = "i2c";
-			compatible  = "tsi-i2c";
+			compatible  = "tsi108-i2c";
 		};
 
-		mdio@6000 {
+		MDIO: mdio@6000 {
 			device_type = "mdio";
-			compatible = "tsi-ethernet";
+			compatible = "tsi108-mdio";
+			reg = <6000 50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-			phy8: ethernet-phy@6000 {
+			phy8: ethernet-phy@8 {
 				interrupt-parent = <&mpic>;
 				interrupts = <2 1>;
-				reg = <6000 50>;
-				phy-id = <8>;
-				device_type = "ethernet-phy";
+				reg = <8>;
 			};
 
-			phy9: ethernet-phy@6400 {
+			phy9: ethernet-phy@9 {
 				interrupt-parent = <&mpic>;
 				interrupts = <2 1>;
-				reg = <6000 50>;
-				phy-id = <9>;
-				device_type = "ethernet-phy";
+				reg = <9>;
 			};
 
 		};
@@ -83,12 +82,12 @@
 		ethernet@6200 {
 			#size-cells = <0>;
 			device_type = "network";
-			model = "TSI-ETH";
-			compatible = "tsi-ethernet";
+			compatible = "tsi108-ethernet";
 			reg = <6000 200>;
 			address = [ 00 06 D2 00 00 01 ];
 			interrupts = <10 2>;
 			interrupt-parent = <&mpic>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&phy8>;
 		};
 
@@ -96,12 +95,12 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			model = "TSI-ETH";
-			compatible = "tsi-ethernet";
+			compatible = "tsi108-ethernet";
 			reg = <6400 200>;
 			address = [ 00 06 D2 00 00 02 ];
 			interrupts = <11 2>;
 			interrupt-parent = <&mpic>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&phy9>;
 		};
 
@@ -135,7 +134,7 @@
                        	big-endian;
 		};
 		pci@1000 {
-			compatible = "tsi10x";
+			compatible = "tsi108-pci";
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
