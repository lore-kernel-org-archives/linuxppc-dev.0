Message-ID: <39852FD8.81721638@relog.ch>
Date: Mon, 31 Jul 2000 09:50:48 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: SteffenH@hyperion-software.de, takashi oe <toe@unlserve.unl.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
References: <200007302032.VAA26494@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> > Before building, you should have copied xc/config/cf/{xf86site,host}.def
> >
> > Then edit the newly created host.def - you probably only want to build the
> > server and drivers, and choose the drivers you want.
>
> Oh-oh.
>
> This was a step missing from the instructions :-(
>
> Maybe I complied a lot more than necessary (and hence the time)...

Probably.


> Would I need to build all the apps once (so that they are compatible?).

Not absolutely. Servers and clients should be compatible at any version each
(apart from a few issues, of course ;)


> After that, I suppose, I just rebuild the driver when the rsync changes...

Yep, make -C xc/programs/Xserver should do. (And copying the modules to the
ModulePath again)


> > For DRI, you may have to edit even more files in config/cf/, AFAIK DRI is
> > only built on i386 by default.
>
> Do I also need to enable different support in the kernel?
> (e.g. /dev/agpart support ?)

That would be good, but AFAIK there's no such thing for our hardware yet.

You'll have to go to
xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel and do make -f
Makefile.linux (won't build out of the box - I've added '#include
<asm/pgtable.h> to drmP.h and changed the function in r128_dma.c containing
i386 assembly to just call mb() - anyone knows if this makes sense?) and then
modprobe r128.o


> (I have ATI{mach64,r128}/IMSTT support enabled by default - since these are
> the cards I have).

Only the r128 is even theoretically supported by DRI ATM.


Michel


--
Pauli's exclusive, Heisenberg's uncertain, and Schroedinger just waves.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
