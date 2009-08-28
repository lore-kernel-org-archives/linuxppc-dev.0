Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4AC95B7BD3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 16:43:45 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7S6hXWw001128
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 12:13:33 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7S6hX2V1679396
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 12:13:33 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7S6hVlu021807
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 16:43:33 +1000
Date: Fri, 28 Aug 2009 12:13:30 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
Message-ID: <20090828064330.GB11863@linux.vnet.ibm.com>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
	<20090827115354.GC24986@linux.vnet.ibm.com>
	<1251377607.18584.96.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1251377607.18584.96.camel@twins>
Cc: Gautham R Shenoy <ego@in.ibm.com>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-08-27 14:53:27]:

> On Thu, 2009-08-27 at 17:23 +0530, Arun R Bharadwaj wrote:
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-08-27 17:19:08]:
> > 
> > Cpuidle infrastructure assumes pm_idle as the default idle routine.
> > But, ppc_md.power_save is the default idle callback in case of pSeries.
> > 
> > So, create a more generic, architecture independent cpuidle_pm_idle
> > function pointer in driver/cpuidle/cpuidle.c and allow the idle routines
> > of architectures to be set to cpuidle_pm_idle.
> > 
> > Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
> > ---
> >  drivers/cpuidle/cpuidle.c |   12 +++++++-----
> >  include/linux/cpuidle.h   |    7 +++++++
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > Index: linux.trees.git/drivers/cpuidle/cpuidle.c
> > ===================================================================
> > --- linux.trees.git.orig/drivers/cpuidle/cpuidle.c
> > +++ linux.trees.git/drivers/cpuidle/cpuidle.c
> > @@ -25,6 +25,7 @@ DEFINE_PER_CPU(struct cpuidle_device *, 
> >  DEFINE_MUTEX(cpuidle_lock);
> >  LIST_HEAD(cpuidle_detected_devices);
> >  static void (*pm_idle_old)(void);
> > +void (*cpuidle_pm_idle)(void);
> >  
> >  static int enabled_devices;
> >  
> > @@ -98,10 +99,10 @@ static void cpuidle_idle_call(void)
> >   */
> >  void cpuidle_install_idle_handler(void)
> >  {
> > -	if (enabled_devices && (pm_idle != cpuidle_idle_call)) {
> > +	if (enabled_devices && (cpuidle_pm_idle != cpuidle_idle_call)) {
> >  		/* Make sure all changes finished before we switch to new idle */
> >  		smp_wmb();
> > -		pm_idle = cpuidle_idle_call;
> > +		cpuidle_pm_idle = cpuidle_idle_call;
> >  	}
> >  }
> >  
> > @@ -110,8 +111,9 @@ void cpuidle_install_idle_handler(void)
> >   */
> >  void cpuidle_uninstall_idle_handler(void)
> >  {
> > -	if (enabled_devices && pm_idle_old && (pm_idle != pm_idle_old)) {
> > -		pm_idle = pm_idle_old;
> > +	if (enabled_devices && pm_idle_old &&
> > +			(cpuidle_pm_idle != pm_idle_old)) {
> > +		cpuidle_pm_idle = pm_idle_old;
> >  		cpuidle_kick_cpus();
> >  	}
> >  }
> > @@ -382,7 +384,7 @@ static int __init cpuidle_init(void)
> >  {
> >  	int ret;
> >  
> > -	pm_idle_old = pm_idle;
> > +	pm_idle_old = cpuidle_pm_idle;
> >  
> >  	ret = cpuidle_add_class_sysfs(&cpu_sysdev_class);
> >  	if (ret)
> > Index: linux.trees.git/include/linux/cpuidle.h
> > ===================================================================
> > --- linux.trees.git.orig/include/linux/cpuidle.h
> > +++ linux.trees.git/include/linux/cpuidle.h
> > @@ -188,4 +188,11 @@ static inline void cpuidle_unregister_go
> >  #define CPUIDLE_DRIVER_STATE_START	0
> >  #endif
> >  
> > +/*
> > + * Idle callback used by cpuidle to call the cpuidle_idle_call().
> > + * Platform drivers can use this to register to cpuidle's idle loop.
> > + */
> > +
> > +extern void (*cpuidle_pm_idle)(void);
> > +
> >  #endif /* _LINUX_CPUIDLE_H */
> 
> 
> I'm not quite seeing how this makes anything any better. Not we have 3
> function pointers, where 1 should suffice.
> 

Or, can we have something like:
(if exporting a function is ok, instead of exporting a function
pointer).

in drivers/cpuidle/cpuidle.c

void (*return_cpuidle_handler(void))(void)
{
        return cpuidle_pm_idle;
}
EXPORT_SYMBOL(return_cpuidle_handler);


and from pseries/processor_idle.c,

ppc_md.power_save = return_cpuidle_handler;


--arun

> /me wonders what's wrong with something like:
> 
> struct idle_func_desc {
> 	int		 power;
> 	int		 latency;
> 	void		 (*idle)(void);
> 	struct list_head list;
> };
> 
> static void spin_idle(void)
> {
> 	for (;;)
> 		cpu_relax();
> }
> 
> static idle_func_desc default_idle_func = {
> 	power = 0, 	   /* doesn't safe any power */
> 	latency = INT_MAX, /* has max latency */
> 	idle = spin_idle,
> 	list = INIT_LIST_HEAD(default_idle_func.list),
> };
> 
> void (*idle_func)(void);
> static struct list_head idle_func_list;
> 
> static void pick_idle_func(void)
> {
> 	struct idle_func_desc *desc, *idle = &default_idle_desc;
> 
> 	list_for_each_entry(desc, &idle_func_list, list) {
> 		if (desc->power < idle->power)
> 			continue;
> 		if (desc->latency > target_latency);
> 			continue;
> 		idle = desc;
> 	}
> 
> 	pm_idle = idle->idle;
> }
> 
> void register_idle_func(struct idle_func_desc *desc)
> {
> 	WARN_ON_ONCE(!list_empty(&desc->list));
> 
> 	list_add_tail(&idle_func_list, &desc->list);
> 	pick_idle_func();
> }
> 
> void unregister_idle_func(struct idle_func_desc *desc)
> {
> 	WARN_ON_ONCE(list_empty(&desc->list));
> 
> 	list_del_init(&desc->list);
> 	if (idle_func == desc->idle) 
> 		pick_idle_func();
> }
> 
