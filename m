Date: Mon, 1 Feb 1999 15:30:25 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Cc: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>,
        dhiltgen@toocool.itslab.calpoly.edu, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <Pine.LNX.4.03.9902011301580.17350-100000@mercator.cs.kuleuven.ac.be>
Message-Id: <Pine.SGI.4.02A.9902011514570.11398-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> > > > (my PReP does not have OF and I never saw it...) If you uncommented #define
> > > > above, be sure that you commented out complement part from
> > > > drivers/video/offb.c - otherwise matroxfb can be initialized twice, thus
> > > > you'll get two fb's per one hardware :-(
> > > Is there any way that this could be changed? I don't need my internal
> > > video (control) to work, but I'd rather have it and the matrox compiled
> > > into the one kernel without a hack. Unless Geert you know some way of
> > > "fudging" an non-OF card into the OF device tree? OR Petr could you
> > > possibly work in a #define construct so that Daniel's "hack" became
> > > official? (mind you neither of these are very general solutions).
> > There is a problem. What if you HAVE matrox in OF ? Of course,
> Yes, Mac Matrox boards appear in the OF tree.

o.k. well the x86 board definelty doesn't... So we now have a more general
problem:

If I have two idential video boards in my Mac one "mac" specific which
shows up in the OF tree, and one that is x86 sourced and doesn't show up
under OF how can we initialise both boards correctly.

> > I remove this #ifdef from driver and add some variable to ensure, that
> > driver will be initialized only once... And if matroxfb is not your primary

im my case matroxfb will become my primary head, but I'd still like access
to the internal (control) video in case soemthing in a new kernel dies
before matroxfb is initialised.

> > head, you can, as temporary solution, compile it as module. It should
> > work without problems then.
> This is indeed a problem. We should use something like request_region() to
> claim the space used by the board. That way we can make sure each board is
> initialized only once. Boards that are left uninitialized and that appear in
> the OF tree should be handled by offb as a last resort.

Geert, I'm not sure what you are saying here. So you mean that an non-OF
board whould "somehow" be initialised by another driver, and then the OF
tree checked for uninitialised devices? Which in this case would
presumably be the other "mac" specific video board. 

> > > Also does anybody know how this situation changes if you use BootX to boot
> > > (I don't so I can't comment on this). Would BootX map the mystique from
> > As I do not have anything with OF around here, tell me what you want
> > and I'll do it...
> Since BootX creates a fake OF device tree, I suspect it to appear in the tree.
> Can you use your Mystique under MacOS? This is of course a prerequisite for
> BootX seeing your board.

Nope, the card isn't seen (AFAIK) by MacOS. The card was designed for x86
systems so there never was an MacOS driver for it. So unless BootX does
something very fancy when it builds an OF device tree, I guess it would
miss it too.

> > P.P.S.: Should not I remove whole #ifdef CONFIG_FB_OF from driver?
> > Is there anybody who uses this additional feature?
> If you remove it, Matrox boards will be initialized by both matroxfb and offb

If my board isn't seen by OF, then by taking Daniel's hack I only
initialise once by matroxfb correct? So this is only a probelm if the card
is seen by OF and another driver (in the case of a Mac/OF specific Matrox
card)

> (unless you disable offb completely, but then other boards like control are no
> longer found), which is not what we want.

Exactly.

-------------------------------------------------------------------------
Owen Waller                     |   "...sometimes I think I'm a little
PhD. Student in Control Eng.    |    more English than I am French..."
Queens University               |              - Alain Prost 
Belfast                         |
Tele: +44 (0)1232 274085        |    Fax: +44 (0)1232 667023


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
