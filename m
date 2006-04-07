Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 4/5] powerpc: export symbols for page size
	selection
Date: Fri, 7 Apr 2006 18:49:34 +0200
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<200604071803.01836.arnd.bergmann@de.ibm.com>
	<20060407162026.GK952@pb15.lixom.net>
In-Reply-To: <20060407162026.GK952@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604071849.35391.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Mark Nutter <mnutter@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 April 2006 18:20, Olof Johansson wrote:
> On Fri, Apr 07, 2006 at 06:03:01PM +0200, Arnd Bergmann wrote:
> > On Friday 07 April 2006 17:42, Olof Johansson wrote:
> > > Yeah, what's the need for that, really? It needs to know so much of
> > > kernel internals that it's getting silly to allow it to be a module.
> >
> > How about if I do a patch that always includes the base but not
> > the actual file system?
> 
> Sounds like a decent tradeoff.
> 

Unfortunately, this one doesn't get rid of the need to have the
exports, since the context switch code also needs mmu_psize_defs
and the associated objects. I think I have to come up with
a different change for that, but I don't mind putting the base
stuff into the kernel in the first place.

Mark has some changes to the file layout pending that will
impact this as well. I first need to see how that works out
together.

The patch to make the base non-modular is trivial, so we might
as well apply it now.

	Arnd <><

Index: linus-2.6/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/Makefile
+++ linus-2.6/arch/powerpc/platforms/cell/Makefile
@@ -2,15 +2,13 @@ obj-y			+= interrupt.o iommu.o setup.o s
 obj-y			+= pervasive.o
 
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_SPU_FS)	+= spu-base.o spufs/
-
-spu-base-y		+= spu_base.o spu_priv1.o
+obj-$(CONFIG_SPU_FS)	+= spufs/
 
 # needed only when building loadable spufs.ko
 spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
 obj-y			+= $(spufs-modular-m)
 
 # always needed in kernel
-spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o
+spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o
 obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
 
