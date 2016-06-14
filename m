Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTS1K06xvzDqZW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 21:22:45 +1000 (AEST)
Date: Tue, 14 Jun 2016 13:22:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Message-ID: <20160614112234.GF30154@twins.programming.kicks-ass.net>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 07, 2016 at 08:44:03PM +0530, Gautham R. Shenoy wrote:

I'm still puzzled why we don't see this on x86. Afaict there's nothing
PPC specific about this.

> This patch sets the affinity of the worker to
> a) the only online CPU in the cpumask of the worker pool when it comes
>    online.
> b) the cpumask of the worker pool when the second CPU in the pool's
>    cpumask comes online.

This basically works around the WARN conditions, which I suppose is fair
enough, but I would like a note here to revisit this once the whole cpu
hotplug rework has settled.

The real problem is that workqueues seem to want to create worker
threads before there's anybody who would use them or something like
that.

Or is that what PPC does funny? Use an unbound workqueue this early in
cpu bringup?

> @@ -4600,15 +4600,26 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
>  	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
>  		return;
>  
> -	/* is @cpu the only online CPU? */
>  	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
> -	if (cpumask_weight(&cpumask) != 1)
> +
> +	/*
> +	 * The affinity needs to be set
> +	 * a) to @cpu when that is the only online CPU in
> +	 *    pool->attrs->cpumask.
> +	 * b) to pool->attrs->cpumask when exactly two CPUs in
> +	 *    pool->attrs->cpumask are online. This affinity will be
> +	 *    retained when subsequent CPUs come online.
> +	 */
> +	if (cpumask_weight(&cpumask) > 2)
>  		return;
>  
> +	if (cpumask_weight(&cpumask) == 2)
> +		cpumask_copy(&cpumask, pool->attrs->cpumask);
> +
>  	/* as we're called from CPU_ONLINE, the following shouldn't fail */
>  	for_each_pool_worker(worker, pool)
>  		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> -						  pool->attrs->cpumask) < 0);
> +						  &cpumask) < 0);
>  }
