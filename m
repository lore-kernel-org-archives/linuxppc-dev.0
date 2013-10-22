Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A18D2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 01:36:32 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 23 Oct 2013 00:36:24 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 241433578055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 01:36:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9MEIwnc50856102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 01:18:58 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9MEa86b022001
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 01:36:10 +1100
Date: Tue, 22 Oct 2013 20:05:59 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] sched: Fix nohz_kick_needed to consider the nr_busy
 of the parent domain's group
Message-ID: <20131022143559.GA3197@linux.vnet.ibm.com>
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114442.13291.99344.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20131021114442.13291.99344.stgit@drishya>
Cc: Michael Neuling <mikey@neuling.org>, vincent.guittot@linaro.org,
 suresh.b.siddha@intel.com, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mike Galbraith <bitbucket@online.de>, Anton Blanchard <anton@samba.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
 Ingo Molnar <mingo@kernel.org>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> [2013-10-21 17:14:42]:

>  	for_each_domain(cpu, sd) {
> -		struct sched_group *sg = sd->groups;
> -		struct sched_group_power *sgp = sg->sgp;
> -		int nr_busy = atomic_read(&sgp->nr_busy_cpus);
> -
> -		if (sd->flags & SD_SHARE_PKG_RESOURCES && nr_busy > 1)
> -			goto need_kick_unlock;
> +		struct sched_domain *sd_parent = sd->parent;
> +		struct sched_group *sg;
> +		struct sched_group_power *sgp;
> +		int nr_busy;
> +
> +		if (sd_parent) {
> +			sg = sd_parent->groups;
> +			sgp = sg->sgp;
> +			nr_busy = atomic_read(&sgp->nr_busy_cpus);
> +
> +			if (sd->flags & SD_SHARE_PKG_RESOURCES && nr_busy > 1)
> +				goto need_kick_unlock;
> +		}
> 
>  		if (sd->flags & SD_ASYM_PACKING && nr_busy != sg->group_weight
>  		    && (cpumask_first_and(nohz.idle_cpus_mask,

CC'ing Suresh Siddha and Vincent Guittot

Please correct me, If my understanding of idle balancing is wrong.
With proposed approach will not idle load balancer kick in, even if
there are busy cpus across groups or if there are 2 busy cpus which
are spread across sockets.

Consider 2 socket machine with 4 processors each (MC and NUMA domains).
If the machine is partial loaded such that cpus 0,4,5,6,7 are busy, then too
nohz balancing is triggered because with this approach
(NUMA)->groups->sgp->nr_busy_cpus is taken in account for nohz kick, while
iterating over MC domain.

Isn't idle load balancer not suppose kick in, even in the case of two busy
cpu's in a dual-core single socket system.

Thanks,
Kamalesh.
