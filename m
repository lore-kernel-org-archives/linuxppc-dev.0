Message-ID: <39853D27.8F4F5500@relog.ch>
Date: Mon, 31 Jul 2000 10:47:35 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: SteffenH@hyperion-software.de
CC: Iain Sandoe <iain@sandoe.co.uk>, takashi oe <toe@unlserve.unl.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
References: <yam8247.965.146578880@mail.lf-online.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steffen Haeuser wrote:

> >> Do I also need to enable different support in the kernel?
> >> (e.g. /dev/agpart support ?)
>
> >That would be good, but AFAIK there's no such thing for our hardware yet.
>
> Exactly this is AFAIK currently the problem as to 3D Hardware support...
> the /dev/agpart support...

agpgart was required _for r128 DRI_ until some time ago. It's possible that
it's still needed by the driver in X 4.0.1 but definitely not in the latest
DRI CVS.

> a solution might be to use GLX instead of DRI ... after all since 4.0 Beta X
> Server Driver there *is* support for GLX in the LinuxPPC X Server...

Yep, and DRI adds hardware acceleration to it.


> >You'll have to go to
> >xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel and do make -f
> >Makefile.linux (won't build out of the box - I've added '#include
> ><asm/pgtable.h> to drmP.h and changed the function in r128_dma.c containing
> >i386 assembly to just call mb() - anyone knows if this makes sense?) and
> > then modprobe r128.o
>
> Hmmm... what sort of ASM is this ?

It's for flushing write combining buffers AFAIR, thus I thought an mb() should
do on PPC.

> Is this the only reason why agpart is not supported on Mac yet, some lines
> of ASM ?

This is not about agpgart at all but about the DRM (direct rendering manager,
the kernel part of DRI) kernel module.

> (Well, AFAIK it is not even confirmed if this AGPart thing works with PCI,
> but AFAIK it was said that it "should").

PCI is not AGP, thus I don't think agpgart can work on PCI. There's also PCI
GART, but there isn't PPC support for it either yet.


> The most clever thing probably would be to do a GLX Driver (which does not
> require this AGPart thing...). Of course all also depends if Chipset
> information is available.
> To do such a driver should be possible in 3-4 weeks at most... I know of
> what I am speaking as before Hyperion existed people of our company did the
> 3D Drivers for the Amiga 3D Boards, and I know how long THEY took for a 3D
> Driver... (and before someone asks: No, these people are 100% busy with game
> coding now... no time for drivers...).

I doubt it would be as easy on Linux - much more complexity to deal with than
on AmigaOS :)


Michel


--
Hark! What rock through yonder window breaks?
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
