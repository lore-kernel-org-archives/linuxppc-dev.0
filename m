Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BF892C0119
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:22:43 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 25 Oct 2013 23:22:37 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E94EC2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:22:28 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9PD5D1p7864814
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:05:13 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9PDMR8N031649
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:22:28 +1100
Message-ID: <526A6FDD.8030501@linux.vnet.ibm.com>
Date: Fri, 25 Oct 2013 18:49:25 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] sched: Aggressive balance in domains whose groups
 share package resources
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114502.13291.60794.stgit@drishya>
 <20131022222326.GL2490@laptop.programming.kicks-ass.net>
In-Reply-To: <20131022222326.GL2490@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, Mike Galbraith <bitbucket@online.de>,
 Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
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

On 10/23/2013 03:53 AM, Peter Zijlstra wrote:
> On Mon, Oct 21, 2013 at 05:15:02PM +0530, Vaidyanathan Srinivasan wrote:
>>  kernel/sched/fair.c |   18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 828ed97..bbcd96b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5165,6 +5165,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>  {
>>  	int ld_moved, cur_ld_moved, active_balance = 0;
>>  	struct sched_group *group;
>> +	struct sched_domain *child;
>> +	int share_pkg_res = 0;
>>  	struct rq *busiest;
>>  	unsigned long flags;
>>  	struct cpumask *cpus = __get_cpu_var(load_balance_mask);
>> @@ -5190,6 +5192,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>  
>>  	schedstat_inc(sd, lb_count[idle]);
>>  
>> +	child = sd->child;
>> +	if (child && child->flags & SD_SHARE_PKG_RESOURCES)
>> +		share_pkg_res = 1;
>> +
>>  redo:
>>  	if (!should_we_balance(&env)) {
>>  		*continue_balancing = 0;
>> @@ -5202,6 +5208,7 @@ redo:
>>  		goto out_balanced;
>>  	}
>>  
>> +redo_grp:
>>  	busiest = find_busiest_queue(&env, group);
>>  	if (!busiest) {
>>  		schedstat_inc(sd, lb_nobusyq[idle]);
>> @@ -5292,6 +5299,11 @@ more_balance:
>>  			if (!cpumask_empty(cpus)) {
>>  				env.loop = 0;
>>  				env.loop_break = sched_nr_migrate_break;
>> +				if (share_pkg_res &&
>> +					cpumask_intersects(cpus,
>> +						to_cpumask(group->cpumask)))
> 
> sched_group_cpus()
> 
>> +					goto redo_grp;
>> +
>>  				goto redo;
>>  			}
>>  			goto out_balanced;
>> @@ -5318,9 +5330,15 @@ more_balance:
>>  			 */
>>  			if (!cpumask_test_cpu(this_cpu,
>>  					tsk_cpus_allowed(busiest->curr))) {
>> +				cpumask_clear_cpu(cpu_of(busiest), cpus);
>>  				raw_spin_unlock_irqrestore(&busiest->lock,
>>  							    flags);
>>  				env.flags |= LBF_ALL_PINNED;
>> +				if (share_pkg_res &&
>> +					cpumask_intersects(cpus,
>> +						to_cpumask(group->cpumask)))
>> +					goto redo_grp;
>> +
>>  				goto out_one_pinned;
>>  			}
> 
> Man this retry logic is getting annoying.. isn't there anything saner we
> can do?

Maybe we can do this just at the SIBLINGS level? Having the hyper
threads busy due to the scenario described in the changelog is bad for
performance.

Regards
Preeti U Murthy
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
