Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 242841A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 12:10:16 +1100 (AEDT)
Message-ID: <1426036206.25026.108.camel@redhat.com>
Subject: Re: [PATCH v5 29/29] vfio: powerpc/spapr: Support Dynamic DMA windows
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 10 Mar 2015 19:10:06 -0600
In-Reply-To: <1425910045-26167-30-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
 <1425910045-26167-30-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-10 at 01:07 +1100, Alexey Kardashevskiy wrote:
> This adds create/remove window ioctls to create and remove DMA windows.
> sPAPR defines a Dynamic DMA windows capability which allows
> para-virtualized guests to create additional DMA windows on a PCI bus.
> The existing linux kernels use this new window to map the entire guest
> memory and switch to the direct DMA operations saving time on map/unmap
> requests which would normally happen in a big amounts.
> 
> This adds 2 ioctl handlers - VFIO_IOMMU_SPAPR_TCE_CREATE and
> VFIO_IOMMU_SPAPR_TCE_REMOVE - to create and remove windows.
> Up to 2 windows are supported now by the hardware and by this driver.
> 
> This changes VFIO_IOMMU_SPAPR_TCE_GET_INFO handler to return additional
> information such as a number of supported windows and maximum number
> levels of TCE tables.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v4:
> * moved code to tce_iommu_create_window()/tce_iommu_remove_window()
> helpers
> * added docs
> ---
>  Documentation/vfio.txt              |  19 +++++
>  arch/powerpc/include/asm/iommu.h    |   2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c | 165 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/vfio.h           |  24 +++++-
>  4 files changed, 207 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 791e85c..61ce393 100644
> --- a/Documentation/vfio.txt
> +++ b/Documentation/vfio.txt
> @@ -446,6 +446,25 @@ the memory block.
>  The user space is not expected to call these often and the block descriptors
>  are stored in a linked list in the kernel.
>  
> +6) sPAPR specification allows guests to have an ddditional DMA window(s) on
> +a PCI bus with a variable page size. Two ioctls have been added to support
> +this: VFIO_IOMMU_SPAPR_TCE_CREATE and VFIO_IOMMU_SPAPR_TCE_REMOVE.
> +The platform has to support the functionality or error will be returned to
> +the userspace. The existing hardware supports up to 2 DMA windows, one is
> +2GB long, uses 4K pages and called "default 32bit window"; the other can
> +be as big as entire RAM, use different page size, it is optional - guests
> +create those in run-time if the guest driver supports 64bit DMA.
> +
> +VFIO_IOMMU_SPAPR_TCE_CREATE receives a page shift, a DMA window size and
> +a number of TCE table levels (if a TCE table is going to be big enough and
> +the kernel may not be able to allocate enough of physicall contiguous memory).
> +It creates a new window in the available slot and returns the bus address where
> +the new window starts. Due to hardware limitation, the user space cannot choose
> +the location of DMA windows.
> +
> +VFIO_IOMMU_SPAPR_TCE_REMOVE receives the bus start address of the window
> +and removes it.
> +
>  -------------------------------------------------------------------------------
>  
>  [1] VFIO was originally an acronym for "Virtual Function I/O" in its
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index 04f72ac..de82b61 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -138,7 +138,7 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
>  extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>  					    int nid);
>  
> -#define IOMMU_TABLE_GROUP_MAX_TABLES	1
> +#define IOMMU_TABLE_GROUP_MAX_TABLES	2
>  
>  struct iommu_table_group;
>  
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 3a0b5fe..7aa4141b 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -96,6 +96,7 @@ struct tce_container {
>  	struct list_head mem_list;
>  	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
> +	bool v2;
>  };
>  
>  struct tce_iommu_group {
> @@ -333,6 +334,20 @@ static struct iommu_table *spapr_tce_find_table(
>  	return ret;
>  }
>  
> +static int spapr_tce_find_free_table(struct tce_container *container)
> +{
> +	int i;
> +
> +	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl = &container->tables[i];
> +
> +		if (!tbl->it_size)
> +			return i;
> +	}
> +
> +	return -1;


Why not use a real errno here?

> +}
> +
>  static int tce_iommu_enable(struct tce_container *container)
>  {
>  	int ret = 0;
> @@ -432,6 +447,8 @@ static void *tce_iommu_open(unsigned long arg)
>  	INIT_LIST_HEAD_RCU(&container->mem_list);
>  	INIT_LIST_HEAD_RCU(&container->group_list);
>  
> +	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
> +

Ah, here v2 actually provides some enforced differentiation, right?  ...
oh wait, nobody ever uses this.
>  	return container;
>  }
>  
> @@ -605,11 +622,90 @@ static long tce_iommu_build(struct tce_container *container,
>  	return ret;
>  }
>  
> +static long tce_iommu_create_window(struct tce_container *container,
> +		__u32 page_shift, __u64 window_size, __u32 levels,
> +		__u64 *start_addr)
> +{
> +	struct iommu_table_group *table_group;
> +	struct tce_iommu_group *tcegrp;
> +	int num;
> +	long ret;
> +
> +	num = spapr_tce_find_free_table(container);
> +	if (num < 0)
> +		return -ENOSYS;

Wouldn't something like ENOSPC be more appropriate (returned from the
function, not invented here)?

> +
> +	tcegrp = list_first_entry(&container->group_list,
> +			struct tce_iommu_group, next);
> +	table_group = iommu_group_get_iommudata(tcegrp->grp);
> +
> +	ret = table_group->ops->create_table(table_group, num,
> +			page_shift, window_size, levels,
> +			&container->tables[num]);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry(tcegrp, &container->group_list, next) {
> +		struct iommu_table_group *table_group_tmp =
> +			iommu_group_get_iommudata(tcegrp->grp);
> +
> +		if (WARN_ON_ONCE(table_group_tmp->ops != table_group->ops))
> +			return -EFAULT;

EFAULT doesn't seem appropriate either.  What "bad address" did the user
provide?

> +
> +		ret = table_group->ops->set_window(table_group_tmp, num,
> +				&container->tables[num]);
> +		if (ret)
> +			return ret;

I admit I'm getting lost in the details here, but it seems we have a
number of cases we're we've set something up and we're just bailing on
errors with no sign that we're undoing any previous operations.

> +	}
> +
> +	*start_addr = container->tables[num].it_offset <<
> +		container->tables[num].it_page_shift;
> +
> +	return 0;
> +}
> +
> +static long tce_iommu_remove_window(struct tce_container *container,
> +		__u64 start_addr)
> +{
> +	struct iommu_table_group *table_group = NULL;
> +	struct iommu_table *tbl;
> +	struct tce_iommu_group *tcegrp;
> +	int num;
> +
> +	tbl = spapr_tce_find_table(container, start_addr);
> +	if (!tbl)
> +		return -EINVAL;
> +
> +	/* Detach groups from IOMMUs */
> +	num = tbl - container->tables;
> +	list_for_each_entry(tcegrp, &container->group_list, next) {
> +		table_group = iommu_group_get_iommudata(tcegrp->grp);
> +		if (!table_group->ops || !table_group->ops->unset_window)
> +			return -EFAULT;

Is this valid?  Why would we let the user set_window on something that
doesn't have an unset?  What state does this leave the system in to
fault here?  What's the "bad address" the user passed to get here?

> +		if (container->tables[num].it_size)
> +			table_group->ops->unset_window(table_group, num);
> +	}
> +
> +	/* Free table */
> +	tcegrp = list_first_entry(&container->group_list,
> +			struct tce_iommu_group, next);
> +	table_group = iommu_group_get_iommudata(tcegrp->grp);
> +
> +	tce_iommu_clear(container, tbl,
> +			tbl->it_offset, tbl->it_size);
> +	if (tbl->it_ops->free)
> +		tbl->it_ops->free(tbl);
> +
> +	memset(tbl, 0, sizeof(*tbl));
> +
> +	return 0;
> +}
> +
>  static long tce_iommu_ioctl(void *iommu_data,
>  				 unsigned int cmd, unsigned long arg)
>  {
>  	struct tce_container *container = iommu_data;
> -	unsigned long minsz;
> +	unsigned long minsz, ddwsz;
>  	long ret;
>  
>  	switch (cmd) {
> @@ -652,6 +748,16 @@ static long tce_iommu_ioctl(void *iommu_data,
>  
>  		info.dma32_window_start = table_group->tce32_start;
>  		info.dma32_window_size = table_group->tce32_size;
> +		info.max_dynamic_windows_supported =
> +				table_group->max_dynamic_windows_supported;
> +		info.levels = table_group->max_levels;
> +		info.flags = table_group->flags;
> +
> +		ddwsz = offsetofend(struct vfio_iommu_spapr_tce_info,
> +				levels);
> +
> +		if (info.argsz == ddwsz)
> +			minsz = ddwsz;
>  
>  		if (copy_to_user((void __user *)arg, &info, minsz))
>  			return -EFAULT;
> @@ -823,6 +929,63 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		return ret;
>  	}
>  
> +	case VFIO_IOMMU_SPAPR_TCE_CREATE: {
> +		struct vfio_iommu_spapr_tce_create create;
> +
> +		if (!tce_preregistered(container))
> +			return -EPERM;
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
> +		mutex_lock(&container->lock);
> +
> +		ret = tce_iommu_create_window(container, create.page_shift,
> +				create.window_size, create.levels,
> +				&create.start_addr);
> +
> +		if (!ret && copy_to_user((void __user *)arg, &create, minsz))
> +			return -EFAULT;
> +
> +		mutex_unlock(&container->lock);


Too bad that above return doesn't unlock the mutex too.

> +
> +		return ret;
> +	}
> +	case VFIO_IOMMU_SPAPR_TCE_REMOVE: {
> +		struct vfio_iommu_spapr_tce_remove remove;
> +
> +		if (!tce_preregistered(container))
> +			return -EPERM;
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
> +		mutex_lock(&container->lock);
> +
> +		ret = tce_iommu_remove_window(container, remove.start_addr);
> +
> +		mutex_unlock(&container->lock);
> +
> +		return ret;
> +	}
>  	}
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index fbc5286..150f418 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -457,9 +457,11 @@ struct vfio_iommu_type1_dma_unmap {
>   */
>  struct vfio_iommu_spapr_tce_info {
>  	__u32 argsz;
> -	__u32 flags;			/* reserved for future use */
> +	__u32 flags;
>  	__u32 dma32_window_start;	/* 32 bit window start (bytes) */
>  	__u32 dma32_window_size;	/* 32 bit window size (bytes) */
> +	__u32 max_dynamic_windows_supported;
> +	__u32 levels;

How does the user know these extra fields are there?  flags is a return
value here that could be used to indicate features.

>  };
>  
>  #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
> @@ -520,6 +522,26 @@ struct vfio_iommu_spapr_register_memory {
>   */
>  #define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 18)
>  
> +struct vfio_iommu_spapr_tce_create {
> +	__u32 argsz;
> +	__u32 flags;
> +	/* in */
> +	__u32 page_shift;
> +	__u64 window_size;
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

Comments are lacking here compared to the reset of the interfaces.

>  /* ***************************************************************** */
>  
>  #endif /* _UAPIVFIO_H */
