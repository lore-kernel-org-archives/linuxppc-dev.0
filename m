Date: Fri, 10 Mar 2000 11:43:59 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp    cwithr128
In-Reply-To: <v03110700b4eec4979817@[129.100.29.243]>
Message-ID: <Pine.LNX.3.96.1000310114132.26527C-100000@deepspace.mklinux.org>
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
> 1. Either:
>        - user defined cache line size during compile
>    or:
>        - flush a cache range in address increments of 8
>
> to handle the variable line cache size
>
> 2. And something to figure out if we are on a 601 machine in the
> NuBus X100 machines to properly do a "sync or eieio" so that XFree86 4.0
> cache flushing and synchronization for io has some chance of working under
> MkLinux R1.
>
> David can you tell me how the 601 problems with sync and eieio are
> detected and handled in user space apps under MkLinux?

They aren't.  User space apps don't ever flush the cache currently.  In
kernel space, it does this:

#define eieio()         __asm__ volatile("li 0,0; cmpwi 0,0; bne+ 0f;
eieio; 0:" : : : "0")
#define sync()          __asm__ volatile("li 0,0; cmpwi 0,0; bne+ 0f;
sync; 0:" : : : "0")



David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
