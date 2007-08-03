Return-Path: <dgibson@ozlabs.org>
Date: Fri, 3 Aug 2007 16:43:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Message-ID: <20070803064328.GC14456@localhost.localdomain>
References: <20070627065335.GD11191@localhost.localdomain>
	<20070627071008.GA30648@localhost.localdomain>
	<b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
	<20070718013110.GA18251@localhost.localdomain>
	<505C0D97-FF0D-4E7F-B988-88894F629FD2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <505C0D97-FF0D-4E7F-B988-88894F629FD2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2007 at 05:55:16PM +0200, Segher Boessenkool wrote:
> >>> Too big for the list, the patch is at:
> >>> 	http://ozlabs.org/~dgibson/home/prep-support
> >>
> >> Too lazy to split the patch into bite-size chunks, you mean ;-)
> >
> > Well... much as I like small patches, I don't really like having a big
> > string of patches, each of which does basically nothing on its own,
> > i.e. split up just for the sake of making smaller, rather than into
> > separate logically separate changes.
> 
> Yeah I understand.  It's just that I had to dig out the DTS
> part :-)

Diddums :-p.

> >> +			external-control;
> >>
> >> Really?
> >
> > No idea, just copied that from earlier work of Paulus'.  Don't even
> > know what the property means.
> 
> It seems to me a flat device tree could leave out all those
> properties that can be derived from the PVR (except for the
> few that are really useful for bootloaders and such -- cache
> line size, 64-bit-or-not, what kind of MMU).  Linux doesn't
> use it anyway.  Existing DTSs already leave away most.

I agree, ditched them from my dts.

> >> +	pci@80000000 {
> >> +		device_type = "pci";
> >> +		compatible = "prep";
> >>
> >> Is that specific enough?
> >
> > Well, AFAICT, the prep PCI code doesn't need any more info.
> 
> If PReP requires a specific programming model for the PCI
> host bridge, that would be fine.  But then compatible =
> "prep-pci-bridge" or such, not just "prep"; everything on
> your board is "prep", it would make matching a bit hard ;-)

Well... I'm rather unclear on how much PReP requires of the PCI
bridge.  I thought what I'd coded was based on what appeared to be
hard assumptions in prep_pci.c, but now I'm hearing that this won't
cover all PReP machines, so I'm really not sure.

> >> I can't believe this "ranges" and interrupt mapping will
> >> work on all PReP systems...
> >
> > Probably not, but it should work on a chunk of them.  Like I say,
> > there's still a good deal more that needs to be filled in from
> > residual data or wherever.
> 
> Sure, I'm just pointing out things that seem problematic, I'm
> not saying your code can't be merged because of that -- esp.
> since it is a new port anyway (for arch/powerpc, that is).
> 
> >> What is the plan here -- have the bootwrapper build the
> >> device tree / fill in the details from the residual data?
> >
> > Not sure at this stage if it will be best for the bootwrapper to build
> > a complete tree from residual, or to have a dts skeleton with
> > substantial chunks filled in by bootwrapper from residual.
> 
> Conceptually those two options are pretty much the same thing;
> just try them out, see what is nicer for the implementation.
> 
> > I was
> > intending to merge libfdt into the kernel for more flexible device
> > tree manipulation before investigating that further.
> 
> Into the kernel wrapper, I think you mean?

Yes, of course.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
