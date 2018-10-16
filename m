Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A50C5ACCA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 19:10:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03F72087A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 19:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03F72087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZPyp3WXVzF3W7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 06:10:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZPwX6CDHzF3W9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 06:08:28 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87AC57F6BB;
 Tue, 16 Oct 2018 19:08:26 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FF7F62962;
 Tue, 16 Oct 2018 19:08:25 +0000 (UTC)
Date: Tue, 16 Oct 2018 13:08:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Message-ID: <20181016130824.20be215b@w520.home>
In-Reply-To: <20181015094233.1324-4-aik@ozlabs.ru>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 16 Oct 2018 19:08:27 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Oct 2018 20:42:33 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
> pluggable PCIe devices but implement PCIe links for config space and MMIO.
> In addition to that the GPUs are interconnected to each other and also
> have direct links to the P9 CPU. The links are NVLink2 and provide direct
> access to the system RAM for GPUs via NPU (an NVLink2 "proxy" on P9 chip).
> These systems also support ATS (address translation services) which is
> a part of the NVLink2 prototol. Such GPUs also share on-board RAM
> (16GB in tested config) to the system via the same NVLink2 so a CPU has
> cache-coherent access to a GPU RAM.
> 
> This exports GPU RAM to the userspace as a new PCI region. This
> preregisters the new memory as device memory as it might be used for DMA.
> This inserts pfns from the fault handler as the GPU memory is not onlined
> until the NVIDIA driver is loaded and trained the links so doing this
> earlier produces low level errors which we fence in the firmware so
> it does not hurt the host system but still better to avoid.
> 
> This exports ATSD (Address Translation Shootdown) register of NPU which
> allows the guest to invalidate TLB. The register conviniently occupies
> a single 64k page. Since NPU maps the GPU memory, it has a "tgt" property
> (which is an abbreviated host system bus address). This exports the "tgt"
> as a capability so the guest can program it into the GPU so the GPU can
> know how to route DMA trafic.

I'm not really following what "tgt" is and why it's needed.  Is the GPU
memory here different than the GPU RAM region above?  Why does the user
need the host system bus address of this "tgt" thing?  Are we not able
to relocate it in guest physical address space, does this shootdown
only work in the host physical address space and therefore we need this
offset?  Please explain, I'm confused.
 
> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
> know LPID (a logical partition ID or a KVM guest hardware ID in other
> words) and PID (a memory context ID of an userspace process, not to be
> confused with a linux pid). This assigns a GPU to LPID in the NPU and
> this is why this adds a listener for KVM on an IOMMU group. A PID comes
> via NVLink from a GPU and NPU uses a PID wildcard to pass it through.
> 
> This requires coherent memory and ATSD to be available on the host as
> the GPU vendor only supports configurations with both features enabled
> and other configurations are known not to work. Because of this and
> because of the ways the features are advertised to the host system
> (which is a device tree with very platform specific properties),
> this requires enabled POWERNV platform.
> 
> This hardcodes the NVLink2 support for specific vendor and device IDs
> as there is no reliable way of knowing about coherent memory and ATS
> support. The GPU has an unique vendor PCIe capability 0x23 but it was
> confirmed that it does not provide required information (and it is still
> undisclosed what it actually does).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/pci/Makefile           |   1 +
>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>  include/uapi/linux/vfio.h           |  18 ++
>  drivers/vfio/pci/vfio_pci.c         |  37 +++-
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 409 ++++++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/Kconfig            |   4 +
>  6 files changed, 469 insertions(+), 2 deletions(-)
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
> index 93c1738..7639241 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -163,4 +163,6 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
>  	return -ENODEV;
>  }
>  #endif
> +extern int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev);
> +extern int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev);
>  #endif /* VFIO_PCI_PRIVATE_H */
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index f378b98..9e9a8d3 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -303,6 +303,12 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>  
> +/* NVIDIA GPU NVlink2 RAM */
> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
> +
> +/* IBM NPU NVlink2 ATSD */
> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> +

Please include some of the description in the commitlog here for
reference.  Also please be explicit that these are vendor defined
regions and note the numerical vendor ID associated with them.

>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
> @@ -313,6 +319,18 @@ struct vfio_region_info_cap_type {
>   */
>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>  
> +/*
> + * Capability with compressed real address (aka SSA - small system address)
> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
> + */
> +#define VFIO_REGION_INFO_CAP_NPU2		4
> +
> +struct vfio_region_info_cap_npu2 {
> +	struct vfio_info_cap_header header;
> +	__u64 tgt;
> +	/* size is defined in VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM */

But this is a capability for the IBM_NVLINK2_ATSD?  What is the
relevance of this comment?  Is this capability relevant to the RAM or
ATSD?

> +};
> +
>  /**
>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>   *				    struct vfio_irq_info)
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 4a3b93e..e9afd43 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -224,6 +224,16 @@ static bool vfio_pci_nointx(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +int __weak vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
> +{
> +	return -ENODEV;
> +}
> +
> +int __weak vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
> +{
> +	return -ENODEV;
> +}
> +
>  static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -302,14 +312,37 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		if (ret) {
>  			dev_warn(&vdev->pdev->dev,
>  				 "Failed to setup Intel IGD regions\n");
> -			vfio_pci_disable(vdev);
> -			return ret;
> +			goto disable_exit;
> +		}
> +	}
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
> +	    pdev->device == 0x1db1) {
> +		ret = vfio_pci_nvdia_v100_nvlink2_init(vdev);
> +		if (ret) {
> +			dev_warn(&vdev->pdev->dev,
> +				 "Failed to setup NVIDIA NV2 RAM region\n");
> +			goto disable_exit;
> +		}
> +	}

This device ID is not unique to POWER9 Witherspoon systems, I see your
comment in the commitlog, but this is clearly going to generate a
dev_warn and failure on an x86 system with the same hardware.  Perhaps
this could be masked off with IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2) like
the IGD code above this chunk does?

> +
> +	if (pdev->vendor == PCI_VENDOR_ID_IBM &&
> +			pdev->device == 0x04ea) {
> +		ret = vfio_pci_ibm_npu2_init(vdev);
> +		if (ret) {
> +			dev_warn(&vdev->pdev->dev,
> +					"Failed to setup NVIDIA NV2 ATSD region\n");
> +			goto disable_exit;
>  		}

So the NPU is also actually owned by vfio-pci and assigned to the VM?

>  	}
>  
>  	vfio_pci_probe_mmaps(vdev);
>  
>  	return 0;
> +
> +disable_exit:
> +	vfio_pci_disable(vdev);
> +	return ret;
>  }
>  
>  static void vfio_pci_disable(struct vfio_pci_device *vdev)
> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> new file mode 100644
> index 0000000..c9d2b55
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -0,0 +1,409 @@
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
> +#include <asm/kvm_ppc.h>
> +#include "vfio_pci_private.h"
> +

Please steal some of your description in the commitlog to document
inline what this is all about.

> +struct vfio_pci_nvgpu_data {
> +	unsigned long gpu_hpa;
> +	unsigned long useraddr;
> +	unsigned long size;
> +	void *base;
> +	struct mm_struct *mm;
> +	struct mm_iommu_table_group_mem_t *mem;
> +	struct pci_dev *gpdev;
> +	struct notifier_block group_notifier;
> +};
> +
> +static size_t vfio_pci_nvgpu_rw(struct vfio_pci_device *vdev,
> +		char __user *buf, size_t count, loff_t *ppos, bool iswrite)
> +{
> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
> +	struct vfio_pci_nvgpu_data *data = vdev->region[i].data;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +
> +	if (pos >= vdev->region[i].size)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(vdev->region[i].size - pos));
> +
> +	if (iswrite) {
> +		if (copy_from_user(data->base + pos, buf, count))
> +			return -EFAULT;
> +	} else {
> +		if (copy_to_user(buf, data->base + pos, count))
> +			return -EFAULT;
> +	}
> +	*ppos += count;
> +
> +	return count;
> +}
> +
> +static void vfio_pci_nvgpu_release(struct vfio_pci_device *vdev,
> +		struct vfio_pci_region *region)
> +{
> +	struct vfio_pci_nvgpu_data *data = region->data;
> +	long ret;
> +	struct pci_controller *hose;
> +	struct pci_dev *npdev;
> +
> +	/* If there were any mappings at all... */
> +	if (data->mm) {
> +		ret = mm_iommu_put(data->mm, data->mem);
> +		WARN_ON(ret);
> +
> +		mmdrop(data->mm);
> +	}
> +
> +	vfio_unregister_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
> +			&data->group_notifier);
> +
> +	npdev = pnv_pci_get_npu_dev(data->gpdev, 0);
> +	hose = pci_bus_to_host(npdev->bus);
> +
> +	pnv_npu2_map_lpar_dev(hose, data->gpdev, 0, MSR_DR | MSR_PR | MSR_HV);
> +
> +	memunmap(data->base);
> +	kfree(data);
> +}
> +
> +static int vfio_pci_nvgpu_mmap_fault(struct vm_fault *vmf)
> +{
> +	int ret;
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct vfio_pci_region *region = vma->vm_private_data;
> +	struct vfio_pci_nvgpu_data *data = region->data;
> +	unsigned long vmf_off = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> +	unsigned long nv2pg = data->gpu_hpa >> PAGE_SHIFT;
> +	unsigned long vm_pgoff = vma->vm_pgoff &
> +		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> +	unsigned long pfn = nv2pg + vm_pgoff + vmf_off;
> +
> +	ret = vm_insert_pfn(vma, vmf->address, pfn);
> +	pr_debug("NVLink2: vmf=%lx hpa=%lx ret=%d\n",
> +		 vmf->address, pfn << PAGE_SHIFT, ret);

Tracing would probably be a better option if you intend to keep this.

> +	if (ret)
> +		return VM_FAULT_SIGSEGV;
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vfio_pci_nvgpu_mmap_vmops = {
> +	.fault = vfio_pci_nvgpu_mmap_fault,
> +};
> +
> +static int vfio_pci_nvgpu_mmap(struct vfio_pci_device *vdev,
> +		struct vfio_pci_region *region, struct vm_area_struct *vma)
> +{
> +	long ret;
> +	struct vfio_pci_nvgpu_data *data = region->data;
> +
> +	if (data->useraddr)
> +		return -EPERM;
> +
> +	if (vma->vm_end - vma->vm_start > data->size)
> +		return -EINVAL;
> +
> +	vma->vm_private_data = region;
> +	vma->vm_flags |= VM_PFNMAP;
> +	vma->vm_ops = &vfio_pci_nvgpu_mmap_vmops;
> +
> +	/*
> +	 * Calling mm_iommu_newdev() here once as the region is not
> +	 * registered yet and therefore right initialization will happen now.
> +	 * Other places will use mm_iommu_find() which returns
> +	 * registered @mem and does not go gup().
> +	 */
> +	data->useraddr = vma->vm_start;
> +	data->mm = current->mm;
> +
> +	atomic_inc(&data->mm->mm_count);
> +	ret = mm_iommu_newdev(data->mm, data->useraddr,
> +			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
> +			data->gpu_hpa, &data->mem);
> +
> +	pr_debug("VFIO NVLINK2 mmap: useraddr=%lx hpa=%lx size=%lx ret=%ld\n",
> +			data->useraddr, data->gpu_hpa,
> +			vma->vm_end - vma->vm_start, ret);

Same

> +
> +	return ret;
> +}
> +
> +static const struct vfio_pci_regops vfio_pci_nvgpu_regops = {
> +	.rw = vfio_pci_nvgpu_rw,
> +	.release = vfio_pci_nvgpu_release,
> +	.mmap = vfio_pci_nvgpu_mmap,
> +};
> +
> +static int vfio_pci_nvgpu_group_notifier(struct notifier_block *nb,
> +		unsigned long action, void *opaque)
> +{
> +	struct kvm *kvm = opaque;
> +	struct vfio_pci_nvgpu_data *data = container_of(nb,
> +			struct vfio_pci_nvgpu_data,
> +			group_notifier);
> +
> +	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
> +		struct pci_controller *hose;
> +		struct pci_dev *npdev;
> +		struct pnv_phb *nphb;
> +
> +		npdev = pnv_pci_get_npu_dev(data->gpdev, 0);
> +		hose = pci_bus_to_host(npdev->bus);
> +		nphb = hose->private_data;
> +
> +		if (!kvm) {
> +			if (pnv_npu2_map_lpar_dev(hose, data->gpdev, 0,
> +					MSR_DR | MSR_PR | MSR_HV))
> +				return NOTIFY_BAD;
> +		} else {
> +			if (pnv_npu2_map_lpar_dev(hose, data->gpdev,
> +					kvm->arch.lpid, MSR_DR | MSR_PR))
> +				return NOTIFY_BAD;
> +		}
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
> +{
> +	int ret;
> +	u64 reg[2];
> +	struct device_node *npu_node, *mem_node;
> +	struct pci_dev *npu_dev;
> +	struct vfio_pci_nvgpu_data *data;
> +	uint32_t mem_phandle = 0;
> +	unsigned long events = VFIO_GROUP_NOTIFY_SET_KVM;
> +
> +	npu_dev = pnv_pci_get_npu_dev(vdev->pdev, 0);
> +	if (!npu_dev)
> +		return -EINVAL;
> +
> +	npu_node = pci_device_to_OF_node(npu_dev);
> +	if (!npu_node)
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(npu_node, "memory-region", &mem_phandle))
> +		return -EINVAL;
> +
> +	mem_node = of_find_node_by_phandle(mem_phandle);
> +	if (!mem_node)
> +		return -EINVAL;
> +
> +	if (of_property_read_variable_u64_array(mem_node, "reg", reg,
> +				ARRAY_SIZE(reg), ARRAY_SIZE(reg)) !=
> +			ARRAY_SIZE(reg))
> +		return -EINVAL;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->gpu_hpa = reg[0];
> +	data->size = reg[1];
> +	data->base = memremap(data->gpu_hpa, data->size, MEMREMAP_WB);
> +	if (!data->base) {
> +		ret = -ENOMEM;
> +		goto free_exit;
> +	}
> +
> +	dev_dbg(&vdev->pdev->dev, "%lx..%lx\n", data->gpu_hpa,
> +			data->gpu_hpa + data->size - 1);
> +
> +	data->gpdev = vdev->pdev;
> +	data->group_notifier.notifier_call = vfio_pci_nvgpu_group_notifier;
> +
> +	ret = vfio_register_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
> +			&events, &data->group_notifier);
> +	if (ret)
> +		goto free_exit;
> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +			PCI_VENDOR_ID_NVIDIA | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
> +			VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
> +			&vfio_pci_nvgpu_regops, data->size,
> +			VFIO_REGION_INFO_FLAG_READ, data);

Clearly WRITE and MMAP flags are supported above as well as READ.

> +	if (ret)
> +		goto unreg_exit;
> +
> +	return 0;
> +unreg_exit:
> +	vfio_unregister_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
> +			&data->group_notifier);
> +free_exit:
> +	kfree(data);
> +
> +	return ret;
> +}
> +
> +/*
> + * IBM NPU2 bridge
> + */
> +struct vfio_pci_npu2_data {
> +	void *base;
> +	unsigned long mmio_atsd;
> +	unsigned long gpu_tgt;
> +};
> +
> +static size_t vfio_pci_npu2_rw(struct vfio_pci_device *vdev,
> +		char __user *buf, size_t count, loff_t *ppos, bool iswrite)
> +{
> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
> +	struct vfio_pci_npu2_data *data = vdev->region[i].data;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +
> +	if (pos >= vdev->region[i].size)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(vdev->region[i].size - pos));
> +
> +	if (iswrite) {
> +		if (copy_from_user(data->base + pos, buf, count))
> +			return -EFAULT;
> +	} else {
> +		if (copy_to_user(buf, data->base + pos, count))
> +			return -EFAULT;
> +	}
> +	*ppos += count;
> +
> +	return count;
> +}
> +
> +static int vfio_pci_npu2_mmap(struct vfio_pci_device *vdev,
> +		struct vfio_pci_region *region, struct vm_area_struct *vma)
> +{
> +	int ret;
> +	struct vfio_pci_npu2_data *data = region->data;
> +	unsigned long req_len = vma->vm_end - vma->vm_start;
> +
> +	if (req_len != PAGE_SIZE)
> +		return -EINVAL;
> +
> +	vma->vm_flags |= VM_PFNMAP;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	ret = remap_pfn_range(vma, vma->vm_start, data->mmio_atsd >> PAGE_SHIFT,
> +			req_len, vma->vm_page_prot);
> +	pr_debug("VFIO NPU2 mmap: %lx %lx size=%lx ret=%d\n",
> +			vma->vm_start, data->mmio_atsd,
> +			vma->vm_end - vma->vm_start, ret);

For commit or convert to tracing?

> +
> +	return ret;
> +}
> +
> +static void vfio_pci_npu2_release(struct vfio_pci_device *vdev,
> +		struct vfio_pci_region *region)
> +{
> +	struct vfio_pci_npu2_data *data = region->data;
> +
> +	memunmap(data->base);
> +	kfree(data);
> +}
> +
> +static int vfio_pci_npu2_add_capability(struct vfio_pci_device *vdev,
> +		struct vfio_pci_region *region, struct vfio_info_cap *caps)
> +{
> +	struct vfio_pci_npu2_data *data = region->data;
> +	struct vfio_region_info_cap_npu2 cap;
> +
> +	cap.header.id = VFIO_REGION_INFO_CAP_NPU2;
> +	cap.header.version = 1;
> +	cap.tgt = data->gpu_tgt;
> +
> +	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
> +}
> +
> +static const struct vfio_pci_regops vfio_pci_npu2_regops = {
> +	.rw = vfio_pci_npu2_rw,
> +	.mmap = vfio_pci_npu2_mmap,
> +	.release = vfio_pci_npu2_release,
> +	.add_capability = vfio_pci_npu2_add_capability,
> +};
> +
> +int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
> +{
> +	int ret;
> +	struct vfio_pci_npu2_data *data;
> +	struct device_node *nvlink_dn;
> +	u32 nvlink_index = 0;
> +	struct pci_dev *npdev = vdev->pdev;
> +	struct device_node *npu_node = pci_device_to_OF_node(npdev);
> +	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
> +	u64 mmio_atsd = 0;
> +	u64 tgt = 0;
> +
> +	/*
> +	 * NPU2 normally has 8 ATSD registers (for concurrency) and 6 links
> +	 * so we can allocate one register per link.
> +	 * Since skiboot only exposes one (a bug), use this as a fallback
> +	 * which is safe as we do not split GPUs attached to the same NPU.
> +	 */
> +	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
> +	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
> +			&nvlink_index)))
> +		return -ENODEV;
> +
> +	if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", nvlink_index,
> +			&mmio_atsd)) {
> +		if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", 0,
> +					&mmio_atsd)) {
> +			dev_warn(&vdev->pdev->dev, "No ATSD found\n");
> +			return -EFAULT;
> +		}
> +		dev_warn(&vdev->pdev->dev, "Fallback to ATSD#0\n");
> +	}
> +
> +	if (of_property_read_u64(npu_node, "ibm,device-tgt-addr", &tgt)) {
> +		dev_warn(&vdev->pdev->dev, "No ibm,device-tgt-addr found\n");
> +		return -EFAULT;
> +	}
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->mmio_atsd = mmio_atsd;
> +	data->gpu_tgt = tgt;
> +	data->base = memremap(data->mmio_atsd, SZ_64K, MEMREMAP_WT);
> +	if (!data->base) {
> +		ret = -ENOMEM;
> +		goto free_exit;
> +	}
> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +			PCI_VENDOR_ID_IBM | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
> +			VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
> +			&vfio_pci_npu2_regops, PAGE_SIZE,
> +			VFIO_REGION_INFO_FLAG_READ, data);

READ|WRITE|MMAP

> +	if (ret)
> +		goto free_exit;
> +
> +	return 0;
> +
> +free_exit:
> +	kfree(data);
> +
> +	return ret;
> +}
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 42dc1d3..1a58979 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -38,3 +38,7 @@ config VFIO_PCI_IGD
>  	  and LPC bridge config space.
>  
>  	  To enable Intel IGD assignment through vfio-pci, say Y.
> +
> +config VFIO_PCI_NVLINK2
> +	bool "VFIO PCI support for P9 Witherspoon machine with NVIDIA V100 GPUs"
> +	depends on VFIO_PCI && PPC_POWERNV

