Return-Path: <dgibson@ozlabs.org>
Date: Fri, 30 Jul 2010 11:38:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via proc
Message-ID: <20100730013817.GB24624@yookeroo>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
	<1279211961.31679.11.camel@localhost>
	<AANLkTikCDvsrWvtfhpEE0A78Nt3UUT-rzSwPk5nnN95s@mail.gmail.com>
	<1279216999.31679.26.camel@localhost>
	<AANLkTinUBPRsiKMd46EK6_9BBRYwB3jsfg49W9uKEbw-@mail.gmail.com>
	<1279220310.19363.19.camel@localhost>
	<AANLkTilDcYYbsH-6f0_HlX9WwaOwG24w1CfhRLplZKS7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTilDcYYbsH-6f0_HlX9WwaOwG24w1CfhRLplZKS7@mail.gmail.com>
Cc: Mitch Bradley <wmb@firmworks.com>, Matthew McClintock <msm@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 15, 2010 at 01:18:21PM -0600, Grant Likely wrote:
> On Thu, Jul 15, 2010 at 12:58 PM, Matthew McClintock <msm@freescale.com> wrote:
> > On Thu, 2010-07-15 at 12:37 -0600, Grant Likely wrote:
> >> On Thu, Jul 15, 2010 at 12:03 PM, Matthew McClintock <msm@freescale.com> wrote:
> >> > Yes. Where would we get a list of memreserve sections?
> >>
> >> I would say the list of reserves that are not under the control of
> >> Linux should be explicitly described in the device tree proper.  For
> >> instance, if you have a region that firmware depends on, then have a
> >> node for describing the firmware and a property stating the memory
> >> regions that it depends on.  The memreserve regions can be generated
> >> from that.
> >
> > Ok, so we could traverse the tree node-by-bode for a
> > persistent-memreserve property and add them to the /memreserve/ list in
> > the kexec user space tools?

Well.. I don't think it should be this way as a matter of spec.  But
you could use a property as an interim stash for memreserve
information.

I agree that the precise defined semantics of the memreserve regions
is kind of fuzzy and non-obvious.  Here's how I believe they need to
work:

	memory in a reserved region must *never* be touched by the OS
(or subsequent kexec-invoked OSes) unless something else in the device
tree explicitly instructs it how

There already exist several mechanisms for instructing the OS to use
particular reserved regions for particular purposes: e.g. the initrd
properties, and the spin-table properties.  More such mechanisms might
be added in future ePAPR (or whatever) revisions.  But if the OS
version doesn't understand such a future mechanism, it must fall back
to assuming that the memory is reserved in perpetuity.

Now, some of these mechanisms (implicitly) permit the OS to re-use the
reserved memory after it's done using them as instructed (initrd is
the most obvious one).  In that case the OS can re-add the reserved
space to it's general pools, and excise it from the reserved space for
subsequent kexec()-style boots.  However that's (potentially) a more
complex process than just removing an entry - the initial firmware is
free to combine adjacent reserved regions into one reserve entry, or
even to cover a single reserved region with multiple entries.  So in
order to do this manipulation you will need an allocator of sorts that
does the region reservation/dereservation correctly handling the
semantics on a byte-by-byte basis.

You should also be careful that the regions you're handling do
actually lie in memory space.  Linux doesn't support this right now,
but I do have an experimental patch that allows the initrd properties
to point to (e.g.) flash instead of RAM.  In that case the initrd
wouldn't have to lie in an explicitly reserved region, and obviously
could not be returned to the general pool after use.

> I *think* that is okay, but I'd like to hear from Segher, Ben, Mitch,
> David Gibson, and other device tree experts on whether or not that
> exact property naming is a good one.
> 
> Write up a proposed binding (you can use devicetree.org).  Post it for
> review (make sure you cc: both devicetree-discuss and linuxppc-dev, as
> well as cc'ing the people listed above.)
> 
> >> > Should we export
> >> > the reserve sections instead of the device tree location?
> >>
> >> It shouldn't really be something that the kernel is explicitly
> >> exporting because it is a characteristic of the board design.  It is
> >> something that belongs in the tree-proper.  ie. when you extract the
> >> tree you have data telling what the region is, and why it is reserved.
> >
> > Agreed.
> >
> >>
> >> > We just need a
> >> > way to preserve what was there at boot to pass to the new kernel.
> >>
> >> Yet there is no differentiation between the board-dictated memory
> >> reserves and the things that U-Boot/Linux made an arbitrary decision
> >> on.  The solution should focus not on "can I throw this one away?" but
> >> rather "Is this one I should keep?"  :-)  A subtle difference, I know,
> >> but it changes the way you approach the solution.
> >
> > Fair enough. I think the above solution will work nicely, and I can
> > start implementing something if you agree - if I interpreted your idea
> > correctly. Although it should not require any changes to the kernel
> > proper.
> 
> Correct.
> 
> g.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
