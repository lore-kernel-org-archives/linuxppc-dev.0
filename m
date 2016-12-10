Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tbJVp4MWPzDw9Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 17:05:38 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id p66so4456445pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 22:05:38 -0800 (PST)
Date: Sat, 10 Dec 2016 16:05:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: pseudo-NMI/SMP watchdog
Message-ID: <20161210160526.0f46ac1b@roar.ozlabs.ibm.com>
In-Reply-To: <2f2af75c-e8f5-4af4-2949-716da336bf5c@gmail.com>
References: <20161209155252.31381-1-npiggin@gmail.com>
 <2f2af75c-e8f5-4af4-2949-716da336bf5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 10 Dec 2016 16:22:13 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On 10/12/16 02:52, Nicholas Piggin wrote:
> > Rather than use perf / PMU interrupts and the generic hardlockup
> > detector, this takes the decrementer interrupt as an "NMI" when
> > interrupts are soft disabled (XXX: will this do the right thing with a
> > large decrementer?).  This will work even if we start soft-disabling PMU
> > interrupts.
> > 
> > This does not solve the hardlockup problem completely however, because
> > interrupts can often become hard disabled when soft disabled for long
> > periods. And they can be hard disabled for other reasons.
> >   
> 
> Ben/Paul suggested a way to work around this with XICS. The idea was to
> have MSR_EE set and use XICS to stash away the current
> interrupt and acknowledge it/replay it later. Decrementer interrupts would
> not trigger timers, but trigger a special NMI watchdog, like you've
> implemented.

Yeah that's a good idea, it should significantly avoid hard interrupt
disable windows.

> > @@ -718,6 +719,8 @@ static __init void kvm_free_tmp(void)
> >  
> >  static int __init kvm_guest_init(void)
> >  {
> > +	/* XXX: disable hardlockup watchdog? */
> > +  
> 
> You mean the hypervisor watchdog? Did your testing
> catch anything here?

I meant guest. Testing didn't catch anything but I put it there to
investigate because I saw x86 does hardlockup_detector_disable() in
their guest init.

> > +static void nmi_timer_fn(unsigned long data)
> > +{
> > +	struct timer_list *t = this_cpu_ptr(&nmi_timer);
> > +	int cpu = smp_processor_id();
> > +
> > +	watchdog_timer_interrupt(cpu);
> > +
> > +	t->expires = round_jiffies(jiffies + nmi_timer_period * HZ);
> > +	add_timer_on(t, cpu);
> > +}  
> 
> Do we have to have this running all the time? Can we do an on-demand
> version of NMI where we do periodic decrementers without any reliance
> on timers to implement NMI watchdog

We could, but it is trivial to do this and get all the timer and
dynticks stuff taken care of for us. We could bump the period up
to 30s or so and it should hardly be an issue.

I didn't want to try getting too clever, there are times when you
could shut it off, but then you still lose some lockup coverage.

But... I'm open to suggestions. I don't know the timer code well.

> > +static int nmi_cpu_notify(struct notifier_block *self,
> > +				 unsigned long action, void *hcpu)
> > +{
> > +	int cpu = (unsigned long)hcpu;
> > +
> > +	switch (action & ~CPU_TASKS_FROZEN) {
> > +	case CPU_ONLINE:
> > +	case CPU_DOWN_FAILED:
> > +		start_nmi_on_cpu(cpu);
> > +		pr_info("NMI Watchdog running on cpus %*pbl\n",
> > +				cpumask_pr_args(&nmi_cpus_enabled));
> > +		break;
> > +	case CPU_DOWN_PREPARE:
> > +		stop_nmi_on_cpu(cpu);
> > +		pr_info("NMI Watchdog running on cpus %*pbl\n",
> > +				cpumask_pr_args(&nmi_cpus_enabled));
> > +		break;
> > +	}
> > +	return NOTIFY_OK;
> > +}  
> 
> FYI: These bits are changing in linux-next

Yeah I'll have to update them.

> > diff --git a/init/main.c b/init/main.c
> > index 2858be7..36fd7e7 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/start_kernel.h>
> >  #include <linux/security.h>
> >  #include <linux/smp.h>
> > +#include <linux/nmi.h>
> >  #include <linux/profile.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/moduleparam.h>
> > @@ -579,6 +580,8 @@ asmlinkage __visible void __init start_kernel(void)
> >  
> >  	kmem_cache_init_late();
> >  
> > +	nmi_init();  
> 
> How did you test these?

I just tried a few place putting soft/hard irq disable and spinning
forever. Soft disable case was getting caught by the local NMI, hard
disable gets caught by the SMP check.

When we also get the NMI IPI crash debug stuff, we should be able to get
reasonable crash data with hard disabled hangs.

Thanks,
Nick
