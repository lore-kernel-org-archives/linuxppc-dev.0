Date: Tue, 1 Aug 2000 14:06:42 -0700
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
Message-ID: <20000801140642.B24586@drow.them.org>
References: <39853D27.8F4F5500@relog.ch> <Pine.LNX.4.21.0008011508360.4803-100000@idd-01.imbc.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0008011508360.4803-100000@idd-01.imbc.gr>; from gewrgiou@imbc.gr on Tue, Aug 01, 2000 at 03:54:37PM +0300
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 01, 2000 at 03:54:37PM +0300, Kostas Gewrgiou wrote:
> The mb() should be enough in r128_dma.c (we might not need it at all though
> but it shouldn't hurt). The R128_WRITE/R128_READ macros in r128_drv.h will
> need to do byteswapping also i imagine.
>
> The writes to the CCE ring buffer might be a problem also you might need
> to do different swaps depending on where the buffer lives (host memory or
> in the framebuffer) since the framebuffer writes get swapped depending on
> the current depth. (voodoo3 has this problem)
>
> The drm modules need some asm code as well, look at my patches in
> dri.sourceforge.net (patch_id 100488,100568) the code is almost a copy
> from the glibc sources (i know next to nothing about ppc asm) but they
> work well with my voodoo3.
>
> Also note that the DRI drivers don't get build by default in PPC
> you have to #define BuildXF86DRI YES in xf config files *AND*
> patch xc/lib/GL/mesa/src/drv/Imakefile to enable the dri drivers
> to build under ppc.
>
> Unfortunately i don't have an r128 card so i can't do anything here :(

What sort of patch do we need to that Imakefile?  I couldn't figure out
what to do.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
