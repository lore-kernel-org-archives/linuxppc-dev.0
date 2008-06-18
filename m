Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D384FDE052
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 01:00:59 +1000 (EST)
Message-ID: <48592322.3090201@pobox.com>
Date: Wed, 18 Jun 2008 11:00:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 2/2] fs_enet: MDIO on GPIO support
References: <200805261152.37636.laurentp@cse-semaphore.com>
	<200806161057.03158.laurentp@cse-semaphore.com>
	<20080616163400.GA13996@loki.buserror.net>
	<200806181648.40874.laurentp@cse-semaphore.com>
In-Reply-To: <200806181648.40874.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> Hi Scott,
> 
> On Monday 16 June 2008 18:34, Scott Wood wrote:
>> On Mon, Jun 16, 2008 at 10:57:02AM +0200, Laurent Pinchart wrote:
>>> On Monday 26 May 2008 11:53, Laurent Pinchart wrote:
>>>> Port the fs_enet driver to support the MDIO on GPIO driver for PHY
>>>> access in addition to the mii-bitbang driver.
>>> Now that 1/2 has been applied by Jeff, could this one make it to 
>>> powerpc-next ?
>> This patch should probably go through Jeff as well...
> 
> Jeff, what's your opinion on this ?
> 
>> Acked-by: Scott Wood <scottwood@freescale.com>
>>
>>>> -	data = of_get_property(phynode, "reg", &len);
>>>> -	if (!data || len != 4)
>>>> -		goto out_put_mdio;
>>>> +	bus_id = of_get_gpio(mdionode, 0);
>>>> +	if (bus_id < 0) {
>>>> +		struct resource res;
>>>> +		ret = of_address_to_resource(mdionode, 0, &res);
>>>> +		if (ret)
>>>> +			goto out_put_mdio;
>>>> +		bus_id = res.start;
>>>> +	}
>>>>  
>>>> -	snprintf(fpi->bus_id, 16, "%x:%02x", res.start, *data);
>>>> +	snprintf(fpi->bus_id, 16, "%x:%02x", bus_id, *data);

What are the patch dependencies, if any?

My general rule is, anytime I see 80%+ of the patch dealing with 
arch-specific API functions (such as OF resource stuff), I tend to 
prefer that goes via an arch tree.

If it's a networking change, of course I'd prefer it came in my direction.

	Jeff
