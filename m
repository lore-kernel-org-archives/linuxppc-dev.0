Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60091DDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 14:47:49 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4P57GxR249088
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 15:07:18 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4P4o6dX105936
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 14:50:16 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4P4kWFj020601
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 14:46:32 +1000
Date: Fri, 25 May 2007 14:38:52 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070525043852.GH13575@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070525043728.GG13575@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, 2007 at 02:37:28PM +1000, David Gibson wrote:
> On Fri, May 25, 2007 at 02:23:59PM +1000, David Gibson wrote:
> > On Thu, May 24, 2007 at 08:44:20AM -0500, Josh Boyer wrote:
> > > On Wed, 2007-05-23 at 23:22 -0500, Kumar Gala wrote:
> > > > On May 23, 2007, at 11:16 PM, David Gibson wrote:
> > > > 
> > > > > This patch fixes some problems with the way the Ethernet PHYs are
> > > > > represented in the device tree for the Holly board.  This means
> > > > > changes to the dts itself, and to the code with instantiates the
> > > > > tsi108 ethernet platform devices based on the device tree.
> > > > >
> > > > > 	- First, and most importantly, the PHYs are given with an
> > > > > identical 'reg' property.  This reg currently encodes the accessible
> > > > > register used to initiate mdio interaction with the PHYs, rather than
> > > > > a meaningful address on the parent bus (mdio in this case), which is
> > > > > incorrect.  Instead we give the address of these registers as 'reg' in
> > > > > the mdio node itself, and encode the ID of each phy in their 'reg'
> > > > > propertys.  The PHY's unit name addresses are updated to match.
> > > > > 	- Second, the PHYs give only "bcm54xx" as a compatible
> > > > > property.  This is unfortunate, because there are many bcm54xx PHY
> > > > > models, and they have differences which can matter.  We add a more
> > > > > precise compatible string, giving the precise PHY model (bcm5461A in
> > > > > this case).
> > > > 
> > > > Is the compatible really need here?  We are able to provide and bind  
> > > > drivers based on MII_PHYSID1/2.  I don't see what putting the  
> > > > compatible proper gets us.
> > > 
> > > I think it's needed until the TSI driver switches to phylib.  Right now,
> > > it assumes that a Marvell phy is used, which is what is present on the
> > > Taiga MPC7448HPC2 board.  The Holly board uses the Broadcom phy and we
> > > added the compatible code for that.
> > 
> > I think Ben's suggested approach of using a special property in the
> > phy node to indicate that this workaround is necessary is better.
> > After all, the workaround isn't actually related to the type of PHY,
> > which is what compatible encodes, but to how it's wired up.  Revised
> > patch below addressing this and other matters.
> 
> Grah! Forgot quilt ref.  Now a copy that might actually work.

Waah!  Third time lucky?

Fix problems with Holly's DT representation of ethernet PHYs

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
--- working-2.6.orig/arch/powerpc/boot/dts/holly.dts	2007-05-25 14:34:00.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/holly.dts	2007-05-25 14:34:01.000000000 +1000
@@ -60,22 +60,21 @@
 			reg = <7000 400>;
 		};
 
-		mdio@6000 {
+		MDIO: mdio@6000 {
 			device_type = "mdio";
 			compatible = "tsi-ethernet";
+			reg = <6000 50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-			PHY1: ethernet-phy@6000 {
-				device_type = "ethernet-phy";
-				compatible = "bcm54xx";
-				reg = <6000 50>;
-				phy-id = <1>;
+			PHY1: ethernet-phy@1 {
+				reg = <1>;
+				txc-rxc-delay-disable;
 			};
 
-			PHY2: ethernet-phy@6400 {
-				device_type = "ethernet-phy";
-				compatible = "bcm54xx";
-				reg = <6000 50>;
-				phy-id = <2>;
+			PHY2: ethernet-phy@2 {
+				reg = <2>;
+				txc-rxc-delay-disable;
 			};
 		};
 
@@ -88,6 +87,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
 			interrupts = <10 2>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&PHY1>;
 		};
 
@@ -100,6 +100,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
 			interrupts = <11 2>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&PHY2>;
 		};
 
Index: working-2.6/arch/powerpc/sysdev/tsi108_dev.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/tsi108_dev.c	2007-05-25 14:34:00.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/tsi108_dev.c	2007-05-25 14:38:32.000000000 +1000
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
 
@@ -119,20 +125,17 @@ static int __init tsi108_eth_of_init(voi
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
+		if (of_get_property(phy, "txc-rxc-delay-disable", NULL))
 			tsi_eth_data.phy_type = TSI108_PHY_BCM54XX;
 		of_node_put(phy);
+
 		ret =
 		    platform_device_add_data(tsi_eth_dev, &tsi_eth_data,
 					     sizeof(hw_info));
Index: working-2.6/arch/powerpc/boot/dts/mpc7448hpc2.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/mpc7448hpc2.dts	2007-05-25 14:34:00.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/mpc7448hpc2.dts	2007-05-25 14:34:01.000000000 +1000
@@ -58,24 +58,23 @@
 			compatible  = "tsi-i2c";
 		};
 
-		mdio@6000 {
+		MDIO: mdio@6000 {
 			device_type = "mdio";
 			compatible = "tsi-ethernet";
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
@@ -89,6 +88,7 @@
 			address = [ 00 06 D2 00 00 01 ];
 			interrupts = <10 2>;
 			interrupt-parent = <&mpic>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&phy8>;
 		};
 
@@ -102,6 +102,7 @@
 			address = [ 00 06 D2 00 00 02 ];
 			interrupts = <11 2>;
 			interrupt-parent = <&mpic>;
+			mdio-handle = <&MDIO>;
 			phy-handle = <&phy9>;
 		};
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
