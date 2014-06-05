Return-Path: <rientjes@google.com>
Received: from mail-ie0-x233.google.com (mail-ie0-x233.google.com
 [IPv6:2607:f8b0:4001:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49E3C1A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 10:13:50 +1000 (EST)
Received: by mail-ie0-f179.google.com with SMTP id rd18so231242iec.24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jun 2014 17:13:46 -0700 (PDT)
Date: Wed, 4 Jun 2014 17:13:44 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] slub: search partial list on numa_mem_id(),
 instead of numa_node_id()
In-Reply-To: <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.02.1406041712350.23521@chino.kir.corp.google.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joonsoo Kim <js1304@gmail.com>, Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, mpm@selenic.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 May 2014, Joonsoo Kim wrote:

> Currently, if allocation constraint to node is NUMA_NO_NODE, we search
> a partial slab on numa_node_id() node. This doesn't work properly on the
> system having memoryless node, since it can have no memory on that node and
> there must be no partial slab on that node.
> 
> On that node, page allocation always fallback to numa_mem_id() first. So
> searching a partial slab on numa_node_id() in that case is proper solution
> for memoryless node case.
> 
> Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 545a170..cc1f995 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1698,7 +1698,7 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
>  		struct kmem_cache_cpu *c)
>  {
>  	void *object;
> -	int searchnode = (node == NUMA_NO_NODE) ? numa_node_id() : node;
> +	int searchnode = (node == NUMA_NO_NODE) ? numa_mem_id() : node;
>  
>  	object = get_partial_node(s, get_node(s, searchnode), c, flags);
>  	if (object || node != NUMA_NO_NODE)

Andrew, can you merge this please?  It's still not in linux-next.
