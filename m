Date: Fri, 31 May 2002 08:11:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jim Thompson <jim@musenki.com>
Cc: Sergiy Kovtun <skovtun@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
Message-ID: <20020531151130.GN32412@opus.bloom.county>
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com> <20020531145120.GI32412@opus.bloom.county> <15607.36947.107412.219533@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15607.36947.107412.219533@gargle.gargle.HOWL>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 31, 2002 at 10:01:39AM -0500, Jim Thompson wrote:
>
> Tom Rini writes:
> >
> > On Thu, May 30, 2002 at 11:02:44PM -0700, Sergiy Kovtun wrote:
> >
> > > Hello All,
> > > I try to connect all my 64 Meg memoty on
> > > Sandpoint-X3B,
> > > but received a crash( with 32M all OK).
> > > Source:
> > > SP-X3B + Altimus MPC7410
> > > HHL 2.0
> > > Any ideas??
> >
> > DINK32 12.2 does not correctly initalize the memory controller on-board.
> > DINK32 12.3 claims to do this correctly, but in some testing locally it
> > still did not get everything correct.
>
> Could you be more specific as to what is missing?

On the DINK32 12.2 side it blindly sets some parts up for 64mb total
regardless of the ammount of memory.  I think there's other things as
well, but Mark Greer would know better..

For DINK32 12.3 the first problem I've hit is that I can't seem to
convince it to setup the SPD bits on the memory for the 64mb total that seems
to be on the board, only 128mb.  Using DINK32 12.2 and 12.3 to try and
get all of that done 'correctly' still had things blowing up when I
tried to use 64mb.   But I've been busy tracking down other issues at
the moment..

> My question is how have_of got set:
>
> arch/ppc/mm/init.c:
>         if (!have_of)
>                 FREESEC(openfirmware);

On !CONFIG_ALL_PPC, we have:
#define have_of 0
In include/asm-ppc/processor.h, or so.  And the compiler happily
optimizes things in/out with this.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
