Date: Mon, 1 Feb 1999 13:08:39 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
cc: Owen Waller <O.Waller@ee.qub.ac.uk>, dhiltgen@toocool.itslab.calpoly.edu,
        mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <1EDE67B39D1@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.03.9902011301580.17350-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Petr Vandrovec Ing. VTEI wrote:
> On  1 Feb 99 at 11:35, Owen Waller wrote:
> > > (my PReP does not have OF and I never saw it...) If you uncommented #define
> > > above, be sure that you commented out complement part from
> > > drivers/video/offb.c - otherwise matroxfb can be initialized twice, thus
> > > you'll get two fb's per one hardware :-(
> > Is there any way that this could be changed? I don't need my internal
> > video (control) to work, but I'd rather have it and the matrox compiled
> > into the one kernel without a hack. Unless Geert you know some way of
> > "fudging" an non-OF card into the OF device tree? OR Petr could you
> > possibly work in a #define construct so that Daniel's "hack" became
> > official? (mind you neither of these are very general solutions).
> There is a problem. What if you HAVE matrox in OF ? Of course,

Yes, Mac Matrox boards appear in the OF tree.

> I remove this #ifdef from driver and add some variable to ensure, that
> driver will be initialized only once... And if matroxfb is not your primary
> head, you can, as temporary solution, compile it as module. It should
> work without problems then.

This is indeed a problem. We should use something like request_region() to
claim the space used by the board. That way we can make sure each board is
initialized only once. Boards that are left uninitialized and that appear in
the OF tree should be handled by offb as a last resort.

> > Also does anybody know how this situation changes if you use BootX to boot
> > (I don't so I can't comment on this). Would BootX map the mystique from
> As I do not have anything with OF around here, tell me what you want
> and I'll do it...

Since BootX creates a fake OF device tree, I suspect it to appear in the tree.
Can you use your Mystique under MacOS? This is of course a prerequisite for
BootX seeing your board.

> P.P.S.: Should not I remove whole #ifdef CONFIG_FB_OF from driver?
> Is there anybody who uses this additional feature?

If you remove it, Matrox boards will be initialized by both matroxfb and offb
(unless you disable offb completely, but then other boards like control are no
longer found), which is not what we want.

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
