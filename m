Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 30 Dec 2002 08:29:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
Message-ID: <20021230152945.GD5564@opus.bloom.county>
References: <20021223151254.GC15397@opus.bloom.county> <20021228002750.B4A70C6139@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021228002750.B4A70C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Dec 28, 2002 at 01:27:45AM +0100, Wolfgang Denk wrote:
> In message <20021223151254.GC15397@opus.bloom.county> you wrote:
> >
> > > It makes the following modifications to the MPC8xx FEC driver:
> > >
> > > - change PHY configuration from #define to kernel config mechanism
> > > - add support for AMD79C874 PHY
> >
> > Both of these look OK, but can you please split this out into a seperate
> > patch which just does PHY configuration and then adds AMD79C874 support?
>
> Of course I can.
>
> PHY configuration ==> patch.1
> add AMD79C874 support ==> patch.2

Thank you, I'm going to take out the part where it defines
CONFIG_SCCSX_ENET=n when none are selected, as things like that
should never need to be done (and if needed, there's a bug there) and
commit those.

> > > - add multicast support
> >
> > Sounds fine, but can you split this portion of the code from the rest of
> > the patch please?  Thanks.
>
> Of course I can.
>
> cleanup & add multicast support ==> patch.3

Now I have to question some of the 'cleanup'.  A lot of it is just
whitespace / braces.  IMHO, and what I did with the OCP drivers, if
scripts/Lindent is 'happy', then that's good enough.  Also, is there any
reason to go from 'volatile uint *s = &(...->...);' to 'uint s =
...->...;' ?  Maybe it's too early in the morning for me, but why
couldn't it be just 'uint *s', if that volatile isn't needed?
This is on hold for now, and for future patches please keep cleanup
seperate from functionality as much as possible.

> But really, why do I have to do this?

As you are the person submitting these patches, you should have the most
knowledge of what's going on and why.  I could have split out patches 1
and 2 and probably dropped the FEC_PACKETHOOK stuff, but I would have
probably dropped some of the 'cleanup' portion, it would have taken me
longer, and while it's not so obvious with this set of patches, I don't
always have access to the same HW you do, so if you can send out tested
patches which I don't change, there's a good chance that things will
still work :)

> I'm pretty sure you can read the patch as  is  so  you  are  able  to
> either  complain about stuff you don't like or to accept these things
> in one patch. Is this just some form  of  bullying,  or  is  there  a
> rational reason behind this requirement?

When things go upstream, we really have to split things up into logical
chunks.  Furthermore, if there happens to be a problem with some portion
of a patch which does N things, all of those N things don't get in until
the whole patch is 'good'.

I don't like to think of it as 'bullying', but more 'passing the buck'.
Linus / Marcelo don't like big patches from anyone, and now that they
both use BK, it is nice to have a good history.  And I try and pass
this along to everyone, including myself.

> > > - add PACKETHOOK support
> >
> > This was removed, intentionally back on March 22nd, 2002.  From what I
> > recall, it was decided this code was broken / unmaintained and should be
> > yanked.  Have you tested this particular section of code to verify it
> > still compiles and works as expected?
> >
> > In sum: On hold for now.
>
> If that was a decision I'm not in the  position  to  discuss  such  a
> things. Just forget it.

It was removed since no one wanted to maintain it and it didn't work as
is.  If you would like to maintain this bit of code it can come back (as
it wasn't the concept which was the problem, it was the code being
non-functional).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
