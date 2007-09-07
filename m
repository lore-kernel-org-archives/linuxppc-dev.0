Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 10:20:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Message-ID: <20070907002049.GB26079@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
	<22dc6fa3382b591fe721c1b9dee88097@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22dc6fa3382b591fe721c1b9dee88097@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 03:56:38PM +0200, Segher Boessenkool wrote:
> > That looks totally bogus.  Unlike Segher, I think there are a few
> > cases where overlapping reg and ranges can make sense
> 
> That's not unlike me -- I may have lower tolerance for it though :-)

I see.  Can't imagine how I got another impression... :-p

: Date: Thu, 19 Jul 2007 17:51:17 +0200
: From: Segher Boessenkool <segher@kernel.crashing.org>
: Subject: Re: [PATCH] Add 8548CDS with Arcadia 3.0 support
...
: "reg" and "ranges" overlap, that can't be right.

: Date: Tue, 7 Aug 2007 18:51:04 +0200
: From: Segher Boessenkool <segher@kernel.crashing.org>
: Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
...
: > To be honest this looks rather to me like another case where having
: > overlapping 'reg' and 'ranges' would actually make sense.
:
: It never makes sense.  You should give the "master" device
: the full "reg" range it covers, and have it define its own
...

> > (PCI bridges
> > where config space is accessed indirectly via MMIO registers which lie
> > in the legacy ISA IO space is an example).
> 
> That's a good example yes.
> 
> > But this doesn't look like
> > such a case - it just looks like whoever did the device tree
> > misunderstood the distinction between reg and ranges.
> 
> Indeed.
> 
> >>> PCI legacy I/O is not direct mapped: there is no legacy I/O on a
> >>> PowerPC system bus.  So, it can not be mentioned in the "ranges"
> >>> property, but the PHB registers used to access it should be shown
> >>> in the "reg" property.  It could be a simple linear window (it
> >>> sounds like it is here?), but it could for example also be 
> >>> implemented
> >>> via an address/data register pair.
> >
> > Err... huh?  The legacy IO space is assigned a block of addresses in
> > 3-word "OF-PCI-space by the PCI binding.  When that is translated into
> > an MMIO range by the bridge, there's no reason that can't be encoded
> > into the ranges property.
> 
> Sure, it can be encoded like that.  But does it make sense?
> You cannot use legacy I/O space as normal memory space.

Well, no, but you can't use *any* MMIO space as normal memory space,
and that's handled routinely by 'ranges'.

> On an arch like x86, where "I/O addresses" exist on the system
> bus as well, it would make sense, since you can translate I/O
> addresses to I/O addresses that way (except on x86 even it cannot
> be done either, since I/O addresses cannot be encoded on the root
> bus -- at least not in existing device trees.  There is no official
> x86 binding yet though).

What!?  This is nuts, Segher.  Why should the binding have to define
some bridge-specific way of encoding the legacy I/O information, when
the PCI-binding's address encoding plus 'ranges' provides a perfectly
unambiguous way of doing so.  *And* it makes the normal semantics of
ranges do just the right thing for a subordinate PCI<->ISA bridge.

> Also, from a driver standpoint, a PHB driver needs to find out
> two main things about the bridge: a) how and where to generate
> config cycles; b) how and where to generate legacy I/O cycles.
> It is told "how" by the "compatible" property, and "where" by
> the "reg" property, normally.
> 
> But yes, you _can_ use "ranges" for this purpose on PHBs where
> legacy I/O is linearly mapped.  It just doesn't make much sense.
> The binding for your specific PHB should tell you what to do.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
