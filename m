Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBD78DE3B0
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 02:30:19 +1000 (EST)
Message-Id: <15BE5723-9703-42FA-815D-4A9CF9A67C33@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080723115321.53aa655b@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC] 4xx hardware watchpoint support
Date: Wed, 23 Jul 2008 11:26:49 -0500
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
	<20080723115321.53aa655b@zod.rchland.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 23, 2008, at 10:53 AM, Josh Boyer wrote:

> On Tue, 22 Jul 2008 22:47:58 -0300
> Luis Machado <luisgpm@linux.vnet.ibm.com> wrote:
>
>> Hi,
>>
>>> That, or adding a small function to move the bits to the appropriate
>>> registers (set_dbcr or set_dac_events).
>>>
>>>> Do you think it's worth to support this facility on 405's  
>>>> processors? If
>>>> so, i'll gladly work on a solution to it.
>>>
>>> I would think so.  There's really no difference from a userspace
>>> perspective, so gdb watchpoints could be valuable there too.  I'll
>>> leave it up to you though.
>>
>> As the 440 support is ready and the 405 needs additional tweaking  
>> due to
>> the use of DBCR1 instead of DBCR0 and due to a different position  
>> scheme
>> of the DAC1R/DAC1W flags inside DBCR1, i'd say we should include this
>> code and handle the 405 case later.
>
> That's fine with me, but I have one question below then.
>
>> Index: linux-2.6.26/arch/powerpc/kernel/signal.c
>> ===================================================================
>> --- linux-2.6.26.orig/arch/powerpc/kernel/signal.c	2008-07-20  
>> 16:56:57.000000000 -0700
>> +++ linux-2.6.26/arch/powerpc/kernel/signal.c	2008-07-22  
>> 16:47:22.000000000 -0700
>> @@ -145,8 +145,12 @@
>> 	 * user space. The DABR will have been cleared if it
>> 	 * triggered inside the kernel.
>> 	 */
>> -	if (current->thread.dabr)
>> +	if (current->thread.dabr) {
>> 		set_dabr(current->thread.dabr);
>> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>> +		mtspr(SPRN_DBCR0, current->thread.dbcr0);
>> +#endif
>
> Shouldn't this (and other places) be:
>
> #if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
>
> if you are going to exclude 40x for now?  Otherwise this is still
> enabled on 405 and setting the wrong register.

if we are ignoring 40x this can just be CONFIG_BOOKE.  CONFIG_44x sets  
CONFIG_BOOKE.

- k
