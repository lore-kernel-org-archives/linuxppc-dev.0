Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 947162C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 15:03:55 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 23 Oct 2013 14:03:54 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 80FBC2BB0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 15:03:46 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9N3kNjX8585588
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 14:46:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9N43ixC021710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 15:03:45 +1100
Message-ID: <526749EC.9030005@linux.vnet.ibm.com>
Date: Wed, 23 Oct 2013 09:30:44 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] sched: Fix nohz_kick_needed to consider the nr_busy
 of the parent domain's group
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114442.13291.99344.stgit@drishya>
 <20131022221138.GJ2490@laptop.programming.kicks-ass.net>
In-Reply-To: <20131022221138.GJ2490@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, Mike Galbraith <bitbucket@online.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, Paul Turner <pjt@google.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On 10/23/2013 03:41 AM, Peter Zijlstra wrote:
> On Mon, Oct 21, 2013 at 05:14:42PM +0530, Vaidyanathan Srinivasan wrote:
>>  kernel/sched/fair.c |   19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7c70201..12f0eab 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5807,12 +5807,19 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
>>  
>>  	rcu_read_lock();
>>  	for_each_domain(cpu, sd) {
>> +		struct sched_domain *sd_parent = sd->parent;
>> +		struct sched_group *sg;
>> +		struct sched_group_power *sgp;
>> +		int nr_busy;
>> +
>> +		if (sd_parent) {
>> +			sg = sd_parent->groups;
>> +			sgp = sg->sgp;
>> +			nr_busy = atomic_read(&sgp->nr_busy_cpus);
>> +
>> +			if (sd->flags & SD_SHARE_PKG_RESOURCES && nr_busy > 1)
>> +				goto need_kick_unlock;
>> +		}
>>  
>>  		if (sd->flags & SD_ASYM_PACKING && nr_busy != sg->group_weight
>>  		    && (cpumask_first_and(nohz.idle_cpus_mask,
>>
> 
> Almost I'd say; what happens on !sd_parent && SD_ASYM_PACKING ?

You are right, sorry about this. The idea was to correct the nr_busy
computation before the patch that would remove its usage in the second
patch. But that would mean the condition nr_busy != sg->group_weight
would be invalid with this patch. The second patch needs to go first to
avoid this confusion.

> 
> Also, this made me look at the nr_busy stuff again, and somehow that
> entire thing makes me a little sad.
> 
> Can't we do something like the below and cut that nr_busy sd iteration
> short?

We can surely cut the nr_busy sd iteration but not like what is done
with this patch. You stop the nr_busy computation at the sched domain
that has the flag SD_SHARE_PKG_RESOURCES set. But nohz_kick_needed()
would want to know the nr_busy for one level above this.
   Consider a core. Assume it is the highest domain with this flag set.
The nr_busy of its groups, which are logical threads are set to 1/0
each. But nohz_kick_needed() would like to know the sum of the nr_busy
parameter of all the groups, i.e. the threads in a core before it
decides if it can kick nohz_idle balancing. The information about the
individual group's nr_busy is of no relevance here.

Thats why the above patch tries to get the
sd->parent->groups->sgp->nr_busy_cpus. This will translate rightly to
the core's busy cpus in this example. But the below patch stops before
updating this parameter at the sd->parent level, where sd is the highest
level sched domain with the SD_SHARE_PKG_RESOURCES flag set.

But we can get around all this confusion if we can move the nr_busy
parameter to be included in the sched_domain structure rather than the
sched_groups_power structure. Anyway the only place where nr_busy is
used, that is at nohz_kick_needed(), is done to know the total number of
busy cpus at a sched domain level which has the SD_SHARE_PKG_RESOURCES
set and not at a sched group level.

So why not move nr_busy to struct sched_domain  and having the below
patch which just updates this parameter for the sched domain, sd_busy ?
This will avoid iterating through all the levels of sched domains and
should resolve the scalability issue. We also don't need to get to
sd->parent to get the nr_busy parameter for the sake of nohz_kick_needed().

What do you think?

Regards
Preeti U Murthy
> 
> This nohz stuff really needs to be re-thought and made more scalable --
> its a royal pain :/
> 
> 
>  kernel/sched/core.c  |  4 ++++
>  kernel/sched/fair.c  | 21 +++++++++++++++------
>  kernel/sched/sched.h |  5 ++---
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c06b8d3..89db8dc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5271,6 +5271,7 @@ DEFINE_PER_CPU(struct sched_domain *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
>  DEFINE_PER_CPU(struct sched_domain *, sd_numa);
> +DEFINE_PER_CPU(struct sched_domain *, sd_busy);
> 
>  static void update_top_cache_domain(int cpu)
>  {
> @@ -5290,6 +5291,9 @@ static void update_top_cache_domain(int cpu)
> 
>  	sd = lowest_flag_domain(cpu, SD_NUMA);
>  	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
> +
> +	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING);
> +	rcu_assign_pointer(per_cpu(sd_busy, cpu), sd);
>  }
> 
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 813dd61..3d5141e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6512,19 +6512,23 @@ static inline void nohz_balance_exit_idle(int cpu)
>  	}
>  }
> 
> -static inline void set_cpu_sd_state_busy(void)
> +static inline void set_cpu_sd_state_busy(int cpu)
>  {
>  	struct sched_domain *sd;
> +	struct rq *rq = cpu_rq(cpu);
> 
>  	rcu_read_lock();
> -	sd = rcu_dereference_check_sched_domain(this_rq()->sd);
> +	sd = rcu_dereference_check_sched_domain(rq->sd);
> 
>  	if (!sd || !sd->nohz_idle)
>  		goto unlock;
>  	sd->nohz_idle = 0;
> 
> -	for (; sd; sd = sd->parent)
> +	for (; sd; sd = sd->parent) {
>  		atomic_inc(&sd->groups->sgp->nr_busy_cpus);
> +		if (sd == per_cpu(sd_busy, cpu))
> +			break;
> +	}
>  unlock:
>  	rcu_read_unlock();
>  }
> @@ -6532,16 +6536,21 @@ static inline void set_cpu_sd_state_busy(void)
>  void set_cpu_sd_state_idle(void)
>  {
>  	struct sched_domain *sd;
> +	int cpu = smp_processor_id();
> +	struct rq *rq = cpu_rq(cpu);
> 
>  	rcu_read_lock();
> -	sd = rcu_dereference_check_sched_domain(this_rq()->sd);
> +	sd = rcu_dereference_check_sched_domain(rq->sd);
> 
>  	if (!sd || sd->nohz_idle)
>  		goto unlock;
>  	sd->nohz_idle = 1;
> 
> -	for (; sd; sd = sd->parent)
> +	for (; sd; sd = sd->parent) {
>  		atomic_dec(&sd->groups->sgp->nr_busy_cpus);
> +		if (sd == per_cpu(sd_busy, cpu))
> +			break;
> +	}
>  unlock:
>  	rcu_read_unlock();
>  }
> @@ -6756,7 +6765,7 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
>  	* We may be recently in ticked or tickless idle mode. At the first
>  	* busy tick after returning from idle, we will update the busy stats.
>  	*/
> -	set_cpu_sd_state_busy();
> +	set_cpu_sd_state_busy(cpu);
>  	nohz_balance_exit_idle(cpu);
> 
>  	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ffc7087..80c5fd2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -599,9 +599,8 @@ static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
>  	struct sched_domain *sd, *hsd = NULL;
> 
>  	for_each_domain(cpu, sd) {
> -		if (!(sd->flags & flag))
> -			break;
> -		hsd = sd;
> +		if (sd->flags & flag)
> +			hsd = sd;
>  	}
> 
>  	return hsd;
> 
