Return-Path: <laijs@cn.fujitsu.com>
Received: from heian.cn.fujitsu.com (unknown [59.151.112.132])
 by lists.ozlabs.org (Postfix) with ESMTP id F31281A0AE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 18:21:45 +1000 (EST)
Message-ID: <53C8D6A8.3040400@cn.fujitsu.com>
Date: Fri, 18 Jul 2014 16:11:20 +0800
From: Lai Jiangshan <laijs@cn.fujitsu.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC 1/2] workqueue: use the nearest NUMA node, not the local one
References: <20140717230923.GA32660@linux.vnet.ibm.com>
 <20140717230958.GB32660@linux.vnet.ibm.com>
In-Reply-To: <20140717230958.GB32660@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Jiang Liu <jiang.liu@linux.intel.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm curious about what will it happen when alloc_pages_node(memoryless_node).

If the memory is allocated from the most preferable node for the @memoryless_node,
why we need to bother and use cpu_to_mem() in the caller site?

If not, why the memory allocation subsystem refuses to find a preferable node
for @memoryless_node in this case? Does it intend on some purpose or
it can't find in some cases?

Thanks,
Lai

Added CC to Tejun (workqueue maintainer).

On 07/18/2014 07:09 AM, Nishanth Aravamudan wrote:
> In the presence of memoryless nodes, the workqueue code incorrectly uses
> cpu_to_node() to determine what node to prefer memory allocations come
> from. cpu_to_mem() should be used instead, which will use the nearest
> NUMA node with memory.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 35974ac..0bba022 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3547,7 +3547,12 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  		for_each_node(node) {
>  			if (cpumask_subset(pool->attrs->cpumask,
>  					   wq_numa_possible_cpumask[node])) {
> -				pool->node = node;
> +				/*
> +				 * We could use local_memory_node(node) here,
> +				 * but it is expensive and the following caches
> +				 * the same value.
> +				 */
> +				pool->node = cpu_to_mem(cpumask_first(pool->attrs->cpumask));
>  				break;
>  			}
>  		}
> @@ -4921,7 +4926,7 @@ static int __init init_workqueues(void)
>  			pool->cpu = cpu;
>  			cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
>  			pool->attrs->nice = std_nice[i++];
> -			pool->node = cpu_to_node(cpu);
> +			pool->node = cpu_to_mem(cpu);
>  
>  			/* alloc pool ID */
>  			mutex_lock(&wq_pool_mutex);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
