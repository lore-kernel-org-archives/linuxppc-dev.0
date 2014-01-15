Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93D222C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 14:47:48 +1100 (EST)
Message-ID: <1389757657.6933.54.camel@pasglop>
Subject: Re: [PATCH] powerpc: dma-mapping: Return dma_direct_ops variable
 when dev == NULL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chunhe Lan <b25806@freescale.com>
Date: Wed, 15 Jan 2014 14:47:37 +1100
In-Reply-To: <52D60238.2040204@freescale.com>
References: <1389692656-27758-1-git-send-email-Chunhe.Lan@freescale.com>
 <1389694446.6933.14.camel@pasglop> <52D60238.2040204@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-15 at 11:36 +0800, Chunhe Lan wrote:

> >
> >> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Tested-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> >> ---
> >>   arch/powerpc/include/asm/dma-mapping.h |   13 +++++++++----
> >>   1 files changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> >> index e27e9ad..b8c10de 100644
> >> --- a/arch/powerpc/include/asm/dma-mapping.h
> >> +++ b/arch/powerpc/include/asm/dma-mapping.h
> >> @@ -84,10 +84,15 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>          I see the get_dma_ops function in 
> arch/*x86*/include/asm/dma-mapping.h as the following:
> 
>   32 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>   33 {
>   34 #ifndef CONFIG_X86_DEV_DMA_OPS
>   35         return dma_ops;
>   36 #else
>   37         if (unlikely(!dev) || !dev->archdata.dma_ops)
>   38                 return dma_ops;
>   39         else
>   40                 return dev->archdata.dma_ops;
>   41 #endif
>   42 }
> 
>          And also  see the get_dma_ops function in  
> arch/*arm*/include/asm/dma-mapping.h as the following:
> 
>   18 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>   19 {
>   20         if (dev && dev->archdata.dma_ops)
>   21                 return dev->archdata.dma_ops;
>   22         return &arm_dma_ops;
>   23 }
> 
>        Why not powerpc use this method to process dev == NULL ?

Because we don't :-) We used to and removed this. Due to how our HW
works it might not be correct. When an iommu is enabled for example
you simply cannot use the direct ops.

So the right fix is to properly establish the iommu for the VFs like
we do for the PFs.

> Thanks,
> -Chunhe
> 
> >>   	 * only ISA DMA device we support is the floppy and we have a hack
> >>   	 * in the floppy driver directly to get a device for us.
> >>   	 */
> >> -	if (unlikely(dev == NULL))
> >> -		return NULL;
> >> -
> >> -	return dev->archdata.dma_ops;
> >> +	if (dev && dev->archdata.dma_ops)
> >> +		return dev->archdata.dma_ops;
> >> +	/*
> >> +	 * In some cases (for example, use the Intel(R) 10 Gigabit PCI
> >> +	 * expression Virtual Function Network Driver -- ixgbevf.ko),
> >> +	 * their value of dev is the NULL. If return NULL, the driver is
> >> +	 * aborting. So return dma_direct_ops variable when dev == NULL.
> >> +	 */
> >> +	return &dma_direct_ops;
> >>   }
> >>   
> >>   static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
> >
> >
> >
> 
> 
