Date: Fri, 10 Mar 2000 19:25:23 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Michel Dänzer <michdaen@iiic.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
   cwithr128
In-Reply-To: <v03110700b4eec4979817@[129.100.29.243]>
Message-ID: <Pine.LNX.4.21.0003101831430.19076-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 Mar 2000, Kevin B. Hendricks wrote:

> Hi,
>
> So Xfree 4.0 final is out but without the very last minute cache flushing
> changes Kostas made.
>
> So we should probably get some official patch out there that includes a few
> elements:
>

  What do you mean by official ? The next xfree86 update will have
this fix what more official do you suggest ?

> 1. Either:
>        - user defined cache line size during compile
>    or:
>        - flush a cache range in address increments of 8
>
> to handle the variable line cache size
>

  Glibc assumes a line size of 16 so that will be ok, in any
case the cache flush will be used only in the startup of the
xserver not need to worry about a few extra instructions there
so we can live even with 4byte increments, definitely better than
a compile time option.

> 2. And something to figure out if we are on a 601 machine in the
> NuBus X100 machines to properly do a "sync or eieio" so that XFree86 4.0
> cache flushing and synchronization for io has some chance of working under
> MkLinux R1.
>
> David can you tell me how the 601 problems with sync and eieio are
> detected and handled in user space apps under MkLinux?
>
   Hmm i don't think that xfree86 4.0 will work under mklinux, there
aren't any drivers that will work under mk anymore (xpmac is gone and
the vgahw/fbdev based ones won't work).

> Thanks,
>
> Kevin
>

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
