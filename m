Message-ID: <39A25283.1A7B0E3C@relog.ch>
Date: Tue, 22 Aug 2000 12:14:27 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
References: <Pine.LNX.4.10.10008221141390.377-100000@cassiopeia.home>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> > Anyway, what do you think about the patch I posted? Michel, can you please
> > try it? I don't think having to use ShadowFB with the fbdev driver is too
> > bad because it should generally enhance performance :) If the patch is
> > okay, I'll submit it to XFree86.
>
> I never read any XFree86 4.0 code.
>
> I know ShadowFB is faster for machines without hardware acceleration. But is
> it also faster with hardware acceleration?

ShadowFB and hardware acceleration are mutually exclusive (except for hardware
cursor and other things I am forgetting). With ShadowFB, the framebuffer is in
main RAM and only the updated parts are copied to video RAM.

However, as the fbdev driver has no acceleration, this doesn't matter, and
ShadowFB is a win in most cases. And for the other drivers which use fbdevhw,
the assumption 'displayWidth == virtualX' holds, so they work correctly
without ShadowFB.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
