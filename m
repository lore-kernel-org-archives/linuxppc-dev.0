Message-ID: <975932158.3a2b8afe69611@rascal.ums.easynet.net>
Date: Mon, 04 Dec 2000 12:15:58 +0000
To: linuxppc-dev@lists.linuxppc.org
From: "Simon Stapleton" <simon@tufty.co.uk>
Subject: Re: No Backlight Control in 2.2.18pre21
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Subject says it: with current linux-pmac-stable kernels, the
> backlight control via [Fn-]F{1,2} does not work, neither
> dimming nor turning off the LCD altogether, on a PB Lombard
> at least.
> Might have been this way since the CONFIG_PMAC section appeared,
> in any case, in 2.4.0-test11 there is a CONFIG_PMAC_BACKLIGHT
> option, and backlight control is working (I've set it to "=y",
> of course).

Funny you should mention this.  I was about to pen a missive along
the same lines.  I noticed it this very weekend when getting back
to hacking together ADB Wacom support (not necessarily coming
any time soon, BTW)

The problem appears, to me at least, that if you use the USB
backport code the powerbook buttons stuff doesn't get included.
I think somewhere a CONFIG_PMAC_BACKLIGHT is being missed, but
I may well be wrong.  Changing CONFIG_PMAC_BACKLIGHT to
CONFIG_PMAC_PBOOK seems to fix the problem (and seems to make
more sense as we're dealing with powerbook button devices here.
Or are we?  What about the buttons on the front of some of the
older pmacs, and on the apple monitors?  I assume these are all
ADB devices.  I can't test the monitor stuff as my 1710 decided
it doesn't want to start up recently.  Bah.)

In a related note, I've been looking at the code that does this.
I had a patch under 2.2.17 to make the volume and mute buttons work
on my wallstreet, and was wanting to reinstate it - the original
patch won't work but the coding seems (relatively) simple.

So - a couple of questions.

1: What is labelled as the 'contrast' button is actually the
   wallstreet volume control.  Is this the case for other Pbooks?
   (I can probably get hold of a 3400 to test, but kangas, lombards
   and the like are all unreachable).  If this _is_ the case, could
   we rename the constant?
2: Getting to the sound device.  This is probably a stupid question,
   but here goes anyway... The sound device is controllable from
   userland via the /dev/mixer ioctl, as far as I can see.  Can I
   use this from within the kernel, or is that a big no-no?  I don't
   like the idea of putting extra helpers in the sound code (or even
   using existing ones directly), as there's no guarantee that sound
   support has been built in.  And I _really_ don't like lots more
   #ifdef's in the code.

Thoughts, comments, flames?

Simon

--
Your mouse has moved.  You must reboot Windows NT for these changes to be
recognised.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
