Date: Mon, 1 Feb 1999 17:18:23 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Owen Waller <O.Waller@ee.qub.ac.uk>
cc: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>,
        dhiltgen@toocool.itslab.calpoly.edu, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <Pine.SGI.4.02A.9902011514570.11398-100000@myst.ee.qub.ac.uk>
Message-ID: <Pine.LNX.4.03.9902011705480.17350-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Owen Waller wrote:
> > > There is a problem. What if you HAVE matrox in OF ? Of course,
> > Yes, Mac Matrox boards appear in the OF tree.
> 
> o.k. well the x86 board definelty doesn't... So we now have a more general
> problem:
> 
> If I have two idential video boards in my Mac one "mac" specific which
> shows up in the OF tree, and one that is x86 sourced and doesn't show up
> under OF how can we initialise both boards correctly.

That's indeed a case the problem will show up.

> > > I remove this #ifdef from driver and add some variable to ensure, that
> > > driver will be initialized only once... And if matroxfb is not your primary
> 
> im my case matroxfb will become my primary head, but I'd still like access
> to the internal (control) video in case soemthing in a new kernel dies
> before matroxfb is initialised.

So you need both offb+controlfb and matroxfb in your kernel.

> > > head, you can, as temporary solution, compile it as module. It should
> > > work without problems then.
> > This is indeed a problem. We should use something like request_region() to
> > claim the space used by the board. That way we can make sure each board is
> > initialized only once. Boards that are left uninitialized and that appear in
> > the OF tree should be handled by offb as a last resort.
> 
> Geert, I'm not sure what you are saying here. So you mean that an non-OF
> board whould "somehow" be initialised by another driver, and then the OF
> tree checked for uninitialised devices? Which in this case would
> presumably be the other "mac" specific video board. 

Suppose you have three boards:

  1. controlfb (in OF tree)
  2. Mac Matrox (in OF tree)
  3. normal Matrox (not in OF tree)

Offb will walk the OF tree and call the controlfb init routine for board 1 and
the matroxfb init routine for board 2. Board 3 will not be initialized. Hence
you have two frame buffer devices: fb0 and fb1.

Now suppose you modify matroxfb to not use OF probing, but PCI probing. You
also have to remove the test for `MTRX' in offb.c. Result: Offb will walk the
OF tree and call the controlfb init routine for board 1. It will see board 2 in
the OF tree and consider it as an `unknown' OF-capable board. So you have 2
frame buffer devices fb0 and fb1. Furthermore the PCI probing in matroxfb will
see both boards 2 and 3, and you end up with 2 more buffer devices fb2 and fb3.
But fb1 and fb1 are the same board!

A possible solution would be to ignore OF-capable boards (`MTRX') if matroxfb
is configured, and to always use PCI probing in matroxfb. The same is true for
ATI boards (atyfb can do PCI probing as well).

However, the best fix (IMHO) would be:

  1. Use a request_region() alike function to claim the frame buffer address
     region. This would make sure no more than one driver can claim the frame
     buffer of each board.
  2. Always use PCI probing in the chip specific drivers.
  3. Initialize offb only after all chip specific drivers, so offb is used as a
     fallback in case no other driver has claimed the board before.

Whether e.g. controlfb and the other Mac specific chipsets should use PCI
probing or be called by offb (as is currently done) is left out of the
discussion.

> > > P.P.S.: Should not I remove whole #ifdef CONFIG_FB_OF from driver?
> > > Is there anybody who uses this additional feature?
> > If you remove it, Matrox boards will be initialized by both matroxfb and offb
> 
> If my board isn't seen by OF, then by taking Daniel's hack I only
> initialise once by matroxfb correct? So this is only a probelm if the card
> is seen by OF and another driver (in the case of a Mac/OF specific Matrox
> card)

What's Daniel's hack?

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
