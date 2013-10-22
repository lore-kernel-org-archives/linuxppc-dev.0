Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 80A852C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 09:18:17 +1100 (EST)
Date: Wed, 23 Oct 2013 00:18:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] sched: Fix asymmetric scheduling for POWER7
Message-ID: <20131022221808.GK2490@laptop.programming.kicks-ass.net>
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114452.13291.19947.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131021114452.13291.19947.stgit@drishya>
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

On Mon, Oct 21, 2013 at 05:14:52PM +0530, Vaidyanathan Srinivasan wrote:
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

Ahh, so here you remove the nr_busy usage.. this patch should really go
before the first one that makes this all weird and funny.
