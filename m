Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AF892C007E
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 04:55:13 +1000 (EST)
Message-ID: <500EEF86.5040806@freescale.com>
Date: Tue, 24 Jul 2012 13:55:02 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500EE4C3.40707@freescale.com>
 <500EEA46.6030807@freescale.com>
In-Reply-To: <500EEA46.6030807@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

>>>> +	compatible = "fsl,P5040";
>>>
>>> When would we not override this?
>>
>> I don't understand.
> 
> I was wondering why we put these chip-based toplevel compatibles in the
> dtsi, when we'll always overwrite it with a board-based toplevel compatible.

That's a good point, but I'm loathe to break the current convention.  I'd
rather post a patch that removes them from all boards, but I'd like an ACK
from Kumar first.

>>> Why are kernel/dtb read only?
>>
>> Because that's how it is on the P5020!
> 
> This is a copy-and-paste meme that I've probably complained about a few
> dozen times by now. :-)

I know, I know, but you would think problems like this would already be
fixed upstream.  I didn't think I would need to review every single
property in the P5020 device trees.

>>>> +#ifdef CONFIG_SMP
>>>> +		/*
>>>> +		 * Disable the timebase sync operations because we can't write
>>>> +		 * to the timebase registers under the hypervisor.
>>>> +		  */
>>>> +		smp_85xx_ops.give_timebase = NULL;
>>>> +		smp_85xx_ops.take_timebase = NULL;
>>>> +#endif
>>>
>>> Why are they getting set in the first place?
>>
>> This is how the structure is defined in smp.c:
>>
>> struct smp_ops_t smp_85xx_ops = {
>> 	.kick_cpu = smp_85xx_kick_cpu,
>> #ifdef CONFIG_KEXEC
>> 	.give_timebase	= smp_generic_give_timebase,
>> 	.take_timebase	= smp_generic_take_timebase,
>> #endif
>> };
>>
>> This code has not changed in years.
> 
> There was a patch to fix this, but I guess it hasn't been merged yet.

Can you give me a clue which patch this is, so I can find it on the
mailing list?

>> I'm not sure what you think is wrong
>> with it.
> 
> We should never be using smp_generic_take/give_timebase.  We have a
> better way of synchronizing for the few cases where we need to.

Ok, I'll match the new paradigm when I find it.

-- 
Timur Tabi
Linux kernel developer at Freescale
