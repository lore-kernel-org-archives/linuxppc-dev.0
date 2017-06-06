Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whvSF0CMvzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 00:38:21 +1000 (AEST)
Received: by mail-yw0-x244.google.com with SMTP id p144so9841998ywp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 07:38:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Jun 2017 10:38:16 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] workqueue: Fix edge cases for calc of pool's cpumask
Message-ID: <20170606143816.GC18318@htj.duckdns.org>
References: <735de0b9-13bb-e245-397c-2d12ca03f833@linux.vnet.ibm.com>
 <20170606142009.GA18318@htj.duckdns.org>
 <a6fbf0fe-e6a4-dd99-f329-614a6de99555@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a6fbf0fe-e6a4-dd99-f329-614a6de99555@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Tue, Jun 06, 2017 at 09:34:05AM -0500, Michael Bringmann wrote:
> >> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> >> index c74bf39..460de61 100644
> >> --- a/kernel/workqueue.c
> >> +++ b/kernel/workqueue.c
> >> @@ -3366,6 +3366,9 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
> >>  	copy_workqueue_attrs(pool->attrs, attrs);
> >>  	pool->node = target_node;
> >>  
> >> +	if (!cpumask_weight(pool->attrs->cpumask))
> >> +		cpumask_copy(pool->attrs->cpumask, cpumask_of(smp_processor_id()));
> > 
> > So, this is still wrong.
> 
> It only catches if something has gone wrong before.  The alternative in this case
> would be,
> 
> 	BUG(!cpumask_weight(pool->attrs->cpumask));

I'm kinda confused, so the hotplug problems you see across hotplugs go
away without the above change and the above is "just in case"?

> >> @@ -3559,13 +3562,13 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
> >>   * stable.
> >>   *
> >>   * Return: %true if the resulting @cpumask is different from @attrs->cpumask,
> >> - * %false if equal.
> >> + * %false if equal.  On %false return, the content of @cpumask is undefined.
> >>   */
> >>  static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
> >>  				 int cpu_going_down, cpumask_t *cpumask)
> >>  {
> >>  	if (!wq_numa_enabled || attrs->no_numa)
> >> -		goto use_dfl;
> >> +		return false;
> >>  
> >>  	/* does @node have any online CPUs @attrs wants? */
> >>  	cpumask_and(cpumask, cpumask_of_node(node), attrs->cpumask);
> >> @@ -3573,15 +3576,13 @@ static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
> >>  		cpumask_clear_cpu(cpu_going_down, cpumask);
> >>  
> >>  	if (cpumask_empty(cpumask))
> >> -		goto use_dfl;
> >> +		return false;
> >>  
> >>  	/* yeap, return possible CPUs in @node that @attrs wants */
> >>  	cpumask_and(cpumask, attrs->cpumask, wq_numa_possible_cpumask[node]);
> >> -	return !cpumask_equal(cpumask, attrs->cpumask);
> >>  
> >> -use_dfl:
> >> -	cpumask_copy(cpumask, attrs->cpumask);
> >> -	return false;
> >> +	return !cpumask_empty(cpumask) &&
> >> +		!cpumask_equal(cpumask, attrs->cpumask);
> > 
> > And this part doesn't really change that.
> > 
> > CPUs going offline or online shouldn't change their relation to
> > wq_numa_possible_cpumask.  I wonder whether the arch code is changing
> > CPU id <-> NUMA node mapping on CPU on/offlining.  x86 used to do that
> > too and got recently modified.  Can you see whether that's the case?
> 
> The but that I see does not appear to be related to changing of CPU/Node mapping
> -- they are not changing their place when going offline/online.  Rather new CPUs
> are being hot-added to the system (i.e. they were not present at boot), and the
> node to which they are being added had no CPUs at boot.

Can you please post the messages with the debug patch from the prev
thread?  In fact, let's please continue on that thread.  I'm having a
hard time following what's going wrong with the code.

Thanks.

-- 
tejun
