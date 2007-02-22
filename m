Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Feb 2007 21:34:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070222103410.GB11014@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <45b623f395654fc4f4920b9553794def@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <b08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 22, 2007 at 08:01:31AM +0100, Segher Boessenkool wrote:
> >> what problem is this trying to solve?
> >
> > As he says, it's for devices with interrupts routed to multiple
> > controllers.  The normal interrupts property assumes a single
> > interrupt parent for a device.  This is needed on most 4xx boards,
> > where the MAL has 5 interrupts, some of which are on UIC0 and some of
> > which are on UIC1.  At the moment the Ebony port deals with this using
> > an "interesting" hack, treating the MAL as an interrupt nexus for
> > itself, using an interrupt-map to remap its interrupts to the two
> > controllers.
> 
> Not really a hack, this is documented in the interrupt
> binding:

No, it really is a hack, I'm afraid.  interrupt-map doesn't in general
make sense for mapping interrupt-children which are not physical
children.  Why?  Because the interrupt map includes unit specifiers,
which means the expected addressing format in the interrupt map must
match that of the reg property in every node mapped through it.

We get away with it in this case because we ignore the unit specifier
part, and the kernel parser happens to use the interrupt parent's
#address-cells value, rather than the physical parent's.

> > 3.3.  "interrupt-map" property
> > At any level in the interrupt tree, a mapping may need to take
> > place between the child interrupt domain and the parent’s.  This
> > is represented by a new property called "interrupt-map".
> 
> Note it says "*any* level".

We could do this properly via an interrupt map by placing the MAL
under a MAL-interrupt-nexus node, which exists to do nothing but remap
the interrupts.  That's pretty horrible, though.

> > The interrupt-array proposal does the same thing much
> > more neatly and compactly.
> 
> Sure, for every specific case one can envision a more neat
> and compact device tree ;-P
> 
> If in a certain tree you have this "problem" with not only
> the MAL but with lots of devices, you could introduce a
> "fake" interrupt nexus that doesn't represent a physical
> device as such, but that represents the combined cascaded
> interrupt controllers, and maps the interrupts to the nodes
> for the "physical" interrupt controllers.  Just don't make
> the mistake of putting an "interrupt-controller" property
> in there and all is just fine.  As an added bonus you end up
> with one single namespace for the interrupts (one interrupt
> domain in interrupt-mapping speak), which is probably what
> the chip documentation does as well.

No, actually.  Afaict for the 4xx chips, the user manuals just give
the interrupt mapping in tables in the the chapter on the interrupt
controllers.  There's a separate table, with separate interrupt
numbers for each UIC.  IIRC, elsewhere in the document the interrupts
are just referred to by name.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
