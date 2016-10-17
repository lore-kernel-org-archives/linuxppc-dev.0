Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syRGR6Y47zDvNr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 05:15:59 +1100 (AEDT)
Received: by mail-yw0-x244.google.com with SMTP id u124so7140843ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 11:15:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 17 Oct 2016 14:15:56 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
Message-ID: <20161017181556.GB6248@htj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
 <87eg3fcge5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87eg3fcge5.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael.

On Mon, Oct 17, 2016 at 11:24:34PM +1100, Michael Ellerman wrote:
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

Ah, should have read this before replying to the previous mail, so
it's the numa mask, not the cpu_possible_mask.

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

I should be able to move the numa part of initialization to the later
init function.  Working on it.

Thanks.

-- 
tejun
