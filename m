Return-Path: <blofeldus@yahoo.com>
Received: from web53506.mail.re2.yahoo.com (web53506.mail.re2.yahoo.com
	[206.190.37.67]) by ozlabs.org (Postfix) with SMTP id F32FEB70A7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 02:28:15 +1000 (EST)
Message-ID: <752348.50217.qm@web53506.mail.re2.yahoo.com>
References: <1280769682-2839-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 3 Aug 2010 09:28:13 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: [PATCH] powerpc: Dont require a dma_ops struct to set dma mask
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
In-Reply-To: <1280769682-2839-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- Original Message ----

> From: Kumar Gala <galak@kernel.crashing.org>
> To: linuxppc-dev@ozlabs.org
> Sent: Mon, August 2, 2010 12:21:22 PM
> Subject: [PATCH] powerpc: Dont require a dma_ops struct to set dma mask
> 
> The only reason to require a dma_ops struct is to see if it has
> implemented  set_dma_mask.  If not we can fall back to setting the  mask
> directly.
> 
> This resolves an issue with how to sequence the setting  of a DMA mask
> for platform devices.  Before we had an issue in that we  have no way of
> setting the DMA mask before the various low level bus  notifiers get
> called that might check it (swiotlb).
> 
> So now we can  do:
> 
>     pdev = platform_device_alloc("foobar",  0);
>     dma_set_mask(&pdev->dev,  DMA_BIT_MASK(37));
>      platform_device_register(pdev);
> 
> And expect the right thing to happen with  the bus notifiers get called
> via  platform_device_register.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>   arch/powerpc/include/asm/dma-mapping.h |    4 +---
>  1 files  changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git  a/arch/powerpc/include/asm/dma-mapping.h  
>b/arch/powerpc/include/asm/dma-mapping.h
> index c85ef23..17d5c17 100644
> ---  a/arch/powerpc/include/asm/dma-mapping.h
> +++  b/arch/powerpc/include/asm/dma-mapping.h
> @@ -131,9 +131,7 @@ static inline  int dma_set_mask(struct device *dev, u64 
>dma_mask)
>  {
>       struct dma_map_ops *dma_ops = get_dma_ops(dev);
> 
> -    if  (unlikely(dma_ops == NULL))
> -        return  -EIO;
> -    if (dma_ops->set_dma_mask !=  NULL)
> +    if (unlikely(dma_ops == NULL) &&  (dma_ops->set_dma_mask != NULL))
>           return dma_ops->set_dma_mask(dev, dma_mask);
>      if  (!dev->dma_mask || !dma_supported(dev, dma_mask))
>           return -EIO;
> -- 
> 1.6.0.6
> 
> _______________________________________________
> Linuxppc-dev  mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Isn't that test wrong? Perhaps you meant to test for dma_ops non-null before 
dereferencing it?
-roger


      
