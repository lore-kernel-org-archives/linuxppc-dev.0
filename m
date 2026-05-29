Return-Path: <linuxppc-dev+bounces-21685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE4DCD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 07:46:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRb5t1RWbz3bp7;
	Fri, 29 May 2026 17:46:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780040802;
	cv=none; b=hMXrCN9t9rsYU5eEQV18w/Q0exBcZ3l9zGKyoSRVporsV0rJrOPJlLiiWfAfxbSvTQoNaJJ8hBkWMvFRHOq6fygrqHbqUowxDvJKU4M93wwU4G63EIEoxa0Rh7+ZWWYBkXNChR3FgJgzCDZ9pLkQNqdFH1b62745+ebJQbOeAtEb59kqrY9BiOuQz9os+lzGCdMPM7Zjx22CkwSJMGsCs2xY0KTG1fit2r/WAA31SD6mr6HaVfl6qGIglZY7PdlrEb73GBbsJpzWrtJUX9Z9COHkJqRo67EDrzzZbrXKlgrNIfnbqRUBUS4UZtcvBHFJJ0a6bZJn1letj/PS8SiERg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780040802; c=relaxed/relaxed;
	bh=/9CHHWmBxbO285j3s+oErzUVtg40ZUJ8QQ4Gwq27hes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmkq7Dt888kEqRTIiJH+W1PtjaZs6soX7v/B8DcN3iGfZv9qG4aWykc8RpMiD24UfN32LwIdRZ+9irMxDnxy4V8y2K1n7yKJxP9Axhed/BP7UpKB1jZtWGzIcgc3UBteYd5gBkNMzxB63OTSRtnL7US+g/cc9uEINgj+5kWZ7vgtW1fp75DCdYOHKPzeS+ChmV4JH00C6bZYvwfAXF3rgZlbAd7501YLM3x9K1cWlUkj41EYO983o/5aObTIAJLconrW4UUPbc6sP8MiR5B7RHE9YuljFoFBvPR18XPzDLmWVgmj0cQpv5uPQw51aoKQwT5Vdx1Xk4BIF+r8ydoytA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zvs5TTU6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zvs5TTU6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRb5s1Cfwz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 17:46:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1372460564;
	Fri, 29 May 2026 07:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC231F00893;
	Fri, 29 May 2026 07:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780040798;
	bh=/9CHHWmBxbO285j3s+oErzUVtg40ZUJ8QQ4Gwq27hes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zvs5TTU67/6xKtZWmPKdtyYCfQ6apR7ef+zeu0Nb/UY6Wnel89+2ATf15FT79A03U
	 E7aRfF4CCWsGvrXbimoDOSbnPIn2GMRzmwq6QYRf6w45P3+wMNCxxOPFfWUjukgsrr
	 1oIOHJLT+1j4Mz7xUw8PEd3YhKbQdxCB5AcaLyOgfS+/SnnGk52GX0TGPH84HmTOJf
	 jUejFiFWKSPvEXEqQgMGxGDxvUFRmUqg3OcJOgqevWkhRXyYzsn793Q8iIuCCvUb7Q
	 lAbkJJ9C2RTwD0gRYTtjX//zzTifHYVksT+LA75Og65b4j52mAgOSXCg6u70M4en3C
	 K+WThV7ZXjOtQ==
Message-ID: <1f0b54f5-1df0-4649-89bc-9ab3a6d9a100@kernel.org>
Date: Fri, 29 May 2026 09:46:35 +0200
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
Subject: Re: [PATCH 2/3] powerpc/irq: Make irqstats array based
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260523174016.999456-1-sshegde@linux.ibm.com>
 <20260523174016.999456-3-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260523174016.999456-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/05/2026 à 19:40, Shrikanth Hegde a écrit :
> Current irq_cpustat_t has separate member for handling each arch
> specific interrupt type. The same can be achieved with array instead
> indexed by corresponding irq counter type.
> 
> This helps to,
> 
> - Make it easy to integrate into genirq improvements by calling
>    genirq provided irq_proc_emit_counts. That speeds up quite a bit
>    by printing all 0's once as much as possible.
> 
> - Adding a new vector or software counter only requires to update the table
>    and everything just works
> 
> - Remove ifdef usage a bit.
> 
> - Instead of going through each member, it simply becomes an array
>    traversal.
> 
> Time taken to read /proc/interrupts 1000 times.
> Base and v6 details can be found in cover-letter.
> Base		:  103us
> v6		:   63us
> v6+this_patch	:   57us
> 
> A Decent 10% reduction can be seen in a system 240 CPUs. As the system
> size increases the gain would be more as emitting 0 would reduce more
> and more.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/hardirq.h |  27 +++++---
>   arch/powerpc/kernel/dbell.c        |   2 +-
>   arch/powerpc/kernel/irq.c          | 107 ++++++++++-------------------
>   arch/powerpc/kernel/time.c         |   6 +-
>   arch/powerpc/kernel/traps.c        |  11 ++-
>   arch/powerpc/kernel/watchdog.c     |   2 +-
>   6 files changed, 64 insertions(+), 91 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
> index bf3926a0c69c..38098e35b241 100644
> --- a/arch/powerpc/include/asm/hardirq.h
> +++ b/arch/powerpc/include/asm/hardirq.h
> @@ -5,26 +5,33 @@
>   #include <linux/threads.h>
>   #include <linux/irq.h>
>   
> -typedef struct {
> -	unsigned int timer_irqs_event;
> -	unsigned int broadcast_irqs_event;
> -	unsigned int timer_irqs_others;
> -	unsigned int pmu_irqs;
> -	unsigned int mce_exceptions;
> -	unsigned int spurious_irqs;
> -	unsigned int sreset_irqs;
> +enum irq_stat_counts {
> +	IRQ_COUNT_LOC_TIMER,
> +	IRQ_COUNT_BCT_TIMER,
> +	IRQ_COUNT_OTHER_TIMER,
> +	IRQ_COUNT_SPURIOUS,
> +	IRQ_COUNT_PMI,
> +	IRQ_COUNT_MCE,
> +	IRQ_COUNT_NMI_SRESET,
>   #ifdef CONFIG_PPC_WATCHDOG
> -	unsigned int soft_nmi_irqs;
> +	IRQ_COUNT_WATCHDOG,
>   #endif
>   #ifdef CONFIG_PPC_DOORBELL
> -	unsigned int doorbell_irqs;
> +	IRQ_COUNT_DOORBELL,
>   #endif
> +	IRQ_COUNT_MAX,
> +};
> +
> +typedef struct {
> +	unsigned int counts[IRQ_COUNT_MAX];
>   } ____cacheline_aligned irq_cpustat_t;
>   
>   DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
>   DECLARE_PER_CPU(unsigned int, __softirq_pending);
>   #define local_softirq_pending_ref       __softirq_pending
>   
> +#define inc_irq_stat(index)	__this_cpu_inc(irq_stat.counts[IRQ_COUNT_##index])
> +
>   #define __ARCH_IRQ_STAT
>   #define __ARCH_IRQ_EXIT_IRQS_DISABLED
>   
> diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
> index 5712dd846263..f5e298a4c4c0 100644
> --- a/arch/powerpc/kernel/dbell.c
> +++ b/arch/powerpc/kernel/dbell.c
> @@ -31,7 +31,7 @@ DEFINE_INTERRUPT_HANDLER_ASYNC(doorbell_exception)
>   		do_hard_irq_enable();
>   
>   	kvmppc_clear_host_ipi(smp_processor_id());
> -	__this_cpu_inc(irq_stat.doorbell_irqs);
> +	inc_irq_stat(DOORBELL);
>   
>   	smp_ipi_demux_relaxed(); /* already performed the barrier */
>   
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index f33df5e5c23f..e67a18f62142 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -84,79 +84,57 @@ u32 tau_interrupts(unsigned long cpu);
>   #endif
>   #endif /* CONFIG_PPC32 */
>   
> +struct irq_stat_info {
> +	const char	*symbol;
> +	const char	*text;
> +};
> +
> +#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt}
> +
> +static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
> +	ISE(LOC_TIMER,		"LOC", "  Local timer interrupts for timer event device\n"),
> +	ISE(BCT_TIMER,		"BCT", "  Broadcast timer interrupts for timer event device\n"),
> +	ISE(OTHER_TIMER,	"LOC", "  Local timer interrupts for others\n"),
> +	ISE(SPURIOUS,		"SPU", "  Spurious interrupts\n"),
> +	ISE(PMI,		"PMI", "  Performance monitoring interrupts\n"),
> +	ISE(MCE,		"MCE", "  Machine check exceptions\n"),
> +	ISE(NMI_SRESET,		"NMI", "  System Reset interrupts\n"),
> +#ifdef CONFIG_PPC_WATCHDOG
> +	ISE(WATCHDOG,		"WDG", "  Watchdog soft-NMI interrupts\n"),
> +#endif
> +#ifdef CONFIG_PPC_DOORBELL
> +	ISE(DOORBELL,		"DBL", "  Doorbell interrupts\n"),
> +#endif
> +};
> +
>   int arch_show_interrupts(struct seq_file *p, int prec)
>   {
> -	int j;
> +	const struct irq_stat_info *info = irq_stat_info;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, info++) {
> +		seq_printf(p, "%*s:", prec, info->symbol);
> +		irq_proc_emit_counts(p, &irq_stat.counts[i]);
> +		seq_puts(p, info->text);
> +	}
>   
>   #if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
>   	if (tau_initialized) {
> +		int j;
>   		seq_printf(p, "%*s:", prec, "TAU");
>   		for_each_online_cpu(j)
>   			seq_put_decimal_ull_width(p, " ", tau_interrupts(j), 10);
>   		seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
>   	}
>   #endif /* CONFIG_PPC32 && CONFIG_TAU_INT */
> -
> -	seq_printf(p, "%*s:", prec, "LOC");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_event, 10);
> -        seq_printf(p, "  Local timer interrupts for timer event device\n");
> -
> -	seq_printf(p, "%*s:", prec, "BCT");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).broadcast_irqs_event, 10);
> -	seq_printf(p, "  Broadcast timer interrupts for timer event device\n");
> -
> -	seq_printf(p, "%*s:", prec, "LOC");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_others, 10);
> -        seq_printf(p, "  Local timer interrupts for others\n");
> -
> -	seq_printf(p, "%*s:", prec, "SPU");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).spurious_irqs, 10);
> -	seq_printf(p, "  Spurious interrupts\n");
> -
> -	seq_printf(p, "%*s:", prec, "PMI");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).pmu_irqs, 10);
> -	seq_printf(p, "  Performance monitoring interrupts\n");
> -
> -	seq_printf(p, "%*s:", prec, "MCE");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).mce_exceptions, 10);
> -	seq_printf(p, "  Machine check exceptions\n");
> -
>   #ifdef CONFIG_PPC_BOOK3S_64
>   	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> +		int j;
>   		seq_printf(p, "%*s:", prec, "HMI");
>   		for_each_online_cpu(j)
>   			seq_put_decimal_ull_width(p, " ", paca_ptrs[j]->hmi_irqs, 10);
>   		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
>   	}
>   #endif
> -
> -	seq_printf(p, "%*s:", prec, "NMI");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).sreset_irqs, 10);
> -	seq_printf(p, "  System Reset interrupts\n");
> -
> -#ifdef CONFIG_PPC_WATCHDOG
> -	seq_printf(p, "%*s:", prec, "WDG");
> -	for_each_online_cpu(j)
> -		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).soft_nmi_irqs, 10);
> -	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
> -#endif
> -
> -#ifdef CONFIG_PPC_DOORBELL
> -	if (cpu_has_feature(CPU_FTR_DBELL)) {
> -		seq_printf(p, "%*s:", prec, "DBL");
> -		for_each_online_cpu(j)
> -			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).doorbell_irqs, 10);
> -		seq_printf(p, "  Doorbell interrupts\n");
> -	}
> -#endif
> -
>   	return 0;
>   }
>   
> @@ -165,24 +143,15 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>    */
>   u64 arch_irq_stat_cpu(unsigned int cpu)
>   {
> -	u64 sum = per_cpu(irq_stat, cpu).timer_irqs_event;
> +	irq_cpustat_t *p = per_cpu_ptr(&irq_stat, cpu);
> +	u64 sum = 0;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++)
> +		sum += p->counts[i];
>   
> -	sum += per_cpu(irq_stat, cpu).broadcast_irqs_event;
> -	sum += per_cpu(irq_stat, cpu).pmu_irqs;
> -	sum += per_cpu(irq_stat, cpu).mce_exceptions;
> -	sum += per_cpu(irq_stat, cpu).spurious_irqs;
> -	sum += per_cpu(irq_stat, cpu).timer_irqs_others;
>   #ifdef CONFIG_PPC_BOOK3S_64
>   	sum += paca_ptrs[cpu]->hmi_irqs;
>   #endif
> -	sum += per_cpu(irq_stat, cpu).sreset_irqs;
> -#ifdef CONFIG_PPC_WATCHDOG
> -	sum += per_cpu(irq_stat, cpu).soft_nmi_irqs;
> -#endif
> -#ifdef CONFIG_PPC_DOORBELL
> -	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
> -#endif
> -
>   	return sum;
>   }
>   
> @@ -248,7 +217,7 @@ static void __do_irq(struct pt_regs *regs, unsigned long oldsp)
>   
>   	/* And finally process it */
>   	if (unlikely(!irq))
> -		__this_cpu_inc(irq_stat.spurious_irqs);
> +		inc_irq_stat(SPURIOUS);
>   	else
>   		generic_handle_irq(irq);
>   
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 4bbeb8644d3d..44da7be36199 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -572,13 +572,13 @@ DEFINE_INTERRUPT_HANDLER_ASYNC(timer_interrupt)
>   	now = get_tb();
>   	if (now >= *next_tb) {
>   		evt->event_handler(evt);
> -		__this_cpu_inc(irq_stat.timer_irqs_event);
> +		inc_irq_stat(LOC_TIMER);
>   	} else {
>   		now = *next_tb - now;
>   		if (now > decrementer_max)
>   			now = decrementer_max;
>   		set_dec_or_work(now);
> -		__this_cpu_inc(irq_stat.timer_irqs_others);
> +		inc_irq_stat(OTHER_TIMER);
>   	}
>   
>   	trace_timer_interrupt_exit(regs);
> @@ -591,7 +591,7 @@ EXPORT_SYMBOL(timer_interrupt);
>   void timer_broadcast_interrupt(void)
>   {
>   	tick_receive_broadcast();
> -	__this_cpu_inc(irq_stat.broadcast_irqs_event);
> +	inc_irq_stat(BCT_TIMER);
>   }
>   #endif
>   
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index cb8e9357383e..a8f15154bd9a 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -459,8 +459,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(system_reset_exception)
>   	}
>   
>   	hv_nmi_check_nonrecoverable(regs);
> -
> -	__this_cpu_inc(irq_stat.sreset_irqs);
> +	inc_irq_stat(NMI_SRESET);
>   
>   	/* See if any machine dependent calls */
>   	if (ppc_md.system_reset_exception) {
> @@ -817,7 +816,7 @@ static void __machine_check_exception(struct pt_regs *regs)
>   {
>   	int recover = 0;
>   
> -	__this_cpu_inc(irq_stat.mce_exceptions);
> +	inc_irq_stat(MCE);
>   
>   	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>   
> @@ -1932,8 +1931,7 @@ DEFINE_INTERRUPT_HANDLER(vsx_unavailable_tm)
>   DECLARE_INTERRUPT_HANDLER_NMI(performance_monitor_exception_nmi);
>   DEFINE_INTERRUPT_HANDLER_NMI(performance_monitor_exception_nmi)
>   {
> -	__this_cpu_inc(irq_stat.pmu_irqs);
> -
> +	inc_irq_stat(PMI);
>   	perf_irq(regs);
>   
>   	return 0;
> @@ -1943,8 +1941,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(performance_monitor_exception_nmi)
>   DECLARE_INTERRUPT_HANDLER_ASYNC(performance_monitor_exception_async);
>   DEFINE_INTERRUPT_HANDLER_ASYNC(performance_monitor_exception_async)
>   {
> -	__this_cpu_inc(irq_stat.pmu_irqs);
> -
> +	inc_irq_stat(PMI);
>   	perf_irq(regs);
>   }
>   
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 764001deb060..f516eeccc9f6 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -381,7 +381,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
>   	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled))
>   		return 0;
>   
> -	__this_cpu_inc(irq_stat.soft_nmi_irqs);
> +	inc_irq_stat(WATCHDOG);
>   
>   	tb = get_tb();
>   	if (tb - per_cpu(wd_timer_tb, cpu) >= wd_panic_timeout_tb) {


