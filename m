Message-Id: <5.0.0.13.2.20000825143508.01cb48f0@mail.munich.netsurf.de>
Date: Fri, 25 Aug 2000 15:02:05 +0200
To: Malcolm Purvis <malcolmpurvis@optushome.com.au>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Emulating button 3 on 2 button ADB mice.
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <14758.21537.701471.542545@co3018576-a.rivrw1.nsw.optushome
 .com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 13:10 25.08.00, Malcolm Purvis wrote:

>There is a problem in getting XFree86 4.0.1 to emulate the third mouse button
>with two button ADB devices, in my case a Kensington 'Orbit' trackball.
>Reviewing the archives, I see that variations of this problem have appeared in
>the past but there never has been a well publicised solution.
>
>In summary, my problem is:
>
>1) The two buttons on the trackball map to buttons 1 and 2, when ideally they
>    should be 1 and 3.
>
>2) I cannot get XFree86 to emulate the third button when I hold down both
>    buttons at once.
>
>It should be noted that a message was posted to this list nearly a year ago
>that exactly describes my symptoms:
>
><http://lists.linuxppc.org/listarcs/linuxppc-dev/199909/msg00135.html>
>
>The suggested solutions, of using mousemode and xmodmap and the
>Emulate3Buttons XFree86 option, did not work for that poster, and it didn't
>work for me.
>
>The cause of the problem is that the kernel (in adbmouse.c) generates busmouse
>messages with the trackball buttons assigned to 1 and 2, but XFree86 (in
>input/mouse/mouce.c), when emulating the third mouse button, expects two
>button mice to have buttons 1 and 3!
>
>(Note that this is cannot be fixed with xmodmap because it is the button
>numbers the device driver is returning, not the X server.)
>
>I have written a small hack for XFree86 that switches buttons 2 and 3 on bus
>mice when appropriate.  The question is, is this the right place to put the
>fix?  It's a very device specific solution, so really shouldn't go in user
>space but, conversely, how many other programs expect the kernel to set
>buttons 1 and 2 for two button mice instead of 1 and 3?
>
>I welcome suggestions as to where to put the fix so I can submit it to the
>right people.

Well, I can add it to the kernel, send me the output of "dmesg|grep -iw
adb", if possible use a recent 2.2 benh kernel for that.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
