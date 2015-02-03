Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D85F1A0519
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 13:53:51 +1100 (AEDT)
Message-ID: <1422932018.22865.450.camel@redhat.com>
Subject: Re: [PATCH v3 24/24] vfio: powerpc/spapr: Support Dynamic DMA windows
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 02 Feb 2015 19:53:38 -0700
In-Reply-To: <1422523325-1389-25-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
 <1422523325-1389-25-git-send-email-aik@ozlabs.ru>
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

On Thu, 2015-01-29 at 20:22 +1100, Alexey Kardashevskiy wrote:
> This adds create/remove window ioctls to create and remove DMA windows.
> 
> This changes VFIO_IOMMU_SPAPR_TCE_GET_INFO handler to return additional
> information such as a number of supported windows and maximum number
> levels of TCE tables.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h    |   2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c | 137 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/vfio.h           |  24 ++++++-
>  3 files changed, 160 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index 33009f9..7ca1c8c 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -133,7 +133,7 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
>  extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>  					    int nid);
>  
> -#define POWERPC_IOMMU_MAX_TABLES	1
> +#define POWERPC_IOMMU_MAX_TABLES	2
>  
>  #define POWERPC_IOMMU_DEFAULT_LEVELS	1
>  
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 8bcafb7..d3a1cc9 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -300,6 +300,20 @@ static struct iommu_table *spapr_tce_find_table(
>  	return ret;
>  }
>  
> +static int spapr_tce_find_free_table(struct tce_container *container)
> +{
> +	int i;
> +
> +	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl = &container->tables[i];
> +
> +		if (!tbl->it_size)
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
>  static unsigned long tce_default_winsize(struct tce_container *container)
>  {
>  	struct tce_iommu_group *tcegrp;
> @@ -594,7 +608,7 @@ static long tce_iommu_ioctl(void *iommu_data,
>  				 unsigned int cmd, unsigned long arg)
>  {
>  	struct tce_container *container = iommu_data;
> -	unsigned long minsz;
> +	unsigned long minsz, ddwsz;
>  	long ret;
>  
>  	switch (cmd) {
> @@ -636,6 +650,15 @@ static long tce_iommu_ioctl(void *iommu_data,
>  
>  		info.dma32_window_start = iommu->tce32_start;
>  		info.dma32_window_size = iommu->tce32_size;
> +		info.windows_supported = iommu->windows_supported;
> +		info.levels = iommu->levels;
> +		info.flags = iommu->flags;
> +
> +		ddwsz = offsetofend(struct vfio_iommu_spapr_tce_info,
> +				levels);
> +
> +		if (info.argsz == ddwsz)
> +			minsz = ddwsz;
>  
>  		if (copy_to_user((void __user *)arg, &info, minsz))
>  			return -EFAULT;
> @@ -800,6 +823,118 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		return ret;
>  	}
>  
> +	case VFIO_IOMMU_SPAPR_TCE_CREATE: {
> +		struct vfio_iommu_spapr_tce_create create;
> +		struct powerpc_iommu *iommu;
> +		struct tce_iommu_group *tcegrp;
> +		int num;
> +
> +		if (!tce_preregistered(container))
> +			return -ENXIO;
> +
> +		minsz = offsetofend(struct vfio_iommu_spapr_tce_create,
> +				start_addr);
> +
> +		if (copy_from_user(&create, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (create.argsz < minsz)
> +			return -EINVAL;
> +
> +		if (create.flags)
> +			return -EINVAL;
> +
> +		num = spapr_tce_find_free_table(container);
> +		if (num < 0)
> +			return -ENOSYS;
> +
> +		tcegrp = list_first_entry(&container->group_list,
> +				struct tce_iommu_group, next);
> +		iommu = iommu_group_get_iommudata(tcegrp->grp);
> +
> +		ret = iommu->ops->create_table(iommu, num,
> +				create.page_shift, create.window_shift,
> +				create.levels,
> +				&container->tables[num]);
> +		if (ret)
> +			return ret;
> +
> +		list_for_each_entry(tcegrp, &container->group_list, next) {
> +			struct powerpc_iommu *iommutmp =
> +					iommu_group_get_iommudata(tcegrp->grp);
> +
> +			if (WARN_ON_ONCE(iommutmp->ops != iommu->ops))
> +				return -EFAULT;
> +
> +			ret = iommu->ops->set_window(iommutmp, num,
> +					&container->tables[num]);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		create.start_addr =
> +				container->tables[num].it_offset <<
> +				container->tables[num].it_page_shift;
> +
> +		if (copy_to_user((void __user *)arg, &create, minsz))
> +			return -EFAULT;
> +
> +		mutex_lock(&container->lock);
> +		mutex_unlock(&container->lock);

Huh?

> +
> +		return ret;
> +	}
> +	case VFIO_IOMMU_SPAPR_TCE_REMOVE: {
> +		struct vfio_iommu_spapr_tce_remove remove;
> +		struct powerpc_iommu *iommu = NULL;
> +		struct iommu_table *tbl;
> +		struct tce_iommu_group *tcegrp;
> +		int num;
> +
> +		if (!tce_preregistered(container))
> +			return -ENXIO;
> +
> +		minsz = offsetofend(struct vfio_iommu_spapr_tce_remove,
> +				start_addr);
> +
> +		if (copy_from_user(&remove, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (remove.argsz < minsz)
> +			return -EINVAL;
> +
> +		if (remove.flags)
> +			return -EINVAL;
> +
> +
> +		tbl = spapr_tce_find_table(container, remove.start_addr);
> +		if (!tbl)
> +			return -EINVAL;
> +
> +		/* Detach windows from IOMMUs */
> +		mutex_lock(&container->lock);
> +
> +		/* Detach groups from IOMMUs */
> +		num = tbl - container->tables;
> +		list_for_each_entry(tcegrp, &container->group_list, next) {
> +			iommu = iommu_group_get_iommudata(tcegrp->grp);
> +			if (container->tables[num].it_size)
> +				iommu->ops->unset_window(iommu, num);
> +		}
> +
> +		/* Free table */
> +		tcegrp = list_first_entry(&container->group_list,
> +				struct tce_iommu_group, next);
> +		iommu = iommu_group_get_iommudata(tcegrp->grp);
> +
> +		tce_iommu_clear(container, tbl,
> +				tbl->it_offset, tbl->it_size);
> +		iommu->ops->free_table(tbl);
> +
> +		mutex_unlock(&container->lock);
> +
> +		return 0;
> +	}
>  	}
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 2bb0c9b..7ed7000 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -483,9 +483,11 @@ struct vfio_iommu_type1_unregister_memory {
>   */
>  struct vfio_iommu_spapr_tce_info {
>  	__u32 argsz;
> -	__u32 flags;			/* reserved for future use */
> +	__u32 flags;

So what are the flags?

>  	__u32 dma32_window_start;	/* 32 bit window start (bytes) */
>  	__u32 dma32_window_size;	/* 32 bit window size (bytes) */
> +	__u32 windows_supported;
> +	__u32 levels;
>  };
>  
>  #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
> @@ -521,6 +523,26 @@ struct vfio_eeh_pe_op {
>  
>  #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
>  
> +struct vfio_iommu_spapr_tce_create {
> +	__u32 argsz;
> +	__u32 flags;
> +	/* in */
> +	__u32 page_shift;
> +	__u32 window_shift;
> +	__u32 levels;
> +	/* out */
> +	__u64 start_addr;
> +};
> +#define VFIO_IOMMU_SPAPR_TCE_CREATE	_IO(VFIO_TYPE, VFIO_BASE + 19)
> +
> +struct vfio_iommu_spapr_tce_remove {
> +	__u32 argsz;
> +	__u32 flags;
> +	/* in */
> +	__u64 start_addr;
> +};
> +#define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
> +


Nak, -EINSUFFICIENTDOCS

>  /* ***************************************************************** */
>  
>  #endif /* _UAPIVFIO_H */
