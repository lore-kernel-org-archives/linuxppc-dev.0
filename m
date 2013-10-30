Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DC862C016E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 20:23:24 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 30 Oct 2013 14:53:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3902EE0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 14:54:55 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9U9NCMD42598534
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 14:53:13 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9U9NE1C015126
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 14:53:15 +0530
Date: Wed, 30 Oct 2013 14:53:13 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/2] sched: Remove un-necessary iteration over sched
 domains to update nr_busy_cpus
Message-ID: <20131030092313.GA4196@linux.vnet.ibm.com>
References: <20131030031145.23426.22930.stgit@preeti.in.ibm.com>
 <20131030031252.23426.4417.stgit@preeti.in.ibm.com>
 <52707B02.7030100@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52707B02.7030100@linux.vnet.ibm.com>
Cc: mikey@neuling.org, vincent.guittot@linaro.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, Morten.Rasmussen@arm.com, bitbucket@online.de,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 pjt@google.com
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Preeti,

> nr_busy_cpus parameter is used by nohz_kick_needed() to find out the number
> of busy cpus in a sched domain which has SD_SHARE_PKG_RESOURCES flag set.
> Therefore instead of updating nr_busy_cpus at every level of sched domain,
> since it is irrelevant, we can update this parameter only at the parent
> domain of the sd which has this flag set. Introduce a per-cpu parameter
> sd_busy which represents this parent domain.
> 
> In nohz_kick_needed() we directly query the nr_busy_cpus parameter
> associated with the groups of sd_busy.
> 
> By associating sd_busy with the highest domain which has
> SD_SHARE_PKG_RESOURCES flag set, we cover all lower level domains which could
> have this flag set and trigger nohz_idle_balancing if any of the levels have
> more than one busy cpu.
> 
> sd_busy is irrelevant for asymmetric load balancing. However sd_asym has been
> introduced to represent the highest sched domain which has SD_ASYM_PACKING flag set
> so that it can be queried directly when required.
> 
> While we are at it, we might as well change the nohz_idle parameter to be
> updated at the sd_busy domain level alone and not the base domain level of a CPU.
> This will unify the concept of busy cpus at just one level of sched domain
> where it is currently used.
> 
> Signed-off-by: Preeti U Murthy<preeti@linux.vnet.ibm.com>
> ---
>  kernel/sched/core.c  |    6 ++++++
>  kernel/sched/fair.c  |   38 ++++++++++++++++++++------------------
>  kernel/sched/sched.h |    2 ++
>  3 files changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c06b8d3..e6a6244 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5271,6 +5271,8 @@ DEFINE_PER_CPU(struct sched_domain *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
>  DEFINE_PER_CPU(struct sched_domain *, sd_numa);
> +DEFINE_PER_CPU(struct sched_domain *, sd_busy);
> +DEFINE_PER_CPU(struct sched_domain *, sd_asym);
> 
>  static void update_top_cache_domain(int cpu)
>  {
> @@ -5282,6 +5284,7 @@ static void update_top_cache_domain(int cpu)
>  	if (sd) {
>  		id = cpumask_first(sched_domain_span(sd));
>  		size = cpumask_weight(sched_domain_span(sd));
> +		rcu_assign_pointer(per_cpu(sd_busy, cpu), sd->parent);
>  	}


consider a machine with single socket, dual core with HT enabled. The top most
domain is also the highest domain with SD_SHARE_PKG_RESOURCES flag set,
i.e MC domain (the machine toplogy consist of SIBLING and MC domain).

# lstopo-no-graphics --no-bridges --no-io
Machine (7869MB) + Socket L#0 + L3 L#0 (3072KB)
  L2 L#0 (256KB) + L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0
    PU L#0 (P#0)
    PU L#1 (P#1)
  L2 L#1 (256KB) + L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1
    PU L#2 (P#2)
    PU L#3 (P#3)

With this approach parent of MC domain is NULL and given that sd_busy is NULL,
nr_busy_cpus of sched domain sd_busy will never be incremented/decremented.
Resulting is nohz_kick_needed returning 0.

Thanks,
Kamalesh.
