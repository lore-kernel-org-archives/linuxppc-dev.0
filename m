Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37A7D1A0E00
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 13:18:33 +1100 (AEDT)
Received: by pdbnh10 with SMTP id nh10so4144272pdb.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 18:18:31 -0800 (PST)
Message-ID: <54E6996E.9060103@ozlabs.ru>
Date: Fri, 20 Feb 2015 13:18:22 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 27/28] vfio: powerpc/spapr: Register memory
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
 <1424081180-4494-28-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-28-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Alexander Graf <agraf@suse.de>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just noticed - this patch should be split into two, they were squashed by 
mistake, my bad.


On 02/16/2015 09:06 PM, Alexey Kardashevskiy wrote:
> The existing implementation accounts the whole DMA window in
> the locked_vm counter which is going to be even worse with multiple
> containers and huge DMA windows.
>
> This introduces 2 ioctls to register/unregister DMA memory which
> receive user space address and size of the memory region which
> needs to be pinned/unpinned and counted in locked_vm.
>
> If any memory region was registered, all subsequent DMA map requests
> should address already pinned memory. If no memory was registered,
> then the amount of memory required for a single default memory will be
> accounted when the container is enabled and every map/unmap will pin/unpin
> a page.
>
> Dynamic DMA window and in-kernel acceleration will require memory to
> be registered in order to work.
>
> The accounting is done per VFIO container. When the support of
> multiple groups per container is added, we will have accurate locked_vm
> accounting.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v4:
> * updated docs
> * s/kzmalloc/vzalloc/
> * in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
> replaced offset with index
> * renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_register_memory
> and removed duplicating vfio_iommu_spapr_register_memory
> ---
>   drivers/vfio/vfio_iommu_spapr_tce.c | 222 ++++++++++++++++++++++++------------
>   1 file changed, 148 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 4ff8289..ee91d51 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -91,10 +91,16 @@ static void decrement_locked_vm(long npages)
>    */
>   struct tce_container {
>   	struct mutex lock;
> -	struct iommu_group *grp;
>   	bool enabled;
>   	unsigned long locked_pages;
>   	struct list_head mem_list;
> +	struct iommu_table tables[POWERPC_IOMMU_MAX_TABLES];
> +	struct list_head group_list;
> +};
> +
> +struct tce_iommu_group {
> +	struct list_head next;
> +	struct iommu_group *grp;
>   };
>
>   struct tce_memory {
> @@ -300,19 +306,20 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
>   	return false;
>   }
>
> +static inline bool tce_groups_attached(struct tce_container *container)
> +{
> +	return !list_empty(&container->group_list);
> +}
> +
>   static struct iommu_table *spapr_tce_find_table(
>   		struct tce_container *container,
>   		phys_addr_t ioba)
>   {
>   	long i;
>   	struct iommu_table *ret = NULL;
> -	struct powerpc_iommu *iommu = iommu_group_get_iommudata(container->grp);
> -
> -	if (!iommu)
> -		return NULL;
>
>   	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
> -		struct iommu_table *tbl = &iommu->tables[i];
> +		struct iommu_table *tbl = &container->tables[i];
>   		unsigned long entry = ioba >> tbl->it_page_shift;
>   		unsigned long start = tbl->it_offset;
>   		unsigned long end = start + tbl->it_size;
> @@ -330,11 +337,8 @@ static int tce_iommu_enable(struct tce_container *container)
>   {
>   	int ret = 0;
>   	unsigned long locked;
> -	struct iommu_table *tbl;
>   	struct powerpc_iommu *iommu;
> -
> -	if (!container->grp)
> -		return -ENXIO;
> +	struct tce_iommu_group *tcegrp;
>
>   	if (!current->mm)
>   		return -ESRCH; /* process exited */
> @@ -368,12 +372,24 @@ static int tce_iommu_enable(struct tce_container *container)
>   	 * KVM agnostic.
>   	 */
>   	if (!tce_preregistered(container)) {
> -		iommu = iommu_group_get_iommudata(container->grp);
> +		if (!tce_groups_attached(container))
> +			return -ENODEV;
> +
> +		tcegrp = list_first_entry(&container->group_list,
> +				struct tce_iommu_group, next);
> +		iommu = iommu_group_get_iommudata(tcegrp->grp);
>   		if (!iommu)
>   			return -ENODEV;
>
> -		tbl = &iommu->tables[0];
> -		locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> +		/*
> +		 * We do not allow enabling a group if no DMA-able memory was
> +		 * registered as there is no way to know how much we should
> +		 * increment the locked_vm counter.
> +		 */
> +		if (!iommu->tce32_size)
> +			return -EPERM;
> +
> +		locked = iommu->tce32_size >> PAGE_SHIFT;
>   		ret = try_increment_locked_vm(locked);
>   		if (ret)
>   			return ret;
> @@ -386,6 +402,10 @@ static int tce_iommu_enable(struct tce_container *container)
>   	return ret;
>   }
>
> +static int tce_iommu_clear(struct tce_container *container,
> +		struct iommu_table *tbl,
> +		unsigned long entry, unsigned long pages);
> +
>   static void tce_iommu_disable(struct tce_container *container)
>   {
>   	if (!container->enabled)
> @@ -414,6 +434,7 @@ static void *tce_iommu_open(unsigned long arg)
>
>   	mutex_init(&container->lock);
>   	INIT_LIST_HEAD_RCU(&container->mem_list);
> +	INIT_LIST_HEAD_RCU(&container->group_list);
>
>   	return container;
>   }
> @@ -427,16 +448,30 @@ static void tce_iommu_release(void *iommu_data)
>   	struct tce_container *container = iommu_data;
>   	struct iommu_table *tbl;
>   	struct powerpc_iommu *iommu;
> +	int i;
> +	struct tce_iommu_group *tcegrp;
> +	struct powerpc_iommu_ops *iommuops = NULL;
>
> -	WARN_ON(container->grp);
>   	tce_iommu_disable(container);
>
> -	if (container->grp) {
> -		iommu = iommu_group_get_iommudata(container->grp);
> -		tbl = &iommu->tables[0];
> -		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
> -		iommu->ops->free_table(tbl);
> -		tce_iommu_detach_group(iommu_data, container->grp);
> +	/* Free tables */
> +	if (iommuops) {
> +		for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
> +			tbl = &container->tables[i];
> +
> +			tce_iommu_clear(container, tbl,
> +					tbl->it_offset, tbl->it_size);
> +
> +			iommuops->free_table(tbl);
> +		}
> +	}
> +
> +	while (tce_groups_attached(container)) {
> +		tcegrp = list_first_entry(&container->group_list,
> +				struct tce_iommu_group, next);
> +		iommu = iommu_group_get_iommudata(tcegrp->grp);
> +		iommuops = iommu->ops;
> +		tce_iommu_detach_group(iommu_data, tcegrp->grp);
>   	}
>
>   	tce_mem_unregister_all(container);
> @@ -607,16 +642,17 @@ static long tce_iommu_ioctl(void *iommu_data,
>
>   	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>   		struct vfio_iommu_spapr_tce_info info;
> -		struct iommu_table *tbl;
> +		struct tce_iommu_group *tcegrp;
>   		struct powerpc_iommu *iommu;
>
> -		if (WARN_ON(!container->grp))
> +		if (!tce_groups_attached(container))
>   			return -ENXIO;
>
> -		iommu = iommu_group_get_iommudata(container->grp);
> +		tcegrp = list_first_entry(&container->group_list,
> +				struct tce_iommu_group, next);
> +		iommu = iommu_group_get_iommudata(tcegrp->grp);
>
> -		tbl = &iommu->tables[0];
> -		if (WARN_ON_ONCE(!tbl))
> +		if (!iommu)
>   			return -ENXIO;
>
>   		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
> @@ -628,9 +664,8 @@ static long tce_iommu_ioctl(void *iommu_data,
>   		if (info.argsz < minsz)
>   			return -EINVAL;
>
> -		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
> -		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
> -		info.flags = 0;
> +		info.dma32_window_start = iommu->tce32_start;
> +		info.dma32_window_size = iommu->tce32_size;
>
>   		if (copy_to_user((void __user *)arg, &info, minsz))
>   			return -EFAULT;
> @@ -779,12 +814,20 @@ static long tce_iommu_ioctl(void *iommu_data,
>   		tce_iommu_disable(container);
>   		mutex_unlock(&container->lock);
>   		return 0;
> -	case VFIO_EEH_PE_OP:
> -		if (!container->grp)
> -			return -ENODEV;
>
> -		return vfio_spapr_iommu_eeh_ioctl(container->grp,
> -						  cmd, arg);
> +	case VFIO_EEH_PE_OP: {
> +		struct tce_iommu_group *tcegrp;
> +
> +		ret = 0;
> +		list_for_each_entry(tcegrp, &container->group_list, next) {
> +			ret = vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
> +					cmd, arg);
> +			if (ret)
> +				return ret;
> +		}
> +		return ret;
> +	}
> +
>   	}
>
>   	return -ENOTTY;
> @@ -793,34 +836,34 @@ static long tce_iommu_ioctl(void *iommu_data,
>   static int tce_iommu_attach_group(void *iommu_data,
>   		struct iommu_group *iommu_group)
>   {
> -	int ret = 0;
> +	int ret = 0, i;
>   	struct tce_container *container = iommu_data;
> -	struct powerpc_iommu *iommu;
> -	struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
> +	struct powerpc_iommu *iommu = iommu_group_get_iommudata(iommu_group);
> +	struct tce_iommu_group *tcegrp;
> +	bool first_group = !tce_groups_attached(container);
>
>   	mutex_lock(&container->lock);
>
>   	/* pr_debug("tce_vfio: Attaching group #%u to iommu %p\n",
>   			iommu_group_id(iommu_group), iommu_group); */
> -	if (container->grp) {
> -		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, existing id=%d, attaching id=%d\n",
> -				iommu_group_id(container->grp),
> -				iommu_group_id(iommu_group));
> -		ret = -EBUSY;
> -		goto unlock_exit;
> -	}
>
> -	if (container->enabled) {
> -		pr_err("tce_vfio: attaching group #%u to enabled container\n",
> -				iommu_group_id(iommu_group));
> -		ret = -EBUSY;
> -		goto unlock_exit;
> -	}
> +	list_for_each_entry(tcegrp, &container->group_list, next) {
> +		struct powerpc_iommu *iommutmp;
>
> -	iommu = iommu_group_get_iommudata(iommu_group);
> -	if (WARN_ON_ONCE(!iommu)) {
> -		ret = -ENXIO;
> -		goto unlock_exit;
> +		if (tcegrp->grp == iommu_group) {
> +			pr_warn("tce_vfio: Group %d is already attached\n",
> +					iommu_group_id(iommu_group));
> +			ret = -EBUSY;
> +			goto unlock_exit;
> +		}
> +		iommutmp = iommu_group_get_iommudata(tcegrp->grp);
> +		if (iommutmp->ops != iommu->ops) {
> +			pr_warn("tce_vfio: Group %d is incompatible with group %d\n",
> +					iommu_group_id(iommu_group),
> +					iommu_group_id(tcegrp->grp));
> +			ret = -EBUSY;
> +			goto unlock_exit;
> +		}
>   	}
>
>   	/*
> @@ -835,14 +878,48 @@ static int tce_iommu_attach_group(void *iommu_data,
>   		goto unlock_exit;
>   	}
>
> -	container->grp = iommu_group;
> -
> -	/* Create the default window as only now we know the parameters */
> -	ret = iommu->ops->create_table(iommu, 0,
> -			IOMMU_PAGE_SHIFT_4K,
> -			ilog2(iommu->tce32_size), 1, tbl);
> -	if (!ret)
> -		ret = iommu->ops->set_window(iommu, 0, tbl);
> +	/* Put the group to the list so tce_def_window_create() can succeed */
> +	tcegrp = kzalloc(sizeof(*tcegrp), GFP_KERNEL);
> +	tcegrp->grp = iommu_group;
> +	list_add(&tcegrp->next, &container->group_list);
> +
> +	/*
> +	 * If it the first group attached, check if there is any window
> +	 * created and create one if none.
> +	 */
> +	if (first_group) {
> +		bool found = false;
> +
> +		for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
> +			if (!container->tables[i].it_size)
> +				continue;
> +
> +			found = true;
> +			break;
> +		}
> +		if (!found) {
> +			struct iommu_table *tbl = &container->tables[0];
> +
> +			ret = iommu->ops->create_table(iommu, 0,
> +					IOMMU_PAGE_SHIFT_4K,
> +					ilog2(iommu->tce32_size), 1, tbl);
> +			if (ret)
> +				goto unlock_exit;
> +		}
> +	}
> +
> +	/* Set all windows to the new group */
> +	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl = &container->tables[i];
> +
> +		if (!tbl->it_size)
> +			continue;
> +
> +		/* Set the default window to a new group */
> +		ret = iommu->ops->set_window(iommu, i, tbl);
> +		if (ret)
> +			goto unlock_exit;
> +	}
>
>   unlock_exit:
>   	mutex_unlock(&container->lock);
> @@ -855,24 +932,18 @@ static void tce_iommu_detach_group(void *iommu_data,
>   {
>   	struct tce_container *container = iommu_data;
>   	struct powerpc_iommu *iommu;
> +	struct tce_iommu_group *tcegrp, *tcegrptmp;
>   	long i;
>
>   	mutex_lock(&container->lock);
> -	if (iommu_group != container->grp) {
> -		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
> -				iommu_group_id(iommu_group),
> -				iommu_group_id(container->grp));
> -	} else {
> -		if (container->enabled) {
> -			pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
> -					iommu_group_id(container->grp));
> -			tce_iommu_disable(container);
> -		}
>
> -		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
> -				iommu_group_id(iommu_group), iommu_group); */
> -		container->grp = NULL;
> +	/* Detach windows from IOMMUs */
> +	list_for_each_entry_safe(tcegrp, tcegrptmp, &container->group_list,
> +			next) {
> +		if (tcegrp->grp != iommu_group)
> +			continue;
>
> +		list_del(&tcegrp->next);
>   		iommu = iommu_group_get_iommudata(iommu_group);
>   		BUG_ON(!iommu);
>
> @@ -882,6 +953,9 @@ static void tce_iommu_detach_group(void *iommu_data,
>   		/* Kernel owns the device now, we can restore bypass */
>   		if (iommu->ops && iommu->ops->set_ownership)
>   			iommu->ops->set_ownership(iommu, false);
> +
> +		kfree(tcegrp);
> +		break;
>   	}
>   	mutex_unlock(&container->lock);
>   }
>


-- 
Alexey
