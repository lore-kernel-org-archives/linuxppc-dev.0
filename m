Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71A60DDEBA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:05:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4PE4xu0016670
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:04:59 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4PE4xDA551958
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:04:59 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4PE4wRj007798
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:04:58 -0400
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070525043852.GH13575@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
	<20070525043852.GH13575@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 25 May 2007 09:03:51 -0500
Message-Id: <1180101831.3360.38.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-25 at 14:38 +1000, David Gibson wrote:
> 
> Waah!  Third time lucky?

Not quite. :)

> 	- Second, the PHYs give only "bcm54xx" as a compatible
> property.  This is unfortunate, because there are many bcm54xx PHY
> models, and they have differences which can matter.  We add a more
> precise compatible string, giving the precise PHY model (bcm5461A in
> this case).

You don't actually do this.  Instead, you specify a
txc-rxc-delay-disable property.

> -			PHY1: ethernet-phy@6000 {
> -				device_type = "ethernet-phy";
> -				compatible = "bcm54xx";
> -				reg = <6000 50>;
> -				phy-id = <1>;
> +			PHY1: ethernet-phy@1 {
> +				reg = <1>;
> +				txc-rxc-delay-disable;
>  			};

I would have rather we left the compatible = "bmc5461A" as well.  Though
perhaps a comment would suffice instead.

> Index: working-2.6/arch/powerpc/sysdev/tsi108_dev.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/sysdev/tsi108_dev.c	2007-05-25 14:34:00.000000000 +1000
> +++ working-2.6/arch/powerpc/sysdev/tsi108_dev.c	2007-05-25 14:38:32.000000000 +1000

> +
>  		tsi_eth_data.regs = r[0].start;
>  		tsi_eth_data.phyregs = res.start;
>  		tsi_eth_data.phy = *phy_id;
>  		tsi_eth_data.irq_num = irq_of_parse_and_map(np, 0);
> -		if (of_device_is_compatible(phy, "bcm54xx"))
> +
> +		if (of_get_property(phy, "txc-rxc-delay-disable", NULL))
>  			tsi_eth_data.phy_type = TSI108_PHY_BCM54XX;
>  		of_node_put(phy);

At the very least this needs a comment explaining what exactly is being
done here.  Right now, it's looking for some magical property and
setting the PHY type to a Broadcom PHY...  very confusing to someone
that hasn't followed the email thread.

josh
