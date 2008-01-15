Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26DF3DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 04:08:11 +1100 (EST)
Message-Id: <17A215CC-EFAE-41B9-8DB7-C6CDB4E708F2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080115164053.GA10812@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] fsl_soc: Fix get_immrbase() to use ranges,
	rather than reg.
Date: Tue, 15 Jan 2008 11:07:38 -0600
References: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
	<BFCCA52A-85B7-4DD5-ACF4-2F3E65CFD7FD@kernel.crashing.org>
	<20080115164053.GA10812@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2008, at 10:40 AM, Scott Wood wrote:

> On Mon, Jan 14, 2008 at 08:37:27PM -0600, Kumar Gala wrote:
>>> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/
>>> fsl_soc.c
>>> index 3ace747..7502e03 100644
>>> --- a/arch/powerpc/sysdev/fsl_soc.c
>>> +++ b/arch/powerpc/sysdev/fsl_soc.c
>>> @@ -54,10 +54,18 @@ phys_addr_t get_immrbase(void)
>>> 	soc = of_find_node_by_type(NULL, "soc");
>>> 	if (soc) {
>>> 		int size;
>>> -		const void *prop = of_get_property(soc, "reg", &size);
>>> +		u32 naddr;
>>> +		const u32 *prop = of_get_property(soc, "#address-cells",
>>> &size);
>>> +
>>> +		if (prop && size == 4)
>>> +			naddr = *prop;
>>> +		else
>>> +			naddr = 2;
>>
>> Why default to two?
>
> Because that's what the OF spec says the default is?

fair.

>>> +		prop = of_get_property(soc, "ranges", &size);
>>> +		if (prop && size == 12)
>>> +			immrbase = of_translate_address(soc, prop + naddr);
>
> Grr, I thought I removed the size == 12 check...
>
>>> -		if (prop)
>>> -			immrbase = of_translate_address(soc, prop);
>>
>> why not make your code an else case if we don't have reg?
>
> Why?

I agree (had to think about it a bit more).

>> or something like, than we don't have to worry about adjust anything,
>> and if you don't have any children its kinda a pointless device  
>> tree :)
>
> It's not pointless, it's just incomplete.
>
>> 	if (soc) {
>> 		struct device_node *child = of_get_next_child(soc, NULL);
>> 		if (child) {
>> 			const void *prop = of_get_property(soc, "ranges",
>> 			NULL);
>> 			if (prop)
>> 				immrbase = of_translate_address(child, prop);
>> 			of_node_put(child);
>> 		}
>> 		of_node_put(soc);
>> 	}
>
> Why go out of our way to fail on a childless soc node?

do we see any case in which we'd have a childless soc node?

I'm just concerned about make sure this works for all the various  
cases of #address-cells and #size-cells.

- k
