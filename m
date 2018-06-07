Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411sNN56xrzF34s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 03:04:52 +1000 (AEST)
Date: Thu, 7 Jun 2018 11:04:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Ram Pai <linuxram@us.ibm.com>,
 kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 5/5] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Message-ID: <20180607110449.2c25a62d@w520.home>
In-Reply-To: <20180607084420.29513-6-aik@ozlabs.ru>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607084420.29513-6-aik@ozlabs.ru>
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

On Thu,  7 Jun 2018 18:44:20 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Some POWER9 chips come with special NVLink2 links which provide
> cacheable memory access to the RAM physically located on NVIDIA GPU.
> This memory is presented to a host via the device tree but remains
> offline until the NVIDIA driver onlines it.
> 
> This exports this RAM to the userspace as a new region so
> the NVIDIA driver in the guest can train these links and online GPU RAM.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/pci/Makefile           |   1 +
>  drivers/vfio/pci/vfio_pci_private.h |   8 ++
>  include/uapi/linux/vfio.h           |   3 +
>  drivers/vfio/pci/vfio_pci.c         |   9 ++
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 190 ++++++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/Kconfig            |   4 +
>  6 files changed, 215 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
> 
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 76d8ec0..9662c06 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -1,5 +1,6 @@
>  
>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> +vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
>  
>  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 86aab05..7115b9b 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -160,4 +160,12 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
>  	return -ENODEV;
>  }
>  #endif
> +#ifdef CONFIG_VFIO_PCI_NVLINK2
> +extern int vfio_pci_nvlink2_init(struct vfio_pci_device *vdev);
> +#else
> +static inline int vfio_pci_nvlink2_init(struct vfio_pci_device *vdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
>  #endif /* VFIO_PCI_PRIVATE_H */
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82..2fe8227 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -301,6 +301,9 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>  
> +/* NVIDIA GPU NV2 */
> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2	(4)

You're continuing the Intel vendor ID sub-types for an NVIDIA vendor ID
subtype.  Each vendor has their own address space of sub-types.

> +
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 7bddf1e..38c9475 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -306,6 +306,15 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		}
>  	}
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
> +	    pdev->device == 0x1db1 &&
> +	    IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2)) {

Can't we do better than check this based on device ID?  Perhaps PCIe
capability hints at this?

Is it worthwhile to continue with assigning the device in the !ENABLED
case?  For instance, maybe it would be better to provide a weak
definition of vfio_pci_nvlink2_init() that would cause us to fail here
if we don't have this device specific support enabled.  I realize
you're following the example set forth for IGD, but those regions are
optional, for better or worse.

> +		ret = vfio_pci_nvlink2_init(vdev);
> +		if (ret)
> +			dev_warn(&vdev->pdev->dev,
> +				 "Failed to setup NVIDIA NV2 RAM region\n");
> +	}
> +
>  	vfio_pci_probe_mmaps(vdev);
>  
>  	return 0;
> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> new file mode 100644
> index 0000000..451c5cb
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VFIO PCI NVIDIA Whitherspoon GPU support a.k.a. NVLink2.
> + *
> + * Copyright (C) 2018 IBM Corp.  All rights reserved.
> + *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Register an on-GPU RAM region for cacheable access.
> + *
> + * Derived from original vfio_pci_igd.c:
> + * Copyright (C) 2016 Red Hat, Inc.  All rights reserved.
> + *	Author: Alex Williamson <alex.williamson@redhat.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +#include <linux/uaccess.h>
> +#include <linux/vfio.h>
> +#include <linux/sched/mm.h>
> +#include <linux/mmu_context.h>
> +
> +#include "vfio_pci_private.h"
> +
> +struct vfio_pci_nvlink2_data {
> +	unsigned long gpu_hpa;
> +	unsigned long useraddr;
> +	unsigned long size;
> +	struct mm_struct *mm;
> +	struct mm_iommu_table_group_mem_t *mem;
> +};
> +
> +static size_t vfio_pci_nvlink2_rw(struct vfio_pci_device *vdev,
> +		char __user *buf, size_t count, loff_t *ppos, bool iswrite)
> +{
> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
> +	void *base = vdev->region[i].data;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +
> +	if (pos >= vdev->region[i].size)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(vdev->region[i].size - pos));
> +
> +	if (iswrite) {
> +		if (copy_from_user(base + pos, buf, count))
> +			return -EFAULT;
> +	} else {
> +		if (copy_to_user(buf, base + pos, count))
> +			return -EFAULT;
> +	}
> +	*ppos += count;
> +
> +	return count;
> +}
> +
> +static void vfio_pci_nvlink2_release(struct vfio_pci_device *vdev,
> +		struct vfio_pci_region *region)
> +{
> +	struct vfio_pci_nvlink2_data *data = region->data;
> +	long ret;
> +
> +	ret = mm_iommu_put(data->mm, data->mem);
> +	WARN_ON(ret);
> +
> +	mmdrop(data->mm);
> +	kfree(data);
> +}
> +
> +static int vfio_pci_nvlink2_mmap_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct vfio_pci_region *region = vma->vm_private_data;
> +	struct vfio_pci_nvlink2_data *data = region->data;
> +	int ret;
> +	unsigned long vmf_off = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> +	unsigned long nv2pg = data->gpu_hpa >> PAGE_SHIFT;
> +	unsigned long vm_pgoff = vma->vm_pgoff &
> +		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> +	unsigned long pfn = nv2pg + vm_pgoff + vmf_off;
> +
> +	ret = vm_insert_pfn(vma, vmf->address, pfn);
> +	/* TODO: make it a tracepoint */
> +	pr_debug("NVLink2: vmf=%lx hpa=%lx ret=%d\n",
> +		 vmf->address, pfn << PAGE_SHIFT, ret);
> +	if (ret)
> +		return VM_FAULT_SIGSEGV;
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vfio_pci_nvlink2_mmap_vmops = {
> +	.fault = vfio_pci_nvlink2_mmap_fault,
> +};
> +
> +static int vfio_pci_nvlink2_mmap(struct vfio_pci_device *vdev,
> +		struct vfio_pci_region *region, struct vm_area_struct *vma)
> +{
> +	long ret;
> +	struct vfio_pci_nvlink2_data *data = region->data;
> +
> +	if (data->useraddr)
> +		return -EPERM;
> +
> +	if (vma->vm_end - vma->vm_start > data->size)
> +		return -EINVAL;
> +
> +	vma->vm_private_data = region;
> +	vma->vm_flags |= VM_PFNMAP;
> +	vma->vm_ops = &vfio_pci_nvlink2_mmap_vmops;
> +
> +	/*
> +	 * Calling mm_iommu_newdev() here once as the region is not
> +	 * registered yet and therefore right initialization will happen now.
> +	 * Other places will use mm_iommu_find() which returns
> +	 * registered @mem and does not go gup().
> +	 */
> +	data->useraddr = vma->vm_start;
> +	data->mm = current->mm;
> +	atomic_inc(&data->mm->mm_count);
> +	ret = mm_iommu_newdev(data->mm, data->useraddr,
> +			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
> +			data->gpu_hpa, &data->mem);
> +
> +	pr_debug("VFIO NVLINK2 mmap: useraddr=%lx hpa=%lx size=%lx ret=%ld\n",
> +			data->useraddr, data->gpu_hpa,
> +			vma->vm_end - vma->vm_start, ret);
> +
> +	return ret;
> +}
> +
> +static const struct vfio_pci_regops vfio_pci_nvlink2_regops = {
> +	.rw = vfio_pci_nvlink2_rw,
> +	.release = vfio_pci_nvlink2_release,
> +	.mmap = vfio_pci_nvlink2_mmap,
> +};
> +
> +int vfio_pci_nvlink2_init(struct vfio_pci_device *vdev)
> +{
> +	int len = 0, ret;
> +	struct device_node *npu_node, *mem_node;
> +	struct pci_dev *npu_dev;
> +	uint32_t *mem_phandle, *val;
> +	struct vfio_pci_nvlink2_data *data;
> +
> +	npu_dev = pnv_pci_get_npu_dev(vdev->pdev, 0);
> +	if (!npu_dev)
> +		return -EINVAL;
> +
> +	npu_node = pci_device_to_OF_node(npu_dev);
> +	if (!npu_node)
> +		return -EINVAL;
> +
> +	mem_phandle = (void *) of_get_property(npu_node, "memory-region", NULL);
> +	if (!mem_phandle)
> +		return -EINVAL;
> +
> +	mem_node = of_find_node_by_phandle(be32_to_cpu(*mem_phandle));
> +	if (!mem_node)
> +		return -EINVAL;
> +
> +	val = (uint32_t *) of_get_property(mem_node, "reg", &len);
> +	if (!val || len != 2 * sizeof(uint64_t))
> +		return -EINVAL;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->gpu_hpa = ((uint64_t)be32_to_cpu(val[0]) << 32) |
> +			be32_to_cpu(val[1]);
> +	data->size = ((uint64_t)be32_to_cpu(val[2]) << 32) |
> +			be32_to_cpu(val[3]);
> +
> +	dev_dbg(&vdev->pdev->dev, "%lx..%lx\n", data->gpu_hpa,
> +			data->gpu_hpa + data->size - 1);
> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +			PCI_VENDOR_ID_NVIDIA | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
> +			VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2,
> +			&vfio_pci_nvlink2_regops, data->size,
> +			VFIO_REGION_INFO_FLAG_READ, data);
> +	if (ret)
> +		kfree(data);
> +
> +	return ret;
> +}
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 24ee260..2725bc8 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -30,3 +30,7 @@ config VFIO_PCI_INTX
>  config VFIO_PCI_IGD
>  	depends on VFIO_PCI
>  	def_bool y if X86
> +
> +config VFIO_PCI_NVLINK2
> +	depends on VFIO_PCI
> +	def_bool y if PPC_POWERNV

As written, this also depends on PPC_POWERNV (or at least TCE), it's not
a portable implementation that we could re-use on X86 or ARM or any
other platform if hardware appeared for it.  Can we improve that as
well to make this less POWER specific?  Thanks,

Alex
