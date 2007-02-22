Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Feb 2007 09:48:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070222224809.GA15387@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
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

On Thu, Feb 22, 2007 at 12:06:09PM +0100, Segher Boessenkool wrote:
> >> Not really a hack, this is documented in the interrupt
> >> binding:
> >
> > No, it really is a hack, I'm afraid.  interrupt-map doesn't in general
> > make sense for mapping interrupt-children which are not physical
> > children.  Why?  Because the interrupt map includes unit specifiers,
> > which means the expected addressing format in the interrupt map must
> > match that of the reg property in every node mapped through it.
> 
> Hrm I guess I misunderstood the way you do things now.
> Could you give an example?  I'm too lazy to look up
> the DTS file :-)
> 
> > We get away with it in this case because we ignore the unit specifier
> > part,
> 
> That's perfectly fine for many interrupt maps.
> 
> > and the kernel parser happens to use the interrupt parent's
> > #address-cells value, rather than the physical parent's.
> 
> For the child interrupt specifiers, the "#address-cells"
> value in the node containing the "interrupt-map" itself
> should be used.  For the parent interrupt specifier, the
> "#address-cells" value in whatever node the "interrupt-map"
> for the matching entry points to should be used.
> 
> It sounds like the kernel does the right thing here?
> 
> [Of course the #a value better be the same as the value
> in the physical parent, and all nodes mapping via a
> particular "interrupt-map" better have unique unit
> address for that map].

Right.  In other words, the addressing format of the interrupt-parent
must match that of the physical parent, which breaks the usual
disconnection between the interrupt tree and the main tree.  Or to
look at it another way, the "reg" property is doubly constrained to
make sense both in the main tree, and in the interrupt tree.  And
really, the only way I can see it working other than by happy
coincidence is if the interrupt-parent *is* the physical parent.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
