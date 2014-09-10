Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C3C21A0B61
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 10:11:28 +1000 (EST)
Date: Tue, 9 Sep 2014 17:11:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] slub: fallback to node_to_mem_node() node if
 allocating on memoryless node
Message-Id: <20140909171125.de9844579d55599c59260afb@linux-foundation.org>
In-Reply-To: <20140909190514.GE22906@linux.vnet.ibm.com>
References: <20140909190154.GC22906@linux.vnet.ibm.com>
 <20140909190326.GD22906@linux.vnet.ibm.com>
 <20140909190514.GE22906@linux.vnet.ibm.com>
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

On Tue, 9 Sep 2014 12:05:14 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Update the SLUB code to search for partial slabs on the nearest node
> with memory in the presence of memoryless nodes. Additionally, do not
> consider it to be an ALLOC_NODE_MISMATCH (and deactivate the slab) when
> a memoryless-node specified allocation goes off-node.
> 
> ...
>
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1699,7 +1699,12 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
>  		struct kmem_cache_cpu *c)
>  {
>  	void *object;
> -	int searchnode = (node == NUMA_NO_NODE) ? numa_mem_id() : node;
> +	int searchnode = node;
> +
> +	if (node == NUMA_NO_NODE)
> +		searchnode = numa_mem_id();
> +	else if (!node_present_pages(node))
> +		searchnode = node_to_mem_node(node);

I expect a call to node_to_mem_node() will always be preceded by a test
of node_present_pages().  Perhaps node_to_mem_node() should just do the
node_present_pages() call itself?
