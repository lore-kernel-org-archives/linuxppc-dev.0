Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40b1sk3x6VzF2Qr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 23:07:38 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f189so9086731pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 06:07:38 -0700 (PDT)
Message-ID: <dcda2a1bb4dc3b2c6066186cffbb356d2ff61ec8.camel@gmail.com>
Subject: Re: [PATCH] powerpc/watchdog: provide more data in watchdog messages
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 01 May 2018 23:07:28 +1000
In-Reply-To: <20180501022216.1420-1-npiggin@gmail.com>
References: <20180501022216.1420-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-01 at 12:22 +1000, Nicholas Piggin wrote:
> Provide timebase and timebase of last heartbeat in watchdog lockup
> messages. Also provide a stack trace of when a CPU becomes un-stuck,
> which can be useful -- it could be where irqs are re-enabled, so it
> may be the end of the critical section which is responsible for the
> latency.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> A lockup + unstuck event now looks like this (with irqtrace enabled):
> 
> watchdog: CPU 1 self-detected hard LOCKUP @ udelay+0x40/0x60
> watchdog: CPU 1 TB:82611697355, last heartbeat TB:75431975757

Can we divide TB with tb_ticks_per_sec, TB itself is not very useful, the
delta maybe, but it needs more work on behalf of the person looking
at the output.

> Modules linked in:
> irq event stamp: 2250184
> hardirqs last  enabled at (2250183): [<c000000000bb9158>] _raw_spin_unlock_irqrestore+0x58/0xd0
> hardirqs last disabled at (2250184): [<c00000000000e76c>] kernel_init+0x7c/0x1b0
> softirqs last  enabled at (2243178): [<c000000000bba5d8>] __do_softirq+0x4d8/0x6f8
> softirqs last disabled at (2243159): [<c0000000000f4138>] irq_exit+0x108/0x1a0
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc3-00003-g7e2de68fdf39 #319
> NIP:  c000000000026d40 LR: c00000000000e77c CTR: 0000000000000000
> REGS: c000000fffcebd80 TRAP: 0900   Not tainted  (4.17.0-rc3-00003-g7e2de68fdf39)
> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000824  XER: 20040000
> CFAR: c000000000026d4c SOFTE: 1
> GPR00: c00000000000e77c c000000006a07dc0 c000000001306000 00000002625a0000
> GPR04: c00000000000e76c 0000000000000038 8f5c28f5c28f5c29 c000000ff0e18cb0
> GPR08: c0000000011a6000 00000001802d8dcf 00000011bbdcdf4c 7bc4830ddfa301bf
> GPR12: 0000000000000000 c000000fffffe300 c00000000000e6f8 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> NIP [c000000000026d40] udelay+0x40/0x60
> LR [c00000000000e77c] kernel_init+0x8c/0x1b0
> Call Trace:
> [c000000006a07dc0] [c00000000000e76c] kernel_init+0x7c/0x1b0 (unreliable)
> [c000000006a07e30] [c00000000000b9b0] ret_from_kernel_thread+0x5c/0xac
> Instruction dump:
> 3d22ffe9 e929d400 7c6349d2 7c210b78 7d4c42a6 7d2c42a6 7d2a4850 7fa34840
> 409d0020 60000000 60000000 60000000 <7d2c42a6> 7d2a4850 7fa34840 419dfff4
> time 86406258554
> watchdog: CPU 1 became unstuck TB:86406275034

Same as above for TB

> irq event stamp: 2250201
> hardirqs last  enabled at (2250200): [<c000000000bb9218>] _raw_spin_unlock_irq+0x48/0x80
> hardirqs last disabled at (2250201): [<c000000000189ff8>] vprintk_emit+0x98/0x5c0
> softirqs last  enabled at (2243178): [<c000000000bba5d8>] __do_softirq+0x4d8/0x6f8
> softirqs last disabled at (2250191): [<c0000000000f4138>] irq_exit+0x108/0x1a0
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc3-00003-g7e2de68fdf39 #319
> NIP:  c00000000000abdc LR: c0000000000186b8 CTR: 000000003003e65c
> REGS: c000000006a07b10 TRAP: 0901   Not tainted  (4.17.0-rc3-00003-g7e2de68fdf39)
> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 48000824  XER: 00000000
> CFAR: c000000000026d4c SOFTE: 0
> GPR00: c000000000018660 c000000006a07d90 c000000001306000 0000000000000900
> GPR04: 0000000000000001 0000000000000038 8f5c28f5c28f5c29 c000000ff0e17970
> GPR08: c000000001348d98 00000002002d8dee 00000011bbdcdf4c 7bc4830ddfa301bf
> GPR12: 0000000000000000 c000000fffffe300
> NIP [c00000000000abdc] replay_interrupt_return+0x0/0x4
> LR [c0000000000186b8] arch_local_irq_restore+0xd8/0xf0
> Call Trace:
> [c000000006a07d90] [c000000000018660] arch_local_irq_restore+0x80/0xf0 (unreliable)
> [c000000006a07dc0] [c00000000000e7ac] kernel_init+0xbc/0x1b0
> [c000000006a07e30] [c00000000000b9b0] ret_from_kernel_thread+0x5c/0xac
> Instruction dump:
> 7d200026 618c8000 2c030900 4182e518 2c030500 4182f140 2c030f00 4182f278
> 2c030a00 4182ff9c 2c030e60 4182eea8 <4e800020> 7c781b78 480003a5 480003bd
> 
> 
>  arch/powerpc/kernel/watchdog.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 6256dc3b0087..8a0f7d97f8d9 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -111,7 +111,11 @@ static inline void wd_smp_unlock(unsigned long *flags)
>  
>  static void wd_lockup_ipi(struct pt_regs *regs)
>  {
> -	pr_emerg("CPU %d Hard LOCKUP\n", raw_smp_processor_id());
> +	int cpu = raw_smp_processor_id();
> +
> +	pr_emerg("CPU %d Hard LOCKUP\n", cpu);
> +	pr_emerg("CPU %d TB:%lld, last heartbeat TB:%lld\n",
> +		 cpu, get_tb(), per_cpu(wd_timer_tb, cpu));
>  	print_modules();
>  	print_irqtrace_events(current);
>  	if (regs)
> @@ -154,6 +158,8 @@ static void watchdog_smp_panic(int cpu, u64 tb)
>  
>  	pr_emerg("CPU %d detected hard LOCKUP on other CPUs %*pbl\n",
>  		 cpu, cpumask_pr_args(&wd_smp_cpus_pending));
> +	pr_emerg("CPU %d TB:%lld, last SMP heartbeat TB:%lld\n",
> +		 cpu, tb, wd_smp_last_reset_tb);
>  
>  	if (!sysctl_hardlockup_all_cpu_backtrace) {
>  		/*
> @@ -194,10 +200,19 @@ static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
>  {
>  	if (!cpumask_test_cpu(cpu, &wd_smp_cpus_pending)) {
>  		if (unlikely(cpumask_test_cpu(cpu, &wd_smp_cpus_stuck))) {
> +			struct pt_regs *regs = get_irq_regs();
>  			unsigned long flags;
>  
> -			pr_emerg("CPU %d became unstuck\n", cpu);
>  			wd_smp_lock(&flags);
> +
> +			pr_emerg("CPU %d became unstuck TB:%lld\n",
> +				 cpu, tb);
> +			print_irqtrace_events(current);
> +			if (regs)
> +				show_regs(regs);
> +			else
> +				dump_stack();
> +
>  			cpumask_clear_cpu(cpu, &wd_smp_cpus_stuck);
>  			wd_smp_unlock(&flags);
>  		}
> @@ -245,8 +260,6 @@ void soft_nmi_interrupt(struct pt_regs *regs)
>  
>  	tb = get_tb();
>  	if (tb - per_cpu(wd_timer_tb, cpu) >= wd_panic_timeout_tb) {
> -		per_cpu(wd_timer_tb, cpu) = tb;
> -

Is this related to the print improvements? It looks like you don't want
to reset the tb, but I would split it out

>  		wd_smp_lock(&flags);
>  		if (cpumask_test_cpu(cpu, &wd_smp_cpus_stuck)) {
>  			wd_smp_unlock(&flags);
> @@ -254,7 +267,10 @@ void soft_nmi_interrupt(struct pt_regs *regs)
>  		}
>  		set_cpu_stuck(cpu, tb);
>  
> -		pr_emerg("CPU %d self-detected hard LOCKUP @ %pS\n", cpu, (void *)regs->nip);
> +		pr_emerg("CPU %d self-detected hard LOCKUP @ %pS\n",
> +			 cpu, (void *)regs->nip);
> +		pr_emerg("CPU %d TB:%lld, last heartbeat TB:%lld\n",
> +			 cpu, get_tb(), per_cpu(wd_timer_tb, cpu));
>  		print_modules();
>  		print_irqtrace_events(current);
>  		show_regs(regs);

Balbir Singh.
