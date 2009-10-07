Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79DCBB7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 03:46:02 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n97Gk0YL028131
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 03:46:00 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n97Gk0l0377112
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 03:46:00 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n97GjxZ8018425
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 03:46:00 +1100
Date: Wed, 7 Oct 2009 22:15:36 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v7 PATCH 3/7]: x86: refactor x86 idle power management code
	and remove all instances of pm_idle.
Message-ID: <20091007164536.GA4141@linux.vnet.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
	<20091006153126.GA7358@linux.vnet.ibm.com>
	<1254926750.26976.253.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1254926750.26976.253.camel@twins>
Cc: linux-arch@vger.kernel.org, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-10-07 16:45:50]:

> On Tue, 2009-10-06 at 21:01 +0530, Arun R Bharadwaj wrote:
> > +++ linux.trees.git/arch/x86/kernel/process.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/random.h>
> > +#include <linux/cpuidle.h>
> >  #include <trace/events/power.h>
> >  #include <asm/system.h>
> >  #include <asm/apic.h>
> > @@ -244,12 +245,6 @@ int sys_vfork(struct pt_regs *regs)
> >  unsigned long boot_option_idle_override = 0;
> >  EXPORT_SYMBOL(boot_option_idle_override);
> >  
> > -/*
> > - * Powermanagement idle function, if any..
> > - */
> > -void (*pm_idle)(void);
> > -EXPORT_SYMBOL(pm_idle);
> > -
> >  #ifdef CONFIG_X86_32
> >  /*
> >   * This halt magic was a workaround for ancient floppy DMA
> > @@ -329,17 +324,15 @@ static void do_nothing(void *unused)
> >  }
> >  
> >  /*
> > - * cpu_idle_wait - Used to ensure that all the CPUs discard old value of
> > - * pm_idle and update to new pm_idle value. Required while changing pm_idle
> > - * handler on SMP systems.
> > + * cpu_idle_wait - Required while changing idle routine handler on SMP systems.
> >   *
> > - * Caller must have changed pm_idle to the new value before the call. Old
> > - * pm_idle value will not be used by any CPU after the return of this function.
> > + * Caller must have changed idle routine to the new value before the call. Old
> > + * value will not be used by any CPU after the return of this function.
> >   */
> >  void cpu_idle_wait(void)
> >  {
> >         smp_mb();
> > -       /* kick all the CPUs so that they exit out of pm_idle */
> > +       /* kick all the CPUs so that they exit out of idle loop */
> >         smp_call_function(do_nothing, NULL, 1);
> >  }
> >  EXPORT_SYMBOL_GPL(cpu_idle_wait);
> > @@ -518,15 +511,59 @@ static void c1e_idle(void)
> >                 default_idle();
> >  }
> >  
> > +static void (*local_idle)(void);
> > +DEFINE_PER_CPU(struct cpuidle_device, idle_devices);
> > +
> > +struct cpuidle_driver cpuidle_default_driver = {
> > +       .name =         "cpuidle_default",
> > +};
> > +
> > +static int local_idle_loop(struct cpuidle_device *dev, struct cpuidle_state *st)
> > +{
> > +       ktime_t t1, t2;
> > +       s64 diff;
> > +       int ret;
> > +
> > +       t1 = ktime_get();
> > +       local_idle();
> > +       t2 = ktime_get();
> > +
> > +       diff = ktime_to_us(ktime_sub(t2, t1));
> > +       if (diff > INT_MAX)
> > +               diff = INT_MAX;
> > +       ret = (int) diff;
> > +
> > +       return ret;
> > +}
> > +
> > +static int setup_cpuidle_simple(void)
> > +{
> > +       struct cpuidle_device *dev;
> > +       int cpu;
> > +
> > +       if (!cpuidle_curr_driver)
> > +               cpuidle_register_driver(&cpuidle_default_driver);
> > +
> > +       for_each_online_cpu(cpu) {
> > +               dev = &per_cpu(idle_devices, cpu);
> > +               dev->cpu = cpu;
> > +               dev->states[0].enter = local_idle_loop;
> > +               dev->state_count = 1;
> > +               cpuidle_register_device(dev);
> > +       }
> > +       return 0;
> > +}
> > +device_initcall(setup_cpuidle_simple);
> > +
> >  void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
> >  {
> >  #ifdef CONFIG_SMP
> > -       if (pm_idle == poll_idle && smp_num_siblings > 1) {
> > +       if (local_idle == poll_idle && smp_num_siblings > 1) {
> >                 printk(KERN_WARNING "WARNING: polling idle and HT enabled,"
> >                         " performance may degrade.\n");
> >         }
> >  #endif
> > -       if (pm_idle)
> > +       if (local_idle)
> >                 return;
> >  
> >         if (cpu_has(c, X86_FEATURE_MWAIT) && mwait_usable(c)) {
> > @@ -534,18 +571,20 @@ void __cpuinit select_idle_routine(const
> >                  * One CPU supports mwait => All CPUs supports mwait
> >                  */
> >                 printk(KERN_INFO "using mwait in idle threads.\n");
> > -               pm_idle = mwait_idle;
> > +               local_idle = mwait_idle;
> >         } else if (check_c1e_idle(c)) {
> >                 printk(KERN_INFO "using C1E aware idle routine\n");
> > -               pm_idle = c1e_idle;
> > +               local_idle = c1e_idle;
> >         } else
> > -               pm_idle = default_idle;
> > +               local_idle = default_idle;
> > +
> > +       return;
> >  }
> >  
> >  void __init init_c1e_mask(void)
> >  {
> >         /* If we're using c1e_idle, we need to allocate c1e_mask. */
> > -       if (pm_idle == c1e_idle)
> > +       if (local_idle == c1e_idle)
> >                 zalloc_cpumask_var(&c1e_mask, GFP_KERNEL);
> >  }
> >  
> > @@ -556,7 +595,7 @@ static int __init idle_setup(char *str)
> >  
> >         if (!strcmp(str, "poll")) {
> >                 printk("using polling idle threads.\n");
> > -               pm_idle = poll_idle;
> > +               local_idle = poll_idle;
> >         } else if (!strcmp(str, "mwait"))
> >                 force_mwait = 1;
> >         else if (!strcmp(str, "halt")) {
> > @@ -567,7 +606,7 @@ static int __init idle_setup(char *str)
> >                  * To continue to load the CPU idle driver, don't touch
> >                  * the boot_option_idle_override.
> >                  */
> > -               pm_idle = default_idle;
> > +               local_idle = default_idle;
> >                 idle_halt = 1;
> >                 return 0;
> >         } else if (!strcmp(str, "nomwait")) {
> 
> 
> What guarantees that the cpuidle bits actually select this
> cpuidle_default driver when you do idle=poll?
> 

When we do a idle=poll, it sets boot_option_idle_override = 1, which
is checked during cpuidle_register_device in acpi/processor_idle.c

So cpuidle devices are not even registered if this option is set.

But, in acpi/processor_core.c where cpuidle_register_driver happens,
this check is not made currently. So, I guess this check must be added
before we register acpi_idle driver.

> Also, cpuidle already has a poll loop in it, why duplicate that?
>

Suppose the arch doesnt have a poll loop of its own, it can use the
one provided by cpuidle. I have just retained this from the earlier
implementation.

--arun
