Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 479072C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 09:23:37 +1100 (EST)
Date: Wed, 23 Oct 2013 00:23:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] sched: Aggressive balance in domains whose groups
 share package resources
Message-ID: <20131022222326.GL2490@laptop.programming.kicks-ass.net>
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114502.13291.60794.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131021114502.13291.60794.stgit@drishya>
Cc: Michael Neuling <mikey@neuling.org>, Mike Galbraith <bitbucket@online.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Paul Turner <pjt@google.com>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 21, 2013 at 05:15:02PM +0530, Vaidyanathan Srinivasan wrote:
>  kernel/sched/fair.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 828ed97..bbcd96b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5165,6 +5165,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  {
>  	int ld_moved, cur_ld_moved, active_balance = 0;
>  	struct sched_group *group;
> +	struct sched_domain *child;
> +	int share_pkg_res = 0;
>  	struct rq *busiest;
>  	unsigned long flags;
>  	struct cpumask *cpus = __get_cpu_var(load_balance_mask);
> @@ -5190,6 +5192,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  
>  	schedstat_inc(sd, lb_count[idle]);
>  
> +	child = sd->child;
> +	if (child && child->flags & SD_SHARE_PKG_RESOURCES)
> +		share_pkg_res = 1;
> +
>  redo:
>  	if (!should_we_balance(&env)) {
>  		*continue_balancing = 0;
> @@ -5202,6 +5208,7 @@ redo:
>  		goto out_balanced;
>  	}
>  
> +redo_grp:
>  	busiest = find_busiest_queue(&env, group);
>  	if (!busiest) {
>  		schedstat_inc(sd, lb_nobusyq[idle]);
> @@ -5292,6 +5299,11 @@ more_balance:
>  			if (!cpumask_empty(cpus)) {
>  				env.loop = 0;
>  				env.loop_break = sched_nr_migrate_break;
> +				if (share_pkg_res &&
> +					cpumask_intersects(cpus,
> +						to_cpumask(group->cpumask)))

sched_group_cpus()

> +					goto redo_grp;
> +
>  				goto redo;
>  			}
>  			goto out_balanced;
> @@ -5318,9 +5330,15 @@ more_balance:
>  			 */
>  			if (!cpumask_test_cpu(this_cpu,
>  					tsk_cpus_allowed(busiest->curr))) {
> +				cpumask_clear_cpu(cpu_of(busiest), cpus);
>  				raw_spin_unlock_irqrestore(&busiest->lock,
>  							    flags);
>  				env.flags |= LBF_ALL_PINNED;
> +				if (share_pkg_res &&
> +					cpumask_intersects(cpus,
> +						to_cpumask(group->cpumask)))
> +					goto redo_grp;
> +
>  				goto out_one_pinned;
>  			}

Man this retry logic is getting annoying.. isn't there anything saner we
can do?
