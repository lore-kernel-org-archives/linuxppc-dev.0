Return-Path: <michael.neuling@au1.ibm.com>
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] sched: Fix asymmetric scheduling for POWER7
In-reply-to: <20131021114452.13291.19947.stgit@drishya>
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114452.13291.19947.stgit@drishya>
Date: Tue, 22 Oct 2013 09:55:10 +1100
Message-ID: <21476.1382396110@ale.ozlabs.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Mike Galbraith <bitbucket@online.de>,
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

Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

> Asymmetric scheduling within a core is a scheduler loadbalancing
> feature that is triggered when SD_ASYM_PACKING flag is set.  The goal
> for the load balancer is to move tasks to lower order idle SMT threads
> within a core on a POWER7 system.
> 
> In nohz_kick_needed(), we intend to check if our sched domain (core)
> is completely busy or we have idle cpu.
> 
> The following check for SD_ASYM_PACKING:
> 
>     (cpumask_first_and(nohz.idle_cpus_mask, sched_domain_span(sd)) < cpu)
> 
> already covers the case of checking if the domain has an idle cpu,
> because cpumask_first_and() will not yield any set bits if this domain
> has no idle cpu.
> 
> Hence, nr_busy check against group weight can be removed.
> 
> Reported-by: Michael Neuling <michael.neuling@au1.ibm.com>

Tested-by: Michael Neuling <mikey@neuling.org>

Peter, I tested this only a brief while back but it turned out my test
wasn't stringent enough and it was actually broken (in v3.9).  This
fixes it.

Mikey

> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 12f0eab..828ed97 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5821,8 +5821,8 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
>  				goto need_kick_unlock;
>  		}
>  
> -		if (sd->flags & SD_ASYM_PACKING && nr_busy != sg->group_weight
> -		    && (cpumask_first_and(nohz.idle_cpus_mask,
> +		if (sd->flags & SD_ASYM_PACKING &&
> +			(cpumask_first_and(nohz.idle_cpus_mask,
>  					  sched_domain_span(sd)) < cpu))
>  			goto need_kick_unlock;
>  
> 
