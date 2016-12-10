Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tbHYD5ZN5zDw7p
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 16:22:40 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id c4so2017532pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 21:22:40 -0800 (PST)
Subject: Re: [PATCH] powerpc/64: pseudo-NMI/SMP watchdog
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161209155252.31381-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2f2af75c-e8f5-4af4-2949-716da336bf5c@gmail.com>
Date: Sat, 10 Dec 2016 16:22:13 +1100
MIME-Version: 1.0
In-Reply-To: <20161209155252.31381-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/12/16 02:52, Nicholas Piggin wrote:
> Rather than use perf / PMU interrupts and the generic hardlockup
> detector, this takes the decrementer interrupt as an "NMI" when
> interrupts are soft disabled (XXX: will this do the right thing with a
> large decrementer?).  This will work even if we start soft-disabling PMU
> interrupts.
> 
> This does not solve the hardlockup problem completely however, because
> interrupts can often become hard disabled when soft disabled for long
> periods. And they can be hard disabled for other reasons.
> 

Ben/Paul suggested a way to work around this with XICS. The idea was to
have MSR_EE set and use XICS to stash away the current
interrupt and acknowledge it/replay it later. Decrementer interrupts would
not trigger timers, but trigger a special NMI watchdog, like you've
implemented.

> To make up for the lack of a periodic true NMI, this also has an SMP
> hard lockup detector where all CPUs can observe lockups on others.
> 
> This still needs a bit more polishing, testing, comments, config
> options, and boot parameters, etc., so it's RFC quality only.
> 
> Thanks,
> Nick
> ---
>  arch/powerpc/Kconfig                 |   2 +
>  arch/powerpc/include/asm/nmi.h       |   5 +
>  arch/powerpc/kernel/Makefile         |   1 +
>  arch/powerpc/kernel/exceptions-64s.S |  14 +-
>  arch/powerpc/kernel/kvm.c            |   3 +
>  arch/powerpc/kernel/nmi.c            | 288 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_64.c       |  18 ---
>  arch/powerpc/kernel/time.c           |   2 +
>  arch/sparc/kernel/nmi.c              |   2 +-
>  include/linux/nmi.h                  |  14 ++
>  init/main.c                          |   3 +
>  kernel/watchdog.c                    |  16 +-
>  12 files changed, 341 insertions(+), 27 deletions(-)
>  create mode 100644 arch/powerpc/kernel/nmi.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 65fba4c..adb3387 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -124,6 +124,8 @@ config PPC
>  	select HAVE_CBPF_JIT if !PPC64
>  	select HAVE_EBPF_JIT if PPC64
>  	select HAVE_ARCH_JUMP_LABEL
> +	select HAVE_NMI
> +	select HAVE_NMI_WATCHDOG if PPC64
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select GENERIC_SMP_IDLE_THREAD
> diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
> index ff1ccb3..d00e29b 100644
> --- a/arch/powerpc/include/asm/nmi.h
> +++ b/arch/powerpc/include/asm/nmi.h
> @@ -1,4 +1,9 @@
>  #ifndef _ASM_NMI_H
>  #define _ASM_NMI_H
>  
> +#define arch_nmi_init powerpc_nmi_init
> +void __init powerpc_nmi_init(void);
> +void touch_nmi_watchdog(void);
> +void soft_nmi_interrupt(struct pt_regs *regs);
> +
>  #endif /* _ASM_NMI_H */
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 1925341..77f199f 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
>  				   signal_64.o ptrace32.o \
>  				   paca.o nvram_64.o firmware.o
>  obj-$(CONFIG_VDSO32)		+= vdso32/
> +obj-$(CONFIG_HAVE_NMI_WATCHDOG)	+= nmi.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 1ba82ea..b159d02 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1295,7 +1295,7 @@ masked_##_H##interrupt:					\
>  	lis	r10,0x7fff;				\
>  	ori	r10,r10,0xffff;				\
>  	mtspr	SPRN_DEC,r10;				\
> -	b	2f;					\
> +	b	masked_decrementer_##_H##interrupt;	\
>  1:	cmpwi	r10,PACA_IRQ_DBELL;			\
>  	beq	2f;					\
>  	cmpwi	r10,PACA_IRQ_HMI;			\
> @@ -1312,6 +1312,16 @@ masked_##_H##interrupt:					\
>  	##_H##rfid;					\
>  	b	.
>  
> +#define MASKED_NMI(_H)					\
> +masked_decrementer_##_H##interrupt:			\
> +	std	r12,PACA_EXGEN+EX_R12(r13);		\
> +	GET_SCRATCH0(r10);				\
> +	std	r10,PACA_EXGEN+EX_R13(r13);		\
> +	EXCEPTION_PROLOG_PSERIES_1(soft_nmi_common, _H)
> +
> +EXC_COMMON(soft_nmi_common, 0x900, soft_nmi_interrupt)
> +
> +
>  /*
>   * Real mode exceptions actually use this too, but alternate
>   * instruction code patches (which end up in the common .text area)
> @@ -1319,7 +1329,9 @@ masked_##_H##interrupt:					\
>   */
>  USE_FIXED_SECTION(virt_trampolines)
>  	MASKED_INTERRUPT()
> +	MASKED_NMI()
>  	MASKED_INTERRUPT(H)
> +	MASKED_NMI(H)
>  
>  #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
>  TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 9ad37f8..f0d215c 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -25,6 +25,7 @@
>  #include <linux/kvm_para.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/nmi.h>
>  
>  #include <asm/reg.h>
>  #include <asm/sections.h>
> @@ -718,6 +719,8 @@ static __init void kvm_free_tmp(void)
>  
>  static int __init kvm_guest_init(void)
>  {
> +	/* XXX: disable hardlockup watchdog? */
> +

You mean the hypervisor watchdog? Did your testing
catch anything here?

>  	if (!kvm_para_available())
>  		goto free_tmp;
>  
> diff --git a/arch/powerpc/kernel/nmi.c b/arch/powerpc/kernel/nmi.c
> new file mode 100644
> index 0000000..8e89db4
> --- /dev/null
> +++ b/arch/powerpc/kernel/nmi.c
> @@ -0,0 +1,288 @@
> +/*
> + * NMI support on powerpc systems.
> + *
> + * Copyright 2016, IBM Corporation.
> + *
> + * This uses code from arch/sparc/kernel/nmi.c and kernel/watchdog.c
> + */
> +#include <linux/kernel.h>
> +#include <linux/param.h>
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/cpu.h>
> +#include <linux/nmi.h>
> +#include <linux/module.h>
> +#include <linux/export.h>
> +#include <linux/kprobes.h>
> +#include <linux/hardirq.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +#include <linux/kdebug.h>
> +#include <linux/delay.h>
> +#include <linux/smp.h>
> +
> +#include <asm/paca.h>
> +
> +/*
> + * Powerpc NMI is implemented using either the 0x100 system reset interrupt
> + * which is a real NMI, or using the soft-disable mechanism which can still
> + * be hard masked.
> + */
> +static int nmi_panic_timeout __read_mostly = 30; /* sec to panic */
> +static u64 nmi_panic_timeout_tb __read_mostly; /* timebase ticks */
> +
> +static int nmi_timer_period __read_mostly = 10; /* sec between activity checks */
> +static u64 nmi_timer_period_tb __read_mostly; /* timebase ticks */
> +
> +static DEFINE_PER_CPU(struct timer_list, nmi_timer);
> +static DEFINE_PER_CPU(u64, last_activity_tb);
> +
> +static cpumask_t nmi_cpus_enabled __read_mostly;
> +
> +/*
> + * Cross-CPU watchdog checker
> + */
> +#ifdef CONFIG_SMP
> +static int nmi_global_panic_timeout __read_mostly = 60; /* sec to panic other */
> +static u64 nmi_global_panic_timeout_tb __read_mostly; /* timebase ticks */
> +static cpumask_t nmi_global_cpus_pending;
> +static u64 nmi_global_last_reset_tb;
> +#endif
> +
> +static void watchdog_panic(struct pt_regs *regs, int cpu)
> +{
> +	static unsigned long lock = 0;
> +
> +	while (unlikely(test_and_set_bit_lock(0, &lock)))
> +		cpu_relax();
> +
> +	if (cpu < 0) {
> +		pr_emerg("Watchdog detected hard LOCKUP other cpus %*pbl\n",
> +				cpumask_pr_args(&nmi_global_cpus_pending));
> +	} else {
> +		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
> +	}
> +	print_modules();
> +	print_irqtrace_events(current);
> +	if (regs)
> +		show_regs(regs);
> +	else
> +		dump_stack();
> +
> +	/* XXX: trigger NMI IPI? */
> +
> +	nmi_panic(regs, "Hard LOCKUP");
> +}
> +
> +#ifdef CONFIG_SMP
> +static void nmi_global_clear_cpu_pending(int cpu, u64 tb)
> +{
> +	static unsigned long lock = 0;
> +
> +	while (unlikely(test_and_set_bit_lock(0, &lock)))
> +		cpu_relax();
> +	cpumask_clear_cpu(cpu, &nmi_global_cpus_pending);
> +	if (cpumask_empty(&nmi_global_cpus_pending)) {
> +		nmi_global_last_reset_tb = tb;
> +		cpumask_copy(&nmi_global_cpus_pending, &nmi_cpus_enabled);
> +	}
> +	clear_bit_unlock(0, &lock);
> +}
> +#endif
> +
> +static void watchdog_timer_interrupt(int cpu)
> +{
> +	u64 tb = get_tb();
> +
> +	raw_cpu_write(last_activity_tb, tb);
> +
> +#ifdef CONFIG_SMP
> +	if (tb - nmi_global_last_reset_tb < nmi_timer_period_tb)
> +		return;
> +
> +	if (cpumask_test_cpu(cpu, &nmi_global_cpus_pending))
> +		nmi_global_clear_cpu_pending(cpu, tb);
> +
> +	if (tb - nmi_global_last_reset_tb >= nmi_global_panic_timeout_tb)
> +		watchdog_panic(NULL, -1);
> +#endif
> +}
> +
> +static void nmi_timer_fn(unsigned long data)
> +{
> +	struct timer_list *t = this_cpu_ptr(&nmi_timer);
> +	int cpu = smp_processor_id();
> +
> +	watchdog_timer_interrupt(cpu);
> +
> +	t->expires = round_jiffies(jiffies + nmi_timer_period * HZ);
> +	add_timer_on(t, cpu);
> +}

Do we have to have this running all the time? Can we do an on-demand
version of NMI where we do periodic decrementers without any reliance
on timers to implement NMI watchdog
 
> +
> +void touch_nmi_watchdog(void)
> +{
> +	int cpu = smp_processor_id();
> +
> +	if (cpumask_test_cpu(cpu, &nmi_cpus_enabled))
> +		watchdog_timer_interrupt(cpu);
> +
> +	touch_softlockup_watchdog();
> +}
> +EXPORT_SYMBOL(touch_nmi_watchdog);
> +
> +static void watchdog_nmi_interrupt(struct pt_regs *regs, u64 tb)
> +{
> +	u64 interval = tb - __this_cpu_read(last_activity_tb);
> +
> +	if (interval >= nmi_panic_timeout_tb)
> +		watchdog_panic(regs, smp_processor_id());
> +}
> +
> +/*
> + * This is the soft-mask nmi handler (called by masked_interrupt() in
> + * low level exception entry).
> + */
> +static DEFINE_PER_CPU(u64, soft_nmi_last_tb);
> +
> +/*
> + * Soft nmi interrupts only occur when linux irqs are disabled (but
> + * powerpc hardware irqs are enabled), so they can not be relied
> + * upon to be timely or delivered at all. Their only real use is
> + * the nmi watchdog.
> + */
> +void soft_nmi_interrupt(struct pt_regs *regs)
> +{
> +	u64 tb;
> +
> +	if (!cpumask_test_cpu(smp_processor_id(), &nmi_cpus_enabled))
> +		return;
> +
> +	tb = get_tb();
> +	if (tb - __this_cpu_read(soft_nmi_last_tb) < nmi_timer_period_tb)
> +		return;
> +	__this_cpu_write(soft_nmi_last_tb, tb);
> +
> +	nmi_enter();
> +	watchdog_nmi_interrupt(regs, tb);
> +	nmi_exit();
> +}
> +
> +static void start_nmi_on_cpu(int cpu)
> +{
> +	struct timer_list *t = per_cpu_ptr(&nmi_timer, cpu);
> +	u64 *last_tb = per_cpu_ptr(&soft_nmi_last_tb, cpu);
> +
> +	*last_tb = get_tb();
> +	cpumask_set_cpu(cpu, &nmi_cpus_enabled);
> +
> +	setup_pinned_timer(t, nmi_timer_fn, cpu);
> +	t->expires = round_jiffies(jiffies + nmi_timer_period * HZ);
> +	add_timer_on(t, cpu);
> +}
> +
> +static void stop_nmi_on_cpu(int cpu)
> +{
> +	struct timer_list *t = per_cpu_ptr(&nmi_timer, cpu);
> +
> +	del_timer_sync(t);
> +
> +	cpumask_clear_cpu(cpu, &nmi_cpus_enabled);
> +#ifdef CONFIG_SMP
> +	nmi_global_clear_cpu_pending(cpu, get_tb());
> +#endif
> +}
> +
> +
> +static int nmi_startup(void)
> +{
> +	if (num_online_cpus() != 1) {
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +
> +#ifdef CONFIG_SMP
> +	nmi_global_last_reset_tb = get_tb();
> +#endif
> +	start_nmi_on_cpu(smp_processor_id());
> +#ifdef CONFIG_SMP
> +	cpumask_copy(&nmi_global_cpus_pending, &nmi_cpus_enabled);
> +#endif
> +
> +	pr_info("NMI Watchdog started on cpus %*pbl\n",
> +			cpumask_pr_args(&nmi_cpus_enabled));
> +
> +	return 0;
> +}
> +
> +static int nmi_cpu_notify(struct notifier_block *self,
> +				 unsigned long action, void *hcpu)
> +{
> +	int cpu = (unsigned long)hcpu;
> +
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +	case CPU_ONLINE:
> +	case CPU_DOWN_FAILED:
> +		start_nmi_on_cpu(cpu);
> +		pr_info("NMI Watchdog running on cpus %*pbl\n",
> +				cpumask_pr_args(&nmi_cpus_enabled));
> +		break;
> +	case CPU_DOWN_PREPARE:
> +		stop_nmi_on_cpu(cpu);
> +		pr_info("NMI Watchdog running on cpus %*pbl\n",
> +				cpumask_pr_args(&nmi_cpus_enabled));
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}

FYI: These bits are changing in linux-next

> +
> +static int nmi_shutdown(struct notifier_block *nb, unsigned long cmd, void *p)
> +{
> +	stop_nmi_on_cpu(smp_processor_id());
> +	return 0;
> +}
> +
> +static struct notifier_block nmi_reboot_notifier = {
> +	.notifier_call = nmi_shutdown,
> +};
> +
> +void __init powerpc_nmi_init(void)
> +{
> +	int err;
> +
> +	if (!nmi_panic_timeout)
> +		return;
> +
> +	nmi_panic_timeout_tb = nmi_panic_timeout * ppc_tb_freq;
> +	nmi_timer_period_tb = nmi_timer_period * ppc_tb_freq;
> +#ifdef CONFIG_SMP
> +	nmi_global_panic_timeout_tb = nmi_global_panic_timeout * ppc_tb_freq;
> +#endif
> +
> +	err = register_reboot_notifier(&nmi_reboot_notifier);
> +	if (err)
> +		return;
> +
> +	err = nmi_startup();
> +	if (err) {
> +		unregister_reboot_notifier(&nmi_reboot_notifier);
> +		return;
> +	}
> +
> +	cpu_notifier(nmi_cpu_notify, 0);
> +}
> +
> +static int __init setup_nmi_watchdog(char *str)
> +{
> +	if (!strncmp(str, "0", 1))
> +		nmi_panic_timeout = 0;
> +	return 0;
> +}
> +__setup("nmi_watchdog=", setup_nmi_watchdog);
> +
> +static int __init nowatchdog_setup(char *str)
> +{
> +	nmi_panic_timeout = 0;
> +	return 1;
> +}
> +__setup("nowatchdog", nowatchdog_setup);
> +
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 8d586cf..6a403a9 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -652,21 +652,3 @@ struct ppc_pci_io ppc_pci_io;
>  EXPORT_SYMBOL(ppc_pci_io);
>  #endif
>  
> -#ifdef CONFIG_HARDLOCKUP_DETECTOR
> -u64 hw_nmi_get_sample_period(int watchdog_thresh)
> -{
> -	return ppc_proc_freq * watchdog_thresh;
> -}
> -
> -/*
> - * The hardlockup detector breaks PMU event based branches and is likely
> - * to get false positives in KVM guests, so disable it by default.
> - */
> -static int __init disable_hardlockup_detector(void)
> -{
> -	hardlockup_detector_disable();
> -
> -	return 0;
> -}
> -early_initcall(disable_hardlockup_detector);
> -#endif
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index bc3f7d0..5aec1ad 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -52,6 +52,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/posix-timers.h>
>  #include <linux/irq.h>
> +#include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/irq_work.h>
>  #include <linux/clk-provider.h>
> @@ -66,6 +67,7 @@
>  #include <asm/machdep.h>
>  #include <asm/uaccess.h>
>  #include <asm/time.h>
> +#include <asm/nmi.h>
>  #include <asm/prom.h>
>  #include <asm/irq.h>
>  #include <asm/div64.h>
> diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
> index a9973bb..ae3a4d5 100644
> --- a/arch/sparc/kernel/nmi.c
> +++ b/arch/sparc/kernel/nmi.c
> @@ -244,7 +244,7 @@ static struct notifier_block nmi_reboot_notifier = {
>  	.notifier_call = nmi_shutdown,
>  };
>  
> -int __init nmi_init(void)
> +void __init nmi_init(void)
>  {
>  	int err;
>  
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index a78c35c..9552ab0 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -18,6 +18,9 @@
>  #include <asm/nmi.h>
>  extern void touch_nmi_watchdog(void);
>  #else
> +static inline void nmi_init(void)
> +{
> +}
>  static inline void touch_nmi_watchdog(void)
>  {
>  	touch_softlockup_watchdog();
> @@ -30,6 +33,17 @@ extern void hardlockup_detector_disable(void);
>  static inline void hardlockup_detector_disable(void) {}
>  #endif
>  
> +#ifdef arch_nmi_init
> +static inline void nmi_init(void)
> +{
> +	arch_nmi_init();
> +}
> +#else
> +static inline void nmi_init(void)
> +{
> +}
> +#endif
> +
>  /*
>   * Create trigger_all_cpu_backtrace() out of the arch-provided
>   * base function. Return whether such support was available,
> diff --git a/init/main.c b/init/main.c
> index 2858be7..36fd7e7 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -33,6 +33,7 @@
>  #include <linux/start_kernel.h>
>  #include <linux/security.h>
>  #include <linux/smp.h>
> +#include <linux/nmi.h>
>  #include <linux/profile.h>
>  #include <linux/rcupdate.h>
>  #include <linux/moduleparam.h>
> @@ -579,6 +580,8 @@ asmlinkage __visible void __init start_kernel(void)
>  
>  	kmem_cache_init_late();
>  
> +	nmi_init();

How did you test these?

Balbir
