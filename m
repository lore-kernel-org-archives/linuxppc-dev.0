Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Feb 2007 11:33:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070223003317.GA18508@localhost.localdomain>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<20070222225707.GB15387@localhost.localdomain>
	<621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 23, 2007 at 01:07:25AM +0100, Segher Boessenkool wrote:
> >> Option #3 -- define new, logical interrupt nexus to do
> >> the mapping.
> 
> > There's no point to option 3 as given.  If we're going to use an
> > interrupt nexus, and rely on the fact that the physical versus
> > interrupt tree addressing mismatch doesn't matter in this case, then
> > we might as well put the interrupt nexus into the node itself,
> > i.e. option 1.
> 
> That can give problems if there are interrupts in one
> of the descendants of the node.  It's also just nasty,
> don't you agree?

Well, if the node has descendents then it's going to need something
more complex in the interrupt-map to handle them, certainly.  But
then, if it has (interrupt) children they'll need to be handled
properly by the nexus in any case.

> > The only point to 3 would be if we make the MAL a
> > child of its interrupt nexus, thereby ensuring that the address forms
> > match.
> 
> No, you cannot do that.  There is no extra device
> there in reality so it shouldn't be in the device tree
> either.  Also, it just doesn't work.

Exactly, there's no extra device in reality.  So I don't see that it's
any more bogus to put the fake device as the MAL's parent than as the
MAL's child or sibling or anywhere else in the tree.

To represent this without either the nexus-in-node or an extra bogus
node, we need something like interrupt-array.  Which is why I like the
idea.

> > Something like:
> >
> > malint-nexus {
> > 	#interrupt-cells = <1>;
> > 	ranges;
> > 	interrupt-map = <0 0 0 &UIC0 a 4
> > 		.... >;
> > 	interrupt-map-mask = <ffffffff 0 0>;
> 
> If you have a "ranges" property you need a
> "#address-cells" and a "#size-cells" property
> too -- it just doesn't make any sense otherwise.

Oh, yes, my mistake.  #a and #s would need to be identical to the
parent of malint-nexus.

> You don't want this nexus node to be anywhere inside
> the "normal" device tree -- it doesn't sit there in
> hardware, it shouldn't sit there in the device tree,
> that will only cause problems.

So why did you suggest its existance in the first place?

> > Note the empty ranges property (passthrough).
> 
> There is nothing to pass anything through though,
> this node shouldn't be here.

If it shouldn't be here, it shouldn't be anywhere else either.

> > That's kind of
> > irrelevant here, since MAL is DCR controlled,
> 
> Yeah, so MAL should have the DCR reg in its "reg"
> property.  It needs *something* there -- what if
> you had two MALs?

No, because that would potentially collide with "reg" properties in
its siblings which have MMIO addresses on the parent bus.

> > but would matter if we
> > had a similar situation with a device that had MMIO registers (and
> > therefore a "reg" property).
> 
> Sorry, I'm going to shout: "reg" HAS NOTHING TO DO
> WITH MMIO.

Not in general, no, but here specifically it does.  "reg" has to match
the address type of the parent bus, in this case that's MMIO.  But the
MAL *is* on the PLB (it's a PLB master, in fact), but it has no
address on the PLB.

> > For MAL, since it has no "reg", we set
> > the interrupt-map-mask to ignore the unit address.
> 
> So you're saying your "#address-cells" is not 0, but
> you have no "reg" property?  Congratulations, you
> built yourself a wildcard package.

How else would you represent a device which exists on the bus, but
which has no address on the bus?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
