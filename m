Return-Path: <dgibson@ozlabs.org>
Date: Mon, 26 Feb 2007 15:16:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070226041646.GC29826@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172299259.1902.22.camel@localhost.localdomain>
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

On Sat, Feb 24, 2007 at 07:40:59AM +0100, Benjamin Herrenschmidt wrote:
> On Fri, 2007-02-23 at 12:15 -0700, Yoder Stuart-B08248 wrote:
> > > I'd rather write it like
> > > 
> > > >       interrupts        = < a 4   b 4   0 4   1 4   2 4 >
> > > >       interrupt-parents = <&UIC0 &UIC0 &UIC1 &UIC1 &UIC1>
> > > 
> > 
> > Segher, with your proposal here of an interrupt-parents property
> > is this really keeping with the normal OF way of representing
> > property values?
> > 
> > Examples exists where one property tells you how to interpret
> > or decode another (e.g. #address-cells), but your proposal we
> > have two distinct properties each with values that together
> > provide the complete 'value' (interrupt parent + interrupt
> > specifier).  Is there any precedent for this approach?
> 
> Somewhat... interrupt-map and interrupt-map-mask... that sort of thing.
> 
> > I think I'd rather see all the information encoded in
> > one value.
> 
> On the other hand, I do quite like keeping with the old principle that
> having interrupts == having an "interrupts" node.

That would be nice.  On the other hand, re-using interrupts means that
it's possible to get a silent misparse of the interrupt information: a
parser which doesn't understand the new 'interrupt-parents' property
will encounter the node, see the 'interrupts' property, assume that
the interrupt parent is the physical parent and, if the
#interrupt-cells values match up, which is quite possible, assume that
it has correctly understood the interrupt information.

This is arguably a worse behaviour than simply having an old-style
parser see the lack of 'interrupts' property and assume the device has
no interrupts.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
