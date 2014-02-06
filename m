Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E97112C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 06:12:13 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 6 Feb 2014 12:12:10 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0F24419D8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 12:12:08 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s16JBmb564749614
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Feb 2014 20:11:48 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s16JBoHR005605
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Feb 2014 12:11:52 -0700
Date: Thu, 6 Feb 2014 11:11:31 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Joonsoo Kim <js1304@gmail.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140206191131.GB7845@linux.vnet.ibm.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06.02.2014 [19:29:16 +0900], Joonsoo Kim wrote:
> 2014-02-06 David Rientjes <rientjes@google.com>:
> > On Thu, 6 Feb 2014, Joonsoo Kim wrote:
> >
> >> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >>
> >
> > I may be misunderstanding this patch and there's no help because there's
> > no changelog.
> 
> Sorry about that.
> I made this patch just for testing. :)
> Thanks for looking this.
> 
> >> diff --git a/include/linux/topology.h b/include/linux/topology.h
> >> index 12ae6ce..a6d5438 100644
> >> --- a/include/linux/topology.h
> >> +++ b/include/linux/topology.h
> >> @@ -233,11 +233,20 @@ static inline int numa_node_id(void)
> >>   * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
> >>   */
> >>  DECLARE_PER_CPU(int, _numa_mem_);
> >> +int _node_numa_mem_[MAX_NUMNODES];
> >>
> >>  #ifndef set_numa_mem
> >>  static inline void set_numa_mem(int node)
> >>  {
> >>       this_cpu_write(_numa_mem_, node);
> >> +     _node_numa_mem_[numa_node_id()] = node;
> >> +}
> >> +#endif
> >> +
> >> +#ifndef get_numa_mem
> >> +static inline int get_numa_mem(int node)
> >> +{
> >> +     return _node_numa_mem_[node];
> >>  }
> >>  #endif
> >>
> >> @@ -260,6 +269,7 @@ static inline int cpu_to_mem(int cpu)
> >>  static inline void set_cpu_numa_mem(int cpu, int node)
> >>  {
> >>       per_cpu(_numa_mem_, cpu) = node;
> >> +     _node_numa_mem_[numa_node_id()] = node;
> >
> > The intention seems to be that _node_numa_mem_[X] for a node X will return
> > a node Y with memory that has the nearest distance?  In other words,
> > caching the value returned by local_memory_node(X)?
> 
> Yes, you are right.
> 
> > That doesn't seem to be what it's doing since numa_node_id() is the node
> > of the cpu that current is running on so this ends up getting initialized
> > to whatever local_memory_node(cpu_to_node(cpu)) is for the last bit set in
> > cpu_possible_mask.
> 
> Yes, I made a mistake.
> Thanks for pointer.
> I fix it and attach v2.
> Now I'm out of office, so I'm not sure this second version is correct :(
> 
> Thanks.
> 
> ----------8<--------------
> From bf691e7eb07f966e3aed251eaeb18f229ee32d1f Mon Sep 17 00:00:00 2001
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Date: Thu, 6 Feb 2014 17:07:05 +0900
> Subject: [RFC PATCH 2/3 v2] topology: support node_numa_mem() for
> determining the
>  fallback node
> 
> We need to determine the fallback node in slub allocator if the allocation
> target node is memoryless node. Without it, the SLUB wrongly select
> the node which has no memory and can't use a partial slab, because of node
> mismatch. Introduced function, node_numa_mem(X), will return
> a node Y with memory that has the nearest distance. If X is memoryless
> node, it will return nearest distance node, but, if
> X is normal node, it will return itself.
> 
> We will use this function in following patch to determine the fallback
> node.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 12ae6ce..66b19b8 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -233,11 +233,20 @@ static inline int numa_node_id(void)
>   * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
>   */
>  DECLARE_PER_CPU(int, _numa_mem_);
> +int _node_numa_mem_[MAX_NUMNODES];

Should be static, I think?

> 
>  #ifndef set_numa_mem
>  static inline void set_numa_mem(int node)
>  {
>   this_cpu_write(_numa_mem_, node);
> + _node_numa_mem_[numa_node_id()] = node;
> +}
> +#endif
> +
> +#ifndef get_numa_mem
> +static inline int get_numa_mem(int node)
> +{
> + return _node_numa_mem_[node];
>  }
>  #endif
> 
> @@ -260,6 +269,7 @@ static inline int cpu_to_mem(int cpu)
>  static inline void set_cpu_numa_mem(int cpu, int node)
>  {
>   per_cpu(_numa_mem_, cpu) = node;
> + _node_numa_mem_[cpu_to_node(cpu)] = node;
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
> + return node;
> +}
> +#endif
> +
>  #ifndef cpu_to_mem
>  static inline int cpu_to_mem(int cpu)
>  {
> -- 
> 1.7.9.5
> 
