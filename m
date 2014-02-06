Return-Path: <rientjes@google.com>
Received: from mail-pb0-x22a.google.com (mail-pb0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E50DF2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 19:52:53 +1100 (EST)
Received: by mail-pb0-f42.google.com with SMTP id jt11so1490004pbb.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Feb 2014 00:52:50 -0800 (PST)
Date: Thu, 6 Feb 2014 00:52:35 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, penberg@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, Anton Blanchard <anton@samba.org>,
 mpm@selenic.com, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Feb 2014, Joonsoo Kim wrote:

> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 

I may be misunderstanding this patch and there's no help because there's 
no changelog.

> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 12ae6ce..a6d5438 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -233,11 +233,20 @@ static inline int numa_node_id(void)
>   * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
>   */
>  DECLARE_PER_CPU(int, _numa_mem_);
> +int _node_numa_mem_[MAX_NUMNODES];
>  
>  #ifndef set_numa_mem
>  static inline void set_numa_mem(int node)
>  {
>  	this_cpu_write(_numa_mem_, node);
> +	_node_numa_mem_[numa_node_id()] = node;
> +}
> +#endif
> +
> +#ifndef get_numa_mem
> +static inline int get_numa_mem(int node)
> +{
> +	return _node_numa_mem_[node];
>  }
>  #endif
>  
> @@ -260,6 +269,7 @@ static inline int cpu_to_mem(int cpu)
>  static inline void set_cpu_numa_mem(int cpu, int node)
>  {
>  	per_cpu(_numa_mem_, cpu) = node;
> +	_node_numa_mem_[numa_node_id()] = node;

The intention seems to be that _node_numa_mem_[X] for a node X will return 
a node Y with memory that has the nearest distance?  In other words, 
caching the value returned by local_memory_node(X)?

That doesn't seem to be what it's doing since numa_node_id() is the node 
of the cpu that current is running on so this ends up getting initialized 
to whatever local_memory_node(cpu_to_node(cpu)) is for the last bit set in 
cpu_possible_mask.

>  }
>  #endif
>  
> @@ -273,6 +283,13 @@ static inline int numa_mem_id(void)
>  }
>  #endif
>  
> +#ifndef get_numa_mem
> +static inline int get_numa_mem(int node)
> +{
> +	return node;
> +}
> +#endif
> +
>  #ifndef cpu_to_mem
>  static inline int cpu_to_mem(int cpu)
>  {
