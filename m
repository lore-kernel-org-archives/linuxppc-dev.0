Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF4A42C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 14:34:11 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 13:34:09 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 065502CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 14:34:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9T3GV7m7471502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 14:16:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9T3XxhB031581
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 14:34:00 +1100
Message-ID: <526F2BEC.3040207@linux.vnet.ibm.com>
Date: Tue, 29 Oct 2013 09:00:52 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] sched: Fix nohz_kick_needed to consider the nr_busy
 of the parent domain's group
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114442.13291.99344.stgit@drishya>
 <20131022221138.GJ2490@laptop.programming.kicks-ass.net>
 <52679BD6.6090507@linux.vnet.ibm.com>
 <CAKfTPtAUFdmc7PasebNksYztMwRrWsGWPgN6JJJurddu+UP-hQ@mail.gmail.com>
 <5268D54A.9060604@linux.vnet.ibm.com> <20131028135043.GP19466@laptop.lan>
In-Reply-To: <20131028135043.GP19466@laptop.lan>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Mike Galbraith <bitbucket@online.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
 Paul Turner <pjt@google.com>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On 10/28/2013 07:20 PM, Peter Zijlstra wrote:
> On Thu, Oct 24, 2013 at 01:37:38PM +0530, Preeti U Murthy wrote:
>>  kernel/sched/core.c  |    5 +++++
>>  kernel/sched/fair.c  |   38 ++++++++++++++++++++------------------
>>  kernel/sched/sched.h |    1 +
>>  3 files changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c06b8d3..c540392 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5271,6 +5271,7 @@ DEFINE_PER_CPU(struct sched_domain *, sd_llc);
>>  DEFINE_PER_CPU(int, sd_llc_size);
>>  DEFINE_PER_CPU(int, sd_llc_id);
>>  DEFINE_PER_CPU(struct sched_domain *, sd_numa);
>> +DEFINE_PER_CPU(struct sched_domain *, sd_busy);
>>  
>>  static void update_top_cache_domain(int cpu)
>>  {
>> @@ -5290,6 +5291,10 @@ static void update_top_cache_domain(int cpu)
>>  
>>  	sd = lowest_flag_domain(cpu, SD_NUMA);
>>  	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>> +
>> +	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
>> +	if (sd)
>> +		rcu_assign_pointer(per_cpu(sd_busy, cpu), sd->parent);
>>  }
>>  
>>  /*
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e9c9549..f66cfd9 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6515,16 +6515,16 @@ static inline void nohz_balance_exit_idle(int cpu)
>>  static inline void set_cpu_sd_state_busy(void)
>>  {
>>  	struct sched_domain *sd;
>> +	int cpu = smp_processor_id();
>>  
>>  	rcu_read_lock();
>> +	sd = rcu_dereference(per_cpu(sd_busy, cpu));
>>  
>>  	if (!sd || !sd->nohz_idle)
>>  		goto unlock;
>>  	sd->nohz_idle = 0;
>>  
>> +	atomic_inc(&sd->groups->sgp->nr_busy_cpus);
>>  unlock:
>>  	rcu_read_unlock();
>>  }
>> @@ -6532,16 +6532,16 @@ unlock:
>>  void set_cpu_sd_state_idle(void)
>>  {
>>  	struct sched_domain *sd;
>> +	int cpu = smp_processor_id();
>>  
>>  	rcu_read_lock();
>> +	sd = rcu_dereference(per_cpu(sd_busy, cpu));
>>  
>>  	if (!sd || sd->nohz_idle)
>>  		goto unlock;
>>  	sd->nohz_idle = 1;
>>  
>> +	atomic_dec(&sd->groups->sgp->nr_busy_cpus);
>>  unlock:
>>  	rcu_read_unlock();
>>  }
> 
> Oh nice, that gets rid of the multiple atomics, and it nicely splits
> this nohz logic into per topology groups -- now if only we could split
> the rest too :-)

I am sorry, I don't get you here. By the 'rest', do you refer to
nohz_kick_needed() as below? Or am I missing something?

> 
>> @@ -6748,6 +6748,8 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
>>  {
>>  	unsigned long now = jiffies;
>>  	struct sched_domain *sd;
>> +	struct sched_group_power *sgp;
>> +	int nr_busy;
>>  
>>  	if (unlikely(idle_cpu(cpu)))
>>  		return 0;
>> @@ -6773,22 +6775,22 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
>>  		goto need_kick;
>>  
>>  	rcu_read_lock();
>> +	sd = rcu_dereference(per_cpu(sd_busy, cpu));
>>  
>> +	if (sd) {
>> +		sgp = sd->groups->sgp;
>> +		nr_busy = atomic_read(&sgp->nr_busy_cpus);
>>  
>> +		if (nr_busy > 1)
>>  			goto need_kick_unlock;
>>  	}
> 
> OK, so far so good.
> 
>> +
>> +	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
>> +
>> +	if (sd && (cpumask_first_and(nohz.idle_cpus_mask,
>> +				  sched_domain_span(sd)) < cpu))
>> +		goto need_kick_unlock;
>> +
>>  	rcu_read_unlock();
>>  	return 0;
> 
> This again is a bit sad; most archs will not have SD_ASYM_PACKING set at
> all; this means that they all will do a complete (and pointless) sched
> domain tree walk here.

There will not be a 'complete' sched domain tree walk right? The
iteration will break at the first level of the sched domain for those
archs which do not have SD_ASYM_PACKING set at all.

But it is true that doing a sched domain tree walk regularly is a bad
idea, might as well update the domain with SD_ASYM_PACKING flag set once
and query this domain when required.

I will send out the patch with sd_asym domain introduced rather than the
above.

Thanks

Regards
Preeti U Murthy

> 
> It would be much better to also introduce sd_asym and do the analogous
> thing to the new sd_busy.
> 
