Message-ID: <3A541B7F.98ABCD9D@wanadoo.fr>
Date: Thu, 04 Jan 2001 07:43:11 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: bootc@worldnet.fr
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes in the Valkyrie driver from 2.1.24 to 2.2.18
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> On Wed, 3 Jan 2001, Chris Boot wrote:
> > It has struck me, after weeks of research, that my problems in booting my
> > 5400/180 cold through OpenFirmware are caused by changes in the Linux

Chris, are you trying to boot with Quik? This, in fact, stopped working
on the 5400/6400 around kernel 2.1.125, IIRC. What's wrong with using
BootX?

> > kernel.  This machine uses the Valkyrie display device, and in 2.1.24 this
> > is handled by directly accessing its memory, whereas in 2.2.18 it is
> > accessed through OpenFirmware.

The main change from 2.1.24 was to use the FB drivers structure. The
init through offb or through fbmem has no effect whatsoever if one boots
from BootX.

> >                                OpenFirmware is known to choke on this
> > machine when using the display (as in CLAIM failed).

And seeing people fight against this windmill was one of the motivations
for BenH to develop BootX in 1998.

> >
> > My suspicions were aroused when, after disabling CONFIG_FB, the machine
> > booted cold without any problems whatsoever.

And what display?

> >
> > Is it at all possible to use Valkyrie without going through OpenFirmware at
> > all?  It is not selectable if I disable CONFIG_FB_OF.  Would it be possible
> > to port the older non-OF driver to the newer kernel?  What are the
> > disadvantages of using the older memory-based driver to the newer OF-based
> > driver?
>
> Have you tried 2.4.0-testX yet?
>
> In 2.4.0-testX, valkyriefb is initialized without the help of offb.
> I don't have a 2.2.18 tree at hand, but you can probably use a similar method
> in 2.2.18 with some hacking (call valkyriefb_init() from drivers/video/fbmem.c,
> and not offb_init()).

Geert, this modification is contained in the 2.2.18 kernels from bk and
from Paul. It just didn't make it into the official 2.2.18 tree. But
most users of valkyrie probably don't care anyway.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
