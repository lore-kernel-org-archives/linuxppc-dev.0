Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14BE5DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 14:24:27 +1000 (EST)
In-Reply-To: <20070524041625.GD20078@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Wed, 23 May 2007 23:22:34 -0500
To: David Gibson <david@gibson.dropbear.id.au>
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


On May 23, 2007, at 11:16 PM, David Gibson wrote:

> This patch fixes some problems with the way the Ethernet PHYs are
> represented in the device tree for the Holly board.  This means
> changes to the dts itself, and to the code with instantiates the
> tsi108 ethernet platform devices based on the device tree.
>
> 	- First, and most importantly, the PHYs are given with an
> identical 'reg' property.  This reg currently encodes the accessible
> register used to initiate mdio interaction with the PHYs, rather than
> a meaningful address on the parent bus (mdio in this case), which is
> incorrect.  Instead we give the address of these registers as 'reg' in
> the mdio node itself, and encode the ID of each phy in their 'reg'
> propertys.  The PHY's unit name addresses are updated to match.
> 	- Second, the PHYs give only "bcm54xx" as a compatible
> property.  This is unfortunate, because there are many bcm54xx PHY
> models, and they have differences which can matter.  We add a more
> precise compatible string, giving the precise PHY model (bcm5461A in
> this case).

Is the compatible really need here?  We are able to provide and bind  
drivers based on MII_PHYSID1/2.  I don't see what putting the  
compatible proper gets us.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>
> Index: working-2.6/arch/powerpc/boot/dts/holly.dts
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/dts/holly.dts	2007-05-24  
> 13:55:38.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/dts/holly.dts	2007-05-24  
> 14:11:56.000000000 +1000
> @@ -63,19 +63,20 @@
>  		mdio@6000 {
>  			device_type = "mdio";
>  			compatible = "tsi-ethernet";
> +			reg = <6000 50>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>
> -			PHY1: ethernet-phy@6000 {
> +			PHY1: ethernet-phy@1 {
>  				device_type = "ethernet-phy";
> -				compatible = "bcm54xx";
> -				reg = <6000 50>;
> -				phy-id = <1>;
> +				compatible = "bcm5461A", "bcm54xx";
> +				reg = <1>;
>  			};
>
> -			PHY2: ethernet-phy@6400 {
> +			PHY2: ethernet-phy@2 {
>  				device_type = "ethernet-phy";
> -				compatible = "bcm54xx";
> -				reg = <6000 50>;
> -				phy-id = <2>;
> +				compatible = "bcm5461A", "bcm54xx";
> +				reg = <2>;
>  			};
>  		};
>
> Index: working-2.6/arch/powerpc/sysdev/tsi108_dev.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/sysdev/tsi108_dev.c	2007-05-24  
> 13:55:38.000000000 +1000
> +++ working-2.6/arch/powerpc/sysdev/tsi108_dev.c	2007-05-24  
> 14:12:11.000000000 +1000
> @@ -75,9 +75,8 @@ static int __init tsi108_eth_of_init(voi
>  	     (np = of_find_compatible_node(np, "network", "tsi- 
> ethernet")) != NULL;
>  	     i++) {
>  		struct resource r[2];
> -		struct device_node *phy;
> +		struct device_node *phy, *mdio;
>  		hw_info tsi_eth_data;
> -		const unsigned int *id;
>  		const unsigned int *phy_id;
>  		const void *mac_addr;
>  		const phandle *ph;
> @@ -119,13 +118,13 @@ static int __init tsi108_eth_of_init(voi
>  			goto unreg;
>  		}
>
> -		id = of_get_property(phy, "reg", NULL);
> -		phy_id = of_get_property(phy, "phy-id", NULL);
> -		ret = of_address_to_resource(phy, 0, &res);
> -		if (ret) {
> -			of_node_put(phy);
> +		phy_id = of_get_property(phy, "reg", NULL);
> +
> +		mdio = of_get_parent(phy);
> +		ret = of_address_to_resource(mdio, 0, &res);
> +		of_node_put(mdio);
> +		if (ret)
>  			goto unreg;
> -		}
>  		tsi_eth_data.regs = r[0].start;
>  		tsi_eth_data.phyregs = res.start;
>  		tsi_eth_data.phy = *phy_id;
>
>
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_  
> _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
