Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7CC18DDF37
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:43:46 +1000 (EST)
Message-Id: <8B237995-6FEC-481F-AAAB-76E0A67B6227@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080502234927.GC28587@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2.6.26] powerpc: Add 8568 PHY workarounds to board code
Date: Fri, 2 May 2008 18:43:24 -0500
References: <1209751422-25634-1-git-send-email-afleming@freescale.com>
	<20080502234927.GC28587@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 18:49, Olof Johansson wrote:

> Hi,
>
> On Fri, May 02, 2008 at 01:03:42PM -0500, Andy Fleming wrote:
>> +static int __init board_fixups(void)
>> +{
>> +	char phy_id[BUS_ID_SIZE];
>> +	char *compstrs[2] = {"fsl,gianfar-mdio", "fsl,ucc-mdio"};
>> +	struct device_node *mdio;
>> +	struct resource res;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(compstrs); i++) {
>> +		mdio = of_find_compatible_node(NULL, NULL, compstrs[i]);
>> +
>> +		of_address_to_resource(mdio, 0, &res);
>> +		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
>> +
>> +		phy_register_fixup_for_id(phy_id, mpc8568_fixup_125_clock);
>> +		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
>> +
>> +		/* Register a workaround for errata */
>> +		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 7);
>> +		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
>> +
>> +		of_node_put(mdio);
>> +	}
>> +
>> +	return 0;
>> +}
>> +arch_initcall(board_fixups);
>
> Are you sure you want to run this workaround on all boards that happen
> to be built-in?  I.e. shouldn't you be checked for what board you are
> running on, since the compatible strings you match on seem generic?


Shoot.  That's a good point.  I keep forgetting that just because it's  
in mpc85xx_mds.c, doesn't mean it's only being run on that platform.   
Alright, I'll resubmit.

>
>
>
> -Olof
