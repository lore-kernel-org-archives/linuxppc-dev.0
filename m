Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83E381A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 10:55:55 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 9 Sep 2014 20:55:52 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5A798C9002E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 20:55:41 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8A0tn4g9568538
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 00:55:49 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8A0tmkR011669
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 20:55:49 -0400
Date: Tue, 9 Sep 2014 17:55:42 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] slub: fallback to node_to_mem_node() node if
 allocating on memoryless node
Message-ID: <20140910005542.GI22906@linux.vnet.ibm.com>
References: <20140909190154.GC22906@linux.vnet.ibm.com>
 <20140909190326.GD22906@linux.vnet.ibm.com>
 <20140909190514.GE22906@linux.vnet.ibm.com>
 <20140909171125.de9844579d55599c59260afb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140909171125.de9844579d55599c59260afb@linux-foundation.org>
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

On 09.09.2014 [17:11:25 -0700], Andrew Morton wrote:
> On Tue, 9 Sep 2014 12:05:14 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:
> 
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > Update the SLUB code to search for partial slabs on the nearest node
> > with memory in the presence of memoryless nodes. Additionally, do not
> > consider it to be an ALLOC_NODE_MISMATCH (and deactivate the slab) when
> > a memoryless-node specified allocation goes off-node.
> > 
> > ...
> >
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1699,7 +1699,12 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> >  		struct kmem_cache_cpu *c)
> >  {
> >  	void *object;
> > -	int searchnode = (node == NUMA_NO_NODE) ? numa_mem_id() : node;
> > +	int searchnode = node;
> > +
> > +	if (node == NUMA_NO_NODE)
> > +		searchnode = numa_mem_id();
> > +	else if (!node_present_pages(node))
> > +		searchnode = node_to_mem_node(node);
> 
> I expect a call to node_to_mem_node() will always be preceded by a test
> of node_present_pages().  Perhaps node_to_mem_node() should just do the
> node_present_pages() call itself?

Really, we don't need that test here. We could always use the result of
node_to_mem_node() in the else. If memoryless nodes are not supported
(off in .config), then node_to_mem_node() trivially returns. If they are
supported, it returns the correct value for all nodes.
 
It's just an optimization (premature?) since we can avoid worrying (in
this path) about memoryless nodes if the node in question has memory.

And, in fact, in __slab_alloc(), we could do the following:

...
	int searchnode = node;

	if (node != NUMA_NO_NODE)
		searchnode = node_to_mem_node(node);

	if (node != searchnode &&
		unlikely(!node_match(page, searchnode))) {

...

which would minimize the impact to non-memoryless node NUMA configs.

Does that seem better to you? I can add comments to this patch as well.

Thanks,
Nish
