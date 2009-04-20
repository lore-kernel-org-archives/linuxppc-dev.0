Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B07BDDDA5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 06:04:42 +1000 (EST)
Message-Id: <AC7EE6C5-5487-4D70-B690-2F60BE974C92@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <6084F3DB-F587-43EC-8753-9E116189A453@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 4/5] powerpc: Add support for swiotlb on 32-bit
Date: Mon, 20 Apr 2009 15:04:34 -0500
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
	<D5619B7C-6B6E-4D89-AB47-A9B1CED24885@kernel.crashing.org>
	<6084F3DB-F587-43EC-8753-9E116189A453@kernel.crashing.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 2:06 PM, Becky Bruce wrote:

>
> On Apr 20, 2009, at 1:31 PM, Kumar Gala wrote:
>
>>
>> On Apr 20, 2009, at 11:26 AM, Becky Bruce wrote:
>>
>>> +static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
>>> +				  unsigned long action, void *data)
>>> +{
>>> +	struct device *dev = data;
>>> +
>>> +	/* We are only intereted in device addition */
>>> +	if (action != BUS_NOTIFY_ADD_DEVICE)
>>> +		return 0;
>>> +
>>> +	if (dma_get_mask(dev) < DMA_BIT_MASK(36))
>>> +		set_dma_ops(dev, &swiotlb_dma_ops);
>>> +
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>> +static struct notifier_block ppc_swiotlb_plat_bus_notifier = {
>>> +	.notifier_call = ppc_swiotlb_bus_notify,
>>> +	.priority = 0,
>>> +};
>>> +
>>> +static struct notifier_block ppc_swiotlb_of_bus_notifier = {
>>> +	.notifier_call = ppc_swiotlb_bus_notify,
>>> +	.priority = 0,
>>> +};
>>> +
>>> +static int __init setup_bus_notifier(void)
>>> +{
>>> +	bus_register_notifier(&platform_bus_type,
>>> +			      &ppc_swiotlb_plat_bus_notifier);
>>> +	bus_register_notifier(&of_platform_bus_type,
>>> +			      &ppc_swiotlb_of_bus_notifier);
>>> +
>>> +	return 0;
>>> +}
>>
>> I think we should move all this into the platform code for now.  I  
>> don't like having to duplicate it but that gives us the proper  
>> flexibility for now.
>
> Ugh, gross.  I'd like to think about this some more.

I'm suggesting we do it one for FSL in fsl_soc.c, the 4xx guys can do  
it once, etc.  Since the behavior desired is going to be a bit unique  
to SoCs/chipsets.

- k
