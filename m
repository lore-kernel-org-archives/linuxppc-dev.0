Return-Path: <iamjoonsoo.kim@lge.com>
Received: from LGEMRELSE1Q.lge.com (LGEMRELSE1Q.lge.com [156.147.1.111])
 by ozlabs.org (Postfix) with ESMTP id 4D1572C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 16:41:29 +1100 (EST)
Date: Fri, 7 Feb 2014 14:41:19 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 3/3] slub: fallback to get_numa_mem() node if we want
 to allocate on memoryless node
Message-ID: <20140207054119.GA28952@lge.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-3-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.10.1402061127001.5348@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402061127001.5348@nuc>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 06, 2014 at 11:30:20AM -0600, Christoph Lameter wrote:
> On Thu, 6 Feb 2014, Joonsoo Kim wrote:
> 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index cc1f995..c851f82 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1700,6 +1700,14 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> >  	void *object;
> >  	int searchnode = (node == NUMA_NO_NODE) ? numa_mem_id() : node;
> >
> > +	if (node == NUMA_NO_NODE)
> > +		searchnode = numa_mem_id();
> > +	else {
> > +		searchnode = node;
> > +		if (!node_present_pages(node))
> 
> This check wouild need to be something that checks for other contigencies
> in the page allocator as well. A simple solution would be to actually run
> a GFP_THIS_NODE alloc to see if you can grab a page from the proper node.
> If that fails then fallback. See how fallback_alloc() does it in slab.
> 

Hello, Christoph.

This !node_present_pages() ensure that allocation on this node cannot succeed.
So we can directly use numa_mem_id() here.

> > +			searchnode = get_numa_mem(node);
> > +	}
> 
> > @@ -2277,11 +2285,18 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  redo:
> >
> >  	if (unlikely(!node_match(page, node))) {
> > -		stat(s, ALLOC_NODE_MISMATCH);
> > -		deactivate_slab(s, page, c->freelist);
> > -		c->page = NULL;
> > -		c->freelist = NULL;
> > -		goto new_slab;
> > +		int searchnode = node;
> > +
> > +		if (node != NUMA_NO_NODE && !node_present_pages(node))
> 
> Same issue here. I would suggest not deactivating the slab and first check
> if the node has no pages. If so then just take an object from the current
> cpu slab. If that is not available do an allcoation from the indicated
> node and take whatever the page allocator gave you.

Here I do is not to deactivate the slab. I first check if the node has no pages.
And then, not taking an object from the current cpu slab. Instead, checking
current cpu slab comes from proper node getting from introduced get_numa_mem().
I think that this approach is better than just taking an object whatever node
requested.

Thanks.
