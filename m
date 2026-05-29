Return-Path: <linuxppc-dev+bounces-21686-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7542CD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 07:51:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRbCZ09Hwz3bqM;
	Fri, 29 May 2026 17:51:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780041097;
	cv=none; b=OQUYiT5bhXlivD+N1xiII6rINCHnVlreAB8FHkb5P9lOeYCOxkMt82f2m+LLKtvivf3n3wuw7lfqo9eB8dISUi7lN2h81o1EY2zZ9yndvHsyS0wsAvJlext+akSjD3Fl/9E5Ojb3TvG4qq83p/HdyAwOprJIcLYksPSuPkfREnor3r7DRjLHEAuAJIoa1d+f1Abv16n4ZDefnk6Xly9HGm4Cr8wlVs+cHP7IP4EPvxhLDPjXS/7WSekzlvXHf9o3292UEeYCdbQZ1pTibOxIexEcPixIcHi1GxlQBy8iGJRTg1RMRfQFIRT3OfRxI4jBa+zusEggQJVNnb7OhOtkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780041097; c=relaxed/relaxed;
	bh=BqItn3go96ajO++fnJeMn+tQO+ikanoSwI/BdjIOUgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1YDHxlQSAaAYKS8Ureee74ji2ghj2x6Qt5rZ3ReLzTfMp+Eg50KBWNDaIGktapSIXS7TAFdh6TTUtRRR6TvKJgtgcaoCTmO/DS1/ubtL14z/ceFhbTmRx0nN0ssjjTDiikwdJ/rv78YWQym9nprNnOYbVx1sohu4TV1k/ulwldDgTlYnvO37uWOlHskkpgqHil+SBFN6Tc0UAA6IVal+NhvrGLCJs61Cn6SskBSgZOsoK57V4jC3MTEraTHFKAQ/PVaXJVFnCOhzW85VvvxliiLHdKO8ZXQ2zKhZjPs7eysDkmSGaiVj3nFIJ/vFvz1AaRSXkabR081bnfcQLh89g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiNDu4Lc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiNDu4Lc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRbCX6jgQz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 17:51:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DD2D760564;
	Fri, 29 May 2026 07:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205B31F00893;
	Fri, 29 May 2026 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780041094;
	bh=BqItn3go96ajO++fnJeMn+tQO+ikanoSwI/BdjIOUgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eiNDu4LcaIxM6TpQddEpxQm1z3hE+eHn/jj2Tu2RIkT2p3s630bnEWeaoPh0VcUwq
	 CC60TAEADz8lxWXpDsALAvcRFKOsZxV+zC9DRzFmopKqUbzJK5SDfrL+XINdv8DIjc
	 SBM48AsCEhnGOggMlb+3bJLYvb93bA2l4Ftd8zsMGrWQf06K5DvFpnk79mhrvdIWdz
	 HVVbaucBDpeTpRvmk2cjf7sTuNlsKgke0CqYAuDobV3eaJ/qdQHFG/aeKntbqfCyf1
	 zZ3Qg2znBu/RHWrJZz4K+PiJb4lj6XzI7e8S1441B6JqSRHKb6rRNpgJOQw+gssRJ1
	 5O+P6fsCrrNmQ==
Message-ID: <584f7d44-4486-4fad-a925-abb69c362f06@kernel.org>
Date: Fri, 29 May 2026 09:51:30 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] powerpc/irq: Suppress unlikely interrupt stats by
 default
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260523174016.999456-1-sshegde@linux.ibm.com>
 <20260523174016.999456-4-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260523174016.999456-4-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/05/2026 à 19:40, Shrikanth Hegde a écrit :
> Some interrupts are always zero and that is expected since they occur
> very rarely and are mostly error indications. Don't print them by
> default.
> 
> "MCE" -  "Machine check exceptions"
> "NMI" -  "System Reset interrupts"
> 
> Print them if they occur once. Maintain a bitmap to know which
> interrupts are to be printed.

Is that bitmap needed at all ? Can't we just print them as soon as they 
are not zero ?

> 
> Time taken to read /proc/interrupts 1000 times.
> Base and v6 details can be found in cover-letter.
> Base            :  103us
> v6              :   63us
> v6+patch 1+2    :   57us
> v6+patch 1+2+3  :   54us
> 
> Patch 3 shows an additional 5% gain compared to patch 1+2. So it does
> make sense to print them only if they are ever set.
> 
> Note: Since /proc/interrupts depend on kconfig and arch dependent,
> userspace tools don't make explicit assumptions.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hardirq.h |  1 +
>   arch/powerpc/kernel/irq.c          | 37 +++++++++++++++++++++++++++---
>   arch/powerpc/kernel/traps.c        |  4 ++--
>   3 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
> index 38098e35b241..be6cd5aab016 100644
> --- a/arch/powerpc/include/asm/hardirq.h
> +++ b/arch/powerpc/include/asm/hardirq.h
> @@ -31,6 +31,7 @@ DECLARE_PER_CPU(unsigned int, __softirq_pending);
>   #define local_softirq_pending_ref       __softirq_pending
>   
>   #define inc_irq_stat(index)	__this_cpu_inc(irq_stat.counts[IRQ_COUNT_##index])
> +void inc_irq_stat_and_enable(enum irq_stat_counts which);
>   
>   #define __ARCH_IRQ_STAT
>   #define __ARCH_IRQ_EXIT_IRQS_DISABLED
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index e67a18f62142..048ddfa66fc4 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -87,9 +87,13 @@ u32 tau_interrupts(unsigned long cpu);
>   struct irq_stat_info {
>   	const char	*symbol;
>   	const char	*text;
> +	int		skip;

I'd call it 'optional' instead, and then during the print, if value 0 
and optional then don't print.

>   };
>   
> -#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt}
> +/* ISE - IRQ STAT ENABLED, ISC - IRQ STAT CONDITIONAL */
> +#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt, .skip = 0}
> +#define ISC(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt, .skip = 1}
> +
>   
>   static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
>   	ISE(LOC_TIMER,		"LOC", "  Local timer interrupts for timer event device\n"),
> @@ -97,8 +101,8 @@ static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
>   	ISE(OTHER_TIMER,	"LOC", "  Local timer interrupts for others\n"),
>   	ISE(SPURIOUS,		"SPU", "  Spurious interrupts\n"),
>   	ISE(PMI,		"PMI", "  Performance monitoring interrupts\n"),
> -	ISE(MCE,		"MCE", "  Machine check exceptions\n"),
> -	ISE(NMI_SRESET,		"NMI", "  System Reset interrupts\n"),
> +	ISC(MCE,		"MCE", "  Machine check exceptions\n"),
> +	ISC(NMI_SRESET,		"NMI", "  System Reset interrupts\n"),
>   #ifdef CONFIG_PPC_WATCHDOG
>   	ISE(WATCHDOG,		"WDG", "  Watchdog soft-NMI interrupts\n"),
>   #endif
> @@ -107,11 +111,25 @@ static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
>   #endif
>   };
>   
> +/*
> + * Used for default disabled counters to increment the stats and to enable the
> + * entry for /proc/interrupts output.
> + */
> +static DECLARE_BITMAP(irq_stat_count_show, IRQ_COUNT_MAX) __read_mostly;
> +void inc_irq_stat_and_enable(enum irq_stat_counts which)
> +{
> +	__this_cpu_inc(irq_stat.counts[which]);
> +	set_bit(which, irq_stat_count_show);
> +}
> +
>   int arch_show_interrupts(struct seq_file *p, int prec)
>   {
>   	const struct irq_stat_info *info = irq_stat_info;
>   
>   	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, info++) {
> +		if (!test_bit(i, irq_stat_count_show))
> +			continue;
> +
>   		seq_printf(p, "%*s:", prec, info->symbol);
>   		irq_proc_emit_counts(p, &irq_stat.counts[i]);
>   		seq_puts(p, info->text);
> @@ -138,6 +156,19 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>   	return 0;
>   }
>   
> +static int __init irq_init_stats(void)
> +{
> +	struct irq_stat_info *info = irq_stat_info;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, info++) {
> +		if (info->skip == 0)
> +			set_bit(i, irq_stat_count_show);
> +	}
> +
> +	return 0;
> +}
> +late_initcall(irq_init_stats);
> +
>   /*
>    * /proc/stat helpers
>    */
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a8f15154bd9a..3eacbd20fc80 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -459,7 +459,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(system_reset_exception)
>   	}
>   
>   	hv_nmi_check_nonrecoverable(regs);
> -	inc_irq_stat(NMI_SRESET);
> +	inc_irq_stat_and_enable(IRQ_COUNT_NMI_SRESET);
>   
>   	/* See if any machine dependent calls */
>   	if (ppc_md.system_reset_exception) {
> @@ -816,7 +816,7 @@ static void __machine_check_exception(struct pt_regs *regs)
>   {
>   	int recover = 0;
>   
> -	inc_irq_stat(MCE);
> +	inc_irq_stat_and_enable(IRQ_COUNT_MCE);
>   
>   	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>   


