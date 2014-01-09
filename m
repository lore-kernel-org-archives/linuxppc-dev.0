Return-Path: <iamjoonsoo.kim@lge.com>
Received: from LGEMRELSE7Q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by ozlabs.org (Postfix) with ESMTP id 2CC952C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 11:19:50 +1100 (EST)
Date: Thu, 9 Jan 2014 09:20:00 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140109002000.GB15738@lge.com>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52cbce84.aa71b60a.537c.ffffd9efSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52cbce84.aa71b60a.537c.ffffd9efSMTPIN_ADDED_BROKEN@mx.google.com>
Cc: cl@linux-foundation.org, nacc@linux.vnet.ibm.com, penberg@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, Anton Blanchard <anton@samba.org>,
 mpm@selenic.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 07, 2014 at 05:52:31PM +0800, Wanpeng Li wrote:
> On Tue, Jan 07, 2014 at 04:41:36PM +0900, Joonsoo Kim wrote:
> >On Tue, Jan 07, 2014 at 01:21:00PM +1100, Anton Blanchard wrote:

> >> Index: b/mm/slub.c
> >> ===================================================================
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2278,10 +2278,17 @@ redo:
> >>  
> >>  	if (unlikely(!node_match(page, node))) {
> >>  		stat(s, ALLOC_NODE_MISMATCH);
> >> -		deactivate_slab(s, page, c->freelist);
> >> -		c->page = NULL;
> >> -		c->freelist = NULL;
> >> -		goto new_slab;
> >> +
> >> +		/*
> >> +		 * If the node contains no memory there is no point in trying
> >> +		 * to allocate a new node local slab
> >> +		 */
> >> +		if (node_spanned_pages(node)) {
> >> +			deactivate_slab(s, page, c->freelist);
> >> +			c->page = NULL;
> >> +			c->freelist = NULL;
> >> +			goto new_slab;
> >> +		}
> >>  	}
> >>  
> >>  	/*
> >
> >Hello,
> >
> >I think that we need more efforts to solve unbalanced node problem.
> >
> >With this patch, even if node of current cpu slab is not favorable to
> >unbalanced node, allocation would proceed and we would get the unintended memory.
> >
> >And there is one more problem. Even if we have some partial slabs on
> >compatible node, we would allocate new slab, because get_partial() cannot handle
> >this unbalance node case.
> >
> >To fix this correctly, how about following patch?
> >
> >Thanks.
> >
> >------------->8--------------------
> >diff --git a/mm/slub.c b/mm/slub.c
> >index c3eb3d3..a1f6dfa 100644
> >--- a/mm/slub.c
> >+++ b/mm/slub.c
> >@@ -1672,7 +1672,19 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> > {
> >        void *object;
> >        int searchnode = (node == NUMA_NO_NODE) ? numa_node_id() : node;
> >+       struct zonelist *zonelist;
> >+       struct zoneref *z;
> >+       struct zone *zone;
> >+       enum zone_type high_zoneidx = gfp_zone(flags);
> >
> >+       if (!node_present_pages(searchnode)) {
> >+               zonelist = node_zonelist(searchnode, flags);
> >+               for_each_zone_zonelist(zone, z, zonelist, high_zoneidx) {
> >+                       searchnode = zone_to_nid(zone);
> >+                       if (node_present_pages(searchnode))
> >+                               break;
> >+               }
> >+       }
> 
> Why change searchnode instead of depending on fallback zones/nodes in 
> get_any_partial() to allocate partial slabs?
> 

If node != NUMA_NO_NODE, get_any_partial() isn't called.
That's why I change searchnode here instead of get_any_partial().

Thanks.
