Date: Fri, 25 Aug 2000 14:20:27 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Malcolm Purvis <malcolmpurvis@optushome.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Emulating button 3 on 2 button ADB mice.
In-Reply-To: <14758.21537.701471.542545@co3018576-a.rivrw1.nsw.optushome.com.au>
Message-ID: <Pine.LNX.4.10.10008251358120.6415-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> There is a problem in getting XFree86 4.0.1 to emulate the third mouse button
> with two button ADB devices, in my case a Kensington 'Orbit' trackball.
> Reviewing the archives, I see that variations of this problem have appeared in
> the past but there never has been a well publicised solution.
>
> In summary, my problem is:
>
> 1) The two buttons on the trackball map to buttons 1 and 2, when ideally they
>    should be 1 and 3.
>
> 2) I cannot get XFree86 to emulate the third button when I hold down both
>    buttons at once.
>
> It should be noted that a message was posted to this list nearly a year ago
> that exactly describes my symptoms:
>
> <http://lists.linuxppc.org/listarcs/linuxppc-dev/199909/msg00135.html>
>
> The suggested solutions, of using mousemode and xmodmap and the
> Emulate3Buttons XFree86 option, did not work for that poster, and it didn't
> work for me.
>
> The cause of the problem is that the kernel (in adbmouse.c) generates busmouse
> messages with the trackball buttons assigned to 1 and 2, but XFree86 (in
> input/mouse/mouce.c), when emulating the third mouse button, expects two
> button mice to have buttons 1 and 3!

Clearly X is broken if it assumes that sort of numbering :-) First, try
the magic new input device layer. If that doesn't fix it, we'd need a way
to recognize real two button mice from the ADB packets the busmouse driver
sees. If there's a clear way to tell the number of mouse buttons inside
the adbmouse interrupt handler I see no problem remapping 2 to 3 there
(other than the busmouse driver being OLD_CRAP and scheduled to
disappear).

FWIW: the assumption that the second mouse button is counted as middle
button is used throughout mouse_input and later code (even for the
inputdev sections). Think twice before you suggest breaking this.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
