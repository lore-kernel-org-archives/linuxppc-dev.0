Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10635DDFB3
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 16:05:14 +1000 (EST)
Message-Id: <AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080519174651.GA28185@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
Date: Tue, 20 May 2008 01:04:55 -0500
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 19, 2008, at 12:46 PM, Anton Vorontsov wrote:

> GTM stands for General-purpose Timers Module and able to generate
> timer{1,2,3,4} interrupts. These timers are used by the drivers that
> need time precise interrupts (like for USB transactions scheduling for
> the Freescale USB Host controller as found in some QE and CPM chips),
> or these timers could be used as wakeup events from the CPU deep-sleep
> mode.
>
> Things unimplemented:
> 1. Cascaded (32 bit) timers (1-2, 3-4).
>   This is straightforward to implement when needed, two timers should
>   be marked as "requested" and configured as appropriate.
> 2. Super-cascaded (64 bit) timers (1-2-3-4).
>   This is also straightforward to implement when needed, all timers
>   should be marked as "requested" and configured as appropriate.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> Documentation/powerpc/booting-without-of.txt |   37 +++-
> arch/powerpc/Kconfig                         |    5 +
> arch/powerpc/sysdev/Makefile                 |    1 +
> arch/powerpc/sysdev/fsl_gtm.c                |  424 +++++++++++++++++=20=

> +++++++++
> include/asm-powerpc/fsl_gtm.h                |   47 +++
> 5 files changed, 513 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
> create mode 100644 include/asm-powerpc/fsl_gtm.h


> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3934e26..e5d3366 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -538,6 +538,11 @@ config FSL_LBC
> 	help
> 	  Freescale Localbus support
>
> +config FSL_GTM
> +	bool

I'd prefer something like:

depends on PPC_83xx || QUICC_ENGINE || CPM2

>
> +	help
> +	  Freescale General-purpose Timers support
> +
> # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
> config MCA
> 	bool

> diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/=20
> fsl_gtm.c
> new file mode 100644
> index 0000000..8b35cc4
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_gtm.c
> @@ -0,0 +1,424 @@
> +/*
> + * Freescale General-purpose Timers Module
> + *
> + * Copyright (c) Freescale Semicondutor, Inc. 2006.
> + *               Shlomi Gridish <gridish@freescale.com>
> + *               Jerry Huang <Chang-Ming.Huang@freescale.com>
> + * Copyright (c) MontaVista Software, Inc. 2008.
> + *               Anton Vorontsov <avorontsov@ru.mvista.com>
> + *
> + * This program is free software; you can redistribute  it and/or =20
> modify it
> + * under  the terms of  the GNU General  Public License as =20
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or =20=

> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/list.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/spinlock.h>
> +#include <linux/bitops.h>
> +#include <asm/fsl_gtm.h>
> +
> +#define GTCFR_STP(x)		((x) & 1 ? 1 << 5 : 1 << 1)
> +#define GTCFR_RST(x)		((x) & 1 ? 1 << 4 : 1 << 0)
> +
> +#define GTMDR_ICLK_MASK		(3 << 1)
> +#define GTMDR_ICLK_ICAS		(0 << 1)
> +#define GTMDR_ICLK_ICLK		(1 << 1)
> +#define GTMDR_ICLK_SLGO		(2 << 1)
> +#define GTMDR_FRR		(1 << 3)
> +#define GTMDR_ORI		(1 << 4)
> +#define GTMDR_SPS(x)		((x) << 8)
> +
> +struct gtm_timers_regs {
> +	u8	gtcfr1;		/* Timer 1, Timer 2 global config =
register */
> +	u8	res0[0x3];
> +	u8	gtcfr2;		/* Timer 3, timer 4 global config =
register */
> +	u8	res1[0xB];
> +	__be16	gtmdr1;		/* Timer 1 mode register */
> +	__be16	gtmdr2;		/* Timer 2 mode register */
> +	__be16	gtrfr1;		/* Timer 1 reference register */
> +	__be16	gtrfr2;		/* Timer 2 reference register */
> +	__be16	gtcpr1;		/* Timer 1 capture register */
> +	__be16	gtcpr2;		/* Timer 2 capture register */
> +	__be16	gtcnr1;		/* Timer 1 counter */
> +	__be16	gtcnr2;		/* Timer 2 counter */
> +	__be16	gtmdr3;		/* Timer 3 mode register */
> +	__be16	gtmdr4;		/* Timer 4 mode register */
> +	__be16	gtrfr3;		/* Timer 3 reference register */
> +	__be16	gtrfr4;		/* Timer 4 reference register */
> +	__be16	gtcpr3;		/* Timer 3 capture register */
> +	__be16	gtcpr4;		/* Timer 4 capture register */
> +	__be16	gtcnr3;		/* Timer 3 counter */
> +	__be16	gtcnr4;		/* Timer 4 counter */
> +	__be16	gtevr1;		/* Timer 1 event register */
> +	__be16	gtevr2;		/* Timer 2 event register */
> +	__be16	gtevr3;		/* Timer 3 event register */
> +	__be16	gtevr4;		/* Timer 4 event register */
> +	__be16	gtpsr1;		/* Timer 1 prescale register */
> +	__be16	gtpsr2;		/* Timer 2 prescale register */
> +	__be16	gtpsr3;		/* Timer 3 prescale register */
> +	__be16	gtpsr4;		/* Timer 4 prescale register */
> +	u8 res2[0x40];
> +} __attribute__ ((packed));
> +
> +struct gtm {
> +	unsigned int clock;
> +	struct gtm_timers_regs __iomem *regs;
> +	struct gtm_timer timers[4];
> +	spinlock_t lock;
> +	struct list_head list_node;
> +};
> +
> +static LIST_HEAD(gtms);
> +
> +/**
> + * gtm_get_timer - request GTM timer to use it with the rest of GTM =20=

> API
> + * @width:	timer width (only 16 bits wide timers implemented so =
far)
> + *
> + * This function reserves GTM timer for later use. It returns =20
> gtm_timer
> + * structure to use with the rest of GTM API, you should use timer-=20=

> >irq
> + * to manage timer interrupt.
> + */
> +struct gtm_timer *gtm_get_timer(int width)
> +{
> +	struct gtm *gtm =3D NULL;
> +	int i;
> +
> +	if (width !=3D 16)
> +		return ERR_PTR(-ENOSYS);
> +
> +	list_for_each_entry(gtm, &gtms, list_node) {
> +		spin_lock_irq(&gtm->lock);
> +
> +		for (i =3D 0; i < ARRAY_SIZE(gtm->timers); i++) {
> +			if (!gtm->timers[i].requested) {
> +				gtm->timers[i].requested =3D true;
> +				spin_unlock_irq(&gtm->lock);
> +				return &gtm->timers[i];
> +			}
> +		}
> +
> +		spin_unlock_irq(&gtm->lock);
> +	}
> +
> +	if (gtm)
> +		return ERR_PTR(-EBUSY);
> +	return ERR_PTR(-ENODEV);
> +}
> +EXPORT_SYMBOL(gtm_get_timer);
> +
> +/**
> + * gtm_get_specific_timer - request specific GTM timer
> + * @gtm:	specific GTM, pass here GTM's device_node->data
> + * @timer:	specific timer number, Timer1 is 0.
> + * @width:	timer width (only 16 bits wide timers implemented so =
far)
> + *
> + * This function reserves GTM timer for later use. It returns =20
> gtm_timer
> + * structure to use with the rest of GTM API, you should use timer-=20=

> >irq
> + * to manage timer interrupt.
> + */
> +struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, int =20
> timer, int width)
> +{
> +	struct gtm_timer *ret =3D ERR_PTR(-EBUSY);
> +
> +	if (width !=3D 16)
> +		return ERR_PTR(-ENOSYS);

should we not range check timer (since it can only be 0..3)?

> +
> +	spin_lock_irq(&gtm->lock);
> +
> +	if (gtm->timers[timer].requested)
> +		goto out;
> +
> +	ret =3D &gtm->timers[timer];
> +	ret->requested =3D true;
> +
> +out:
> +	spin_unlock_irq(&gtm->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(gtm_get_specific_timer);
> +
> +/**
> + * gtm_put_timer - release GTM timer
> + * @width:	timer width (only 16 bits wide timers implemented so =
far)
> + *
> + * This function releases GTM timer so others may request it.
> + */
> +void gtm_put_timer(struct gtm_timer *tmr)
> +{
> +	spin_lock_irq(&tmr->gtm->lock);
> +
> +	tmr->requested =3D false;

should we not stop the timer as well?
>
> +
> +	spin_unlock_irq(&tmr->gtm->lock);
> +}
> +EXPORT_SYMBOL(gtm_put_timer);
> +
> +/*
> + * This is back-end for the exported functions, it's used to reset =20=

> single
> + * timer in reference mode.
> + */
> +static int gtm_reset_ref_timer16(struct gtm_timer *tmr, int =20
> frequency,
> +				 int reference_value, bool free_run)
> +{
> +	struct gtm *gtm =3D tmr->gtm;
> +	int num =3D tmr - &gtm->timers[0];
> +	unsigned int prescaler;
> +	u8 iclk =3D GTMDR_ICLK_ICLK;
> +	u8 psr;
> +	u8 sps;
> +	unsigned long flags;
> +	int max_prescaler =3D 256 * 256 * 16;
> +
> +	/* CPM2 doesn't have primary prescaler */
> +	if (!tmr->gtpsr)
> +		max_prescaler /=3D 256;
> +
> +	prescaler =3D gtm->clock / frequency;
> +	/*
> +	 * We have two 8 bit prescalers -- primary and secondary (psr, =
sps),
> +	 * plus "slow go" mode (clk / 16). So, total prescale value is
> +	 * 16 * (psr + 1) * (sps + 1). Though, for CPM2 GTMs we losing =
psr.
> +	 */
> +	if (prescaler > max_prescaler)
> +		return -EINVAL;
> +
> +	if (prescaler > max_prescaler / 16) {
> +		iclk =3D GTMDR_ICLK_SLGO;
> +		prescaler /=3D 16;
> +	}
> +
> +	if (prescaler <=3D 256) {
> +		psr =3D 0;
> +		sps =3D prescaler - 1;
> +	} else {
> +		psr =3D 256 - 1;
> +		sps =3D prescaler / 256 - 1;
> +	}
> +
> +	spin_lock_irqsave(&gtm->lock, flags);
> +
> +	/*
> +	 * Properly reset timers: stop, reset, set up prescalers, =
reference
> +	 * value and clear event register.
> +	 */
> +	clrsetbits_8(tmr->gtcfr, ~(GTCFR_STP(num) | GTCFR_RST(num)),
> +				 GTCFR_STP(num) | GTCFR_RST(num));
> +
> +	setbits8(tmr->gtcfr, GTCFR_STP(num));
> +
> +	if (tmr->gtpsr)
> +		out_be16(tmr->gtpsr, psr);
> +	clrsetbits_be16(tmr->gtmdr, 0xFFFF, iclk | GTMDR_SPS(sps) |
> +			GTMDR_ORI | (free_run ? GTMDR_FRR : 0));
> +	out_be16(tmr->gtcnr, 0);
> +	out_be16(tmr->gtrfr, reference_value);
> +	out_be16(tmr->gtevr, 0xFFFF);
> +
> +	/* Let it be. */
> +	clrbits8(tmr->gtcfr, GTCFR_STP(num));
> +
> +	spin_unlock_irqrestore(&gtm->lock, flags);
> +
> +	return 0;
> +}
> +/**
> + * gtm_reset_timer16 - reset 16 bit timer with arbitrary precision
> + * @tmr:	pointer to the gtm_timer structure obtained from =20
> gtm_get_timer
> + * @usec:	timer interval in microseconds
> + * @reload:	if set, the timer will reset upon expiry rather than
> + *         	continue running free.
> + *
> + * This function (re)sets the GTM timer so that it counts up to the =20=

> requested
> + * interval value, and fires the interrupt when the value is =20
> reached. This
> + * function will reduce the precision of the timer as needed in =20
> order for the
> + * requested timeout to fit in a 16-bit register.

is this save to call in interrupt context?

>
> + */
> +int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec, =20
> bool reload)
> +{
> +	/* quite obvious, frequency which is enough for =C2=B5Sec =
precision */
> +	int freq =3D 1000000;
> +	unsigned int bit;
> +
> +	bit =3D fls_long(usec);
> +	if (bit > 15) {
> +		freq >>=3D bit - 15;
> +		usec >>=3D bit - 15;
> +	}
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	return gtm_reset_ref_timer16(tmr, freq, usec, reload);
> +}
> +EXPORT_SYMBOL(gtm_reset_timer16);
> +
> +/**
> + * gtm_reset_utimer16 - reset 16 bits timer
> + * @tmr:	pointer to the gtm_timer structure obtained from =20
> gtm_get_timer
> + * @usec:	timer interval in microseconds
> + * @reload:	if set, the timer will reset upon expiry rather than
> + *         	continue running free.
> + *
> + * This function (re)sets GTM timer so that it counts up to the =20
> requested
> + * interval value, and fires the interrupt when the value is =20
> reached. If reload
> + * flag was set, timer will also reset itself upon reference value, =20=

> otherwise
> + * it continues to increment.

is this save to call in interrupt context?

>
> + */
> +int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool reload)
> +{
> +	/* quite obvious, frequency which is enough for =C2=B5Sec =
precision */
> +	const int freq =3D 1000000;
> +
> +	/*
> +	 * We can lower the frequency (and probably power consumption) =
by
> +	 * dividing both frequency and usec by 2 until there is no =20
> remainder.
> +	 * But we won't bother with this unless savings are measured, so =
=20
> just
> +	 * run the timer as is.
> +	 */
> +
> +	return gtm_reset_ref_timer16(tmr, freq, usec, reload);
> +}
> +EXPORT_SYMBOL(gtm_reset_utimer16);
> +
> +/**
> + * gtm_stop_timer16 - stop single timer
> + * @tmr:	pointer to the gtm_timer structure obtained from =20
> gtm_get_timer
> + *
> + * This function simply stops the GTM timer.
> + */
> +void gtm_stop_timer16(struct gtm_timer *tmr)
> +{
> +	struct gtm *gtm =3D tmr->gtm;
> +	int num =3D tmr - &gtm->timers[0];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gtm->lock, flags);
> +
> +	setbits8(tmr->gtcfr, GTCFR_STP(num));
> +	out_be16(tmr->gtevr, 0xFFFF);
> +
> +	spin_unlock_irqrestore(&gtm->lock, flags);
> +}
> +EXPORT_SYMBOL(gtm_stop_timer16);
> +
> +/**
> + * gtm_ack_timer16 - acknowledge timer event (free-run timers only)
> + * @tmr:	pointer to the gtm_timer structure obtained from =20
> gtm_get_timer
> + * @events:	events mask to ack
> + *
> + * Thus function used to acknowledge timer interrupt event, use it =20=

> inside the
> + * interrupt handler.
> + */
> +void gtm_ack_timer16(struct gtm_timer *tmr, u16 events)
> +{
> +	out_be16(tmr->gtevr, events);
> +}
> +EXPORT_SYMBOL(gtm_ack_timer16);
> +
> +static void __init gtm_set_shortcuts(struct device_node *np,
> +				     struct gtm_timer *timers,
> +				     struct gtm_timers_regs __iomem =
*regs)
> +{
> +	/*
> +	 * Yeah, I don't like this either, but timers' registers a bit =20=

> messed,
> +	 * so we have to provide shortcuts to write timer independent =
code.
> +	 * Alternative option is to create gt*() accessors, but that =
will be
> +	 * even uglier and cryptic.
> +	 */
> +	timers[0].gtcfr =3D &regs->gtcfr1;
> +	timers[0].gtmdr =3D &regs->gtmdr1;
> +	timers[0].gtcnr =3D &regs->gtcnr1;
> +	timers[0].gtrfr =3D &regs->gtrfr1;
> +	timers[0].gtevr =3D &regs->gtevr1;
> +
> +	timers[1].gtcfr =3D &regs->gtcfr1;
> +	timers[1].gtmdr =3D &regs->gtmdr2;
> +	timers[1].gtcnr =3D &regs->gtcnr2;
> +	timers[1].gtrfr =3D &regs->gtrfr2;
> +	timers[1].gtevr =3D &regs->gtevr2;
> +
> +	timers[2].gtcfr =3D &regs->gtcfr2;
> +	timers[2].gtmdr =3D &regs->gtmdr3;
> +	timers[2].gtcnr =3D &regs->gtcnr3;
> +	timers[2].gtrfr =3D &regs->gtrfr3;
> +	timers[2].gtevr =3D &regs->gtevr3;
> +
> +	timers[3].gtcfr =3D &regs->gtcfr2;
> +	timers[3].gtmdr =3D &regs->gtmdr4;
> +	timers[3].gtcnr =3D &regs->gtcnr4;
> +	timers[3].gtrfr =3D &regs->gtrfr4;
> +	timers[3].gtevr =3D &regs->gtevr4;
> +
> +	/* CPM2 doesn't have primary prescaler */
> +	if (!of_device_is_compatible(np, "fsl,cpm2-gtm")) {
> +		timers[0].gtpsr =3D &regs->gtpsr1;
> +		timers[1].gtpsr =3D &regs->gtpsr2;
> +		timers[2].gtpsr =3D &regs->gtpsr3;
> +		timers[3].gtpsr =3D &regs->gtpsr4;
> +	}
> +}
> +
> +void __init fsl_gtm_init(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "fsl,gtm") {
> +		int i;
> +		struct gtm *gtm;
> +		const u32 *clock;
> +		int size;
> +
> +		gtm =3D kzalloc(sizeof(*gtm), GFP_KERNEL);
> +		if (!gtm) {
> +			pr_err("%s: unable to allocate memory\n",
> +				np->full_name);
> +			continue;
> +		}

why bother with making this a dynamic alloc?

>
> +
> +		spin_lock_init(&gtm->lock);
> +
> +		clock =3D of_get_property(np, "clock-frequency", &size);
> +		if (!clock || size !=3D sizeof(*clock)) {
> +			pr_err("%s: no clock-frequency\n", =
np->full_name);
> +			goto err;
> +		}
> +		gtm->clock =3D *clock;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(gtm->timers); i++) {
> +			int ret;
> +			struct resource irq;
> +
> +			ret =3D of_irq_to_resource(np, i, &irq);
> +			if (ret =3D=3D NO_IRQ) {
> +				pr_err("%s: not enough interrupts =
specified\n",
> +				       np->full_name);
> +				goto err;
> +			}
> +			gtm->timers[i].irq =3D irq.start;
> +			gtm->timers[i].gtm =3D gtm;
> +		}
> +
> +		gtm->regs =3D of_iomap(np, 0);
> +		if (!gtm->regs) {
> +			pr_err("%s: unable to iomap registers\n",
> +			       np->full_name);
> +			goto err;
> +		}
> +
> +		gtm_set_shortcuts(np, gtm->timers, gtm->regs);
> +		list_add(&gtm->list_node, &gtms);
> +
> +		/* We don't want to lose the node and its ->data */
> +		np->data =3D gtm;
> +		of_node_get(np);
> +
> +		continue;
> +err:
> +		kfree(gtm);
> +	}
> +}

Shouldn't we have an arch_initcall(fsl_gtm_init);


>
> diff --git a/include/asm-powerpc/fsl_gtm.h b/include/asm-powerpc/=20
> fsl_gtm.h
> new file mode 100644
> index 0000000..49f1240
> --- /dev/null
> +++ b/include/asm-powerpc/fsl_gtm.h
> @@ -0,0 +1,47 @@
> +/*
> + * Freescale General-purpose Timers Module
> + *
> + * Copyright (c) Freescale Semicondutor, Inc. 2006.
> + *               Shlomi Gridish <gridish@freescale.com>
> + *               Jerry Huang <Chang-Ming.Huang@freescale.com>
> + * Copyright (c) MontaVista Software, Inc. 2008.
> + *               Anton Vorontsov <avorontsov@ru.mvista.com>
> + *
> + * This program is free software; you can redistribute  it and/or =20
> modify it
> + * under  the terms of  the GNU General  Public License as =20
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or =20=

> (at your
> + * option) any later version.
> + */
> +
> +#ifndef __ASM_FSL_GTM_H
> +#define __ASM_FSL_GTM_H
> +
> +#include <linux/types.h>
> +
> +struct gtm;
> +
> +struct gtm_timer {
> +	unsigned int irq;
> +
> +	struct gtm *gtm;
> +	bool requested;
> +	u8 __iomem *gtcfr;
> +	__be16 __iomem *gtmdr;
> +	__be16 __iomem *gtpsr;
> +	__be16 __iomem *gtcnr;
> +	__be16 __iomem *gtrfr;
> +	__be16 __iomem *gtevr;
> +};
> +
> +extern void __init fsl_gtm_init(void);
> +extern struct gtm_timer *gtm_get_timer(int width);
> +extern struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, =20
> int timer,
> +						int width);
> +extern void gtm_put_timer(struct gtm_timer *tmr);
> +extern int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long =20
> usec,
> +			     bool reload);
> +extern int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool =20=

> reload);

can you explain the difference between these two.  I'm not sure I =20
understand the difference.

>
> +extern void gtm_stop_timer16(struct gtm_timer *tmr);
> +extern void gtm_ack_timer16(struct gtm_timer *tmr, u16 events);
> +
> +#endif /* __ASM_FSL_GTM_H */
> --=20
> 1.5.5.1
