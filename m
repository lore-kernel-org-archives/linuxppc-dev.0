Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syJ4C6VSMzDvJx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 23:51:39 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i85so9341800pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 05:51:39 -0700 (PDT)
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
To: Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
 <87eg3fcge5.fsf@concordia.ellerman.id.au>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <cdbc6901-9183-c2ff-1690-e909381c7956@gmail.com>
Date: Mon, 17 Oct 2016 23:51:30 +1100
MIME-Version: 1.0
In-Reply-To: <87eg3fcge5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/10/16 23:24, Michael Ellerman wrote:
> Tejun Heo <tj@kernel.org> writes:
> 
>> Hello, Michael.
>>
>> On Tue, Oct 11, 2016 at 10:22:13PM +1100, Michael Ellerman wrote:
>>> The oops happens because we're in enqueue_task_fair() and p->se->cfs_rq
>>> is NULL.
>>>
>>> The cfs_rq is NULL because we did set_task_rq(p, 2048), where 2048 is
>>> NR_CPUS. That causes us to index past the end of the tg->cfs_rq array in
>>> set_task_rq() and happen to get NULL.
>>>
>>> We never should have done set_task_rq(p, 2048), because 2048 is >=
>>> nr_cpu_ids, which means it's not a valid CPU number, and set_task_rq()
>>> doesn't cope with that.
>>
>> Hmm... it doesn't reproduce it here and can't see how the commit would
>> affect this given that it doesn't really change when the kworker
>> kthreads are being created.
> 
> It changes when the pool attributes are created, which is the source of
> the bug.
> 
> The original crash happens because we have a task with an empty cpus_allowed
> mask. That mask originally comes from pool->attrs->cpumask.
> 
> The attrs for the pool are created early via workqueue_init_early() in
> apply_wqattrs_prepare():
> 
>   start_here_common
>   -> start_kernel
>      -> workqueue_init_early
>         -> __alloc_workqueue_key
>            -> apply_workqueue_attrs
>               -> apply_workqueue_attrs_locked
>                  -> apply_wqattrs_prepare
> 	          
> In there we do:
> 
> 	copy_workqueue_attrs(new_attrs, attrs);
> 	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, wq_unbound_cpumask);
> 	if (unlikely(cpumask_empty(new_attrs->cpumask)))
> 		cpumask_copy(new_attrs->cpumask, wq_unbound_cpumask);
> 	...
> 	copy_workqueue_attrs(tmp_attrs, new_attrs);
> 	...
> 	for_each_node(node) {
> 		if (wq_calc_node_cpumask(new_attrs, node, -1, tmp_attrs->cpumask)) {
> +			BUG_ON(cpumask_empty(tmp_attrs->cpumask));
> 			ctx->pwq_tbl[node] = alloc_unbound_pwq(wq, tmp_attrs);
> 
> 
> The bad case (where we hit the BUG_ON I added above) is where we are
> creating a wq for node 1.
> 
> In wq_calc_node_cpumask() we do:
> 
> 	cpumask_and(cpumask, attrs->cpumask, wq_numa_possible_cpumask[node]);
> 	return !cpumask_equal(cpumask, attrs->cpumask);
> 
> Which with the arguments inserted is:
> 
> 	cpumask_and(tmp_attrs->cpumask, new_attrs->cpumask, wq_numa_possible_cpumask[1]);
> 	return !cpumask_equal(tmp_attrs->cpumask, new_attrs->cpumask);
> 
> And that results in tmp_attrs->cpumask being empty, because
> wq_numa_possible_cpumask[1] is an empty cpumask.
> 
> The reason wq_numa_possible_cpumask[1] is an empty mask is because in
> wq_numa_init() we did:
> 
> 	for_each_possible_cpu(cpu) {
> 		node = cpu_to_node(cpu);
> 		if (WARN_ON(node == NUMA_NO_NODE)) {
> 			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> 			/* happens iff arch is bonkers, let's just proceed */
> 			return;
> 		}
> 		cpumask_set_cpu(cpu, tbl[node]);
> 	}
> 
> And cpu_to_node() returned node 0 for every CPU in the system, despite there
> being multiple nodes.
> 
> That happened because we haven't yet called set_cpu_numa_node() for the non-boot
> cpus, because that happens in smp_prepare_cpus(), and
> workqueue_init_early() is called much earlier than that.
> 
> This doesn't trigger on x86 because it does set_cpu_numa_node() in
> setup_per_cpu_areas(), which is called prior to workqueue_init_early().
> 
> We can (should) probably do the same on powerpc, I'll look at that
> tomorrow. But other arches may have a similar problem, and at the very
> least we need to document that workqueue_init_early() relies on
> cpu_to_node() working.

Don't we do the setup cpu->node mapings in initmem_init()?
Ideally we have setup_arch->intmem_init->numa_setup_cpu

Will look at it tomorrow
Balbir Singh
