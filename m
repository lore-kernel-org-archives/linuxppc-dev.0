Date: Thu, 31 Aug 2000 17:17:11 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
In-Reply-To: <Pine.HPX.4.10.10008311107320.15978-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.10008311714050.390-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000, Gabriel Paubert wrote:
> On Wed, 30 Aug 2000, Geert Uytterhoeven wrote:
> > On Sun, 30 Jul 2000, Geert Uytterhoeven wrote:
> > > Personally I'd more like a configuration where you can select whatever you
> > > want of
> > >
> > >   - PowerMac (CONFIG_PMAC)
> > >   - PReP (CONFIG_PREP)
> > >   - MTX (CONFIG_MTX)
> > >   - CHRP (CONFIG_CHRP)
> > >   - Gemini (CONFIG_GEMINI)
> > >   - EST8260 (CONFIG_EST8260)
> > >   - APUS (CONFIG_APUS)
> > >
> > > with of course some extra logic to prevent illegal combinations.
> >
> > So what about this?
> >
> > --- linux-2.4.0-test8-pre1/arch/ppc/config.in.orig	Wed Aug 23 18:52:20 2000
> > +++ linux-2.4.0-test8-pre1/arch/ppc/config.in	Wed Aug 30 14:23:38 2000
> > @@ -82,6 +82,10 @@
> >  fi
> >
> >  if [ "$CONFIG_ALL_PPC" != "y" ];then
> > +  bool 'PowerMac support' CONFIG_PMAC
> > +  bool 'PReP support' CONFIG_PREP
> > +  bool 'MTX support' CONFIG_MTX
> > +  bool 'CHRP support' CONFIG_CHRP
> >    define_bool CONFIG_MACH_SPECIFIC y
> >  fi
> >
> > and replace all tests for CONFIG_ALL_PPC by a suitable combination of tests
> > for CONFIG_PMAC/CONFIG_PREP/CONFIG_MTX/CONFIG_CHRP? (BTW, there are still some
> > relics of CONFIG_PREP around in config.in)
> >
> > This clearly indicates that you can
> >  1. still compile one kernel that can run on all of PowerMac/PReP/MTX/CHRP,
> >     while
> >  2. it allows to fine tune the kernel to your specific machine and
> >  3. protect against illegal combinations with other machine types.
> > And if it ever will be possible to compile a generic kernel that runs on e.g.
> > APUS as well, CONFIG_APUS can be included in CONFIG_ALL_PPC (or better, rename
> > it to CONFIG_GENERIC_PPC) as well.
> >
> > I'm willing to work on a first patch, but I don't have a PPC cross-compiler at
> > hand and am unable to use bitkeeper, so I have to base it on plain
> > 2.4.0-test8-pre1 and leave it untested. Whoever owns whatever machine can
> > smooth the rough edges for his/her platform afterwards.
> >
> > What do you think?
>
> I strongly disagree. What I would like to see is the same kernel running
> on all machines, without exception (well all 6xx/7xx/74xx and Power[34]
> in 32 bit mode, obvioulsy 8xx and company are too different).

You can still compile a generic kernel by enabling all of
CONFIG_PMAC/CONFIG_PREP/CONFIG_MTX/CONFIG_CHRP.

> The only reasonable way to do this that I see is to have a self linking
> kernel, the initial boot code would simply uncompress a partially linked
> kernel and perform the final link step before passing control to it.
>
> Yes this involves putting several versions of processor specific code
> in the same kernel, but once compressed it's not that big. The _init
> sections are ok, but adding apus/prep/openfirmware is pushing the method
> past the breaking point.

Cool!

> Yes, this will make the bot iamge bigger, I just  don't care (embedded
> systems are different) since it will make the running kernel smaller:

My interest is in smaller kernel images. I don't want to compile every single
piece of PPC code that's useless for my hardware, I want to compile only what
I need. I think I'm already wasting too much of my time waiting for kernel
compiles.

And since there are people who care about embedded PPC systems, it would be
great to at least have _the choice_ to compile a small specific kernel or a
large generic one.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
