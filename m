Return-Path: <iamjoonsoo.kim@lge.com>
Received: from LGEMRELSE1Q.lge.com (LGEMRELSE1Q.lge.com [156.147.1.111])
 by ozlabs.org (Postfix) with ESMTP id D27EB2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 12:29:22 +1100 (EST)
Date: Mon, 10 Feb 2014 10:29:18 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140210012918.GD12574@lge.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402071245040.20246@nuc>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 07, 2014 at 12:51:07PM -0600, Christoph Lameter wrote:
> Here is a draft of a patch to make this work with memoryless nodes.
> 
> The first thing is that we modify node_match to also match if we hit an
> empty node. In that case we simply take the current slab if its there.

Why not inspecting whether we can get the page on the best node such as
numa_mem_id() node?

> 
> If there is no current slab then a regular allocation occurs with the
> memoryless node. The page allocator will fallback to a possible node and
> that will become the current slab. Next alloc from a memoryless node
> will then use that slab.
> 
> For that we also add some tracking of allocations on nodes that were not
> satisfied using the empty_node[] array. A successful alloc on a node
> clears that flag.
> 
> I would rather avoid the empty_node[] array since its global and there may
> be thread specific allocation restrictions but it would be expensive to do
> an allocation attempt via the page allocator to make sure that there is
> really no page available from the page allocator.
> 
> Index: linux/mm/slub.c
> ===================================================================
> --- linux.orig/mm/slub.c	2014-02-03 13:19:22.896853227 -0600
> +++ linux/mm/slub.c	2014-02-07 12:44:49.311494806 -0600
> @@ -132,6 +132,8 @@ static inline bool kmem_cache_has_cpu_pa
>  #endif
>  }
> 
> +static int empty_node[MAX_NUMNODES];
> +
>  /*
>   * Issues still to be resolved:
>   *
> @@ -1405,16 +1407,22 @@ static struct page *new_slab(struct kmem
>  	void *last;
>  	void *p;
>  	int order;
> +	int alloc_node;
> 
>  	BUG_ON(flags & GFP_SLAB_BUG_MASK);
> 
>  	page = allocate_slab(s,
>  		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
> -	if (!page)
> +	if (!page) {
> +		if (node != NUMA_NO_NODE)
> +			empty_node[node] = 1;
>  		goto out;
> +	}

empty_node cannot be set on memoryless node, since page allocation would
succeed on different node.

Thanks.
