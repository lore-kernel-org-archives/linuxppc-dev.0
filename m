Date: Tue, 9 Apr 2002 07:52:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020409145222.GB710@opus.bloom.county>
References: <20020408152026.GG2716@opus.bloom.county> <0204081705.AA21087@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204081705.AA21087@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 08, 2002 at 10:05:53AM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > We shouldn't be #ifdef'ing externs, since it doesn't matter.  The
> > pmac/prep/chrp ones were hidden just because the line above was, iirc.
>
> OK.
>
> > And the one downside to the GENERIC_PPC32 platform_init, is that we're
> > back to adding:
> > #ifdef CONFIG_x
> >  case _MACH_x:
> >   x_init(...);
> >   break;
> > #endif
>
> And what's wrong with that? It allows the user to make the kernel size vs.
> generality trade-off: you can have one machine supported or all of them.

Well, take a look at what the file used to look like in _devel.  It was
around 30-40 lines of that.  Which is not nice to look at.

> > Which I think Paul was happy to see die :)
>
> But it's necessary, and it's a much better system than what you have now.

Well, it's a much better system if you want to group unlike hardware
together in one kernel. :)

> > >   arch/ppc/config.in
> > >     1.127 02/03/31 23:58:43 msokolov@helium.harhan.org +18 -21
> > >     Add generic PPC32 config, implemented for
> > >     Adirondack, EV-64260A, and K2
> >
> > Do any of these boards actually have an ISA slot?
>
> The boards I've used for this first implementation don't. But
> CONFIG_GENERIC_PPC32 is generic PPC32, not just these boards, and it should be
> possible for someone to support a machine with ISA slots under this generic
> framework.

Well, if ISA slots exist on the board, and should be working, they
should just work.  And when BenH merges in prep/chrp, it'll be needed.
But the question is do you really want to offer this up on machines
where it's not tested?

> > Right now it's an ALL_PPC-only
> > option because it's actually needed for sound on some PReP boxes..
>
> And I'm hoping that some day PReP will be part of CONFIG_GENERIC_PPC32. See
> BenH's response about putting CONFIG_ALL_PPC to rest and converting to
> CONFIG_GENERIC_PPC32.

Right.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
