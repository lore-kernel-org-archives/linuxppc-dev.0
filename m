Message-Id: <200007072232.XAA14475@hyperion.valhalla.net>
Date: Fri, 07 Jul 2000 23:31:59 +0100
Subject: [ANN] Dmasound backport to 2.2.17pre7/10 patch 
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Lars Magne Ingebrigtsen <larsi@gnus.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi List,

Thanks to Lars (just the first to reply - no other selection process ;-)

Here it is:

> <URL: http://quimby.gnus.org/circus/dmasound_backport.patch.bz2>

enjoy...

original post:

hello all,

This may/may not help those who are experiencing X lock-up with sound
(although I've never had the problem myself).

I have done a backport of Geert's split-up dmasound stuff to 2.2.17pre7.
Thanks to Geert for helpful suggestions in doing this.

The problem is that the patch is **too big** to put as an attachment to the
list....

Anyone able to provide a place for it? [50-ish kb as bz2]....
If anyone's desperate (i.e. those having actual real-now-problems) I can
e-mail.


It is against linuxcare linux-pmac-stable and OK against linux-pmac-benh as
well.

WHAT IT DOES:

there's a new drivers/sound/dmasound this contains a split-up version of
the multi-platform dmasound.c

It *should* add sound input to the Pmac - but that doesn't work reliably yet
(I suspect weirdness with the mixer abstraction - see below).  No crash but,
then, no recorded sound either.  I'll be on this a bit later on.

WHAT I'VE TESTED:

G3 AWACS Rev 3 with/without build as modules.
I will do G3/Lombard (IIRC has the burgundy AWACS).
I will do G4 just as soon as I get to setting it up :-)

WHAT I DIDN'T DO:

The other platforms - if it is not obvious what is needed - (add call to
dmasound_???_init() into drivers/char/mem.c and fix up the module/no module
stuff in drivers/sound/dmasound_????.c) then e-mail me off list and I'll
have a go.  BUT I've got no h'ware other than Pmac to test on.

TO DO:

Sort out mixer abstraction weirdness - there's definitely some funny
behaviour using kmixer - sometimes the stereo attribute is recognised -
sometimes not.

Sort out what is slowing things down when the buffer size is reduced:

we should be able to achieve 11ms output latency with AWACS.

Please test & comment (but send flames to /dev/null - this is my first
backport ;-)

ciao,
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
