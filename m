Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2B74CB7C00
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 15:46:03 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id n825hEGW029946
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2009 15:43:14 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n825k1hi1208376
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2009 15:46:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n825k0QN022376
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2009 15:46:01 +1000
Date: Wed, 2 Sep 2009 11:15:52 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [v4 PATCH 1/5]: cpuidle: Cleanup drivers/cpuidle/cpuidle.c
Message-ID: <20090902054552.GC5431@linux.vnet.ibm.com>
References: <20090901113704.GG7599@linux.vnet.ibm.com>
	<20090901113840.GH7599@linux.vnet.ibm.com>
	<20090901172825.GA6780@balbir.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090901172825.GA6780@balbir.in.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	aun@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Balbir Singh <balbir@linux.vnet.ibm.com> [2009-09-01 22:58:25]:

> * Arun R B <arun@linux.vnet.ibm.com> [2009-09-01 17:08:40]:
> 
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-01 17:07:04]:
> > 
> > Cleanup drivers/cpuidle/cpuidle.c
> > 
> > Cpuidle maintains a pm_idle_old void pointer because, currently in x86
> > there is no clean way of registering and unregistering a idle function.
> >
> > So remove pm_idle_old and leave the responsibility of maintaining the
> > list of registered idle loops to the architecture specific code. If the
> > architecture registers cpuidle_idle_call as its idle loop, only then
> > this loop is called.
> > 
> 
> It sounds as if there is a side-effect of this
> patch on x86 (am I reading it incorrectly), which can be fixed, but
> it will need a patch or so to get back the old behaviour on x86.
> 
> > Also remove unwanted functions cpuidle_[un]install_idle_handler,
> > cpuidle_kick_cpus()
> >
> > Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
> > ---
> >  drivers/cpuidle/cpuidle.c  |   51 +++++++++++++++------------------------------
> >  drivers/cpuidle/governor.c |    3 --
> >  2 files changed, 17 insertions(+), 37 deletions(-)
> > 
> > Index: linux.trees.git/drivers/cpuidle/cpuidle.c
> > ===================================================================
> > --- linux.trees.git.orig/drivers/cpuidle/cpuidle.c
> > +++ linux.trees.git/drivers/cpuidle/cpuidle.c
> > @@ -24,9 +24,14 @@ DEFINE_PER_CPU(struct cpuidle_device *, 
> > 
> >  DEFINE_MUTEX(cpuidle_lock);
> >  LIST_HEAD(cpuidle_detected_devices);
> > -static void (*pm_idle_old)(void);
> > 
> >  static int enabled_devices;
> > +static int idle_function_registered;
> > +
> > +struct idle_function_desc cpuidle_idle_desc = {
> > +	.name           =       "cpuidle_loop",
> > +	.idle_func      =       cpuidle_idle_call,
> > +};
> > 
> >  #if defined(CONFIG_ARCH_HAS_CPU_IDLE_WAIT)
> >  static void cpuidle_kick_cpus(void)
> > @@ -54,13 +59,10 @@ static void cpuidle_idle_call(void)
> > 
> >  	/* check if the device is ready */
> >  	if (!dev || !dev->enabled) {
> > -		if (pm_idle_old)
> > -			pm_idle_old();
> > -		else
> >  #if defined(CONFIG_ARCH_HAS_DEFAULT_IDLE)
> > -			default_idle();
> > +		default_idle();
> >  #else
> > -			local_irq_enable();
> > +		local_irq_enable();
> >  #endif
> >  		return;
> >  	}
> > @@ -94,35 +96,11 @@ static void cpuidle_idle_call(void)
> >  }
> > 
> >  /**
> > - * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
> > - */
> > -void cpuidle_install_idle_handler(void)
> > -{
> > -	if (enabled_devices && (pm_idle != cpuidle_idle_call)) {
> > -		/* Make sure all changes finished before we switch to new idle */
> > -		smp_wmb();
> > -		pm_idle = cpuidle_idle_call;
> > -	}
> > -}
> > -
> > -/**
> > - * cpuidle_uninstall_idle_handler - uninstalls the cpuidle idle loop handler
> > - */
> > -void cpuidle_uninstall_idle_handler(void)
> > -{
> > -	if (enabled_devices && pm_idle_old && (pm_idle != pm_idle_old)) {
> > -		pm_idle = pm_idle_old;
> > -		cpuidle_kick_cpus();
> > -	}
> > -}
> > -
> > -/**
> >   * cpuidle_pause_and_lock - temporarily disables CPUIDLE
> >   */
> >  void cpuidle_pause_and_lock(void)
> >  {
> >  	mutex_lock(&cpuidle_lock);
> > -	cpuidle_uninstall_idle_handler();
> >  }
> > 
> >  EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
> > @@ -132,7 +110,6 @@ EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock
> >   */
> >  void cpuidle_resume_and_unlock(void)
> >  {
> > -	cpuidle_install_idle_handler();
> >  	mutex_unlock(&cpuidle_lock);
> >  }
> > 
> 
> What does this mean for users of cpuidle_pause_and_lock/unlock?
> Should we be calling register/unregister_idle_function here?
> 

Just observed the use case for cpuidle_pause_and_lock/unlock.
It is not clear as to why we need to switch back to the old idle
handler and then again back to cpuidle's idle handler. Wouldn't it
make more sense to just register the idle handler when the first
cpuidle device is being registered and unregister the idle handler
when the last cpuidle device is unregistered?

--arun

> 
> > @@ -287,6 +264,12 @@ static int __cpuidle_register_device(str
> >  	return 0;
> >  }
> > 
> > +static void register_cpuidle_idle_function(void)
> > +{
> > +	register_idle_function(&cpuidle_idle_desc);
> > +
> > +	idle_function_registered = 1;
> 
> Use booleans if possible, unless you intend to extend the meaning of
> registered someday.
> 
> > +}
> >  /**
> >   * cpuidle_register_device - registers a CPU's idle PM feature
> >   * @dev: the cpu
> > @@ -303,7 +286,9 @@ int cpuidle_register_device(struct cpuid
> >  	}
> > 
> >  	cpuidle_enable_device(dev);
> > -	cpuidle_install_idle_handler();
> > +
> > +	if (!idle_function_registered)
> > +		register_cpuidle_idle_function();
> > 
> >  	mutex_unlock(&cpuidle_lock);
> > 
> > @@ -382,8 +367,6 @@ static int __init cpuidle_init(void)
> >  {
> >  	int ret;
> > 
> > -	pm_idle_old = pm_idle;
> > -
> >  	ret = cpuidle_add_class_sysfs(&cpu_sysdev_class);
> >  	if (ret)
> >  		return ret;
> > Index: linux.trees.git/drivers/cpuidle/governor.c
> > ===================================================================
> > --- linux.trees.git.orig/drivers/cpuidle/governor.c
> > +++ linux.trees.git/drivers/cpuidle/governor.c
> > @@ -48,8 +48,6 @@ int cpuidle_switch_governor(struct cpuid
> >  	if (gov == cpuidle_curr_governor)
> >  		return 0;
> > 
> > -	cpuidle_uninstall_idle_handler();
> > -
> >  	if (cpuidle_curr_governor) {
> >  		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> >  			cpuidle_disable_device(dev);
> > @@ -63,7 +61,6 @@ int cpuidle_switch_governor(struct cpuid
> >  			return -EINVAL;
> >  		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> >  			cpuidle_enable_device(dev);
> > -		cpuidle_install_idle_handler();
> >  		printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
> >  	}
> > 
> 
> -- 
> 	Balbir
