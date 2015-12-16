Return-Path: <kda@linux-powerpc.org>
Received: from mail-qk0-x22d.google.com (mail-qk0-x22d.google.com
 [IPv6:2607:f8b0:400d:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 749051A1176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 22:54:39 +1100 (AEDT)
Received: by mail-qk0-x22d.google.com with SMTP id u65so39938846qkh.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 03:54:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1450265518.8726.2.camel@ellerman.id.au>
References: <1450242896-8322-1-git-send-email-hellozzy1988@126.com>
 <878u4vapsm.fsf@gamma.ozlabs.ibm.com>
 <1450265518.8726.2.camel@ellerman.id.au>
Date: Wed, 16 Dec 2015 14:54:36 +0300
Message-ID: <CAOJe8K1c9szihZz5GpZ=B-rP7FbqvWZ84yFJ5OM=NFe_stN48g@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/irq: tidy up inconsistent context in
 migrate_irqs()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>, Zhang Zhuoyu <hellozzy1988@126.com>,
 benh@kernel.crashing.org,
 paulus@samba.org, tglx@linutronix.de, jiang.liu@linux.intel.com,
 zhangzhuoyu@cmss.chinamobile.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/16/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2015-12-16 at 17:08 +1100, Daniel Axtens wrote:
>> Hi,
>>
>> A couple of things.
>>
>> Firstly, your two email addresses don't match:
>>
>> Zhang Zhuoyu <hellozzy1988@126.com> writes:
>
>> > From: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
>>
>> These lines do seem odd! Are they causing a problem?
>>
>> I'd be more comfortable removing them if I understood why they were
>> added. But they've been around since the beginning of git history so
>> that could be a bit difficult.
>
> It's in the fullhist tree, but that doesn't tell us much (below, named
> fixup_irqs()).
>
> But I suspect those lines are actually there very deliberately.
>
> The function is migrating interrupts off the recently offlined cpu, because
> we
> don't want to take interrupts on an offline cpu.
>
> After it's finished doing the migration, it wants to make sure there are no
> interrupts that have already been latched by the offline cpu. So it briefly
> enables interrupts, waits a bit for the interrupts to fire, and the disables
> them again.
>
> Whether that actually works I couldn't say, it is very old code, and it's
> used
> on platforms where I don't ever test cpu hotplug (85xx & powermac).

Yeah, it would be nice to test this change. I'll try it on my quad-core pmac
machine

>
> cheers
>
>
> commit d58830b9a740ad1c3b089196d4afdaea251dc701
> Author: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> Date:   Fri Mar 4 17:34:00 2005 -0800
>
>     [PATCH] ppc64: generic hotplug cpu support
>
>     Patch provides a generic hotplug cpu implementation, with the only
> current
>     user being pmac.  This doesn't replace real hotplug code as is currently
>     used by LPAR systems.  Ben i can add the additional pmac specific code
> to
>     put the processor into a sleeping state seperately.  Thanks to Nathan
> for
>     testing.
>
>     Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> diff --git a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
> index a7933ab62e98..861f4460ad02 100644
> --- a/arch/ppc64/Kconfig
> +++ b/arch/ppc64/Kconfig
> @@ -313,7 +313,7 @@ source "drivers/pci/Kconfig"
>
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs"
> -	depends on SMP && EXPERIMENTAL && PPC_PSERIES
> +	depends on SMP && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC)
>  	select HOTPLUG
>  	---help---
>  	  Say Y here to be able to turn CPUs off and on.
> diff --git a/arch/ppc64/kernel/idle.c b/arch/ppc64/kernel/idle.c
> index 398b4682127b..51eb6af14a8f 100644
> --- a/arch/ppc64/kernel/idle.c
> +++ b/arch/ppc64/kernel/idle.c
> @@ -293,6 +293,10 @@ static int native_idle(void)
>  			power4_idle();
>  		if (need_resched())
>  			schedule();
> +
> +		if (cpu_is_offline(smp_processor_id()) &&
> +		    system_state == SYSTEM_RUNNING)
> +			cpu_die();
>  	}
>  	return 0;
>  }
> diff --git a/arch/ppc64/kernel/irq.c b/arch/ppc64/kernel/irq.c
> index 0ea8016146a2..4fd7f203c1e3 100644
> --- a/arch/ppc64/kernel/irq.c
> +++ b/arch/ppc64/kernel/irq.c
> @@ -116,6 +116,35 @@ skip:
>  	return 0;
>  }
>
> +#ifdef CONFIG_HOTPLUG_CPU
> +void fixup_irqs(cpumask_t map)
> +{
> +	unsigned int irq;
> +	static int warned;
> +
> +	for_each_irq(irq) {
> +		cpumask_t mask;
> +
> +		if (irq_desc[irq].status & IRQ_PER_CPU)
> +			continue;
> +
> +		cpus_and(mask, irq_affinity[irq], map);
> +		if (any_online_cpu(mask) == NR_CPUS) {
> +			printk("Breaking affinity for irq %i\n", irq);
> +			mask = map;
> +		}
> +		if (irq_desc[irq].handler->set_affinity)
> +			irq_desc[irq].handler->set_affinity(irq, mask);
> +		else if (irq_desc[irq].action && !(warned++))
> +			printk("Cannot set affinity for irq %i\n", irq);
> +	}
> +
> +	local_irq_enable();
> +	mdelay(1);
> +	local_irq_disable();
> +}
> +#endif
> +
>  extern int noirqdebug;
>
>  /*
> diff --git a/arch/ppc64/kernel/pSeries_setup.c
> b/arch/ppc64/kernel/pSeries_setup.c
> index f603397b7b04..0426892749c6 100644
> --- a/arch/ppc64/kernel/pSeries_setup.c
> +++ b/arch/ppc64/kernel/pSeries_setup.c
> @@ -320,8 +320,9 @@ static  void __init pSeries_discover_pic(void)
>  	}
>  }
>
> -static void pSeries_cpu_die(void)
> +static void pSeries_mach_cpu_die(void)
>  {
> +	idle_task_exit();
>  	local_irq_disable();
>  	/* Some hardware requires clearing the CPPR, while other hardware does not
>  	 * it is safe either way
> @@ -599,7 +600,7 @@ struct machdep_calls __initdata pSeries_md = {
>  	.power_off		= rtas_power_off,
>  	.halt			= rtas_halt,
>  	.panic			= rtas_os_term,
> -	.cpu_die		= pSeries_cpu_die,
> +	.cpu_die		= pSeries_mach_cpu_die,
>  	.get_boot_time		= pSeries_get_boot_time,
>  	.get_rtc_time		= pSeries_get_rtc_time,
>  	.set_rtc_time		= pSeries_set_rtc_time,
> diff --git a/arch/ppc64/kernel/pmac_setup.c b/arch/ppc64/kernel/pmac_setup.c
> index 41fa6e95a06f..5c56fc956245 100644
> --- a/arch/ppc64/kernel/pmac_setup.c
> +++ b/arch/ppc64/kernel/pmac_setup.c
> @@ -439,6 +439,9 @@ static int __init pmac_probe(int platform)
>  }
>
>  struct machdep_calls __initdata pmac_md = {
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_die		= generic_mach_cpu_die,
> +#endif
>  	.probe			= pmac_probe,
>  	.setup_arch		= pmac_setup_arch,
>  	.init_early		= pmac_init_early,
> diff --git a/arch/ppc64/kernel/pmac_smp.c b/arch/ppc64/kernel/pmac_smp.c
> index e0b37079943c..c27588ede2fe 100644
> --- a/arch/ppc64/kernel/pmac_smp.c
> +++ b/arch/ppc64/kernel/pmac_smp.c
> @@ -308,4 +308,9 @@ struct smp_ops_t core99_smp_ops __pmacdata = {
>  void __init pmac_setup_smp(void)
>  {
>  	smp_ops = &core99_smp_ops;
> +#ifdef CONFIG_HOTPLUG_CPU
> +	smp_ops->cpu_enable = generic_cpu_enable;
> +	smp_ops->cpu_disable = generic_cpu_disable;
> +	smp_ops->cpu_die = generic_cpu_die;
> +#endif
>  }
> diff --git a/arch/ppc64/kernel/setup.c b/arch/ppc64/kernel/setup.c
> index d98c320828e5..078c3551ce8a 100644
> --- a/arch/ppc64/kernel/setup.c
> +++ b/arch/ppc64/kernel/setup.c
> @@ -1377,9 +1377,6 @@ early_param("xmon", early_xmon);
>
>  void cpu_die(void)
>  {
> -	idle_task_exit();
>  	if (ppc_md.cpu_die)
>  		ppc_md.cpu_die();
> -	local_irq_disable();
> -	for (;;);
>  }
> diff --git a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
> index a9e43792f8fe..cde1947432a1 100644
> --- a/arch/ppc64/kernel/smp.c
> +++ b/arch/ppc64/kernel/smp.c
> @@ -30,6 +30,7 @@
>  #include <linux/err.h>
>  #include <linux/sysdev.h>
>  #include <linux/cpu.h>
> +#include <linux/notifier.h>
>
>  #include <asm/ptrace.h>
>  #include <asm/atomic.h>
> @@ -406,10 +407,89 @@ void __devinit smp_prepare_boot_cpu(void)
>  	current_set[boot_cpuid] = current->thread_info;
>  }
>
> +#ifdef CONFIG_HOTPLUG_CPU
> +/* State of each CPU during hotplug phases */
> +DEFINE_PER_CPU(int, cpu_state) = { 0 };
> +
> +int generic_cpu_disable(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (cpu == boot_cpuid)
> +		return -EBUSY;
> +
> +	systemcfg->processorCount--;
> +	cpu_clear(cpu, cpu_online_map);
> +	fixup_irqs(cpu_online_map);
> +	return 0;
> +}
> +
> +int generic_cpu_enable(unsigned int cpu)
> +{
> +	/* Do the normal bootup if we haven't
> +	 * already bootstrapped. */
> +	if (system_state != SYSTEM_RUNNING)
> +		return -ENOSYS;
> +
> +	/* get the target out of it's holding state */
> +	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
> +	wmb();
> +
> +	while (!cpu_online(cpu))
> +		cpu_relax();
> +
> +	fixup_irqs(cpu_online_map);
> +	/* counter the irq disable in fixup_irqs */
> +	local_irq_enable();
> +	return 0;
> +}
> +
> +void generic_cpu_die(unsigned int cpu)
> +{
> +	int i;
> +
> +	for (i = 0; i < 100; i++) {
> +		rmb();
> +		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
> +			return;
> +		msleep(100);
> +	}
> +	printk(KERN_ERR "CPU%d didn't die...\n", cpu);
> +}
> +
> +void generic_mach_cpu_die(void)
> +{
> +	unsigned int cpu;
> +
> +	local_irq_disable();
> +	cpu = smp_processor_id();
> +	printk(KERN_DEBUG "CPU%d offline\n", cpu);
> +	__get_cpu_var(cpu_state) = CPU_DEAD;
> +	wmb();
> +	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
> +		cpu_relax();
> +
> +	flush_tlb_pending();
> +	cpu_set(cpu, cpu_online_map);
> +	local_irq_enable();
> +}
> +#endif
> +
> +static int __devinit cpu_enable(unsigned int cpu)
> +{
> +	if (smp_ops->cpu_enable)
> +		return smp_ops->cpu_enable(cpu);
> +
> +	return -ENOSYS;
> +}
> +
>  int __devinit __cpu_up(unsigned int cpu)
>  {
>  	int c;
>
> +	if (!cpu_enable(cpu))
> +		return 0;
> +
>  	/* At boot, don't bother with non-present cpus -JSCHOPP */
>  	if (system_state < SYSTEM_RUNNING && !cpu_present(cpu))
>  		return -ENOENT;
> diff --git a/arch/ppc64/kernel/sysfs.c b/arch/ppc64/kernel/sysfs.c
> index bbc9dcda17f7..0925694c3ce5 100644
> --- a/arch/ppc64/kernel/sysfs.c
> +++ b/arch/ppc64/kernel/sysfs.c
> @@ -18,7 +18,7 @@
>  #include <asm/systemcfg.h>
>  #include <asm/paca.h>
>  #include <asm/lppaca.h>
> -
> +#include <asm/machdep.h>
>
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
> @@ -413,9 +413,7 @@ static int __init topology_init(void)
>  		 * CPU.  For instance, the boot cpu might never be valid
>  		 * for hotplugging.
>  		 */
> -#ifdef CONFIG_HOTPLUG_CPU
> -		if (systemcfg->platform != PLATFORM_PSERIES_LPAR)
> -#endif
> +		if (!ppc_md.cpu_die)
>  			c->no_control = 1;
>
>  		if (cpu_online(cpu) || (c->no_control == 0)) {
> diff --git a/include/asm-ppc64/machdep.h b/include/asm-ppc64/machdep.h
> index 476d2185ffd1..03fe499c7604 100644
> --- a/include/asm-ppc64/machdep.h
> +++ b/include/asm-ppc64/machdep.h
> @@ -30,6 +30,7 @@ struct smp_ops_t {
>  	void  (*setup_cpu)(int nr);
>  	void  (*take_timebase)(void);
>  	void  (*give_timebase)(void);
> +	int   (*cpu_enable)(unsigned int nr);
>  	int   (*cpu_disable)(void);
>  	void  (*cpu_die)(unsigned int nr);
>  };
> diff --git a/include/asm-ppc64/smp.h b/include/asm-ppc64/smp.h
> index 965980bbbb57..c8646fa999c2 100644
> --- a/include/asm-ppc64/smp.h
> +++ b/include/asm-ppc64/smp.h
> @@ -29,7 +29,7 @@
>  extern int boot_cpuid;
>  extern int boot_cpuid_phys;
>
> -extern void cpu_die(void) __attribute__((noreturn));
> +extern void cpu_die(void);
>
>  #ifdef CONFIG_SMP
>
> @@ -37,6 +37,13 @@ extern void smp_send_debugger_break(int cpu);
>  struct pt_regs;
>  extern void smp_message_recv(int, struct pt_regs *);
>
> +#ifdef CONFIG_HOTPLUG_CPU
> +extern void fixup_irqs(cpumask_t map);
> +int generic_cpu_disable(void);
> +int generic_cpu_enable(unsigned int cpu);
> +void generic_cpu_die(unsigned int cpu);
> +void generic_mach_cpu_die(void);
> +#endif
>
>  #define __smp_processor_id() (get_paca()->paca_index)
>  #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
