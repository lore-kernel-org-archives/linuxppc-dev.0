Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CD231A07BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 08:48:29 +1100 (AEDT)
Message-ID: <1427924904.5567.303.camel@redhat.com>
Subject: Re: [PATCH kernel v7 04/31] vfio: powerpc/spapr: Use it_page_size
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 01 Apr 2015 15:48:24 -0600
In-Reply-To: <1427468115-2224-5-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
 <1427468115-2224-5-git-send-email-aik@ozlabs.ru>
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

On Sat, 2015-03-28 at 01:54 +1100, Alexey Kardashevskiy wrote:
> This makes use of the it_page_size from the iommu_table struct
> as page size can differ.
> 
> This replaces missing IOMMU_PAGE_SHIFT macro in commented debug code
> as recently introduced IOMMU_PAGE_XXX macros do not include
> IOMMU_PAGE_SHIFT.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index f835e63..8bbee22 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -91,7 +91,7 @@ static int tce_iommu_enable(struct tce_container *container)
>  	 * enforcing the limit based on the max that the guest can map.
>  	 */
>  	down_write(&current->mm->mmap_sem);
> -	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
> +	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
>  	locked = current->mm->locked_vm + npages;
>  	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> @@ -120,7 +120,7 @@ static void tce_iommu_disable(struct tce_container *container)
>  
>  	down_write(&current->mm->mmap_sem);
>  	current->mm->locked_vm -= (container->tbl->it_size <<
> -			IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
> +			container->tbl->it_page_shift) >> PAGE_SHIFT;
>  	up_write(&current->mm->mmap_sem);
>  }
>  
> @@ -222,7 +222,7 @@ static long tce_iommu_build(struct tce_container *container,
>  					tce, ret);
>  			break;
>  		}
> -		tce += IOMMU_PAGE_SIZE_4K;
> +		tce += IOMMU_PAGE_SIZE(tbl);


Is PAGE_SIZE ever smaller than IOMMU_PAGE_SIZE(tbl)?  IOW, can the page
we got from get_user_pages_fast() ever not completely fill the tce
entry?

(Have I asked this before?  Sorry if so)
