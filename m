Return-Path: <dgibson@ozlabs.org>
Date: Wed, 6 Feb 2008 00:20:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
Message-ID: <20080205132026.GE7983@localhost.localdomain>
References: <20080201150126.GB26545@localhost.localdomain>
	<72B60725-FB4A-42FA-832D-8FD5434B9042@kernel.crashing.org>
	<fa686aa40802010823n1b837ffk7110a72e2bd44bf6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40802010823n1b837ffk7110a72e2bd44bf6@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 09:23:47AM -0700, Grant Likely wrote:
> On 2/1/08, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > > --- a/Documentation/powerpc/booting-without-of.txt
> > > +++ b/Documentation/powerpc/booting-without-of.txt
> > > @@ -1675,7 +1675,6 @@ platforms are moved over to use the flattened-
> > > device-tree model.
> > >       ucc@2000 {
> > >               device_type = "network";
> > >               compatible = "ucc_geth";
> > > -             model = "UCC";
> > >               device-id = <1>;
> >
> > can we change device-id to cell-index?
> 
> <aside>
> Here's a thought; do we really need a cell-index at all?  (and I'm
> talking in general; not just this specific case).  I'm starting to
> think we should migrate away from using it.

_Need_ perhaps not, but in some cases I think the alternatives are
overly complex.

> cell-index has been useful for things like clock controllers to know
> what offset into a shared clock control register or something like
> that and a driver would pass the cell-index value to the shared reg
> driver when requesting service.

Right.  Except that if the shared resource is just a single register,
calling the routines to access it a "shared reg driver" gives a
misleading impression.  Depending on how the shared reg is used, even
a lock may not be necessary, so potentially the drivers for the
individual device instances using the shared resource can (safely)
directly access it.

>  However, I think the information
> encoded in cell-index is already encoded in the device tree in a
> different manor.
> 
> Typically, shared registers and the like are all chip specific and the
> behaviour of the shared register drivers usually needs to be tweaked
> for different SoCs.  Each ip core on an SoC is already uniquely
> indexed via the reg property.  True, 'reg' is sparse (0x2000, 0x2200,
> 0x2300, ...) whereas cell-index is tight (0,1,2,3,...), but I don't
> think that introduces any additional difficulty.
> 
> So, instead of a driver passing it's cell-index value to the shared
> reg driver, it would pass it's reg base instead.  The shared register
> driver could then choose an internal representation that makes sense
> for it instead of whatever layout was chosen by the device tree.

Except that the "shared reg driver" then needs a way to map from reg
property to index.  So either it has to have that hardcoded, or the
shared resource will need its own device tree representation for the
mapping.

In some cases the shared resource is complex enough that that makes
sense (e.g. an mdio bus shared between ethernet MACs to take an
extreme example).  But when the "shared reg driver" consists entirely
of:
	(readl(shared_reg_addr) & (1UL << cell_index))
and/or:
	writel(shared_reg_addr, 1UL << cell_index)
your approach would seem to be overkill and then some.  (The latter
example can be safe without locking in the case of a read/clear
register).

Exactly this sort of thing is fairly common on 4xx, which is just the
context in which BenH invented "cell-index" as a really simple way of
representing the index into shared registers like this.

> Dropping cell-index would mean one less property to keep in sync when
> tailoring device trees. (== less complexity for board porters).
> Besides, the purpose of cell-index is often misunderstood already by
> people trying to use it to describe port numbers (ttyS0, ttyS1, etc).

This is indeed a problem.  But I don't think ditching cell-index
entirely is a sensible solution, sorry.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
