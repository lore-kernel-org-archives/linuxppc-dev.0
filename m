From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14237.57911.114344.251740@gargle.gargle.HOWL>
Date: Tue, 27 Jul 1999 12:45:43 -0400 (EDT)
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Ideas on improving powercomputing keyboard
In-Reply-To: <Pine.LNX.4.10.9907271758360.25029-100000@mercator.cs.kuleuven.ac.be>
References: <14237.54703.12309.139409@gargle.gargle.HOWL> <Pine.LNX.4.10.9907271758360.25029-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> "Geert" == Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> writes:

 Geert> On Tue, 27 Jul 1999, Jerry Quinn wrote:
 >> Finally, there is a comment in the code (mac_kbd.c) from Anthony Tong
 >> about emulating the PC keyboard capslock key by immediately sending caps
 >> up as soon as it's pressed.  What is going on with this and how might it
 >> relate to what I want to do?

 Geert> Mac and Amiga keyboards handle Caps Lock in the keyboard itself: the
 Geert> keyboard remembers the Caps Lock state.

 Geert> If you press Caps Lock, a `Caps Lock down' code is sent by the
 Geert> keyboard. If you release Caps Lock, nothing is sent.  If you press
 Geert> Caps Lock again, a `Caps Lock up' code is sent by the keyboard.  If
 Geert> you release Caps Lock, nothing is sent.

 Geert> PC keyboards don't behave that way: there the computer has to remember
 Geert> the Caps Lock state and the Caps Lock key behaves like any other key:
 Geert> it always sents `Caps Lock down' when you press it, and sents `Caps
 Geert> Lock up' when you release it.

 Geert> To emulate this behavior, the Mac and Amiga keyboard driver always
 Geert> feeds two codes (`Caps Lock down' followed by `Caps Lock up') to the
 Geert> upper keyboard layer through handle_scancode() when the keyboard sent
 Geert> any of `Caps Lock down' or `Caps Lock up'.

OK, I think I understand this.  So, what I'm trying to do is get a
powercomputing keyboard, which fortunately doesn't have a mechanical lock but
does have this broken 0x80 behavior to act like a PC keyboard.

It sounds like I need to disable the down/up output behavior for a
powercomputing keyboard and add the state logic I described including ignoring
the difference between the keyboard's notion of down and up.  However, this
sounds like I'm going to break other keyboards.

Is there any way to probe a keyboard and get some info out of it so that this
stuff can be detected rather than compile-time configured?

By the way, do you have any comments on whether my idea makes sense?

Jerry

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
