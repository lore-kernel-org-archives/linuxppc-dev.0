Message-Id: <200009190513.GAA14252@hyperion.valhalla.net>
Date: Tue, 19 Sep 2000 06:13:46 +0100
Subject: Updated dmasound patch to ed19.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list,

I've just updated the dmasound back-port patch (2.2.17/18) to ed19 (my
third, it's 19th ;-)  I will try to do a 2.4.0-t8 version in the next few
days.

BTW: the module is now called dmasound_pmac.o
(reflecting an intention to roll in DACA along with the existing AWACS,
Screamer & Burgundy Codec support).

It's on www.sourceforge.net/projects/ppclinux/
and www.drfruitcake.com/linux/linuxppc.html (check out the Penguin PPC all
star band...)

This ed rolls in:
 the comments/changes made by Geert to the RFC
 pismo fixes by Matthias & Ben H
 pismo & build-in testing by Henry
 testing by Jiri, Gwyn, Steffen and others...

It is OK against linux-pmac-benh (2.2.18-p4-b1) and applied successfully to
linux-pmac-stable.

It is worth trying esp. if you have a newer PMac - several people have
reported sound OK with it (e.g. iMac DV) where the monolithic doesn't quite
happen...  but, of course, this should apply equally to 2.4.0...

*record works for me* with it... (I used SoX 12.17 to test)

Bug-fixes:
    read() should no longer crash the kernel if you try with an unsupported
translation.
   the ioremap() AWACS  window is now correct size (may make no difference
depending on ioremap()'s granularity). but, you never know, it just might
make byte-swapping work on some machines that didn't before...

Changes:
    SNDCTL_DSP_GETOPTS added - may be useful for some userland apps (I had a
report that at least one needs it to work)
   SNDCTL_DSP_GETFMTS now works as per OSS Doc. - this may help userland
apps decide on the right settings.

Numerous small things to try and help figure out the different PMac models &
sample rates etc.

More info in /dev/sndstat about the h'ware.

====

Other archs... I'm not ignoring them.  The changes should apply equally (if
someone knows the right things to put in - about 10 lines of code needed for
each).  I just don't have any way of testing for those machines...

On the other hand, if you do nothing, then they should behave as they did
before (barring Geert's comment that the changes hadn't been compiled or
tested ;-).

====

This is (probably) the last one in this form.  The (Pmac) code is getting
very messy with lots of measures to check for different PMac models/audio
setups.  I'm about to do a more major re-write of that section.

====

Thanks very much to all testers & contributors esp.:
Geert - for comments on both style & substance ;-) ....
Matthias, Ben H & Henry for pismo fixings & testings
Jiri for spotting the read() crash...
Steffen & Gwyn for endian-ness testing

& to Ben H - for putting up with more than his fair share of dumb questions
;-)

Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
