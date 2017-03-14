Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjNN96d64zDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 05:21:13 +1100 (AEDT)
Date: Tue, 14 Mar 2017 12:21:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v8 03/10] powerpc/iommu/vfio_spapr_tce: Cleanup
 iommu_table disposal
Message-ID: <20170314122110.46cc5f52@t450s.home>
In-Reply-To: <20170310035337.22091-4-aik@ozlabs.ru>
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310035337.22091-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Mar 2017 14:53:30 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> At the moment iommu_table can be disposed by either calling
> iommu_table_free() directly or it_ops::free(); the only implementation
> of free() is in IODA2 - pnv_ioda2_table_free() - and it calls
> iommu_table_free() anyway.
> 
> As we are going to have reference counting on tables, we need an unified
> way of disposing tables.
> 
> This moves it_ops::free() call into iommu_free_table() and makes use
> of the latter. The free() callback now handles only platform-specific
> data.
> 
> As from now on the iommu_free_table() calls it_ops->free(), we need
> to have it_ops initialized before calling iommu_free_table() so this
> moves this initialization in pnv_pci_ioda2_create_table().
> 
> This should cause no behavioral change.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> Changes:
> v5:
> * moved "tbl->it_ops = &pnv_ioda2_iommu_ops" earlier and updated
> the commit log
> ---
>  arch/powerpc/kernel/iommu.c               |  4 ++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++------
>  drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 9bace5df05d5..bc142d87130f 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -719,6 +719,9 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>  	if (!tbl)
>  		return;
>  
> +	if (tbl->it_ops->free)
> +		tbl->it_ops->free(tbl);
> +
>  	if (!tbl->it_map) {
>  		kfree(tbl);
>  		return;
> @@ -745,6 +748,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>  	/* free table */
>  	kfree(tbl);
>  }
> +EXPORT_SYMBOL_GPL(iommu_free_table);

A slightly cringe worthy generically named export in arch code.

>  
>  /* Creates TCEs for a user provided buffer.  The user buffer must be
>   * contiguous real kernel storage (not vmalloc).  The address passed here
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 69c40b43daa3..7916d0cb05fe 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1425,7 +1425,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
>  		iommu_group_put(pe->table_group.group);
>  		BUG_ON(pe->table_group.group);
>  	}
> -	pnv_pci_ioda2_table_free_pages(tbl);
>  	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>  }
>  
> @@ -2041,7 +2040,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
>  static void pnv_ioda2_table_free(struct iommu_table *tbl)
>  {
>  	pnv_pci_ioda2_table_free_pages(tbl);
> -	iommu_free_table(tbl, "pnv");
>  }
>  
>  static struct iommu_table_ops pnv_ioda2_iommu_ops = {
> @@ -2318,6 +2316,8 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>  	if (!tbl)
>  		return -ENOMEM;
>  
> +	tbl->it_ops = &pnv_ioda2_iommu_ops;
> +
>  	ret = pnv_pci_ioda2_table_alloc_pages(nid,
>  			bus_offset, page_shift, window_size,
>  			levels, tbl);
> @@ -2326,8 +2326,6 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>  		return ret;
>  	}
>  
> -	tbl->it_ops = &pnv_ioda2_iommu_ops;
> -
>  	*ptbl = tbl;
>  
>  	return 0;
> @@ -2368,7 +2366,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>  				rc);
> -		pnv_ioda2_table_free(tbl);
> +		iommu_free_table(tbl, "");
>  		return rc;
>  	}
>  
> @@ -2456,7 +2454,7 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>  	if (pe->pbus)
>  		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> -	pnv_ioda2_table_free(tbl);
> +	iommu_free_table(tbl, "pnv");
>  }
>  
>  static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index cf3de91fbfe7..fbec7348a7e5 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -680,7 +680,7 @@ static void tce_iommu_free_table(struct tce_container *container,
>  	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
>  
>  	tce_iommu_userspace_view_free(tbl, container->mm);
> -	tbl->it_ops->free(tbl);
> +	iommu_free_table(tbl, "");
>  	decrement_locked_vm(container->mm, pages);
>  }
>  

Acked-by: Alex Williamson <alex.williamson@redhat.com>
