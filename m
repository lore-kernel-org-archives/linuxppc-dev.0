Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EECBF1A003B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 10:11:18 +1000 (EST)
Date: Tue, 9 Sep 2014 17:11:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] topology: add support for node_to_mem_node() to
 determine the fallback node
Message-Id: <20140909171115.75c7702c37dfb23b9e053636@linux-foundation.org>
In-Reply-To: <20140909190326.GD22906@linux.vnet.ibm.com>
References: <20140909190154.GC22906@linux.vnet.ibm.com>
 <20140909190326.GD22906@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Tejun Heo <tj@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Sep 2014 12:03:27 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> We need to determine the fallback node in slub allocator if the
> allocation target node is memoryless node. Without it, the SLUB wrongly
> select the node which has no memory and can't use a partial slab,
> because of node mismatch. Introduced function, node_to_mem_node(X), will
> return a node Y with memory that has the nearest distance. If X is
> memoryless node, it will return nearest distance node, but, if X is
> normal node, it will return itself.
> 
> We will use this function in following patch to determine the fallback
> node.
> 
> ...
>
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -119,11 +119,20 @@ static inline int numa_node_id(void)
>   * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().

This comment could be updated.

>   */
>  DECLARE_PER_CPU(int, _numa_mem_);
> +extern int _node_numa_mem_[MAX_NUMNODES];
>  
>  #ifndef set_numa_mem
>  static inline void set_numa_mem(int node)
>  {
>  	this_cpu_write(_numa_mem_, node);
> +	_node_numa_mem_[numa_node_id()] = node;
> +}
> +#endif
> +
> +#ifndef node_to_mem_node
> +static inline int node_to_mem_node(int node)
> +{
> +	return _node_numa_mem_[node];
>  }

A wee bit of documentation wouldn't hurt.

How does node_to_mem_node(numa_node_id()) differ from numa_mem_id()? 
If I'm reading things correctly, they should both always return the
same thing.  If so, do we need both?

Will node_to_mem_node() ever actually be called with a node !=
numa_node_id()?


>  #endif
>  
> @@ -146,6 +155,7 @@ static inline int cpu_to_mem(int cpu)
>  static inline void set_cpu_numa_mem(int cpu, int node)
>  {
>  	per_cpu(_numa_mem_, cpu) = node;
> +	_node_numa_mem_[cpu_to_node(cpu)] = node;
>  }
>  #endif
>  
> @@ -159,6 +169,13 @@ static inline int numa_mem_id(void)
>  }
>  #endif
>  
> +#ifndef node_to_mem_node
> +static inline int node_to_mem_node(int node)
> +{
> +	return node;
> +}
> +#endif
> +
>  #ifndef cpu_to_mem
>  static inline int cpu_to_mem(int cpu)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 18cee0d4c8a2..0883c42936d4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -85,6 +85,7 @@ EXPORT_PER_CPU_SYMBOL(numa_node);
>   */
>  DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
>  EXPORT_PER_CPU_SYMBOL(_numa_mem_);
> +int _node_numa_mem_[MAX_NUMNODES];

How does this get updated as CPUs, memory and nodes are hot-added and
removed?


>  #endif
>  
