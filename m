Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id D06F9DDEFB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 18:33:48 +1000 (EST)
Date: Fri, 25 Jul 2008 10:34:18 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
	tree lockless
Message-ID: <20080725103418.2ae898f5@bull.net>
In-Reply-To: <1216972177.7257.351.camel@twins>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
	<20080724141839.477de30b@bull.net>
	<1216972177.7257.351.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


  Hi Peter,

On Fri, 25 Jul 2008 09:49:37 +0200 Peter Zijlstra <peterz@infradead.org> wr=
ote:

> On Thu, 2008-07-24 at 14:18 +0200, Sebastien Dugue wrote:
> > On Thu, 24 Jul 2008 21:11:34 +1000 Nick Piggin <nickpiggin@yahoo.com.au=
> wrote:
> >=20
> > > On Thursday 24 July 2008 20:50, Sebastien Dugue wrote:
> > > > From: Sebastien Dugue <sebastien.dugue@bull.net>
> > > > Date: Tue, 22 Jul 2008 11:56:41 +0200
> > > > Subject: [PATCH][RT] powerpc - Make the irq reverse mapping radix t=
ree
> > > > lockless
> > > >
> > > >   The radix tree used by interrupt controllers for their irq reverse
> > > > mapping (currently only the XICS found on pSeries) have a complex l=
ocking
> > > > scheme dating back to before the advent of the concurrent radix tre=
e on
> > > > preempt-rt.
> > > >
> > > >   Take advantage of this and of the fact that the items of the tree=
 are
> > > > pointers to a static array (irq_map) elements which can never go un=
der us
> > > > to simplify the locking.
> > > >
> > > >   Concurrency between readers and writers are handled by the intrin=
sic
> > > > properties of the concurrent radix tree. Concurrency between the tr=
ee
> > > > initialization which is done asynchronously with readers and writer=
s access
> > > > is handled via an atomic variable (revmap_trees_allocated) set when=
 the
> > > > tree has been initialized and checked before any reader or writer a=
ccess
> > > > just like we used to check for tree.gfp_mask !=3D 0 before.
> > >=20
> > > Hmm, RCU radix tree is in mainline too for quite a while. I thought
> > > Ben had already converted this code over ages ago...
> >=20
> >   Mainline does not have the concurrent radix tree which this patch
> > is based on, but maybe it's overkill and the RCU radix tree is enough.
> > Not sure, will have to think about it a bit more.
>=20
> Should be. The model of the concurrent radix tree can be mapped to
> spinlock + rcu radix tree.
>=20
> So instead of:
>=20
> > =EF=BB=BF+               DEFINE_RADIX_TREE_CONTEXT(ctx, tree);
> > +               radix_tree_lock(&ctx);
> > +               radix_tree_insert(ctx.tree, hwirq, &irq_map[virq]);
> > +               radix_tree_unlock(&ctx);
>=20
>=20
> you then write:
>=20
> 	spin_lock(&host->revmap_data.tree_lock);
> 	radix_tree_insert(&host->revmap_data.tree, hwirq, &irq_map[virq]);
> 	spin_unlock(&host->revmap_data.tree_lock);
>=20

  Cool, that will indeed makes it much easier to have something applicable
to mainline which works with preempt-rt.

>=20
> The only advantage of the concurrent radix tree over this model is that
> it can potentially do multiple modification operations at the same time.

  Well in theory that can happen if a module is loaded which creates a mapp=
ing
while another one is unloaded at the same time. The time window is pretty n=
arrow,
but still present nonetheless. That's why I chose to use the concurrent ver=
sion.

>=20
> Still, cool that you used it ;-)


  Yep, looked like what was needed until I realized it was not available in
mainline. Nice work though and good paper for explaining it all.

  Sebastien.
