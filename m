Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8573C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC8D2081F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC8D2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DL1S5hS7zDqSW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:10:20 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DKzB6mZQzDqXN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 11:08:19 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92E1F30001EF;
 Tue, 11 Dec 2018 00:08:16 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD599608F2;
 Tue, 11 Dec 2018 00:08:14 +0000 (UTC)
Date: Mon, 10 Dec 2018 17:08:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 19/19] vfio_pci: Add NVIDIA GV100GL [Tesla
 V100 SXM2] subdriver
Message-ID: <20181210170813.426e382b@x1.home>
In-Reply-To: <20181123055304.25116-20-aik@ozlabs.ru>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-20-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 11 Dec 2018 00:08:17 +0000 (UTC)
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 23 Nov 2018 16:53:04 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
> pluggable PCIe devices but still have PCIe links which are used
> for config space and MMIO. In addition to that the GPUs have 6 NVLinks
> which are connected to other GPUs and the POWER9 CPU. POWER9 chips
> have a special unit on a die called an NPU which is an NVLink2 host bus
> adapter with p2p connections to 2 to 3 GPUs, 3 or 2 NVLinks to each.
> These systems also support ATS (address translation services) which is
> a part of the NVLink2 protocol. Such GPUs also share on-board RAM
> (16GB or 32GB) to the system via the same NVLink2 so a CPU has
> cache-coherent access to a GPU RAM.
> 
> This exports GPU RAM to the userspace as a new VFIO device region. This
> preregisters the new memory as device memory as it might be used for DMA.
> This inserts pfns from the fault handler as the GPU memory is not onlined
> until the vendor driver is loaded and trained the NVLinks so doing this
> earlier causes low level errors which we fence in the firmware so
> it does not hurt the host system but still better be avoided.
> 
> This exports an ATSD (Address Translation Shootdown) register of NPU which
> allows TLB invalidations inside GPU for an operating system. The register
> conveniently occupies a single 64k page. It is also presented to
> the userspace as a new VFIO device region.
> 
> In order to provide the userspace with the information about GPU-to-NVLink
> connections, this exports an additional capability called "tgt"
> (which is an abbreviated host system bus address). The "tgt" property
> tells the GPU its own system address and allows the guest driver to
> conglomerate the routing information so each GPU knows how to get directly
> to the other GPUs.
> 
> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
> know LPID (a logical partition ID or a KVM guest hardware ID in other
> words) and PID (a memory context ID of a userspace process, not to be
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
> The V100 GPUs do not advertise none of these capabilities via the config

s/none/any/

> space and there are more than just one device ID so this relies on
> the platform to tell whether these GPUs have special abilities such as
> NVLinks.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v4:
> * added nvlink-speed to the NPU bridge capability as this turned out to
> be not a constant value
> * instead of looking at the exact device ID (which also changes from system
> to system), now this (indirectly) looks at the device tree to know
> if GPU and NPU support NVLink
> 
> v3:
> * reworded the commit log about tgt
> * added tracepoints (do we want them enabled for entire vfio-pci?)
> * added code comments
> * added write|mmap flags to the new regions
> * auto enabled VFIO_PCI_NVLINK2 config option
> * added 'tgt' capability to a GPU so QEMU can recreate ibm,npu and ibm,gpu
> references; there are required by the NVIDIA driver
> * keep notifier registered only for short time
> ---
>  drivers/vfio/pci/Makefile           |   1 +
>  drivers/vfio/pci/trace.h            | 102 +++++++
>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>  include/uapi/linux/vfio.h           |  27 ++
>  drivers/vfio/pci/vfio_pci.c         |  37 ++-
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 448 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/Kconfig            |   6 +
>  7 files changed, 621 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/vfio/pci/trace.h
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
...
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
> index 8131028..547e71e 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -353,6 +353,20 @@ struct vfio_region_gfx_edid {
>  #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>  };
>  
> +/* 10de vendor sub-type
> + *
> + * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
> + */

nit, prefer the comment style below leaving the first line of a
multi-line comment empty, coding style.

> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
> +
> +/*
> + * 1014 vendor sub-type
> + *
> + * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
> + * to do TLB invalidation on a GPU.
> + */
> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> +
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
> @@ -363,6 +377,19 @@ struct vfio_region_gfx_edid {
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
> +	__u32 link_speed;
> +	__u32 __pad;
> +};
> +
>  /**
>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>   *				    struct vfio_irq_info)
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 6cb70cf..b8a53f9 100644
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

Why not static inlines in vfio_pci_private.h like we do for igd hooks?

...
>  static void vfio_pci_disable(struct vfio_pci_device *vdev)
> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> new file mode 100644
> index 0000000..e8e06c3
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
...
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
> +	trace_vfio_pci_nvgpu_mmap(vdev->pdev, data->gpu_hpa, data->useraddr,
> +			vma->vm_end - vma->vm_start, ret);
> +
> +	return ret;

It's unfortunate that all these mm_iommu_foo function return long, this
function returns int, which made me go down the rabbit hole to see what
mm_iommu_newdev() and therefore mmio_iommu_do_alloc() can return.  Can
you do a translation somewhere so this doesn't look like a possible
overflow?  Thanks,

Alex
