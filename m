Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A156B7155
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 09:40:38 +1000 (EST)
Date: Fri, 3 Sep 2010 16:40:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH] fsldma: fix missing header include
Message-Id: <20100903164033.6ae37727.akpm@linux-foundation.org>
In-Reply-To: <20100902194752.GA24861@ovro.caltech.edu>
References: <20100902194752.GA24861@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 2 Sep 2010 12:47:52 -0700
"Ira W. Snyder" <iws@ovro.caltech.edu> wrote:

> The slab.h header is required to use the kmalloc() family of functions.
> Due to recent kernel changes, this header must be directly included by
> code that calls into the memory allocator.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> Without this patch, any code which includes this header fails to build.
> 
>  arch/powerpc/include/asm/fsldma.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/fsldma.h b/arch/powerpc/include/asm/fsldma.h
> index a67aeed..debc5ed 100644
> --- a/arch/powerpc/include/asm/fsldma.h
> +++ b/arch/powerpc/include/asm/fsldma.h
> @@ -11,6 +11,7 @@
>  #ifndef __ARCH_POWERPC_ASM_FSLDMA_H__
>  #define __ARCH_POWERPC_ASM_FSLDMA_H__
>  
> +#include <linux/slab.h>
>  #include <linux/dmaengine.h>
>  

It also needs list.h, but appears to get it via sheer luck.

The functions in that header simply shouldn't have been inlined.

It's peculiar that fsl_dma_slave_append() hardwires GFP_ATOMIC, whereas
fsl_dma_slave_alloc() takes a gfp_t.
