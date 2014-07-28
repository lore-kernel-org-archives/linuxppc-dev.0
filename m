Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 801831A0044
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 10:47:11 +1000 (EST)
Message-ID: <1406508410.4935.24.camel@pasglop>
Subject: Re: [PATCH v3 04/18] vfio: powerpc: Move locked_vm accounting to a
 helper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 28 Jul 2014 10:46:50 +1000
In-Reply-To: <1406191691-31441-5-git-send-email-aik@ozlabs.ru>
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
 <1406191691-31441-5-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-24 at 18:47 +1000, Alexey Kardashevskiy wrote:
> Additional DMA windows support is coming and accounting will include them
> so let's move this code to a helper for reuse.

This code looks a LOT like the one you added in the previous patch
(ie. kvmppc_account_memlimit()), though in a different place. I
wonder if we should re-arrange things so that there is really
only one version of it..

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 54 ++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index a84788b..c8f7284 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -47,10 +47,40 @@ struct tce_container {
>  	bool enabled;
>  };
>  
> +/*
> + * Checks ulimit in order not to let the user space to pin all
> + * available memory for TCE tables.
> + */
> +static long tce_iommu_account_memlimit(struct iommu_table *tbl, bool inc)
> +{
> +	unsigned long ret = 0, locked, lock_limit;
> +	long npages;
> +
> +	if (!current->mm)
> +		return -ESRCH; /* process exited */
> +
> +	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
> +	if (!inc)
> +		npages = -npages;
> +
> +	down_write(&current->mm->mmap_sem);
> +	locked = current->mm->locked_vm + npages;
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> +		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
> +				rlimit(RLIMIT_MEMLOCK));
> +		ret = -ENOMEM;
> +	} else {
> +		current->mm->locked_vm += npages;
> +	}
> +	up_write(&current->mm->mmap_sem);
> +
> +	return ret;
> +}
> +
>  static int tce_iommu_enable(struct tce_container *container)
>  {
>  	int ret = 0;
> -	unsigned long locked, lock_limit, npages;
>  	struct iommu_table *tbl = container->tbl;
>  
>  	if (!container->tbl)
> @@ -80,20 +110,11 @@ static int tce_iommu_enable(struct tce_container *container)
>  	 * that would effectively kill the guest at random points, much better
>  	 * enforcing the limit based on the max that the guest can map.
>  	 */
> -	down_write(&current->mm->mmap_sem);
> -	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
> -	locked = current->mm->locked_vm + npages;
> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> -		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
> -				rlimit(RLIMIT_MEMLOCK));
> -		ret = -ENOMEM;
> -	} else {
> +	ret = tce_iommu_account_memlimit(tbl, true);
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
> @@ -108,10 +129,7 @@ static void tce_iommu_disable(struct tce_container *container)
>  	if (!container->tbl || !current->mm)
>  		return;
>  
> -	down_write(&current->mm->mmap_sem);
> -	current->mm->locked_vm -= (container->tbl->it_size <<
> -			IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
> -	up_write(&current->mm->mmap_sem);
> +	tce_iommu_account_memlimit(container->tbl, false);
>  }
>  
>  static void *tce_iommu_open(unsigned long arg)
