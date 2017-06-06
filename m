Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whv3L2nRhzDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 00:20:13 +1000 (AEST)
Received: by mail-yw0-x244.google.com with SMTP id p144so9817807ywp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 07:20:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Jun 2017 10:20:09 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] workqueue: Fix edge cases for calc of pool's cpumask
Message-ID: <20170606142009.GA18318@htj.duckdns.org>
References: <735de0b9-13bb-e245-397c-2d12ca03f833@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <735de0b9-13bb-e245-397c-2d12ca03f833@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael.

It would have been better to continue debugging in the prev thread.
This still seems incorrect for the same reason as before.

On Tue, Jun 06, 2017 at 09:09:40AM -0500, Michael Bringmann wrote:
> On NUMA systems with dynamic processors, the content of the cpumask
> may change over time.  As new processors are added via DLPAR operations,
> workqueues are created for them.  Depending upon the order in which CPUs
> are added/removed, we may run into problems with the content of the
> cpumask used by the workqueues.  This patch deals with situations where
> the online cpumask for a node is a proper superset of possible cpumask
> for the node.  It also deals with edge cases where the order in which
> CPUs are removed/added from the online cpumask may leave the set for a
> node empty, and require execution by CPUs on another node.
> 
> In these and other cases, the patch attempts to ensure that a valid,
> usable cpumask is used to set up newly created pools for workqueues.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org> & Michael Bringmann <mwb@linux.vnet.ibm.com>

Heh, you can't add sob's for other people.  For partial attributions,
you can just note in the description.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c74bf39..460de61 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3366,6 +3366,9 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  	copy_workqueue_attrs(pool->attrs, attrs);
>  	pool->node = target_node;
>  
> +	if (!cpumask_weight(pool->attrs->cpumask))
> +		cpumask_copy(pool->attrs->cpumask, cpumask_of(smp_processor_id()));

So, this is still wrong.

>  	/*
>  	 * no_numa isn't a worker_pool attribute, always clear it.  See
>  	 * 'struct workqueue_attrs' comments for detail.
> @@ -3559,13 +3562,13 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
>   * stable.
>   *
>   * Return: %true if the resulting @cpumask is different from @attrs->cpumask,
> - * %false if equal.
> + * %false if equal.  On %false return, the content of @cpumask is undefined.
>   */
>  static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
>  				 int cpu_going_down, cpumask_t *cpumask)
>  {
>  	if (!wq_numa_enabled || attrs->no_numa)
> -		goto use_dfl;
> +		return false;
>  
>  	/* does @node have any online CPUs @attrs wants? */
>  	cpumask_and(cpumask, cpumask_of_node(node), attrs->cpumask);
> @@ -3573,15 +3576,13 @@ static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
>  		cpumask_clear_cpu(cpu_going_down, cpumask);
>  
>  	if (cpumask_empty(cpumask))
> -		goto use_dfl;
> +		return false;
>  
>  	/* yeap, return possible CPUs in @node that @attrs wants */
>  	cpumask_and(cpumask, attrs->cpumask, wq_numa_possible_cpumask[node]);
> -	return !cpumask_equal(cpumask, attrs->cpumask);
>  
> -use_dfl:
> -	cpumask_copy(cpumask, attrs->cpumask);
> -	return false;
> +	return !cpumask_empty(cpumask) &&
> +		!cpumask_equal(cpumask, attrs->cpumask);

And this part doesn't really change that.

CPUs going offline or online shouldn't change their relation to
wq_numa_possible_cpumask.  I wonder whether the arch code is changing
CPU id <-> NUMA node mapping on CPU on/offlining.  x86 used to do that
too and got recently modified.  Can you see whether that's the case?

Thanks.

-- 
tejun
