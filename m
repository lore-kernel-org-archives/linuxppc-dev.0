Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3DD11A0204
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Sep 2014 06:50:02 +1000 (EST)
Message-ID: <1411157769.13320.74.camel@snotra.buserror.net>
Subject: Re: [PATCH 03/15] powerpc/msi: Improve IRQ bitmap allocator
From: Scott Wood <scottwood@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Date: Fri, 19 Sep 2014 15:16:09 -0500
In-Reply-To: <1411028820-29933-4-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-4-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 imunsie@au.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Laurentiu
 Tudor <Laurentiu.Tudor@freescale.com>, anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-18 at 18:26 +1000, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> Currently msi_bitmap_alloc_hwirqs() will round up any IRQ allocation requests
> to the nearest power of 2.  eg. ask for 5 IRQs and you'll get 8.  This wastes a
> lot of IRQs which can be a scarce resource.
> 
> For cxl we can require multiple IRQs for every contexts that is attached to the
> accelerator.  For AFU directed accelerators, there may be 1000s of contexts
> attached, hence we can easily run out of IRQs, especially if we are needlessly
> wasting them.
> 
> This changes the msi_bitmap_alloc_hwirqs() to allocate only the required number
> of IRQs, hence avoiding this wastage.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/sysdev/msi_bitmap.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

This conflicts with (and partially duplicates)
http://patchwork.ozlabs.org/patch/381892/
which I have in my tree.  How should we handle it?

Laurentiu, from looking at the overlap between patches I see a problem
with your existing patch, regarding the out-of-irqs path and
msi_bitmap_free_hwirqs(), so one way or another that needs to get fixed
soon.

-Scott

> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
> index 2ff6302..e001559 100644
> --- a/arch/powerpc/sysdev/msi_bitmap.c
> +++ b/arch/powerpc/sysdev/msi_bitmap.c
> @@ -24,28 +24,36 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
>  	 * This is fast, but stricter than we need. We might want to add
>  	 * a fallback routine which does a linear search with no alignment.
>  	 */
> -	offset = bitmap_find_free_region(bmp->bitmap, bmp->irq_count, order);
> +	offset = bitmap_find_next_zero_area(bmp->bitmap, bmp->irq_count, 0,
> +					    num, (1 << order) - 1);
> +	if (offset > bmp->irq_count)
> +		goto err;
> +	bitmap_set(bmp->bitmap, offset, num);
>  	spin_unlock_irqrestore(&bmp->lock, flags);
>  
>  	pr_debug("msi_bitmap: allocated 0x%x (2^%d) at offset 0x%x\n",
>  		 num, order, offset);
>  
>  	return offset;
> +err:
> +	spin_unlock_irqrestore(&bmp->lock, flags);
> +	return -ENOMEM;
>  }
> +EXPORT_SYMBOL(msi_bitmap_alloc_hwirqs);
>  
>  void msi_bitmap_free_hwirqs(struct msi_bitmap *bmp, unsigned int offset,
>  			    unsigned int num)
>  {
>  	unsigned long flags;
> -	int order = get_count_order(num);
>  
> -	pr_debug("msi_bitmap: freeing 0x%x (2^%d) at offset 0x%x\n",
> -		 num, order, offset);
> +	pr_debug("msi_bitmap: freeing 0x%x at offset 0x%x\n",
> +		 num, offset);
>  
>  	spin_lock_irqsave(&bmp->lock, flags);
> -	bitmap_release_region(bmp->bitmap, offset, order);
> +	bitmap_clear(bmp->bitmap, offset, num);
>  	spin_unlock_irqrestore(&bmp->lock, flags);
>  }
> +EXPORT_SYMBOL(msi_bitmap_free_hwirqs);
>  
>  void msi_bitmap_reserve_hwirq(struct msi_bitmap *bmp, unsigned int hwirq)
>  {
