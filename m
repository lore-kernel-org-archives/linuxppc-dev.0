Date: Sat, 13 Dec 2003 10:03:32 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: insmod ipv6 freezes current linuxppc-2.5 and 2.5-benh
Message-ID: <20031213090332.GH8950@obroa-skai.de.gnumonks.org>
References: <20031120201249.GB29432@sunbeam.de.gnumonks.org> <1069386878.876.49.camel@gaston> <20031121153314.GC23224@sunbeam.de.gnumonks.org> <20031130155530.GK26749@obroa-skai.de.gnumonks.org> <1070380779.5675.16.camel@thor.asgaard.local>
Mime-Version: 1.0
In-Reply-To: <1070380779.5675.16.camel@thor.asgaard.local>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Dec 02, 2003 at 04:59:39PM +0100, Michel Dänzer wrote:
>
> On Sun, 2003-11-30 at 16:55, Harald Welte wrote:
> > On Fri, Nov 21, 2003 at 04:32:52PM +0100, Harald Welte wrote:
> > >
> > > On Fri, Nov 21, 2003 at 02:54:38PM +1100, Benjamin Herrenschmidt wrote:
> > >
> > > > Interesting. Same machine here and I use 2.6 everyday :)
> > >
> > > The problem seems to be gcc-related. Debian testing seems to have
> > > installed gcc-3.3.2 (yes, maybe not the best compiler for a kernel
> > > anyway) per default.
> > >
> > > compiling the same kernel with gcc-2.95 results in a working ipv6
> > > module.
> >
> > I did some more testing:
> >
> > Compiles with gcc-3.3.2 and gcc-3.2.3 result in a broken kernel,
> > gcc-3.0.4 and gcc-2.95.4 work fine.
>
> I've been running Ben's tree built with gcc-3.3 for a while (since
> test7-ish) without problems:
>
> What version of binutils do you have? Current from testing here.

the same here.  I can now even confirm the same problem on a different
machine, a dual G4 450, running debian testing.

The actual problem seems not to be an infinite loop, but rather a very
long loop.   IF you wait long enough, it will eventually work.  A
significant delay (i.e. assumed long loop) is also observed while
loading any module.  Something like 10 - 15 seconds for every module
that I'm loading during startup (ipv6, tulip, dmasound_pmac, ...)

The machine is completely frozen during that loop, not even the cursor
is blinking anymore.

compiling the kernel with gcc 2.95 or 3.0 removes those symptoms.

> --
> Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
