Date: Fri, 16 Nov 2001 19:18:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116191832.D9923@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net> <20011116094210.B3473@beef.az.mvista.com> <20011116101323.B9242@cpe-24-221-152-185.az.sprintbbd.net> <3BF5A01D.4040502@embeddededge.com> <20011117114330.G12763@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011117114330.G12763@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Nov 17, 2001 at 11:43:30AM +1100, David Gibson wrote:
> On Fri, Nov 16, 2001 at 06:24:13PM -0500, Dan Malek wrote:
> > >I think right now, 4xx is done in a different way intentionally.
> >
> > I'm not so sure :-).  I think it started off badly, is getting better,
> > and from these discussions we have clearly learned how to better
> > structure the software.  From the variety of 4xx projects I have worked
> > on, I'm still making the kinds of changes to better utilize and structure
> > existing software.  I feel like I'm doing the same thing I did years ago
> > with the 8xx, only back then no one cared what I was doing (because it
> > was some embedded stuff that didn't seem to interest anyone :-).
> >
> > >..... There's common
> > >ground, with hooks for board-specific stuff.
> >
> > I could argue the 7xx stuff is this way as well.  Every board should
> > probably
> > have a platform_init() that calls the processor architecture unique
> > functions.
> > I am a little confused that there doesn't seem to be as many platform_init()
> > calls as there are boards we support (just 'grep for it' in the kernel
> > directory).  So, there is probably work to do for all boards we support.
>
> That's exactly my point:  platform_init() for *all* 4xx boards is in
> ppc4xx_setup.c, which then calls a board_init() function which comes
> from the particular board.

Right.  And for all of the 7xx boards it's in platforms/board.c.

> > It seems we should call some early architecture generic init functions (if
> > necessary), then platform init, then more general architecture functions
> > if necessary.
>
> No need - the board's platform_init() can call the processor general
> functions if necessary.

But why not do this once instead of many times?  Right now, each of the
405GP 'board' file would look awful similar.  I think what Dan said
before is we need to break things up into logical and somewhat
independant units.  I think we can make ppc4xx_setup.c::platform_init
smart enough so that it works by calling out to the specific parts it
needs to.  The 'correct' order for things, which we're getting closer to
but aren't yet is 4xx-always stuff, which isn't much and could be less.
Then board bits, and then core bits.  But the thing is in general terms
a 405GP 'board' will always have certain things.  A STB03xxx will have
certain things.  So why not have common names for the processor-specific
stuff we want and then call it?  Eg on 405GP we get ppc_405gp.c and
4xx_do_foo is the 405GP version.  Or if we're 403GCX it's that version,
and so on.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
