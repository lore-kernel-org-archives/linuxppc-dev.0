Date: Fri, 31 May 2002 08:26:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jim Thompson <jim@musenki.com>
Cc: Sergiy Kovtun <skovtun@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
Message-ID: <20020531152615.GO32412@opus.bloom.county>
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com> <20020531145120.GI32412@opus.bloom.county> <15607.36947.107412.219533@gargle.gargle.HOWL> <20020531151130.GN32412@opus.bloom.county> <15607.38056.877088.211807@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15607.38056.877088.211807@gargle.gargle.HOWL>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 31, 2002 at 10:20:08AM -0500, Jim Thompson wrote:
>
> Tom Rini writes:
> > On Fri, May 31, 2002 at 10:01:39AM -0500, Jim Thompson wrote:
> > >
> > > Tom Rini writes:
> > > >
> > > > On Thu, May 30, 2002 at 11:02:44PM -0700, Sergiy Kovtun wrote:
>
> > > My question is how have_of got set:
> > >
> > > arch/ppc/mm/init.c:
> > >         if (!have_of)
> > >                 FREESEC(openfirmware);
> >
> > On !CONFIG_ALL_PPC, we have:
> > #define have_of 0
> > In include/asm-ppc/processor.h, or so.  And the compiler happily
> > optimizes things in/out with this.
>
> I should have been more explicit.
>
> in include/asm-ppc/processor.h, I'd found:
>
> #define have_of (_machine == _MACH_chrp || _machine == _MACH_Pmac)

Thanks for the memory jog :)

Up near the top, we have:
#ifdef CONFIG_ALL_PPC
...
int _machine;
...
#else
#define _machine 0
#endif

So have_of becomes: (0 == 0x4 || 0 == 0x2)

> A sandpoint (esp with Dink) is neither CHRP or PMAC, so the call to
> FREESEC(openfirmware) shouldn't have occurred.

It's !have_of, so we really did want to free the __openfirmware stuff.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
