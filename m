Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF5371A0BD9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 11:12:16 +1100 (AEDT)
Message-ID: <1422922326.22865.447.camel@redhat.com>
Subject: Re: [PATCH v3 05/24] vfio: powerpc/spapr: Move locked_vm accounting
 to helpers
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 02 Feb 2015 17:12:06 -0700
In-Reply-To: <1422523325-1389-6-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
 <1422523325-1389-6-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexander Graf <agraf@suse.de>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-29 at 20:21 +1100, Alexey Kardashevskiy wrote:
> There moves locked pages accounting to helpers.
> Later they will be reused for Dynamic DMA windows (DDW).
> 
> While we are here, update the comment explaining why RLIMIT_MEMLOCK
> might be required to be bigger than the guest RAM. This also prints
> pid of the current process in pr_warn/pr_debug.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 72 +++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index c596053..29d5708 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -29,6 +29,47 @@
>  static void tce_iommu_detach_group(void *iommu_data,
>  		struct iommu_group *iommu_group);
>  
> +#define IOMMU_TABLE_PAGES(tbl) \
> +		(((tbl)->it_size << (tbl)->it_page_shift) >> PAGE_SHIFT)

A bit of an infringement on the global namespace with such a generic
name.

> +
> +static long try_increment_locked_vm(long npages)
> +{
> +	long ret = 0, locked, lock_limit;
> +
> +	if (!current || !current->mm)
> +		return -ESRCH; /* process exited */
> +
> +	down_write(&current->mm->mmap_sem);
> +	locked = current->mm->locked_vm + npages;
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> +		pr_warn("[%d] RLIMIT_MEMLOCK (%ld) exceeded\n",
> +				current->pid, rlimit(RLIMIT_MEMLOCK));
> +		ret = -ENOMEM;
> +	} else {
> +		current->mm->locked_vm += npages;
> +	}
> +	pr_debug("[%d] RLIMIT_MEMLOCK+ %ld pages\n", current->pid,
> +			current->mm->locked_vm);
> +	up_write(&current->mm->mmap_sem);
> +
> +	return ret;
> +}
> +
> +static void decrement_locked_vm(long npages)
> +{
> +	if (!current || !current->mm)
> +		return; /* process exited */
> +
> +	down_write(&current->mm->mmap_sem);
> +	if (npages > current->mm->locked_vm)
> +		npages = current->mm->locked_vm;
> +	current->mm->locked_vm -= npages;
> +	pr_debug("[%d] RLIMIT_MEMLOCK- %ld pages\n", current->pid,
> +			current->mm->locked_vm);
> +	up_write(&current->mm->mmap_sem);
> +}
> +
>  /*
>   * VFIO IOMMU fd for SPAPR_TCE IOMMU implementation
>   *
> @@ -66,8 +107,6 @@ static bool tce_check_page_size(struct page *page, unsigned page_shift)
>  static int tce_iommu_enable(struct tce_container *container)
>  {
>  	int ret = 0;
> -	unsigned long locked, lock_limit, npages;
> -	struct iommu_table *tbl = container->tbl;
>  
>  	if (!container->tbl)
>  		return -ENXIO;
> @@ -95,21 +134,19 @@ static int tce_iommu_enable(struct tce_container *container)
>  	 * Also we don't have a nice way to fail on H_PUT_TCE due to ulimits,
>  	 * that would effectively kill the guest at random points, much better
>  	 * enforcing the limit based on the max that the guest can map.
> +	 *
> +	 * Unfortunately at the moment it counts whole tables, no matter how
> +	 * much memory the guest has. I.e. for 4GB guest and 4 IOMMU groups
> +	 * each with 2GB DMA window, 8GB will be counted here. The reason for
> +	 * this is that we cannot tell here the amount of RAM used by the guest
> +	 * as this information is only available from KVM and VFIO is
> +	 * KVM agnostic.
>  	 */
> -	down_write(&current->mm->mmap_sem);
> -	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> -	locked = current->mm->locked_vm + npages;
> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> -		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
> -				rlimit(RLIMIT_MEMLOCK));
> -		ret = -ENOMEM;
> -	} else {
> +	ret = try_increment_locked_vm(IOMMU_TABLE_PAGES(container->tbl));
> +	if (ret)
> +		return ret;
>  
> -		current->mm->locked_vm += npages;
> -		container->enabled = true;
> -	}
> -	up_write(&current->mm->mmap_sem);
> +	container->enabled = true;
>  
>  	return ret;
>  }
> @@ -124,10 +161,7 @@ static void tce_iommu_disable(struct tce_container *container)
>  	if (!container->tbl || !current->mm)
>  		return;
>  
> -	down_write(&current->mm->mmap_sem);
> -	current->mm->locked_vm -= (container->tbl->it_size <<
> -			container->tbl->it_page_shift) >> PAGE_SHIFT;
> -	up_write(&current->mm->mmap_sem);
> +	decrement_locked_vm(IOMMU_TABLE_PAGES(container->tbl));
>  }
>  
>  static void *tce_iommu_open(unsigned long arg)
