Date: Mon, 1 Feb 1999 11:04:59 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
cc: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>,
        O.Waller@ee.qub.ac.uk, mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <1EB9B063356@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.03.9902011101440.17350-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Petr Vandrovec Ing. VTEI wrote:
> Strange. I tried two fbdev servers (on i386) and they both works. There is
> only one problem I know of: only one, foreground, server updates screen.
> I think that fbdev server thinks that he is not visible when it gets

The console subsystem isn't yet multi-head aware. The X server shouldn't
receive the console switch signal when you switch to another VC on a different
frame buffer device. But to make that work and make really use of that, we need
support for multiple input devices first.

> console switch signal... SVGA server even switches into textmode... But
> they work in paralell. Also, maybe that you should run X on fb1 using

Yes, XF86_SVGA switches to text mode on VC switch. BTW, have you tried
XF86_SVGA with Gerd Knorr's patches to make it use fbdev? I assume that one
will keep the display image on VC switch.

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
