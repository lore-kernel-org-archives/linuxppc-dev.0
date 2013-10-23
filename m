Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8930C2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 15:24:51 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 23 Oct 2013 09:54:47 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D1CCDE0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 09:56:16 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9N4RaCe32243798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 09:57:37 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9N4Oh7F001172
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 09:54:44 +0530
Message-ID: <52674EE0.9070103@linux.vnet.ibm.com>
Date: Wed, 23 Oct 2013 09:51:52 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] sched: Fix nohz_kick_needed to consider the nr_busy
 of the parent domain's group
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114442.13291.99344.stgit@drishya>
 <20131022221138.GJ2490@laptop.programming.kicks-ass.net>
 <526749EC.9030005@linux.vnet.ibm.com>
In-Reply-To: <526749EC.9030005@linux.vnet.ibm.com>
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

On 10/23/2013 09:30 AM, Preeti U Murthy wrote:
> Hi Peter,
> 
> On 10/23/2013 03:41 AM, Peter Zijlstra wrote:
>> On Mon, Oct 21, 2013 at 05:14:42PM +0530, Vaidyanathan Srinivasan wrote:
>>>  kernel/sched/fair.c |   19 +++++++++++++------
>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 7c70201..12f0eab 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5807,12 +5807,19 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
>>>  
>>>  	rcu_read_lock();
>>>  	for_each_domain(cpu, sd) {
>>> +		struct sched_domain *sd_parent = sd->parent;
>>> +		struct sched_group *sg;
>>> +		struct sched_group_power *sgp;
>>> +		int nr_busy;
>>> +
>>> +		if (sd_parent) {
>>> +			sg = sd_parent->groups;
>>> +			sgp = sg->sgp;
>>> +			nr_busy = atomic_read(&sgp->nr_busy_cpus);
>>> +
>>> +			if (sd->flags & SD_SHARE_PKG_RESOURCES && nr_busy > 1)
>>> +				goto need_kick_unlock;
>>> +		}
>>>  
>>>  		if (sd->flags & SD_ASYM_PACKING && nr_busy != sg->group_weight
>>>  		    && (cpumask_first_and(nohz.idle_cpus_mask,
>>>
>>
>> Almost I'd say; what happens on !sd_parent && SD_ASYM_PACKING ?
> 
> You are right, sorry about this. The idea was to correct the nr_busy
> computation before the patch that would remove its usage in the second
> patch. But that would mean the condition nr_busy != sg->group_weight
> would be invalid with this patch. The second patch needs to go first to
> avoid this confusion.
> 
>>
>> Also, this made me look at the nr_busy stuff again, and somehow that
>> entire thing makes me a little sad.
>>
>> Can't we do something like the below and cut that nr_busy sd iteration
>> short?
> 
> We can surely cut the nr_busy sd iteration but not like what is done
> with this patch. You stop the nr_busy computation at the sched domain
> that has the flag SD_SHARE_PKG_RESOURCES set. But nohz_kick_needed()
> would want to know the nr_busy for one level above this.
>    Consider a core. Assume it is the highest domain with this flag set.
> The nr_busy of its groups, which are logical threads are set to 1/0
> each. But nohz_kick_needed() would like to know the sum of the nr_busy
> parameter of all the groups, i.e. the threads in a core before it
> decides if it can kick nohz_idle balancing. The information about the
> individual group's nr_busy is of no relevance here.
> 
> Thats why the above patch tries to get the
> sd->parent->groups->sgp->nr_busy_cpus. This will translate rightly to
> the core's busy cpus in this example. But the below patch stops before
> updating this parameter at the sd->parent level, where sd is the highest
> level sched domain with the SD_SHARE_PKG_RESOURCES flag set.
> 
> But we can get around all this confusion if we can move the nr_busy
> parameter to be included in the sched_domain structure rather than the
> sched_groups_power structure. Anyway the only place where nr_busy is
> used, that is at nohz_kick_needed(), is done to know the total number of
> busy cpus at a sched domain level which has the SD_SHARE_PKG_RESOURCES
> set and not at a sched group level.
> 
> So why not move nr_busy to struct sched_domain  and having the below
> patch which just updates this parameter for the sched domain, sd_busy ?

Oh this can't be done :( Domain structures are per cpu!

Regards
Preeti U Murthy
