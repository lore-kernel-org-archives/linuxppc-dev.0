Message-ID: <398ADB57.9ABEDC6F@student.ethz.ch>
Date: Fri, 04 Aug 2000 17:03:51 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: SteffenH@hyperion-software.de, Iain Sandoe <iain@sandoe.co.uk>,
        takashi oe <toe@unlserve.unl.edu>, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Kind of success! (r128 on PPC (Re: LinuxPPC X Server))
References: <Pine.LNX.4.21.0008031541210.6020-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[For the linuxppc-dev people: this is about the DRI CVS trunk]

Kostas Gewrgiou wrote:

> > GL clients even seem to attempt direct rendering now, however I get one of
> > two different errors every time:
> >
> > Error: Rage 128 timed out... exiting
> >
> > Error: Could not submit packet... exiting
>
>   From what i see the problem is probably in the R128_READ/WRITE macros in
> r128_drv.h you need byteswapping functions there (and memory barriers as
> usual).

That did it, thanks! I changed those macros to use the same inline functions
which are used for MMIO_{IN,OUT} on PPC, and here we go!


The remaining problems are:

16 bit doesn't work neither with fbdev (colors completely off - does aty128fb
still use 15 bit in fact?) nor without (at least the grey tones are right
there - wrong endianness?)

At 32 bit, it flickers badly on my Pismo, probably because it only has 8 megs
of VRAM. (These messages appear in the log:
(EE) r128(0): Unable to reserve depth buffer
(EE) r128(0): Unable to reserve texture space in frame buffer
) Curious how it works out for people with more...


About performance: It's much better than software rendering (at least for big
windows) of course, however not too fast with lots of polygons. AGP GART would
definitely be a good thing I guess (Ben: hint, hint :)


Still, big kudos to the DRI team for a great work!

Michel


--
Sometimes you have to stride boldly up to life,
 look it straight in the eye, and say "huh?"
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
