From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15607.38056.877088.211807@gargle.gargle.HOWL>
Date: Fri, 31 May 2002 10:20:08 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sergiy Kovtun <skovtun@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
In-Reply-To: <20020531151130.GN32412@opus.bloom.county>
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com>
	<20020531145120.GI32412@opus.bloom.county>
	<15607.36947.107412.219533@gargle.gargle.HOWL>
	<20020531151130.GN32412@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini writes:
> On Fri, May 31, 2002 at 10:01:39AM -0500, Jim Thompson wrote:
> >
> > Tom Rini writes:
> > >
> > > On Thu, May 30, 2002 at 11:02:44PM -0700, Sergiy Kovtun wrote:

> > My question is how have_of got set:
> >
> > arch/ppc/mm/init.c:
> >         if (!have_of)
> >                 FREESEC(openfirmware);
>
> On !CONFIG_ALL_PPC, we have:
> #define have_of 0
> In include/asm-ppc/processor.h, or so.  And the compiler happily
> optimizes things in/out with this.

I should have been more explicit.

in include/asm-ppc/processor.h, I'd found:

#define have_of (_machine == _MACH_chrp || _machine == _MACH_Pmac)

A sandpoint (esp with Dink) is neither CHRP or PMAC, so the call to
FREESEC(openfirmware) shouldn't have occurred.

Jim

--
"Perl is basically TECO-99."  ---Barry Shein


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
