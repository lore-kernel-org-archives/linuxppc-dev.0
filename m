Return-Path: <clg@kaod.org>
Received: from 17.mo4.mail-out.ovh.net (17.mo4.mail-out.ovh.net [46.105.41.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x3lG59s9zF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:34:48 +1000 (AEST)
Received: from player746.ha.ovh.net (unknown [10.109.160.251])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6F81119997F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 07:27:00 +0200 (CEST)
Subject: Re: [PATCH] powerpc/xive: Initialize symbol before usage
To: Michael Ellerman <mpe@ellerman.id.au>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1534877212-22678-1-git-send-email-leitao@debian.org>
 <87lg8xlq9a.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3b8841ac-ebbb-523e-0d65-ebe27a702d3c@kaod.org>
Date: Thu, 23 Aug 2018 07:26:55 +0200
MIME-Version: 1.0
In-Reply-To: <87lg8xlq9a.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2018 05:24 AM, Michael Ellerman wrote:
> Hi Breno,
> 
> Breno Leitao <leitao@debian.org> writes:
>> Function xive_native_get_ipi() might uses chip_id without it being
>> initialized. This gives the following error on 'smatch' tool:
>>
>> 	error: uninitialized symbol 'chip_id'
> 
> Which is correct, it can be used uninitialised. I'm surprised GCC
> doesn't warn about it.
> 
>> This patch simply sets chip_id initial value to 0.
> 
> I'd prefer we fixed it differently, by explicitly initialising to zero
> at the appropriate place in the code.
> 
>> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
>> index 311185b9960a..fc56673a3c0f 100644
>> --- a/arch/powerpc/sysdev/xive/native.c
>> +++ b/arch/powerpc/sysdev/xive/native.c
>> @@ -239,7 +239,7 @@ static bool xive_native_match(struct device_node *node)
>>  static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>>  {
>>  	struct device_node *np;
>> -	unsigned int chip_id;
>> +	unsigned int chip_id = 0;
>>  	s64 irq;
>>  
>>  	/* Find the chip ID */
> 
> The current code is:
> 
> 	/* Find the chip ID */
> 	np = of_get_cpu_node(cpu, NULL);
> 	if (np) {
> 		if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
> 			chip_id = 0;
> 	}
> 
> Where if np is NULL then we don't initialise chip_id.
> 
> Which could be:
> 
> 	np = of_get_cpu_node(cpu, NULL);
>         if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
>                 chip_id = 0;
> 
> Because of_property_read_u32() will just return an error if np is NULL.
> 
> It's also missing an of_node_put() of np, you should do a separate patch
> to fix that. You can just do it unconditionally after the
> of_property_read_u32().

I think we can simply get rid of the OF code under xive_native_get_ipi()
and use xc->chip_id instead. It should be safe to use as xive_prepare_cpu() 
should have initialized ->chip_id by the time xive_native_get_ipi() is 
called. 

Cheers,

C.
