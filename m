Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1004EDDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 07:16:21 +1000 (EST)
Message-ID: <46CCA79D.40003@freescale.com>
Date: Wed, 22 Aug 2007 16:16:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 6/7 v2] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
References: <20070817181718.GA15792@ld0162-tx32.am.freescale.net>
	<20070821130155.43898b68@localhost.localdomain>
	<46CB172D.9010807@freescale.com>
	<20070823010057.74e1355a@localhost.localdomain>
In-Reply-To: <20070823010057.74e1355a@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> yes, wrong snippet what about
> 
> 
>> #ifdef CONFIG_CPM2 +	r = fs_enet_mdio_bb_init(); +	if (r != 0) +
>> goto out_mdio_bb; +#endif +#ifdef CONFIG_8xx +	r =
>> fs_enet_mdio_fec_init(); +	if (r != 0) +		goto out_mdio_fec; 
>> +#endif
> 
> 
> We had to pray and hope that 8xx would only have fec, and cpm2 has
> some bitbanged stuff. now we can inquire dts and know for sure, at
> least it seems so.

Yeah, that sucks.  We should add kconfig options for each mii type, and
let them have their own init functions.

That only affects the initcalls (and kernel size), though; it still uses 
the phy-handle to decide what mdio controller to actually talk to.

>> How is that different from the old code, where you're hosed without
>>  fep->fpi->bus_id?
>> 
> 
> 
> I wasn't defending old code, and consider "old code is POS, new one
> is just great" game meaningless. I am just stating the problem, that
> we'll have to address later. On 8xx even reference boards may be 
> without phy at all.

OK -- would it suffice to just never call any phylib functions and
always assume the link is up if the phy-handle property is undefined?

> ok, agreed, size is most serious judge here. we'll definitely have to
> revisit pin problem later too (because custom designs sometimes
> switch contradictory devices on-the-fly, disable soc parts for
> alternative function, etc.)

If it's really on-the-fly (and not jumpered/once-per-boot), then board 
code should expose some kind of API to switch the functions, acting like 
a hotplug bus.  Associating it with open/close of the device won't work 
if one of the devices is something like USB which needs to start working 
without any internal open()-like action.

-Scott
