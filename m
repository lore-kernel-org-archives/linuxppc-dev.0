Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70A191A0332
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2015 07:29:16 +1000 (AEST)
Message-ID: <1428701320.5567.623.camel@redhat.com>
Subject: Re: [PATCH kernel v8 15/31] powerpc/iommu: Fix IOMMU ownership
 control functions
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 10 Apr 2015 15:28:40 -0600
In-Reply-To: <1428647473-11738-16-git-send-email-aik@ozlabs.ru>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-16-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 16:30 +1000, Alexey Kardashevskiy wrote:
> This adds missing locks in iommu_take_ownership()/
> iommu_release_ownership().
> 
> This marks all pages busy in iommu_table::it_map in order to catch
> errors if there is an attempt to use this table while ownership over it
> is taken.
> 
> This only clears TCE content if there is no page marked busy in it_map.
> Clearing must be done outside of the table locks as iommu_clear_tce()
> called from iommu_clear_tces_and_put_pages() does this.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v5:
> * do not store bit#0 value, it has to be set for zero-based table
> anyway
> * removed test_and_clear_bit
> ---
>  arch/powerpc/kernel/iommu.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 7d6089b..068fe4ff 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1052,17 +1052,28 @@ EXPORT_SYMBOL_GPL(iommu_tce_build);
>  
>  static int iommu_table_take_ownership(struct iommu_table *tbl)
>  {
> -	unsigned long sz = (tbl->it_size + 7) >> 3;
> +	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> +	for (i = 0; i < tbl->nr_pools; i++)
> +		spin_lock(&tbl->pools[i].lock);
>  
>  	if (tbl->it_offset == 0)
>  		clear_bit(0, tbl->it_map);
>  
>  	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
>  		pr_err("iommu_tce: it_map is not empty");
> -		return -EBUSY;
> +		ret = -EBUSY;


This error is never returned.


> +		if (tbl->it_offset == 0)
> +			set_bit(0, tbl->it_map);
> +	} else {
> +		memset(tbl->it_map, 0xff, sz);
>  	}
>  
> -	memset(tbl->it_map, 0xff, sz);
> +	for (i = 0; i < tbl->nr_pools; i++)
> +		spin_unlock(&tbl->pools[i].lock);
> +	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
>  
>  	return 0;
>  }
> @@ -1095,7 +1106,11 @@ EXPORT_SYMBOL_GPL(iommu_take_ownership);
>  
>  static void iommu_table_release_ownership(struct iommu_table *tbl)
>  {
> -	unsigned long sz = (tbl->it_size + 7) >> 3;
> +	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
> +
> +	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> +	for (i = 0; i < tbl->nr_pools; i++)
> +		spin_lock(&tbl->pools[i].lock);
>  
>  	memset(tbl->it_map, 0, sz);
>  
> @@ -1103,6 +1118,9 @@ static void iommu_table_release_ownership(struct iommu_table *tbl)
>  	if (tbl->it_offset == 0)
>  		set_bit(0, tbl->it_map);
>  
> +	for (i = 0; i < tbl->nr_pools; i++)
> +		spin_unlock(&tbl->pools[i].lock);
> +	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
>  }
>  
>  extern void iommu_release_ownership(struct iommu_table_group *table_group)
