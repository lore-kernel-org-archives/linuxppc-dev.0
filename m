Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 5D01BB7146
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 10:47:28 +1000 (EST)
Date: Fri, 3 Sep 2010 17:47:24 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fsldma: fix missing header include
Message-ID: <20100904004724.GA4085@ovro.caltech.edu>
References: <20100902194752.GA24861@ovro.caltech.edu>
	<20100903164033.6ae37727.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100903164033.6ae37727.akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 03, 2010 at 04:40:33PM -0700, Andrew Morton wrote:
> On Thu, 2 Sep 2010 12:47:52 -0700
> "Ira W. Snyder" <iws@ovro.caltech.edu> wrote:
> 
> > The slab.h header is required to use the kmalloc() family of functions.
> > Due to recent kernel changes, this header must be directly included by
> > code that calls into the memory allocator.
> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > ---
> > 
> > Without this patch, any code which includes this header fails to build.
> > 
> >  arch/powerpc/include/asm/fsldma.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/fsldma.h b/arch/powerpc/include/asm/fsldma.h
> > index a67aeed..debc5ed 100644
> > --- a/arch/powerpc/include/asm/fsldma.h
> > +++ b/arch/powerpc/include/asm/fsldma.h
> > @@ -11,6 +11,7 @@
> >  #ifndef __ARCH_POWERPC_ASM_FSLDMA_H__
> >  #define __ARCH_POWERPC_ASM_FSLDMA_H__
> >  
> > +#include <linux/slab.h>
> >  #include <linux/dmaengine.h>
> >  
> 
> It also needs list.h, but appears to get it via sheer luck.
> 
> The functions in that header simply shouldn't have been inlined.
> 
> It's peculiar that fsl_dma_slave_append() hardwires GFP_ATOMIC, whereas
> fsl_dma_slave_alloc() takes a gfp_t.
> 

Would you like a patch that moves the functions to drivers/dma/fsldma.c
and EXPORT_SYMBOL_GPL()'s them? I don't know the consequences to doing
so, which is why I avoided it when I wrote
arch/powerpc/include/asm/fsldma.h.

Thanks,
Ira
