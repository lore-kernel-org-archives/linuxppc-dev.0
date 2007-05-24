Return-Path: <dgibson@ozlabs.org>
Date: Thu, 24 May 2007 14:16:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070524041625.GD20078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes some problems with the way the Ethernet PHYs are
represented in the device tree for the Holly board.  This means
changes to the dts itself, and to the code with instantiates the
tsi108 ethernet platform devices based on the device tree.

	- First, and most importantly, the PHYs are given with an
identical 'reg' property.  This reg currently encodes the accessible
register used to initiate mdio interaction with the PHYs, rather than
a meaningful address on the parent bus (mdio in this case), which is
incorrect.  Instead we give the address of these registers as 'reg' in
the mdio node itself, and encode the ID of each phy in their 'reg'
propertys.  The PHY's unit name addresses are updated to match.
	- Second, the PHYs give only "bcm54xx" as a compatible
property.  This is unfortunate, because there are many bcm54xx PHY
models, and they have differences which can matter.  We add a more
precise compatible string, giving the precise PHY model (bcm5461A in
this case).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/dts/holly.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/holly.dts	2007-05-24 13:55:38.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/holly.dts	2007-05-24 14:11:56.000000000 +1000
@@ -63,19 +63,20 @@
 		mdio@6000 {
 			device_type = "mdio";
 			compatible = "tsi-ethernet";
+			reg = <6000 50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-			PHY1: ethernet-phy@6000 {
+			PHY1: ethernet-phy@1 {
 				device_type = "ethernet-phy";
-				compatible = "bcm54xx";
-				reg = <6000 50>;
-				phy-id = <1>;
+				compatible = "bcm5461A", "bcm54xx";
+				reg = <1>;
 			};
 
-			PHY2: ethernet-phy@6400 {
+			PHY2: ethernet-phy@2 {
 				device_type = "ethernet-phy";
-				compatible = "bcm54xx";
-				reg = <6000 50>;
-				phy-id = <2>;
+				compatible = "bcm5461A", "bcm54xx";
+				reg = <2>;
 			};
 		};
 
Index: working-2.6/arch/powerpc/sysdev/tsi108_dev.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/tsi108_dev.c	2007-05-24 13:55:38.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/tsi108_dev.c	2007-05-24 14:12:11.000000000 +1000
@@ -75,9 +75,8 @@ static int __init tsi108_eth_of_init(voi
 	     (np = of_find_compatible_node(np, "network", "tsi-ethernet")) != NULL;
 	     i++) {
 		struct resource r[2];
-		struct device_node *phy;
+		struct device_node *phy, *mdio;
 		hw_info tsi_eth_data;
-		const unsigned int *id;
 		const unsigned int *phy_id;
 		const void *mac_addr;
 		const phandle *ph;
@@ -119,13 +118,13 @@ static int __init tsi108_eth_of_init(voi
 			goto unreg;
 		}
 
-		id = of_get_property(phy, "reg", NULL);
-		phy_id = of_get_property(phy, "phy-id", NULL);
-		ret = of_address_to_resource(phy, 0, &res);
-		if (ret) {
-			of_node_put(phy);
+		phy_id = of_get_property(phy, "reg", NULL);
+
+		mdio = of_get_parent(phy);
+		ret = of_address_to_resource(mdio, 0, &res);
+		of_node_put(mdio);
+		if (ret)
 			goto unreg;
-		}
 		tsi_eth_data.regs = r[0].start;
 		tsi_eth_data.phyregs = res.start;
 		tsi_eth_data.phy = *phy_id;


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
