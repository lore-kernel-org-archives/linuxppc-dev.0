Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 266C5DE2F8
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:08:49 +1000 (EST)
Date: Tue, 20 May 2008 18:08:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080520140847.GA2430@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
	<AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
	<20080520123226.GB14573@polina.dev.rtsoft.ru>
	<7A841A6C-137D-4784-B7B0-2BAFFFB0CCF7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <7A841A6C-137D-4784-B7B0-2BAFFFB0CCF7@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 08:15:15AM -0500, Kumar Gala wrote:
[...]
>>>> +	for_each_compatible_node(np, NULL, "fsl,gtm") {
>>>> +		int i;
>>>> +		struct gtm *gtm;
>>>> +		const u32 *clock;
>>>> +		int size;
>>>> +
>>>> +		gtm = kzalloc(sizeof(*gtm), GFP_KERNEL);
>>>> +		if (!gtm) {
>>>> +			pr_err("%s: unable to allocate memory\n",
>>>> +				np->full_name);
>>>> +			continue;
>>>> +		}
>>>
>>> why bother with making this a dynamic alloc?
>>
>> Because different platforms have different number of GTMs
>> blocks. For QE machines this could be up to three GTMs, and QE-less
>> usually implement two GTMs. Not sure about CPM2.
>
> ok, that makes sense.
>
>>>> +
>>>> +		spin_lock_init(&gtm->lock);
>>>> +
>>>> +		clock = of_get_property(np, "clock-frequency", &size);
>>>> +		if (!clock || size != sizeof(*clock)) {
>>>> +			pr_err("%s: no clock-frequency\n", np->full_name);
>>>> +			goto err;
>>>> +		}
>>>> +		gtm->clock = *clock;
>>>> +
>>>> +		for (i = 0; i < ARRAY_SIZE(gtm->timers); i++) {
>>>> +			int ret;
>>>> +			struct resource irq;
>>>> +
>>>> +			ret = of_irq_to_resource(np, i, &irq);
>>>> +			if (ret == NO_IRQ) {
>>>> +				pr_err("%s: not enough interrupts specified\n",
>>>> +				       np->full_name);
>>>> +				goto err;
>>>> +			}
>>>> +			gtm->timers[i].irq = irq.start;
>>>> +			gtm->timers[i].gtm = gtm;
>>>> +		}
>>>> +
>>>> +		gtm->regs = of_iomap(np, 0);
>>>> +		if (!gtm->regs) {
>>>> +			pr_err("%s: unable to iomap registers\n",
>>>> +			       np->full_name);
>>>> +			goto err;
>>>> +		}
>>>> +
>>>> +		gtm_set_shortcuts(np, gtm->timers, gtm->regs);
>>>> +		list_add(&gtm->list_node, &gtms);
>>>> +
>>>> +		/* We don't want to lose the node and its ->data */
>>>> +		np->data = gtm;
>>>> +		of_node_get(np);
>>>> +
>>>> +		continue;
>>>> +err:
>>>> +		kfree(gtm);
>>>> +	}
>>>> +}
>>>
>>> Shouldn't we have an arch_initcall(fsl_gtm_init);
>>
>> There (and in the QE GPIO) was an arch_initcall, but based on
>> Grant Likely's review it was removed in favour of platform-specific
>> machine_initcalls.
>>
>> See http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg16469.html
>> There I was trying to argue, but quickly gave up. ;-) I don't have any
>> strong preference for this anyway. I can do either way, just tell  
>> which
>> you prefer.
>
> I'd prefer the arch_initcall().  If its the board that is going to do  
> the Kconfig select on this that seems sufficient to say do "init" for me 
> w/o an explicit call to it.

IIRC, the argument was that we don't need unnecessary initcalls for the
multi-platform kernels. With arch_initcall() GTM/QE GPIOs will be probed
regardless of a board the kernel currently running at. With
machine_initcalls we only probe the GTMs/QE GPIOs on the boards which
actually use it.

Once again, I see pros and cons of both ways, and I don't have preference,
so.. ok, I will revert the arch_initcall() for GTM and QE GPIO.

>>>> diff --git a/include/asm-powerpc/fsl_gtm.h b/include/asm-powerpc/
>>>> fsl_gtm.h
>>>> new file mode 100644
>>>> index 0000000..49f1240
>>>> --- /dev/null
>>>> +++ b/include/asm-powerpc/fsl_gtm.h
>>>> @@ -0,0 +1,47 @@
>>>> +/*
>>>> + * Freescale General-purpose Timers Module
>>>> + *
>>>> + * Copyright (c) Freescale Semicondutor, Inc. 2006.
>>>> + *               Shlomi Gridish <gridish@freescale.com>
>>>> + *               Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>> + * Copyright (c) MontaVista Software, Inc. 2008.
>>>> + *               Anton Vorontsov <avorontsov@ru.mvista.com>
>>>> + *
>>>> + * This program is free software; you can redistribute  it and/or
>>>> modify it
>>>> + * under  the terms of  the GNU General  Public License as  
>>>> published
>>>> by the
>>>> + * Free Software Foundation;  either version 2 of the  License, or
>>>> (at your
>>>> + * option) any later version.
>>>> + */
>>>> +
>>>> +#ifndef __ASM_FSL_GTM_H
>>>> +#define __ASM_FSL_GTM_H
>>>> +
>>>> +#include <linux/types.h>
>>>> +
>>>> +struct gtm;
>>>> +
>>>> +struct gtm_timer {
>>>> +	unsigned int irq;
>>>> +
>>>> +	struct gtm *gtm;
>>>> +	bool requested;
>>>> +	u8 __iomem *gtcfr;
>>>> +	__be16 __iomem *gtmdr;
>>>> +	__be16 __iomem *gtpsr;
>>>> +	__be16 __iomem *gtcnr;
>>>> +	__be16 __iomem *gtrfr;
>>>> +	__be16 __iomem *gtevr;
>>>> +};
>>>> +
>>>> +extern void __init fsl_gtm_init(void);
>>>> +extern struct gtm_timer *gtm_get_timer(int width);
>>>> +extern struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm,  
>>>> int
>>>> timer,
>>>> +						int width);
>>>> +extern void gtm_put_timer(struct gtm_timer *tmr);
>>>> +extern int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long
>>>> usec,
>>>> +			     bool reload);
>>>> +extern int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool
>>>> reload);
>>>
>>> can you explain the difference between these two.  I'm not sure I
>>> understand the difference.
>>
>> This is explained in the .c file with a kernel doc. Basically the
>> difference is that timer16 could silently crop the precision, while
>> utimer16 could not thus explicitly accepts u16 argument (max. timer
>> interval with usec precision fits in u16).
>
> Maybe I'm confused what the utility is of cropping the precision in this 
> way is.  I'd also say that _timer16 is poorly named to convey the  
> behavior. I'm not sure what to call it because I still dont get exactly 
> why you'd want the precision cropped.

Precision matters for FHCI-like drivers, when driver, for example,
schedule transactions via the GTM timers, and there timings matters
a lot.

Though, timer16 crops the precision _only_ if usecs > 65535, so FHCI
_can_ still use the _timer16 (because FHCI does not request intervals
> 65535). But I implemented two function because:

1. I think we don't need unnecessary stuff in the ISRs (this is weak
   argument since I didn't measure the impact).
2. I wanted to make the API clear (seem to fail this undertaking :-),
   which functions will behave exactly the way you asked it (utimer16),
   and which functions will _silently_ crop the precision (timer16)
   (if asked for 1001000 usecs, it will give you ~~1001000, depending
   on the GTM frequency).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
