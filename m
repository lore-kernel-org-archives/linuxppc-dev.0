Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A62801A03BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:24:57 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 10 Feb 2016 17:24:57 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6F98F2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:24:55 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A7Oh5K45547616
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:24:51 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A7OMLO017400
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:24:23 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 08/18] cxl: IRQ allocation for guests
In-reply-to: <1454765345-7417-9-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-9-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 18:23:57 +1100
Message-Id: <1455088421-sup-7567@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

> +    /*
> +     * Look for the interrupt number.
> +     * On bare-metal, we know the range 0 only contains the PSL
> +     * interrupt so, we could start counting at range 1 and initialize
> +     * afu_irq at 1.
> +     * In a guest, range 0 also contains AFU interrupts, so it must
> +     * be counted for, but we initialize afu_irq at 0 to take into
> +     * account the PSL interrupt.
> +     *
> +     * For code-readability, it just seems easier to go over all
> +     * the ranges.
> +     */

Thanks for adding that explanation :)

> +    if (cpu_has_feature(CPU_FTR_HVMODE))
> +        alloc_count = count;
> +    else
> +        alloc_count = count + 1;

Almost a shame you can't reuse the afu_irq_range_start function you
defined for this, but doing so would probably make the code less
readable, so fine to leave this as is.

>      /* We've allocated all memory now, so let's do the irq allocations */
>      irq_name = list_first_entry(&ctx->irq_names, struct cxl_irq_name, list);
> -    for (r = 1; r < CXL_IRQ_RANGES; r++) {
> +    for (r = afu_irq_range_start(); r < CXL_IRQ_RANGES; r++) {
>          hwirq = ctx->irqs.offset[r];
>          for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> -            cxl_map_irq(ctx->afu->adapter, hwirq,
> -                    cxl_irq_afu, ctx, irq_name->name);
> +            if (r == 0 && i == 0)
> +                /* PSL interrupt, only for guest */

That comment is perhaps not as clear as it could be - the interrupt is
used on either, but it's only allocated per context on PowerVM guests.

Cheers,
-Ian
