Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 63BBCDDFAB
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 22:32:28 +1000 (EST)
Date: Tue, 20 May 2008 16:32:26 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080520123226.GB14573@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
	<AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
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

On Tue, May 20, 2008 at 01:04:55AM -0500, Kumar Gala wrote:
[...]
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 3934e26..e5d3366 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -538,6 +538,11 @@ config FSL_LBC
>> 	help
>> 	  Freescale Localbus support
>>
>> +config FSL_GTM
>> +	bool
>
> I'd prefer something like:
>
> depends on PPC_83xx || QUICC_ENGINE || CPM2

Ok.

>> +/**
>> + * gtm_get_specific_timer - request specific GTM timer
>> + * @gtm:	specific GTM, pass here GTM's device_node->data
>> + * @timer:	specific timer number, Timer1 is 0.
>> + * @width:	timer width (only 16 bits wide timers implemented so far)
>> + *
>> + * This function reserves GTM timer for later use. It returns  
>> gtm_timer
>> + * structure to use with the rest of GTM API, you should use timer- 
>> >irq
>> + * to manage timer interrupt.
>> + */
>> +struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, int timer, 
>> int width)
>> +{
>> +	struct gtm_timer *ret = ERR_PTR(-EBUSY);
>> +
>> +	if (width != 16)
>> +		return ERR_PTR(-ENOSYS);
>
> should we not range check timer (since it can only be 0..3)?

I thought that caller should be smart enough to not ask for bogus
timers. Ok, will range check.

>> +
>> +	spin_lock_irq(&gtm->lock);
>> +
>> +	if (gtm->timers[timer].requested)
>> +		goto out;
>> +
>> +	ret = &gtm->timers[timer];
>> +	ret->requested = true;
>> +
>> +out:
>> +	spin_unlock_irq(&gtm->lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(gtm_get_specific_timer);
>> +
>> +/**
>> + * gtm_put_timer - release GTM timer
>> + * @width:	timer width (only 16 bits wide timers implemented so far)
>> + *
>> + * This function releases GTM timer so others may request it.
>> + */
>> +void gtm_put_timer(struct gtm_timer *tmr)
>> +{
>> +	spin_lock_irq(&tmr->gtm->lock);
>> +
>> +	tmr->requested = false;
>
> should we not stop the timer as well?

Sounds reasonable. I recalling that I intended to implement that,
but obviously forgot. ;-)

>>
>> +
>> +	spin_unlock_irq(&tmr->gtm->lock);
>> +}
>> +EXPORT_SYMBOL(gtm_put_timer);
>> +
>> +/*
>> + * This is back-end for the exported functions, it's used to reset  
>> single
>> + * timer in reference mode.
>> + */
>> +static int gtm_reset_ref_timer16(struct gtm_timer *tmr, int  
>> frequency,
>> +				 int reference_value, bool free_run)
>> +{
>> +	struct gtm *gtm = tmr->gtm;
>> +	int num = tmr - &gtm->timers[0];
>> +	unsigned int prescaler;
>> +	u8 iclk = GTMDR_ICLK_ICLK;
>> +	u8 psr;
>> +	u8 sps;
>> +	unsigned long flags;
>> +	int max_prescaler = 256 * 256 * 16;
>> +
>> +	/* CPM2 doesn't have primary prescaler */
>> +	if (!tmr->gtpsr)
>> +		max_prescaler /= 256;
>> +
>> +	prescaler = gtm->clock / frequency;
>> +	/*
>> +	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
>> +	 * plus "slow go" mode (clk / 16). So, total prescale value is
>> +	 * 16 * (psr + 1) * (sps + 1). Though, for CPM2 GTMs we losing psr.
>> +	 */
>> +	if (prescaler > max_prescaler)
>> +		return -EINVAL;
>> +
>> +	if (prescaler > max_prescaler / 16) {
>> +		iclk = GTMDR_ICLK_SLGO;
>> +		prescaler /= 16;
>> +	}
>> +
>> +	if (prescaler <= 256) {
>> +		psr = 0;
>> +		sps = prescaler - 1;
>> +	} else {
>> +		psr = 256 - 1;
>> +		sps = prescaler / 256 - 1;
>> +	}
>> +
>> +	spin_lock_irqsave(&gtm->lock, flags);
>> +
>> +	/*
>> +	 * Properly reset timers: stop, reset, set up prescalers, reference
>> +	 * value and clear event register.
>> +	 */
>> +	clrsetbits_8(tmr->gtcfr, ~(GTCFR_STP(num) | GTCFR_RST(num)),
>> +				 GTCFR_STP(num) | GTCFR_RST(num));
>> +
>> +	setbits8(tmr->gtcfr, GTCFR_STP(num));
>> +
>> +	if (tmr->gtpsr)
>> +		out_be16(tmr->gtpsr, psr);
>> +	clrsetbits_be16(tmr->gtmdr, 0xFFFF, iclk | GTMDR_SPS(sps) |
>> +			GTMDR_ORI | (free_run ? GTMDR_FRR : 0));
>> +	out_be16(tmr->gtcnr, 0);
>> +	out_be16(tmr->gtrfr, reference_value);
>> +	out_be16(tmr->gtevr, 0xFFFF);
>> +
>> +	/* Let it be. */
>> +	clrbits8(tmr->gtcfr, GTCFR_STP(num));
>> +
>> +	spin_unlock_irqrestore(&gtm->lock, flags);
>> +
>> +	return 0;
>> +}
>> +/**
>> + * gtm_reset_timer16 - reset 16 bit timer with arbitrary precision
>> + * @tmr:	pointer to the gtm_timer structure obtained from  
>> gtm_get_timer
>> + * @usec:	timer interval in microseconds
>> + * @reload:	if set, the timer will reset upon expiry rather than
>> + *         	continue running free.
>> + *
>> + * This function (re)sets the GTM timer so that it counts up to the  
>> requested
>> + * interval value, and fires the interrupt when the value is reached. 
>> This
>> + * function will reduce the precision of the timer as needed in order 
>> for the
>> + * requested timeout to fit in a 16-bit register.
>
> is this save to call in interrupt context?

Yes. Will document.

>>
>> + */
>> +int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec, bool 
>> reload)
>> +{
>> +	/* quite obvious, frequency which is enough for ÂµSec precision */
>> +	int freq = 1000000;
>> +	unsigned int bit;
>> +
>> +	bit = fls_long(usec);
>> +	if (bit > 15) {
>> +		freq >>= bit - 15;
>> +		usec >>= bit - 15;
>> +	}
>> +
>> +	if (!freq)
>> +		return -EINVAL;
>> +
>> +	return gtm_reset_ref_timer16(tmr, freq, usec, reload);
>> +}
>> +EXPORT_SYMBOL(gtm_reset_timer16);
>> +
>> +/**
>> + * gtm_reset_utimer16 - reset 16 bits timer
>> + * @tmr:	pointer to the gtm_timer structure obtained from  
>> gtm_get_timer
>> + * @usec:	timer interval in microseconds
>> + * @reload:	if set, the timer will reset upon expiry rather than
>> + *         	continue running free.
>> + *
>> + * This function (re)sets GTM timer so that it counts up to the  
>> requested
>> + * interval value, and fires the interrupt when the value is reached. 
>> If reload
>> + * flag was set, timer will also reset itself upon reference value,  
>> otherwise
>> + * it continues to increment.
>
> is this save to call in interrupt context?

Yes. Will document.

>>
>> + */
>> +int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool reload)
>> +{
>> +	/* quite obvious, frequency which is enough for ÂµSec precision */
>> +	const int freq = 1000000;
>> +
>> +	/*
>> +	 * We can lower the frequency (and probably power consumption) by
>> +	 * dividing both frequency and usec by 2 until there is no  
>> remainder.
>> +	 * But we won't bother with this unless savings are measured, so  
>> just
>> +	 * run the timer as is.
>> +	 */
>> +
>> +	return gtm_reset_ref_timer16(tmr, freq, usec, reload);
>> +}
>> +EXPORT_SYMBOL(gtm_reset_utimer16);
>> +
>> +/**
>> + * gtm_stop_timer16 - stop single timer
>> + * @tmr:	pointer to the gtm_timer structure obtained from  
>> gtm_get_timer
>> + *
>> + * This function simply stops the GTM timer.
>> + */
>> +void gtm_stop_timer16(struct gtm_timer *tmr)
>> +{
>> +	struct gtm *gtm = tmr->gtm;
>> +	int num = tmr - &gtm->timers[0];
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&gtm->lock, flags);
>> +
>> +	setbits8(tmr->gtcfr, GTCFR_STP(num));
>> +	out_be16(tmr->gtevr, 0xFFFF);
>> +
>> +	spin_unlock_irqrestore(&gtm->lock, flags);
>> +}
>> +EXPORT_SYMBOL(gtm_stop_timer16);
>> +
>> +/**
>> + * gtm_ack_timer16 - acknowledge timer event (free-run timers only)
>> + * @tmr:	pointer to the gtm_timer structure obtained from  
>> gtm_get_timer
>> + * @events:	events mask to ack
>> + *
>> + * Thus function used to acknowledge timer interrupt event, use it  
>> inside the
>> + * interrupt handler.
>> + */
>> +void gtm_ack_timer16(struct gtm_timer *tmr, u16 events)
>> +{
>> +	out_be16(tmr->gtevr, events);
>> +}
>> +EXPORT_SYMBOL(gtm_ack_timer16);
>> +
>> +static void __init gtm_set_shortcuts(struct device_node *np,
>> +				     struct gtm_timer *timers,
>> +				     struct gtm_timers_regs __iomem *regs)
>> +{
>> +	/*
>> +	 * Yeah, I don't like this either, but timers' registers a bit  
>> messed,
>> +	 * so we have to provide shortcuts to write timer independent code.
>> +	 * Alternative option is to create gt*() accessors, but that will be
>> +	 * even uglier and cryptic.
>> +	 */
>> +	timers[0].gtcfr = &regs->gtcfr1;
>> +	timers[0].gtmdr = &regs->gtmdr1;
>> +	timers[0].gtcnr = &regs->gtcnr1;
>> +	timers[0].gtrfr = &regs->gtrfr1;
>> +	timers[0].gtevr = &regs->gtevr1;
>> +
>> +	timers[1].gtcfr = &regs->gtcfr1;
>> +	timers[1].gtmdr = &regs->gtmdr2;
>> +	timers[1].gtcnr = &regs->gtcnr2;
>> +	timers[1].gtrfr = &regs->gtrfr2;
>> +	timers[1].gtevr = &regs->gtevr2;
>> +
>> +	timers[2].gtcfr = &regs->gtcfr2;
>> +	timers[2].gtmdr = &regs->gtmdr3;
>> +	timers[2].gtcnr = &regs->gtcnr3;
>> +	timers[2].gtrfr = &regs->gtrfr3;
>> +	timers[2].gtevr = &regs->gtevr3;
>> +
>> +	timers[3].gtcfr = &regs->gtcfr2;
>> +	timers[3].gtmdr = &regs->gtmdr4;
>> +	timers[3].gtcnr = &regs->gtcnr4;
>> +	timers[3].gtrfr = &regs->gtrfr4;
>> +	timers[3].gtevr = &regs->gtevr4;
>> +
>> +	/* CPM2 doesn't have primary prescaler */
>> +	if (!of_device_is_compatible(np, "fsl,cpm2-gtm")) {
>> +		timers[0].gtpsr = &regs->gtpsr1;
>> +		timers[1].gtpsr = &regs->gtpsr2;
>> +		timers[2].gtpsr = &regs->gtpsr3;
>> +		timers[3].gtpsr = &regs->gtpsr4;
>> +	}
>> +}
>> +
>> +void __init fsl_gtm_init(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	for_each_compatible_node(np, NULL, "fsl,gtm") {
>> +		int i;
>> +		struct gtm *gtm;
>> +		const u32 *clock;
>> +		int size;
>> +
>> +		gtm = kzalloc(sizeof(*gtm), GFP_KERNEL);
>> +		if (!gtm) {
>> +			pr_err("%s: unable to allocate memory\n",
>> +				np->full_name);
>> +			continue;
>> +		}
>
> why bother with making this a dynamic alloc?

Because different platforms have different number of GTMs
blocks. For QE machines this could be up to three GTMs, and QE-less
usually implement two GTMs. Not sure about CPM2.

>> +
>> +		spin_lock_init(&gtm->lock);
>> +
>> +		clock = of_get_property(np, "clock-frequency", &size);
>> +		if (!clock || size != sizeof(*clock)) {
>> +			pr_err("%s: no clock-frequency\n", np->full_name);
>> +			goto err;
>> +		}
>> +		gtm->clock = *clock;
>> +
>> +		for (i = 0; i < ARRAY_SIZE(gtm->timers); i++) {
>> +			int ret;
>> +			struct resource irq;
>> +
>> +			ret = of_irq_to_resource(np, i, &irq);
>> +			if (ret == NO_IRQ) {
>> +				pr_err("%s: not enough interrupts specified\n",
>> +				       np->full_name);
>> +				goto err;
>> +			}
>> +			gtm->timers[i].irq = irq.start;
>> +			gtm->timers[i].gtm = gtm;
>> +		}
>> +
>> +		gtm->regs = of_iomap(np, 0);
>> +		if (!gtm->regs) {
>> +			pr_err("%s: unable to iomap registers\n",
>> +			       np->full_name);
>> +			goto err;
>> +		}
>> +
>> +		gtm_set_shortcuts(np, gtm->timers, gtm->regs);
>> +		list_add(&gtm->list_node, &gtms);
>> +
>> +		/* We don't want to lose the node and its ->data */
>> +		np->data = gtm;
>> +		of_node_get(np);
>> +
>> +		continue;
>> +err:
>> +		kfree(gtm);
>> +	}
>> +}
>
> Shouldn't we have an arch_initcall(fsl_gtm_init);

There (and in the QE GPIO) was an arch_initcall, but based on
Grant Likely's review it was removed in favour of platform-specific
machine_initcalls.

See http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg16469.html
There I was trying to argue, but quickly gave up. ;-) I don't have any
strong preference for this anyway. I can do either way, just tell which
you prefer.

>> diff --git a/include/asm-powerpc/fsl_gtm.h b/include/asm-powerpc/ 
>> fsl_gtm.h
>> new file mode 100644
>> index 0000000..49f1240
>> --- /dev/null
>> +++ b/include/asm-powerpc/fsl_gtm.h
>> @@ -0,0 +1,47 @@
>> +/*
>> + * Freescale General-purpose Timers Module
>> + *
>> + * Copyright (c) Freescale Semicondutor, Inc. 2006.
>> + *               Shlomi Gridish <gridish@freescale.com>
>> + *               Jerry Huang <Chang-Ming.Huang@freescale.com>
>> + * Copyright (c) MontaVista Software, Inc. 2008.
>> + *               Anton Vorontsov <avorontsov@ru.mvista.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or  
>> modify it
>> + * under  the terms of  the GNU General  Public License as published 
>> by the
>> + * Free Software Foundation;  either version 2 of the  License, or  
>> (at your
>> + * option) any later version.
>> + */
>> +
>> +#ifndef __ASM_FSL_GTM_H
>> +#define __ASM_FSL_GTM_H
>> +
>> +#include <linux/types.h>
>> +
>> +struct gtm;
>> +
>> +struct gtm_timer {
>> +	unsigned int irq;
>> +
>> +	struct gtm *gtm;
>> +	bool requested;
>> +	u8 __iomem *gtcfr;
>> +	__be16 __iomem *gtmdr;
>> +	__be16 __iomem *gtpsr;
>> +	__be16 __iomem *gtcnr;
>> +	__be16 __iomem *gtrfr;
>> +	__be16 __iomem *gtevr;
>> +};
>> +
>> +extern void __init fsl_gtm_init(void);
>> +extern struct gtm_timer *gtm_get_timer(int width);
>> +extern struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, int 
>> timer,
>> +						int width);
>> +extern void gtm_put_timer(struct gtm_timer *tmr);
>> +extern int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long  
>> usec,
>> +			     bool reload);
>> +extern int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool  
>> reload);
>
> can you explain the difference between these two.  I'm not sure I  
> understand the difference.

This is explained in the .c file with a kernel doc. Basically the
difference is that timer16 could silently crop the precision, while
utimer16 could not thus explicitly accepts u16 argument (max. timer
interval with usec precision fits in u16).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
