Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C63EC43612
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 04:39:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD4521850
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 04:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bkz36DWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD4521850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KMbz51tKzDqbf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 15:39:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bkz36DWi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bkz36DWi"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KMYJ3l5szDqYL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 15:36:52 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id w73so9207781pfk.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 20:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BhBxKitjRUYz1fpqRhWBjDWWlMu16w+wld61d+psJcM=;
 b=bkz36DWiLnDfqEEFBAUqgxBCiG8kfw82pQbCoBgwlJVNv0HCBV4S/l5da67yB8iLf4
 id+q59EzI4ne2Qgrzs8cDCPVgH+HM6m0yS6k7ws7LzPtUCH25+KT0HraieS1LQ1NWMq1
 W8GJ28TAvF5Zl5EQRzoTdb4mv91+Eghv0vtbB+YzWuxSUV3OXtcreWjMPL8blIPMQllX
 tsesB5ekTXuQxPbQYgt2L6TW9TplYSeuKKXh4prvPk3Gu3Jl9HYwhe/mSyIwHUUMLP4Y
 qnFtbuFvwqyjxeSdP/73F8R8NPrMbwtod5ua8C54HdiKJfMSdnnU0J7Sgpm3yGwGG7HN
 73sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BhBxKitjRUYz1fpqRhWBjDWWlMu16w+wld61d+psJcM=;
 b=ihPUbPSDScUNn4iSY+Nyb10Y/FnKRwCkwupzPX1qM3OlRm/14PGAQYt/i43GVJeJWE
 mHqZG4E2wBcrS/3H3kkL6ytzZwsHjI5EeXZ1Fzv8Y9mldXEfgbLhrT8SF+14aBe3kzNX
 S3P1isdpabHhqiLYpYNI1LWCUGfQa9sYXsKqKHwfIpVB00yv+0nlFUFj9+QITNU129UJ
 gQ3eFadzMIXIf3qqr1qfEHJ6tX23GFm9Wi8F/wS/ogT+FBT6Bl+hgt50ysraYo0XKyLv
 B/tEOeUC6RYu80UWclCHfQWjqt4wzbmsGxytMC6QhuGDFyNSb5bIDOggH3KWbVchcjz9
 O3fg==
X-Gm-Message-State: AA+aEWZhxklulvQ72FqnLcudqYShzzXQGWn2jBHhZlXlWnHMUAIFZW2Z
 vJzsEhGX78xUgtmkn+JiCRSCag==
X-Google-Smtp-Source: AFSGD/WCN9eQ5T7s/FUJ6vs3F2w2a0uqmRyWHd3caBKMWT2hGAwtn3pp0tCCjQD/gjUf1WgW6svJBg==
X-Received: by 2002:a63:5664:: with SMTP id g36mr17913425pgm.313.1545194210004; 
 Tue, 18 Dec 2018 20:36:50 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id q187sm29152077pfq.128.2018.12.18.20.36.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 20:36:49 -0800 (PST)
Subject: Re: [PATCH kernel v5 20/20] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] subdriver
To: Alex Williamson <alex.williamson@redhat.com>
References: <20181213061734.16651-1-aik@ozlabs.ru>
 <20181213061734.16651-21-aik@ozlabs.ru> <20181218153701.56ef37de@x1.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <4088f885-9ae1-4b41-1e8d-d03d4f8e7c38@ozlabs.ru>
Date: Wed, 19 Dec 2018 15:36:41 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218153701.56ef37de@x1.home>
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
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 19/12/2018 09:37, Alex Williamson wrote:
> On Thu, 13 Dec 2018 17:17:34 +1100
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
>> it does not hurt the host system but still better be avoided; for the same
>> reason this does not map GPU RAM into the host kernel (usual thing for
>> emulated access otherwise).
>>
>> This exports an ATSD (Address Translation Shootdown) register of NPU which
>> allows TLB invalidations inside GPU for an operating system. The register
>> conveniently occupies a single 64k page. It is also presented to
>> the userspace as a new VFIO device region. One NPU has 8 ATSD registers,
>> each of them can be used for TLB invalidation in a GPU linked to this NPU.
>> This allocates one ATSD register per an NVLink bridge allowing passing
>> up to 6 registers. Due to the host firmware bug (just recently fixed),
>> only 1 ATSD register per NPU was actually advertised to the host system
>> so this passes that alone register via the first NVLink bridge device in
>> the group which is still enough as QEMU collects them all back and
>> presents to the guest via vPHB to mimic the emulated NPU PHB on the host.
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
>> The V100 GPUs do not advertise any of these capabilities via the config
>> space and there are more than just one device ID so this relies on
>> the platform to tell whether these GPUs have special abilities such as
>> NVLinks.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v5:
>> * do not memremap GPU RAM for emulation, map it only when it is needed
>> * allocate 1 ATSD register per NVLink bridge, if none left, then expose
>> the region with a zero size
>> * separate caps per device type
>> * addressed AW review comments
>>
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
>>  drivers/vfio/pci/trace.h            | 102 ++++++
>>  drivers/vfio/pci/vfio_pci_private.h |  14 +
>>  include/uapi/linux/vfio.h           |  39 +++
>>  drivers/vfio/pci/vfio_pci.c         |  27 +-
>>  drivers/vfio/pci/vfio_pci_nvlink2.c | 473 ++++++++++++++++++++++++++++
>>  drivers/vfio/pci/Kconfig            |   6 +
>>  7 files changed, 660 insertions(+), 2 deletions(-)
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
>> diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
>> new file mode 100644
>> index 0000000..b80d2d3
>> --- /dev/null
>> +++ b/drivers/vfio/pci/trace.h
>> @@ -0,0 +1,102 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * VFIO PCI mmap/mmap_fault tracepoints
>> + *
>> + * Copyright (C) 2018 IBM Corp.  All rights reserved.
>> + *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM vfio_pci
>> +
>> +#if !defined(_TRACE_VFIO_PCI_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_VFIO_PCI_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(vfio_pci_nvgpu_mmap_fault,
>> +	TP_PROTO(struct pci_dev *pdev, unsigned long hpa, unsigned long ua,
>> +			vm_fault_t ret),
>> +	TP_ARGS(pdev, hpa, ua, ret),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(const char *, name)
>> +		__field(unsigned long, hpa)
>> +		__field(unsigned long, ua)
>> +		__field(int, ret)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->name = dev_name(&pdev->dev),
>> +		__entry->hpa = hpa;
>> +		__entry->ua = ua;
>> +		__entry->ret = ret;
>> +	),
>> +
>> +	TP_printk("%s: %lx -> %lx ret=%d", __entry->name, __entry->hpa,
>> +			__entry->ua, __entry->ret)
>> +);
>> +
>> +TRACE_EVENT(vfio_pci_nvgpu_mmap,
>> +	TP_PROTO(struct pci_dev *pdev, unsigned long hpa, unsigned long ua,
>> +			unsigned long size, int ret),
>> +	TP_ARGS(pdev, hpa, ua, size, ret),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(const char *, name)
>> +		__field(unsigned long, hpa)
>> +		__field(unsigned long, ua)
>> +		__field(unsigned long, size)
>> +		__field(int, ret)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->name = dev_name(&pdev->dev),
>> +		__entry->hpa = hpa;
>> +		__entry->ua = ua;
>> +		__entry->size = size;
>> +		__entry->ret = ret;
>> +	),
>> +
>> +	TP_printk("%s: %lx -> %lx size=%lx ret=%d", __entry->name, __entry->hpa,
>> +			__entry->ua, __entry->size, __entry->ret)
>> +);
>> +
>> +TRACE_EVENT(vfio_pci_npu2_mmap,
>> +	TP_PROTO(struct pci_dev *pdev, unsigned long hpa, unsigned long ua,
>> +			unsigned long size, int ret),
>> +	TP_ARGS(pdev, hpa, ua, size, ret),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(const char *, name)
>> +		__field(unsigned long, hpa)
>> +		__field(unsigned long, ua)
>> +		__field(unsigned long, size)
>> +		__field(int, ret)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->name = dev_name(&pdev->dev),
>> +		__entry->hpa = hpa;
>> +		__entry->ua = ua;
>> +		__entry->size = size;
>> +		__entry->ret = ret;
>> +	),
>> +
>> +	TP_printk("%s: %lx -> %lx size=%lx ret=%d", __entry->name, __entry->hpa,
>> +			__entry->ua, __entry->size, __entry->ret)
>> +);
>> +
>> +#endif /* _TRACE_SUBSYS_H */
>> +
>> +#undef TRACE_INCLUDE_PATH
>> +#define TRACE_INCLUDE_PATH .
>> +#undef TRACE_INCLUDE_FILE
>> +#define TRACE_INCLUDE_FILE trace
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
>> index 93c1738..127071b 100644
>> --- a/drivers/vfio/pci/vfio_pci_private.h
>> +++ b/drivers/vfio/pci/vfio_pci_private.h
>> @@ -163,4 +163,18 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
>>  	return -ENODEV;
>>  }
>>  #endif
>> +#ifdef CONFIG_VFIO_PCI_NVLINK2
>> +extern int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev);
>> +extern int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev);
>> +#else
>> +static inline int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
>>  #endif /* VFIO_PCI_PRIVATE_H */
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 8131028..ce28d39 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -353,6 +353,21 @@ struct vfio_region_gfx_edid {
>>  #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>>  };
>>  
>> +/*
>> + * 10de vendor sub-type
>> + *
>> + * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
>> + */
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
>> @@ -363,6 +378,30 @@ struct vfio_region_gfx_edid {
>>   */
>>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>>  
>> +/*
>> + * Capability with compressed real address (aka SSA - small system address)
>> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
>> + */
>> +#define VFIO_REGION_INFO_CAP_NVIDIA_NVLINK2	4
>> +
>> +struct vfio_region_info_cap_nvidia_nvlink2 {
>> +	struct vfio_info_cap_header header;
>> +	__u64 tgt;
>> +};
>> +
>> +/*
>> + * Capability with compressed real address (aka SSA - small system address),
>> + * used to match the NVLink bridge with a GPU. Also contains a link speed.
>> + */
>> +#define VFIO_REGION_INFO_CAP_IBM_NPU2		5
>> +
>> +struct vfio_region_info_cap_ibm_npu2 {
>> +	struct vfio_info_cap_header header;
>> +	__u64 tgt;
>> +	__u32 link_speed;
>> +	__u32 __pad;
>> +};
> 
> Another option here would be to have one capability expose tgt used by
> both devices and another capability expose link_speed used only by the
> NPU.  Perhaps VFIO_REGION_INFO_CAP_NVLINK2_SSATGT and
> VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD.  We don't necessarily need to make
> each capability specific to a device and we can stack multiple
> together.  Is there some association between tgt and link_speed that
> requires them together? 

Not, can be 2 capabilities, I'll repost.

> We could also simply expose the link_speed as
> a __u64 rather than introduce padding.  Thanks,

It is 32bit everywhere else, otherwise I need a "this is safe" comment
or a 64->32 cast in QEMU when putting a property in the device tree.
Unless you insist on 64bit here, I'd keep it 32bit.


-- 
Alexey
