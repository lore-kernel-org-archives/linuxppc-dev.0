Message-ID: <3844A2E1.64157F00@packetengines.com>
Date: Tue, 30 Nov 1999 20:24:01 -0800
From: Alan Mimms <alan@packetengines.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXLite 823 PCMCIA troubles
References: <Pine.LNX.3.96.991130222350.23593A-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Effectively, guarded means "don't prefetch" for code fetches.  It also means that
no speculative data fetches will be performed to a guarded space.  Speculative
data fetches occur when the processor is speculatively executing a chunk of code
as a result of a predicted branch whose condition is not yet known to be as
predicted.  Setting the guarded attribute on an area prevents such speculation.
This issue probably is nearly moot on the nearly non-superscalar (dumb as a rock)
8xx processors, but is MUCH more important (i.e., VITAL) on the 82xx processors
with the 603ish core and on all "real" PowerPC processors.

a

"Mark S. Mathews" wrote:

> Hey Dan,
>
> On Tue, 30 Nov 1999, Dan Malek wrote:
>
> > Mark S. Mathews wrote:
>
> > > We've been working with the embedded 2.2.13 kernel on an RPX-Lite CW with
> > > a XPC823ZT66A processor running at the 50MHz/8MHz setting.
> >
> >
> > It's not only the RPX Lite.....I have a variety of 8xx boards
> > and when I have trouble like this with a particular card, it
> > occurs in all of the boards.
>
> Hmmmm.  The way ours "works for awhile", I'm wondering if there's a
> problem w/ the way the 8xx is handling the WAIT# when the MMU is enabled
> (?)
>
> >
> >
> > > ............ but our
> > > accesses to the common memory regions of the card are twitchy.
> >
> >
> > Same thing I have seen.  The I/O and attribute regions seem
> > to work OK, but memory regions don't.....on more than one
> > type of card.
>
> This is good to know.  Our card supports I/O or memory access to the
> shared memory.  We'll shift over to the I/O and try that.
>
> > > .....but eventually we wind up with a machine-check.
> >
> > Which points to some kind of bus timing or protocol problem.
>
> We've been running _lots_ of experiments with the timing settings.  So far
> 3,10,6 seems to work best....but it still fails.
>
> > > runs well on the x86, our PowerBook, and on a different 860 based platform
> > > (non-Linux, no MMU) so we're fairly confident it isn't the code.
> >
> > Well now, that's interesting (the no MMU, not the non-Linux
> > part :-).  With the MMU disabled, the accesses behave as guarded.
>
> I've seen the 'guarded' thing around in the sources, but I'm not sure what
> it's all about.  Guess I should look. ;-)
>
> > This is something I have not properly implemented on the 8xx,
> > and with my somewhat sloppy use of eieio() and synchronization,
> > I am always waiting for this to come back and haunt me.  Notice
> > how I buried this important fact in this paragraph.  I will now
> > properly implement this (yet tonight).  Tell me the kernel version
> > you are using and I will send some updates for your testing.
>
> embedded kernel 2.2.13
>
> > How does someone (like me :-) determine what a PCMCIA interface
> > in something like a PowerBook uses for bus timing?
>
> I'm not really sure.  Have to ask David, it's probably buried in pcmcia-cs
> somewhere.
>
> > > One specific question...when setting up the PCMCIA bus timings, the 823
> > > book lists the settings in units of "clock cycles".  Which clock?
> >
> > It is the CLKOUT (system/bus) clock.  On the 66MHz processor,
> > this better be 33 MHz (processor clock / 2).  For 50 MHz or
> > less, the CLKOUT is the processor clock.
>
> BIG help!  Thanks a million.
>
> We'll keep trying and let you know.
>
> -Mark
>
> Mark S. Mathews
>
> AbsoluteValue Software     Web:   http://www.absoval.com
> P.O. Box 941149            e-mail: mark@absoval.com
> Maitland, FL 32794-1149    Phone:  407.644.8582
> USA                        Fax:    407.539.1294

--
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
