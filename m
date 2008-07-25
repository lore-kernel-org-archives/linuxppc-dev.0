Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DAA2DE0E1
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 17:49:41 +1000 (EST)
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
	tree lockless
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <20080724141839.477de30b@bull.net>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
	<20080724141839.477de30b@bull.net>
Content-Type: text/plain; charset=utf-8
Date: Fri, 25 Jul 2008 09:49:37 +0200
Message-Id: <1216972177.7257.351.camel@twins>
Mime-Version: 1.0
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Tim Chavez <tinytim@us.ibm.com>,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-24 at 14:18 +0200, Sebastien Dugue wrote:
> On Thu, 24 Jul 2008 21:11:34 +1000 Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > On Thursday 24 July 2008 20:50, Sebastien Dugue wrote:
> > > From: Sebastien Dugue <sebastien.dugue@bull.net>
> > > Date: Tue, 22 Jul 2008 11:56:41 +0200
> > > Subject: [PATCH][RT] powerpc - Make the irq reverse mapping radix tree
> > > lockless
> > >
> > >   The radix tree used by interrupt controllers for their irq reverse
> > > mapping (currently only the XICS found on pSeries) have a complex locking
> > > scheme dating back to before the advent of the concurrent radix tree on
> > > preempt-rt.
> > >
> > >   Take advantage of this and of the fact that the items of the tree are
> > > pointers to a static array (irq_map) elements which can never go under us
> > > to simplify the locking.
> > >
> > >   Concurrency between readers and writers are handled by the intrinsic
> > > properties of the concurrent radix tree. Concurrency between the tree
> > > initialization which is done asynchronously with readers and writers access
> > > is handled via an atomic variable (revmap_trees_allocated) set when the
> > > tree has been initialized and checked before any reader or writer access
> > > just like we used to check for tree.gfp_mask != 0 before.
> > 
> > Hmm, RCU radix tree is in mainline too for quite a while. I thought
> > Ben had already converted this code over ages ago...
> 
>   Mainline does not have the concurrent radix tree which this patch
> is based on, but maybe it's overkill and the RCU radix tree is enough.
> Not sure, will have to think about it a bit more.

Should be. The model of the concurrent radix tree can be mapped to
spinlock + rcu radix tree.

So instead of:

> ﻿+               DEFINE_RADIX_TREE_CONTEXT(ctx, tree);
> +               radix_tree_lock(&ctx);
> +               radix_tree_insert(ctx.tree, hwirq, &irq_map[virq]);
> +               radix_tree_unlock(&ctx);


you then write:

	spin_lock(&host->revmap_data.tree_lock);
	radix_tree_insert(&host->revmap_data.tree, hwirq, &irq_map[virq]);
	spin_unlock(&host->revmap_data.tree_lock);


The only advantage of the concurrent radix tree over this model is that
it can potentially do multiple modification operations at the same time.

Still, cool that you used it ;-)
