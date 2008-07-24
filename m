Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 26E9BDDFFB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 22:18:14 +1000 (EST)
Date: Thu, 24 Jul 2008 14:18:39 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
	tree lockless
Message-ID: <20080724141839.477de30b@bull.net>
In-Reply-To: <200807242111.35338.nickpiggin@yahoo.com.au>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tim Chavez <tinytim@us.ibm.com>, Linux-rt <linux-rt-users@vger.kernel.org>,
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

On Thu, 24 Jul 2008 21:11:34 +1000 Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> On Thursday 24 July 2008 20:50, Sebastien Dugue wrote:
> > From: Sebastien Dugue <sebastien.dugue@bull.net>
> > Date: Tue, 22 Jul 2008 11:56:41 +0200
> > Subject: [PATCH][RT] powerpc - Make the irq reverse mapping radix tree
> > lockless
> >
> >   The radix tree used by interrupt controllers for their irq reverse
> > mapping (currently only the XICS found on pSeries) have a complex locking
> > scheme dating back to before the advent of the concurrent radix tree on
> > preempt-rt.
> >
> >   Take advantage of this and of the fact that the items of the tree are
> > pointers to a static array (irq_map) elements which can never go under us
> > to simplify the locking.
> >
> >   Concurrency between readers and writers are handled by the intrinsic
> > properties of the concurrent radix tree. Concurrency between the tree
> > initialization which is done asynchronously with readers and writers access
> > is handled via an atomic variable (revmap_trees_allocated) set when the
> > tree has been initialized and checked before any reader or writer access
> > just like we used to check for tree.gfp_mask != 0 before.
> 
> Hmm, RCU radix tree is in mainline too for quite a while. I thought
> Ben had already converted this code over ages ago...

  Mainline does not have the concurrent radix tree which this patch
is based on, but maybe it's overkill and the RCU radix tree is enough.
Not sure, will have to think about it a bit more.

> 
> Nothing against the -rt patch, but mainline should probably be updated
> to use RCU as well?
> 

  If rcu radix tree is enough, then definitely yes.

  Sebastien.
