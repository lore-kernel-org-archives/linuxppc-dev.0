Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E452C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:59:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D6220672
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="qUoIMYum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D6220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DM6f1KZkzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:59:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="qUoIMYum";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="qUoIMYum"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DM3t1qpXzDqlP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 11:57:29 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id w7so5784705pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HDzZ1bXi/CyQL9+aeUw/Qn3UtnhNq6V1Et8KHgfBv4o=;
 b=qUoIMYumlnus4eBYs8FZqKLbFMckVuDHRbts2XG13vJm088LIszRPIJ9Tvf21qnwpO
 9TnF4BOMuvWMlueRAWnKzZk/E987z6IM0hu+FPh7a7VyKS4CVAfCk57J6u77HWfQ8juw
 BdUNNXNjflK/btJG8xWMmi/DHojy1uQjc6G/3zYcsit5B1gKZfy4upB7xSaPvc3/a02l
 Q2qUsvI1PyM9U4quu6BDgV14q/SIC5Aj9uVySTwTV0IOkXQZmaUxAhZoLAoGxGFtFKVk
 RogfusKoVvPRNxjkJYRBkCFwBkoPKJyXL9z4dU/jzvk6Sn0dK0WD7cHPW16BaSAiC8Rf
 cLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HDzZ1bXi/CyQL9+aeUw/Qn3UtnhNq6V1Et8KHgfBv4o=;
 b=H9AviVdkkj/KgTTGkxlx49ZgSfz3UjqdibR26CXO7ZLvGs7KwIs3QJd8XQzyiEb5zZ
 xrrVlZyBH36dOfNzsfSzCZ3bu0LgywWmEJ46VMOclPNhqInhswPTYIiRRcvuHLaFTdP1
 /u1Ax7+ddM7BdHsiktaFQn4fOgx7HD5PQCBlZpY9CrQNzevjBtS45LvJkzHdUHC9Fr3V
 nOUDgBJuLPWaQrwHAo5a7KUcpzMWydEj+0XntCoZ4JGBZs1WkAEx02aB7TnBEBaA64hh
 rz7dxIefA9ASwLarLjVq80nuKI3235hMaarRTbKr8jgu1fyaAhAkGtt8IRMae8AVIRdy
 3Bcg==
X-Gm-Message-State: AA+aEWaiQeSBlt+Jz+NJ0bqxcVS65ynHYw96T8BKbzG7jiIy7J+eWUY9
 nesutt5aneNDiqtxMpVWHtvSDQ==
X-Google-Smtp-Source: AFSGD/Vtk7jkwESdCd6VWPSVOba7QwHUmEgHQ8drzSsnyGCA8G+4y3Zl7YNvsU8bPLPCJo8jwDPZsA==
X-Received: by 2002:a63:7556:: with SMTP id f22mr11716621pgn.231.1544489847487; 
 Mon, 10 Dec 2018 16:57:27 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id r76sm18469456pfb.69.2018.12.10.16.57.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 16:57:26 -0800 (PST)
Subject: Re: [PATCH kernel v4 19/19] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] subdriver
To: Alex Williamson <alex.williamson@redhat.com>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-20-aik@ozlabs.ru> <20181210170813.426e382b@x1.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <095d32c2-8190-359b-bf02-32419b829bea@ozlabs.ru>
Date: Tue, 11 Dec 2018 11:57:20 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210170813.426e382b@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/12/2018 11:08, Alex Williamson wrote:
> On Fri, 23 Nov 2018 16:53:04 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
>> pluggable PCIe devices but still have PCIe links which are used
>> for config space and MMIO. In addition to that the GPUs have 6 NVLinks
>> which are connected to other GPUs and the POWER9 CPU. POWER9 chips
>> have a special unit on a die called an NPU which is an NVLink2 host bus
>> adapter with p2p connections to 2 to 3 GPUs, 3 or 2 NVLinks to each.
>> These systems also support ATS (address translation services) which is
>> a part of the NVLink2 protocol. Such GPUs also share on-board RAM
>> (16GB or 32GB) to the system via the same NVLink2 so a CPU has
>> cache-coherent access to a GPU RAM.
>>
>> This exports GPU RAM to the userspace as a new VFIO device region. This
>> preregisters the new memory as device memory as it might be used for DMA.
>> This inserts pfns from the fault handler as the GPU memory is not onlined
>> until the vendor driver is loaded and trained the NVLinks so doing this
>> earlier causes low level errors which we fence in the firmware so
>> it does not hurt the host system but still better be avoided.
>>
>> This exports an ATSD (Address Translation Shootdown) register of NPU which
>> allows TLB invalidations inside GPU for an operating system. The register
>> conveniently occupies a single 64k page. It is also presented to
>> the userspace as a new VFIO device region.
>>
>> In order to provide the userspace with the information about GPU-to-NVLink
>> connections, this exports an additional capability called "tgt"
>> (which is an abbreviated host system bus address). The "tgt" property
>> tells the GPU its own system address and allows the guest driver to
>> conglomerate the routing information so each GPU knows how to get directly
>> to the other GPUs.
>>
>> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
>> know LPID (a logical partition ID or a KVM guest hardware ID in other
>> words) and PID (a memory context ID of a userspace process, not to be
>> confused with a linux pid). This assigns a GPU to LPID in the NPU and
>> this is why this adds a listener for KVM on an IOMMU group. A PID comes
>> via NVLink from a GPU and NPU uses a PID wildcard to pass it through.
>>
>> This requires coherent memory and ATSD to be available on the host as
>> the GPU vendor only supports configurations with both features enabled
>> and other configurations are known not to work. Because of this and
>> because of the ways the features are advertised to the host system
>> (which is a device tree with very platform specific properties),
>> this requires enabled POWERNV platform.
>>
>> The V100 GPUs do not advertise none of these capabilities via the config
> 
> s/none/any/
> 
>> space and there are more than just one device ID so this relies on
>> the platform to tell whether these GPUs have special abilities such as
>> NVLinks.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v4:
>> * added nvlink-speed to the NPU bridge capability as this turned out to
>> be not a constant value
>> * instead of looking at the exact device ID (which also changes from system
>> to system), now this (indirectly) looks at the device tree to know
>> if GPU and NPU support NVLink
>>
>> v3:
>> * reworded the commit log about tgt
>> * added tracepoints (do we want them enabled for entire vfio-pci?)
>> * added code comments
>> * added write|mmap flags to the new regions
>> * auto enabled VFIO_PCI_NVLINK2 config option
>> * added 'tgt' capability to a GPU so QEMU can recreate ibm,npu and ibm,gpu
>> references; there are required by the NVIDIA driver
>> * keep notifier registered only for short time
>> ---
>>  drivers/vfio/pci/Makefile           |   1 +
>>  drivers/vfio/pci/trace.h            | 102 +++++++
>>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>>  include/uapi/linux/vfio.h           |  27 ++
>>  drivers/vfio/pci/vfio_pci.c         |  37 ++-
>>  drivers/vfio/pci/vfio_pci_nvlink2.c | 448 ++++++++++++++++++++++++++++
>>  drivers/vfio/pci/Kconfig            |   6 +
>>  7 files changed, 621 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/vfio/pci/trace.h
>>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
>>
>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>> index 76d8ec0..9662c06 100644
>> --- a/drivers/vfio/pci/Makefile
>> +++ b/drivers/vfio/pci/Makefile
>> @@ -1,5 +1,6 @@
>>  
>>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>> +vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
>>  
>>  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
> ...
>> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
>> index 93c1738..7639241 100644
>> --- a/drivers/vfio/pci/vfio_pci_private.h
>> +++ b/drivers/vfio/pci/vfio_pci_private.h
>> @@ -163,4 +163,6 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
>>  	return -ENODEV;
>>  }
>>  #endif
>> +extern int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev);
>> +extern int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev);
>>  #endif /* VFIO_PCI_PRIVATE_H */
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 8131028..547e71e 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -353,6 +353,20 @@ struct vfio_region_gfx_edid {
>>  #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>>  };
>>  
>> +/* 10de vendor sub-type
>> + *
>> + * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
>> + */
> 
> nit, prefer the comment style below leaving the first line of a
> multi-line comment empty, coding style.
> 
>> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
>> +
>> +/*
>> + * 1014 vendor sub-type
>> + *
>> + * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
>> + * to do TLB invalidation on a GPU.
>> + */
>> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>> +
>>  /*
>>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>>   * which allows direct access to non-MSIX registers which happened to be within
>> @@ -363,6 +377,19 @@ struct vfio_region_gfx_edid {
>>   */
>>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>>  
>> +/*
>> + * Capability with compressed real address (aka SSA - small system address)
>> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
>> + */
>> +#define VFIO_REGION_INFO_CAP_NPU2		4
>> +
>> +struct vfio_region_info_cap_npu2 {
>> +	struct vfio_info_cap_header header;
>> +	__u64 tgt;
>> +	__u32 link_speed;
>> +	__u32 __pad;
>> +};
>> +
>>  /**
>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>>   *				    struct vfio_irq_info)
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 6cb70cf..b8a53f9 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -224,6 +224,16 @@ static bool vfio_pci_nointx(struct pci_dev *pdev)
>>  	return false;
>>  }
>>  
>> +int __weak vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +int __weak vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>> +{
>> +	return -ENODEV;
>> +}
>> +
> 
> Why not static inlines in vfio_pci_private.h like we do for igd hooks?
> 
> ...


Because the earlier review suggested to do "weak definition" and I took
it literally :) I'll make it inline.



>>  static void vfio_pci_disable(struct vfio_pci_device *vdev)
>> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
>> new file mode 100644
>> index 0000000..e8e06c3
>> --- /dev/null
>> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> ...
>> +static int vfio_pci_nvgpu_mmap(struct vfio_pci_device *vdev,
>> +		struct vfio_pci_region *region, struct vm_area_struct *vma)
>> +{
>> +	long ret;
>> +	struct vfio_pci_nvgpu_data *data = region->data;
>> +
>> +	if (data->useraddr)
>> +		return -EPERM;
>> +
>> +	if (vma->vm_end - vma->vm_start > data->size)
>> +		return -EINVAL;
>> +
>> +	vma->vm_private_data = region;
>> +	vma->vm_flags |= VM_PFNMAP;
>> +	vma->vm_ops = &vfio_pci_nvgpu_mmap_vmops;
>> +
>> +	/*
>> +	 * Calling mm_iommu_newdev() here once as the region is not
>> +	 * registered yet and therefore right initialization will happen now.
>> +	 * Other places will use mm_iommu_find() which returns
>> +	 * registered @mem and does not go gup().
>> +	 */
>> +	data->useraddr = vma->vm_start;
>> +	data->mm = current->mm;
>> +
>> +	atomic_inc(&data->mm->mm_count);
>> +	ret = mm_iommu_newdev(data->mm, data->useraddr,
>> +			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
>> +			data->gpu_hpa, &data->mem);
>> +
>> +	trace_vfio_pci_nvgpu_mmap(vdev->pdev, data->gpu_hpa, data->useraddr,
>> +			vma->vm_end - vma->vm_start, ret);
>> +
>> +	return ret;
> 
> It's unfortunate that all these mm_iommu_foo function return long, this
> function returns int, which made me go down the rabbit hole to see what
> mm_iommu_newdev() and therefore mmio_iommu_do_alloc() can return.  Can
> you do a translation somewhere so this doesn't look like a possible
> overflow?  Thanks,


This is not a new thing - gcc produces less assembly for ppc64 if long
is used and this is why I stick to longs. So I have 2 options here:
change all mm_iommu_xxxx to return int (I'd rather not) or change the
@ret type here from long to int, will the latter be ok?



-- 
Alexey
