Date: Tue, 27 Jul 1999 18:06:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Jerry Quinn <jquinn@nortelnetworks.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Ideas on improving powercomputing keyboard
In-Reply-To: <14237.54703.12309.139409@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.10.9907271758360.25029-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Jul 1999, Jerry Quinn wrote:
> Finally, there is a comment in the code (mac_kbd.c) from Anthony Tong about
> emulating the PC keyboard capslock key by immediately sending caps up as soon
> as it's pressed.  What is going on with this and how might it relate to what I 
> want to do?

Mac and Amiga keyboards handle Caps Lock in the keyboard itself: the keyboard
remembers the Caps Lock state.

If you press Caps Lock, a `Caps Lock down' code is sent by the keyboard. If
you release Caps Lock, nothing is sent.
If you press Caps Lock again, a `Caps Lock up' code is sent by the keyboard.
If you release Caps Lock, nothing is sent.

PC keyboards don't behave that way: there the computer has to remember the
Caps Lock state and the Caps Lock key behaves like any other key: it always
sents `Caps Lock down' when you press it, and sents `Caps Lock up' when you
release it.

To emulate this behavior, the Mac and Amiga keyboard driver always feeds two
codes (`Caps Lock down' followed by `Caps Lock up') to the upper keyboard layer
through handle_scancode() when the keyboard sent any of `Caps Lock down' or
`Caps Lock up'.

This works fine in most cases. The only problem is that the keyboard is not
stateless w.r.t. the Caps Lock key. If you press `Caps Lock' and switch to
another virtual console, the keyboard and the kernel disagree on the Caps Lock
state for that virtual console. Hence the virtual console still has Caps Lock
disabled, while the Caps Lock LED on the keyboard (or the mechanical up/down
flip-flop on older keyboards) is still lit.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
