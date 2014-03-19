Return-Path: <ego@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 264652C00A0
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2014 22:02:51 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 19 Mar 2014 05:02:49 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9241B1FF003B
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2014 05:02:46 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2JB242s3080592
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2014 12:02:04 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2JB2jAL027151
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2014 05:02:45 -0600
Date: Wed, 19 Mar 2014 16:32:40 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/6] powernv:cpufreq: Create a
 powernv_cpu_to_core_mask() helper.
Message-ID: <20140319110240.GA25685@in.ibm.com>
References: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
 <1394449861-8688-3-git-send-email-ego@linux.vnet.ibm.com>
 <1395185847.30666.22.camel@pasglop>
 <53293AA8.2040609@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53293AA8.2040609@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2014 at 12:05:20PM +0530, Srivatsa S. Bhat wrote:
> On 03/19/2014 05:07 AM, Benjamin Herrenschmidt wrote:
> > On Mon, 2014-03-10 at 16:40 +0530, Gautham R. Shenoy wrote:
> >> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> >>
> >> Create a helper method that computes the cpumask corresponding to the
> >> thread-siblings of a cpu. Use this for initializing the policy->cpus
> >> mask for a given cpu.
> >>
> >> (Original code written by Srivatsa S. Bhat. Gautham moved this to a
> >> helper function!)
> > 
> > How does that differ from the existing entry in the sibling map  which
> > you can obtain with the helper cpu_sibling_mask() ? (You probably want
> > to *copy* the mask of course but I don't see the need of re-creating
> > one from scratch).
> >
> 
> The intent here was to have a sibling mask that is invariant of CPU
> hotplug. cpu_sibling_mask is updated on every hotplug operation, and this
> would break cpufreq, since policy->cpus has to be hotplug invariant.
> 
> This should have been noted in the changelog of patch 1 as well as this
> patch. (The earlier (internal) versions of this patchset had the
> description in the changelogs, but somehow it got dropped accidentally).
> I'll work with Gautham and ensure that we have this important info
> included in the changelog. Thanks for pointing it out!

I reused that part of the code because I was unaware of
cpu_sibling_mask()!

For implementing powernv_cpufreq_get(), cpu_sibling_mask() suffices
since we are using this mask as a parameter to
smp_call_function_any(), and hence are concerned only about the online
siblings. 

I shall fix the changelog to reflect Srivatsa's reason for having a
mask that does not vary with cpu-hotplug.

> 
> Regards,
> Srivatsa S. Bhat
> 
> 
> > Also, this should have been CCed to the cpufreq mailing list and maybe
> > the relevant maintainer too.

Ok. Will do it in the subsequent version. 

Thanks for the review!

> > 
> > Cheers,
> > Ben.
> > 
> >> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> >> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> >> ---
> >>  drivers/cpufreq/powernv-cpufreq.c | 24 ++++++++++++++++++------
> >>  1 file changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> >> index ab1551f..4cad727 100644
> >> --- a/drivers/cpufreq/powernv-cpufreq.c
> >> +++ b/drivers/cpufreq/powernv-cpufreq.c
> >> @@ -115,6 +115,23 @@ static struct freq_attr *powernv_cpu_freq_attr[] = {
> >>  
> >>  /* Helper routines */
> >>  
> >> +/**
> >> + * Sets the bits corresponding to the thread-siblings of cpu in its core
> >> + * in 'cpus'.
> >> + */
> >> +static void powernv_cpu_to_core_mask(unsigned int cpu, cpumask_var_t cpus)
> >> +{
> >> +	int base, i;
> >> +
> >> +	base = cpu_first_thread_sibling(cpu);
> >> +
> >> +	for (i = 0; i < threads_per_core; i++) {
> >> +		cpumask_set_cpu(base + i, cpus);
> >> +	}
> >> +
> >> +	return;
> >> +}
> >> +
> >>  /* Access helpers to power mgt SPR */
> >>  
> >>  static inline unsigned long get_pmspr(unsigned long sprn)
> >> @@ -180,13 +197,8 @@ static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
> >>  
> >>  static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >>  {
> >> -	int base, i;
> >> -
> >>  #ifdef CONFIG_SMP
> >> -	base = cpu_first_thread_sibling(policy->cpu);
> >> -
> >> -	for (i = 0; i < threads_per_core; i++)
> >> -		cpumask_set_cpu(base + i, policy->cpus);
> >> +	powernv_cpu_to_core_mask(policy->cpu, policy->cpus);
> >>  #endif
> >>  	policy->cpuinfo.transition_latency = 25000;
> >>  
> > 
> > 
> 
