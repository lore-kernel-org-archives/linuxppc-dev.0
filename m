Date: Thu, 25 Sep 2003 13:55:52 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Roland Dreier <roland@topspin.com>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
Message-ID: <20030925135552.B17028@home.com>
References: <20030925125653.A16002@home.com> <Pine.LNX.4.44.0309251459441.12966-100000@spider.ancor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0309251459441.12966-100000@spider.ancor.com>; from Bret.Indrelee@qlogic.com on Thu, Sep 25, 2003 at 03:20:11PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 25, 2003 at 03:20:11PM -0500, Bret Indrelee wrote:
> On Thu, 25 Sep 2003, Matt Porter wrote:
> > On Thu, Sep 25, 2003 at 01:15:15PM -0500, Bret Indrelee wrote:
> > > I've read through the old thread about short DMAs, but still there are
> > > things that aren't clear to me.
> > >
> > > What exactly is the issue?
> >
> > The issue is confined to processors which do not support hardware
> > snooping of the external bus.  In this case, management of the
> > caches is performed in software.
>
> It is trying to figure out which systems have these sort of issues
> that I'm currently puzzling through. Where the heck should I expect
> to find this in the databooks for the various products?

Usually in the overview of the processor and bus interface chipsets
they will list support for snooping.

> [ snip ]
> > > Right now, I'm interested in the PPC and x86 compatible (Pentium,
> > > Pentium 4, Geode) systems, trying to understand the differences and
> > > requirements of each.
> >
> > Which PPCs?  Classic PPC != PPC8xx != PPC40x != Book E PPC. :)
>
> My immediate concern is 8245 and the Intel/Pentium style processors.
>
> In the near term for PPC, the 8245 and maybe 405E.

All 82xx perform hardware snooping to maintain coherence.  405 has
the issue since it is PPC4xx as I mentioned below.

> > PPC8xx and PPC4xx require software cache coherency.  If you want
> > your products to work on PPC44x (I hope you do, they are targetted
> > at markets where qlogic storage controllers are used) ensuring that
> > your DMA buffers are cacheline aligned at the head/tail is
> > important.
>
> It looked like on the PPC if I aligned for 32 byes (0x20), that should
> handle it for now. This is for embedded, not the HBA controller, so I
> shouldn't need to worry about CONFIG_PPC64BRIDGE.

True, except for PPC8xx and PPC403GCX  that have a 16 byte cacheline.
But for the processors you listed, 32 bytes is fine. However,
you can use the platform dependent define that I referenced
earlier in the thread instead of worrying about a particular
number. Might as well write portable code.

> On Pentium, I have to figure out if they do the snooping or not. I
> suspect that they do, but finding cache coherency problems is bad
> enough that I need a more definitive answer than that.

The processor and chipset manuals should talk about "bus snooping"
which is the tipoff.  AFAIK, there is no such thing as a non-coherent
IA32 machine excluding the possibility of a buggy companion chipset
that doesn't implement whatever their snooping protcol is correctly.

Oh, and to throw another wrench in the works...although Classic PPCs
support snooping, some system controllers allow it to be disabled.
e.g. GT64x60.  So even PPC7xx/74xx could be dependent on software
managed cache code in some embedded systems. :)

I guess my point is that it might be easier to use this knowledge
to make the code portable so it runs on all processors instead
of concentrating on a couple cases.  Aligning head/tail of your
DMAable buffers to L1_CACHE_BYTES is a generic operation. As
Eugene points out, this is not a concern for consistent memory
since it will be page aligned and by definition cacheline aligned.
It's streaming mappings that you need to worry about.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
