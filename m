Date: Wed, 2 Aug 2000 21:17:28 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
In-Reply-To: <20000801140642.B24586@drow.them.org>
Message-ID: <Pine.LNX.4.21.0008022109130.3910-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 1 Aug 2000, Daniel Jacobowitz wrote:

>
> On Tue, Aug 01, 2000 at 03:54:37PM +0300, Kostas Gewrgiou wrote:
> > The mb() should be enough in r128_dma.c (we might not need it at all though
> > but it shouldn't hurt). The R128_WRITE/R128_READ macros in r128_drv.h will
> > need to do byteswapping also i imagine.
> >
> > The writes to the CCE ring buffer might be a problem also you might need
> > to do different swaps depending on where the buffer lives (host memory or
> > in the framebuffer) since the framebuffer writes get swapped depending on
> > the current depth. (voodoo3 has this problem)
> >
> > The drm modules need some asm code as well, look at my patches in
> > dri.sourceforge.net (patch_id 100488,100568) the code is almost a copy
> > from the glibc sources (i know next to nothing about ppc asm) but they
> > work well with my voodoo3.
> >
> > Also note that the DRI drivers don't get build by default in PPC
> > you have to #define BuildXF86DRI YES in xf config files *AND*
> > patch xc/lib/GL/mesa/src/drv/Imakefile to enable the dri drivers
> > to build under ppc.
> >
> > Unfortunately i don't have an r128 card so i can't do anything here :(
>
> What sort of patch do we need to that Imakefile?  I couldn't figure out
> what to do.
>

To enable the dri drivers you'll need the following patch:

--- xc/lib/GL/mesa/src/drv/Imakefile-orig       Tue Jul 18 14:32:34 2000
+++ xc/lib/GL/mesa/src/drv/Imakefile    Tue Jul 18 14:33:41 2000
@@ -54,6 +54,14 @@
 SUBDIRS += common
 SUBDIRS += mga
 SUBDIRS += r128
+#elif defined(PpcArchitecture)
+SUBDIRS += gamma
+#if HasGlide3
+SUBDIRS += tdfx
+#endif
+SUBDIRS += common
+SUBDIRS += mga
+SUBDIRS += r128
 #elif defined(SparcArchitecture)
 SUBDIRS += ffb
 #endif

For the build problems because of the empty subdirs in xc/lib/GL/mesa/src
the following will do, its not actually correct but i am not sure how to fix
it.

--- xc/lib/GL/mesa/src/Imakefile-orig   Tue Jul 18 18:29:32 2000
+++ xc/lib/GL/mesa/src/Imakefile        Wed Aug  2 21:13:47 2000
@@ -389,7 +389,7 @@
 #define IHaveSubdirs
 #define PassCDebugFlags

-SUBDIRS = $(MESASUBDIRS) $(ASMSUBDIRS)
+SUBDIRS = $(MESASUBDIRS) $(ASMSUBDIRS) drv

 MakeSubdirs($(SUBDIRS))
 DependSubdirs($(SUBDIRS))


 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
