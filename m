Date: Tue, 1 Aug 2000 15:54:37 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: daenzerm@student.ethz.ch
cc: SteffenH@hyperion-software.de, Iain Sandoe <iain@sandoe.co.uk>,
        takashi oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
In-Reply-To: <39853D27.8F4F5500@relog.ch>
Message-ID: <Pine.LNX.4.21.0008011508360.4803-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 31 Jul 2000, Michel [iso-8859-1] Dänzer wrote:

>
> Steffen Haeuser wrote:
>
> > >> Do I also need to enable different support in the kernel?
> > >> (e.g. /dev/agpart support ?)
> >
> > >That would be good, but AFAIK there's no such thing for our hardware yet.
> >
> > Exactly this is AFAIK currently the problem as to 3D Hardware support...
> > the /dev/agpart support...
>
> agpgart was required _for r128 DRI_ until some time ago. It's possible that
> it's still needed by the driver in X 4.0.1 but definitely not in the latest
> DRI CVS.
>

 If i remember corectly 4.0.1 doesn't need agpgart but i fear that 3d
performance is far worst without it.

> > >You'll have to go to
> > >xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel and do make -f
> > >Makefile.linux (won't build out of the box - I've added '#include
> > ><asm/pgtable.h> to drmP.h and changed the function in r128_dma.c containing
> > >i386 assembly to just call mb() - anyone knows if this makes sense?) and
> > > then modprobe r128.o
> >
> > Hmmm... what sort of ASM is this ?
>
> It's for flushing write combining buffers AFAIR, thus I thought an mb() should
> do on PPC.
>

The mb() should be enough in r128_dma.c (we might not need it at all though
but it shouldn't hurt). The R128_WRITE/R128_READ macros in r128_drv.h will
need to do byteswapping also i imagine.

The writes to the CCE ring buffer might be a problem also you might need
to do different swaps depending on where the buffer lives (host memory or
in the framebuffer) since the framebuffer writes get swapped depending on
the current depth. (voodoo3 has this problem)

The drm modules need some asm code as well, look at my patches in
dri.sourceforge.net (patch_id 100488,100568) the code is almost a copy
from the glibc sources (i know next to nothing about ppc asm) but they
work well with my voodoo3.

Also note that the DRI drivers don't get build by default in PPC
you have to #define BuildXF86DRI YES in xf config files *AND*
patch xc/lib/GL/mesa/src/drv/Imakefile to enable the dri drivers
to build under ppc.

Unfortunately i don't have an r128 card so i can't do anything here :(

   Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
