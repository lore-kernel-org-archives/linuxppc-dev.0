Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n5PD5KKdzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 23:21:36 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7ADJDqt043106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 09:21:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ks9wv4c8e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 09:21:33 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 10 Aug 2018 14:21:31 +0100
Date: Fri, 10 Aug 2018 06:21:26 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Bringmann <mbringm@us.ibm.com>,
 Manjunatha H R <manjuhr1@in.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/topology: Check at boot for topology updates
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533884198-20862-1-git-send-email-srikar@linux.vnet.ibm.com>
 <87bmaa8n2z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87bmaa8n2z.fsf@concordia.ellerman.id.au>
Message-Id: <20180810132126.GA42350@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2018-08-10 21:42:28]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> > index 16b077801a5f..70f2d2285ba7 100644
> > --- a/arch/powerpc/include/asm/topology.h
> > +++ b/arch/powerpc/include/asm/topology.h
> > @@ -113,6 +114,10 @@ static inline int timed_topology_update(int nsecs)
> >  {
> >  	return 0;
> >  }
> > +
> > +#ifdef CONFIG_SMP
> > +static inline void check_topology_updates(void) {}
> > +#endif
> 
> I realise that's only called from smp.c but it doesn't really need to be
> inside #ifdef CONFIG_SMP, it's harmless to have an empty version for
> SMP=n.
> 

I did that just to fix
https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/577//


> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 4794d6b4f4d2..2aa0ffd954c9 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1156,6 +1156,12 @@ void __init smp_cpus_done(unsigned int max_cpus)
> >  	if (smp_ops && smp_ops->bringup_done)
> >  		smp_ops->bringup_done();
> >  
> > +	/*
> > +	 * On a shared LPAR, associativity needs to be requested.
> > +	 * Hence, check for numa topology updates before dumping
> > +	 * cpu topology
> > +	 */
> > +	check_topology_updates();
> 
> I get that you're calling it here because you want to get it correct
> before we do the dump below, but we could move the dump later also.
> 
> You mention we need to do the check before the sched domains are
> initialised, but where exactly does that happen?

Almost immediately after smp_cpus_done, 

kernel_init_freeable() calls smp_init() and sched_init_smp() back to
back.

smp_init() calls smp_cpus_done()
sched_init_smp() calls sched_init_numa() and sched_init_domains()

sched_init_numa() initialises sched_domains_numa_masks which is the
cpumask that matters the most in our discussions.
sched_init_domains initialised the sched_domain.

So I dont think we can move any later.

> 
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 0c7e05d89244..32c13a208589 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -1515,6 +1515,7 @@ int start_topology_update(void)
> >  		   lppaca_shared_proc(get_lppaca())) {
> >  		if (!vphn_enabled) {
> >  			vphn_enabled = 1;
> > +			topology_update_needed = 1;
> 
> I really don't understand what topology_update_needed is for.
> We set it here.

topology_update_needed is even set by numa_update_cpu_topology which
mighet get called from rtasd.

> 
> >  			setup_cpu_associativity_change_counters();
> >  			timer_setup(&topology_timer, topology_timer_fn,
> >  				    TIMER_DEFERRABLE);
> > @@ -1551,6 +1552,19 @@ int prrn_is_enabled(void)
> >  	return prrn_enabled;
> >  }
> >  
> > +void __init check_topology_updates(void)
> > +{
> > +	/* Do not poll for changes if disabled at boot */
> > +	if (topology_updates_enabled)
> > +		start_topology_update();
> 
> Here we call start_topology_update(), which might set
> topology_update_needed to 1.
> 
> > +
> > +	if (topology_update_needed) {
> 
> And then we check it here?
> Why is this logic not *in* start_topology_update() ?

I have split topology_update_init into two parts.  First part being
check_topology_update() and the next part being topology_update_init().

By the time the current topology_update_init() gets called,
sched_domains are already created. So we need to move this part before.

However the scheduled topology updates because of vphn can wait, atleast
that how the current code is written. topology_inited indicates if the
scheduled topology updates have been setup.

> 
> > +		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
> > +			    nr_cpumask_bits);
> > +		numa_update_cpu_topology(false);
> > +	}
> > +}
> 
> I'm not really clear on what check_topology_update() is responsible for
> doing vs topology_update_init(). Why do we need both?

I am okay to move the complete topology_update_init above and delete the
device_initcall. But then we would be moving the polling of vphn events
to a little bit earlier stage in the initialisation.

> 
> > @@ -1608,10 +1618,6 @@ static int topology_update_init(void)
> >  		return -ENOMEM;
> >  
> >  	topology_inited = 1;
> 
> What does that mean? Didn't we already do the init earlier?

If there is an explicit request for topology update via
numa_update_cpu_topology() even before we looked at the feature flags
and set vphn_enabled/prrn_enabled, then we would defer handle it till
the feature flags are checked. topology_inited helps us in achieving
this.

> 
> > -	if (topology_update_needed)
> > -		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
> > -					nr_cpumask_bits);
> > -
> >  	return 0;
> >  }
> >  device_initcall(topology_update_init);

Thanks for the review.

-- 
Thanks and Regards
Srikar
