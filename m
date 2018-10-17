Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF1C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 01:22:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C445214C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 01:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="1HbnZKbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C445214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZZCT0drFzF3Sp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 12:21:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="1HbnZKbv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="1HbnZKbv"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZZ8g25NBzF3JZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 12:19:28 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id g12-v6so11689892pgs.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=266Ey1HOikSy7sKlIvlZpFqwbu1YwlEPi+HAdfqp5B8=;
 b=1HbnZKbvfKiXEbOajBMvEed8u0p/T5XajRKHVmZt2rYLDmOJqN/7MvO3bF/V+i1ftu
 lkG3GvBrArL3R1RlWHkvI1qnlh5Rncw3nto86yJ+Klh92FfKBGddFIJYfW+IDzcGExYm
 mHkdavxl6KsJ4BhnybjEKYEJHIti2wapG/DFmXQoQZiGowMLL+l0+iBhtm8UJWQbKirI
 1gV0951iwYfMc2TQIB2v4KWl2w1MFSRaa5yEy3QIgv3gahr1PRf2B3nV48gG9NEx1org
 A8v+EofVpdpSk+axWuOVjsnpQcQuBd2Uozzh+iyMxQR6ZK8ELVfMDiZrJS0YwZONIhKX
 pUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=266Ey1HOikSy7sKlIvlZpFqwbu1YwlEPi+HAdfqp5B8=;
 b=s1sRL9kB0D8ZZFrsFMuRXdFjnETfLldAxQ7nwpC58csmdtbOYKo1afWlcnSNWjbyE3
 SBKI3FdJw4Z1OjEwhDkMyjfa1Nz6iBS+QHwOm0C3YBQrGHK5YVsZwMSIcHLOXRRTw1M/
 OVr1j9JjKgtY+brIIe4W3kwvB3jYJtiwT7CqxU1y57WNBXYUsj5uK9/8WKh/920DbUzO
 bULcsa/zmVCZN4PQ+2+wNqm9U9ZPcdRJQMRFXCKT3uIYI5Fpfb49w4w6dqOtRoXhsp/y
 OVPzOZVBPaPFNHz40ZRB9WG6/BNUJBJKKGE1AMJTJMayhbOKUktsFdVlhutG3SsfpF1V
 99/A==
X-Gm-Message-State: ABuFfog1CxEV9amRszZM6JTQRIYumm09ZG2ng+W+JWG9N+aajb3IU9nk
 mQksw1ZPSkRCgNA5OknQ7jT6hw==
X-Google-Smtp-Source: ACcGV62su468hlQybNwOTLHnHKXh+2A2stvKc2TVqWQ0CbKqbwFVHY/5s2BvdmJ28y4iDzaMkCxsaQ==
X-Received: by 2002:a63:d256:: with SMTP id
 t22-v6mr22207773pgi.335.1539739166781; 
 Tue, 16 Oct 2018 18:19:26 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h14-v6sm18617137pfn.80.2018.10.16.18.19.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 18:19:25 -0700 (PDT)
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
 [10de:1db1] subdriver
To: Alex Williamson <alex.williamson@redhat.com>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru> <20181016130824.20be215b@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
Date: Wed, 17 Oct 2018 12:19:20 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181016130824.20be215b@w520.home>
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
Cc: kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, Reza Arbab <arbab@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 17/10/2018 06:08, Alex Williamson wrote:
> On Mon, 15 Oct 2018 20:42:33 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
>> pluggable PCIe devices but implement PCIe links for config space and MMIO.
>> In addition to that the GPUs are interconnected to each other and also
>> have direct links to the P9 CPU. The links are NVLink2 and provide direct
>> access to the system RAM for GPUs via NPU (an NVLink2 "proxy" on P9 chip).
>> These systems also support ATS (address translation services) which is
>> a part of the NVLink2 prototol. Such GPUs also share on-board RAM
>> (16GB in tested config) to the system via the same NVLink2 so a CPU has
>> cache-coherent access to a GPU RAM.
>>
>> This exports GPU RAM to the userspace as a new PCI region. This
>> preregisters the new memory as device memory as it might be used for DMA.
>> This inserts pfns from the fault handler as the GPU memory is not onlined
>> until the NVIDIA driver is loaded and trained the links so doing this
>> earlier produces low level errors which we fence in the firmware so
>> it does not hurt the host system but still better to avoid.
>>
>> This exports ATSD (Address Translation Shootdown) register of NPU which
>> allows the guest to invalidate TLB. The register conviniently occupies
>> a single 64k page. Since NPU maps the GPU memory, it has a "tgt" property
>> (which is an abbreviated host system bus address). This exports the "tgt"
>> as a capability so the guest can program it into the GPU so the GPU can
>> know how to route DMA trafic.
> 
> I'm not really following what "tgt" is and why it's needed.  Is the GPU
> memory here different than the GPU RAM region above?  Why does the user
> need the host system bus address of this "tgt" thing?  Are we not able
> to relocate it in guest physical address space, does this shootdown
> only work in the host physical address space and therefore we need this
> offset?  Please explain, I'm confused.


This "tgt" is made of:
- "memory select" (bits 45, 46)
- "group select" (bits 43, 44)
- "chip select" (bit 42)
- chip internal address (bits 0..41)

These are internal to GPU and this is where GPU RAM is mapped into the
GPU's real space, this fits 46 bits.

On POWER9 CPU the bits are different and higher so the same memory is
mapped higher on P9 CPU. Just because we can map it higher, I guess.

So it is not exactly the address but this provides the exact physical
location of the memory.

We have a group of 3 interconnected GPUs, they got their own
memory/group/chip numbers. The GPUs use ATS service to translate
userspace to physical (host or guest) addresses. Now a GPU needs to know
which specific link to use for a specific physical address, in other
words what this physical address belongs to - a CPU or one of GPUs. This
is when "tgt" is used by the GPU hardware.

A GPU could run all the DMA trafic via the system bus indeed, just not
as fast.

I am also struggling here and adding an Nvidia person in cc: (I should
have done that when I posted the patches, my bad) to correct when/if I
am wrong.



>  
>> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
>> know LPID (a logical partition ID or a KVM guest hardware ID in other
>> words) and PID (a memory context ID of an userspace process, not to be
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
>> This hardcodes the NVLink2 support for specific vendor and device IDs
>> as there is no reliable way of knowing about coherent memory and ATS
>> support. The GPU has an unique vendor PCIe capability 0x23 but it was
>> confirmed that it does not provide required information (and it is still
>> undisclosed what it actually does).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  drivers/vfio/pci/Makefile           |   1 +
>>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>>  include/uapi/linux/vfio.h           |  18 ++
>>  drivers/vfio/pci/vfio_pci.c         |  37 +++-
>>  drivers/vfio/pci/vfio_pci_nvlink2.c | 409 ++++++++++++++++++++++++++++++++++++
>>  drivers/vfio/pci/Kconfig            |   4 +
>>  6 files changed, 469 insertions(+), 2 deletions(-)
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
>> index f378b98..9e9a8d3 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -303,6 +303,12 @@ struct vfio_region_info_cap_type {
>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>>  
>> +/* NVIDIA GPU NVlink2 RAM */
>> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
>> +
>> +/* IBM NPU NVlink2 ATSD */
>> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>> +
> 
> Please include some of the description in the commitlog here for
> reference.  Also please be explicit that these are vendor defined
> regions and note the numerical vendor ID associated with them.

These are PCI region subtypes which are not from any PCI spec and which
we define as we like, are not they all "vendor"?


> 
>>  /*
>>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>>   * which allows direct access to non-MSIX registers which happened to be within
>> @@ -313,6 +319,18 @@ struct vfio_region_info_cap_type {
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
>> +	/* size is defined in VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM */
> 
> But this is a capability for the IBM_NVLINK2_ATSD?  What is the
> relevance of this comment?  Is this capability relevant to the RAM or
> ATSD?

It is relevant to NPU (NVLink host bus adapter of POWER9) which maps the
GPU RAM to the system bus and acts as a proxy to nestMMU (NVIDIA's unit
in POWER9 CPU) for ATS/ATSD services so it is a property of NPU. But
then one might ask "wait, here is the address, where is the size then",
 hence the comment...


> 
>> +};
>> +
>>  /**
>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>>   *				    struct vfio_irq_info)
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 4a3b93e..e9afd43 100644
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
>>  static int vfio_pci_enable(struct vfio_pci_device *vdev)
>>  {
>>  	struct pci_dev *pdev = vdev->pdev;
>> @@ -302,14 +312,37 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>>  		if (ret) {
>>  			dev_warn(&vdev->pdev->dev,
>>  				 "Failed to setup Intel IGD regions\n");
>> -			vfio_pci_disable(vdev);
>> -			return ret;
>> +			goto disable_exit;
>> +		}
>> +	}
>> +
>> +	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
>> +	    pdev->device == 0x1db1) {
>> +		ret = vfio_pci_nvdia_v100_nvlink2_init(vdev);
>> +		if (ret) {
>> +			dev_warn(&vdev->pdev->dev,
>> +				 "Failed to setup NVIDIA NV2 RAM region\n");
>> +			goto disable_exit;
>> +		}
>> +	}
> 
> This device ID is not unique to POWER9 Witherspoon systems, I see your
> comment in the commitlog, but this is clearly going to generate a
> dev_warn and failure on an x86 system with the same hardware.  Perhaps
> this could be masked off with IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2) like
> the IGD code above this chunk does?

Right, will fix.


>> +
>> +	if (pdev->vendor == PCI_VENDOR_ID_IBM &&
>> +			pdev->device == 0x04ea) {
>> +		ret = vfio_pci_ibm_npu2_init(vdev);
>> +		if (ret) {
>> +			dev_warn(&vdev->pdev->dev,
>> +					"Failed to setup NVIDIA NV2 ATSD region\n");
>> +			goto disable_exit;
>>  		}
> 
> So the NPU is also actually owned by vfio-pci and assigned to the VM?

Yes. On a running system it looks like:

0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
0035:00:00.0 PCI bridge: IBM Device 04c1
0035:01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
0035:02:04.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
0035:02:05.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
0035:02:0d.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
(rev a1
0035:04:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
(rev a1)
0035:05:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
(rev a1)

One "IBM Device" bridge represents one NVLink2, i.e. a piece of NPU.
They all and 3 GPUs go to the same IOMMU group and get passed through to
a guest.

The entire NPU does not have representation via sysfs as a whole though.

> 
>>  	}
>>  
>>  	vfio_pci_probe_mmaps(vdev);
>>  
>>  	return 0;
>> +
>> +disable_exit:
>> +	vfio_pci_disable(vdev);
>> +	return ret;
>>  }
>>  
>>  static void vfio_pci_disable(struct vfio_pci_device *vdev)
>> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
>> new file mode 100644
>> index 0000000..c9d2b55
>> --- /dev/null
>> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
>> @@ -0,0 +1,409 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * VFIO PCI NVIDIA Whitherspoon GPU support a.k.a. NVLink2.
>> + *
>> + * Copyright (C) 2018 IBM Corp.  All rights reserved.
>> + *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * Register an on-GPU RAM region for cacheable access.
>> + *
>> + * Derived from original vfio_pci_igd.c:
>> + * Copyright (C) 2016 Red Hat, Inc.  All rights reserved.
>> + *	Author: Alex Williamson <alex.williamson@redhat.com>
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/pci.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/vfio.h>
>> +#include <linux/sched/mm.h>
>> +#include <linux/mmu_context.h>
>> +#include <asm/kvm_ppc.h>
>> +#include "vfio_pci_private.h"
>> +
> 
> Please steal some of your description in the commitlog to document
> inline what this is all about.
> 
>> +struct vfio_pci_nvgpu_data {
>> +	unsigned long gpu_hpa;
>> +	unsigned long useraddr;
>> +	unsigned long size;
>> +	void *base;
>> +	struct mm_struct *mm;
>> +	struct mm_iommu_table_group_mem_t *mem;
>> +	struct pci_dev *gpdev;
>> +	struct notifier_block group_notifier;
>> +};
>> +
>> +static size_t vfio_pci_nvgpu_rw(struct vfio_pci_device *vdev,
>> +		char __user *buf, size_t count, loff_t *ppos, bool iswrite)
>> +{
>> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
>> +	struct vfio_pci_nvgpu_data *data = vdev->region[i].data;
>> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
>> +
>> +	if (pos >= vdev->region[i].size)
>> +		return -EINVAL;
>> +
>> +	count = min(count, (size_t)(vdev->region[i].size - pos));
>> +
>> +	if (iswrite) {
>> +		if (copy_from_user(data->base + pos, buf, count))
>> +			return -EFAULT;
>> +	} else {
>> +		if (copy_to_user(buf, data->base + pos, count))
>> +			return -EFAULT;
>> +	}
>> +	*ppos += count;
>> +
>> +	return count;
>> +}
>> +
>> +static void vfio_pci_nvgpu_release(struct vfio_pci_device *vdev,
>> +		struct vfio_pci_region *region)
>> +{
>> +	struct vfio_pci_nvgpu_data *data = region->data;
>> +	long ret;
>> +	struct pci_controller *hose;
>> +	struct pci_dev *npdev;
>> +
>> +	/* If there were any mappings at all... */
>> +	if (data->mm) {
>> +		ret = mm_iommu_put(data->mm, data->mem);
>> +		WARN_ON(ret);
>> +
>> +		mmdrop(data->mm);
>> +	}
>> +
>> +	vfio_unregister_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
>> +			&data->group_notifier);
>> +
>> +	npdev = pnv_pci_get_npu_dev(data->gpdev, 0);
>> +	hose = pci_bus_to_host(npdev->bus);
>> +
>> +	pnv_npu2_map_lpar_dev(hose, data->gpdev, 0, MSR_DR | MSR_PR | MSR_HV);
>> +
>> +	memunmap(data->base);
>> +	kfree(data);
>> +}
>> +
>> +static int vfio_pci_nvgpu_mmap_fault(struct vm_fault *vmf)
>> +{
>> +	int ret;
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	struct vfio_pci_region *region = vma->vm_private_data;
>> +	struct vfio_pci_nvgpu_data *data = region->data;
>> +	unsigned long vmf_off = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
>> +	unsigned long nv2pg = data->gpu_hpa >> PAGE_SHIFT;
>> +	unsigned long vm_pgoff = vma->vm_pgoff &
>> +		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>> +	unsigned long pfn = nv2pg + vm_pgoff + vmf_off;
>> +
>> +	ret = vm_insert_pfn(vma, vmf->address, pfn);
>> +	pr_debug("NVLink2: vmf=%lx hpa=%lx ret=%d\n",
>> +		 vmf->address, pfn << PAGE_SHIFT, ret);
> 
> Tracing would probably be a better option if you intend to keep this.


Ok, tracing it will be here and later.


> 
>> +	if (ret)
>> +		return VM_FAULT_SIGSEGV;
>> +
>> +	return VM_FAULT_NOPAGE;
>> +}
>> +
>> +static const struct vm_operations_struct vfio_pci_nvgpu_mmap_vmops = {
>> +	.fault = vfio_pci_nvgpu_mmap_fault,
>> +};
>> +
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
>> +	pr_debug("VFIO NVLINK2 mmap: useraddr=%lx hpa=%lx size=%lx ret=%ld\n",
>> +			data->useraddr, data->gpu_hpa,
>> +			vma->vm_end - vma->vm_start, ret);
> 
> Same
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct vfio_pci_regops vfio_pci_nvgpu_regops = {
>> +	.rw = vfio_pci_nvgpu_rw,
>> +	.release = vfio_pci_nvgpu_release,
>> +	.mmap = vfio_pci_nvgpu_mmap,
>> +};
>> +
>> +static int vfio_pci_nvgpu_group_notifier(struct notifier_block *nb,
>> +		unsigned long action, void *opaque)
>> +{
>> +	struct kvm *kvm = opaque;
>> +	struct vfio_pci_nvgpu_data *data = container_of(nb,
>> +			struct vfio_pci_nvgpu_data,
>> +			group_notifier);
>> +
>> +	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
>> +		struct pci_controller *hose;
>> +		struct pci_dev *npdev;
>> +		struct pnv_phb *nphb;
>> +
>> +		npdev = pnv_pci_get_npu_dev(data->gpdev, 0);
>> +		hose = pci_bus_to_host(npdev->bus);
>> +		nphb = hose->private_data;
>> +
>> +		if (!kvm) {
>> +			if (pnv_npu2_map_lpar_dev(hose, data->gpdev, 0,
>> +					MSR_DR | MSR_PR | MSR_HV))
>> +				return NOTIFY_BAD;
>> +		} else {
>> +			if (pnv_npu2_map_lpar_dev(hose, data->gpdev,
>> +					kvm->arch.lpid, MSR_DR | MSR_PR))
>> +				return NOTIFY_BAD;
>> +		}
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
>> +{
>> +	int ret;
>> +	u64 reg[2];
>> +	struct device_node *npu_node, *mem_node;
>> +	struct pci_dev *npu_dev;
>> +	struct vfio_pci_nvgpu_data *data;
>> +	uint32_t mem_phandle = 0;
>> +	unsigned long events = VFIO_GROUP_NOTIFY_SET_KVM;
>> +
>> +	npu_dev = pnv_pci_get_npu_dev(vdev->pdev, 0);
>> +	if (!npu_dev)
>> +		return -EINVAL;
>> +
>> +	npu_node = pci_device_to_OF_node(npu_dev);
>> +	if (!npu_node)
>> +		return -EINVAL;
>> +
>> +	if (of_property_read_u32(npu_node, "memory-region", &mem_phandle))
>> +		return -EINVAL;
>> +
>> +	mem_node = of_find_node_by_phandle(mem_phandle);
>> +	if (!mem_node)
>> +		return -EINVAL;
>> +
>> +	if (of_property_read_variable_u64_array(mem_node, "reg", reg,
>> +				ARRAY_SIZE(reg), ARRAY_SIZE(reg)) !=
>> +			ARRAY_SIZE(reg))
>> +		return -EINVAL;
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->gpu_hpa = reg[0];
>> +	data->size = reg[1];
>> +	data->base = memremap(data->gpu_hpa, data->size, MEMREMAP_WB);
>> +	if (!data->base) {
>> +		ret = -ENOMEM;
>> +		goto free_exit;
>> +	}
>> +
>> +	dev_dbg(&vdev->pdev->dev, "%lx..%lx\n", data->gpu_hpa,
>> +			data->gpu_hpa + data->size - 1);
>> +
>> +	data->gpdev = vdev->pdev;
>> +	data->group_notifier.notifier_call = vfio_pci_nvgpu_group_notifier;
>> +
>> +	ret = vfio_register_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
>> +			&events, &data->group_notifier);
>> +	if (ret)
>> +		goto free_exit;
>> +
>> +	ret = vfio_pci_register_dev_region(vdev,
>> +			PCI_VENDOR_ID_NVIDIA | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
>> +			VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
>> +			&vfio_pci_nvgpu_regops, data->size,
>> +			VFIO_REGION_INFO_FLAG_READ, data);
> 
> Clearly WRITE and MMAP flags are supported above as well as READ.


Ah, right. These are informational flags so I did not hit problems
before. I should probably check for these in "[PATCH kernel 1/3]
vfio_pci: Allow mapping extra regions" and block mmap if MMAP is not set
then.

> 
>> +	if (ret)
>> +		goto unreg_exit;
>> +
>> +	return 0;
>> +unreg_exit:
>> +	vfio_unregister_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
>> +			&data->group_notifier);
>> +free_exit:
>> +	kfree(data);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * IBM NPU2 bridge
>> + */
>> +struct vfio_pci_npu2_data {
>> +	void *base;
>> +	unsigned long mmio_atsd;
>> +	unsigned long gpu_tgt;
>> +};
>> +
>> +static size_t vfio_pci_npu2_rw(struct vfio_pci_device *vdev,
>> +		char __user *buf, size_t count, loff_t *ppos, bool iswrite)
>> +{
>> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
>> +	struct vfio_pci_npu2_data *data = vdev->region[i].data;
>> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
>> +
>> +	if (pos >= vdev->region[i].size)
>> +		return -EINVAL;
>> +
>> +	count = min(count, (size_t)(vdev->region[i].size - pos));
>> +
>> +	if (iswrite) {
>> +		if (copy_from_user(data->base + pos, buf, count))
>> +			return -EFAULT;
>> +	} else {
>> +		if (copy_to_user(buf, data->base + pos, count))
>> +			return -EFAULT;
>> +	}
>> +	*ppos += count;
>> +
>> +	return count;
>> +}
>> +
>> +static int vfio_pci_npu2_mmap(struct vfio_pci_device *vdev,
>> +		struct vfio_pci_region *region, struct vm_area_struct *vma)
>> +{
>> +	int ret;
>> +	struct vfio_pci_npu2_data *data = region->data;
>> +	unsigned long req_len = vma->vm_end - vma->vm_start;
>> +
>> +	if (req_len != PAGE_SIZE)
>> +		return -EINVAL;
>> +
>> +	vma->vm_flags |= VM_PFNMAP;
>> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +
>> +	ret = remap_pfn_range(vma, vma->vm_start, data->mmio_atsd >> PAGE_SHIFT,
>> +			req_len, vma->vm_page_prot);
>> +	pr_debug("VFIO NPU2 mmap: %lx %lx size=%lx ret=%d\n",
>> +			vma->vm_start, data->mmio_atsd,
>> +			vma->vm_end - vma->vm_start, ret);
> 
> For commit or convert to tracing?
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static void vfio_pci_npu2_release(struct vfio_pci_device *vdev,
>> +		struct vfio_pci_region *region)
>> +{
>> +	struct vfio_pci_npu2_data *data = region->data;
>> +
>> +	memunmap(data->base);
>> +	kfree(data);
>> +}
>> +
>> +static int vfio_pci_npu2_add_capability(struct vfio_pci_device *vdev,
>> +		struct vfio_pci_region *region, struct vfio_info_cap *caps)
>> +{
>> +	struct vfio_pci_npu2_data *data = region->data;
>> +	struct vfio_region_info_cap_npu2 cap;
>> +
>> +	cap.header.id = VFIO_REGION_INFO_CAP_NPU2;
>> +	cap.header.version = 1;
>> +	cap.tgt = data->gpu_tgt;
>> +
>> +	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
>> +}
>> +
>> +static const struct vfio_pci_regops vfio_pci_npu2_regops = {
>> +	.rw = vfio_pci_npu2_rw,
>> +	.mmap = vfio_pci_npu2_mmap,
>> +	.release = vfio_pci_npu2_release,
>> +	.add_capability = vfio_pci_npu2_add_capability,
>> +};
>> +
>> +int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>> +{
>> +	int ret;
>> +	struct vfio_pci_npu2_data *data;
>> +	struct device_node *nvlink_dn;
>> +	u32 nvlink_index = 0;
>> +	struct pci_dev *npdev = vdev->pdev;
>> +	struct device_node *npu_node = pci_device_to_OF_node(npdev);
>> +	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
>> +	u64 mmio_atsd = 0;
>> +	u64 tgt = 0;
>> +
>> +	/*
>> +	 * NPU2 normally has 8 ATSD registers (for concurrency) and 6 links
>> +	 * so we can allocate one register per link.
>> +	 * Since skiboot only exposes one (a bug), use this as a fallback
>> +	 * which is safe as we do not split GPUs attached to the same NPU.
>> +	 */
>> +	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>> +	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>> +			&nvlink_index)))
>> +		return -ENODEV;
>> +
>> +	if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", nvlink_index,
>> +			&mmio_atsd)) {
>> +		if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", 0,
>> +					&mmio_atsd)) {
>> +			dev_warn(&vdev->pdev->dev, "No ATSD found\n");
>> +			return -EFAULT;
>> +		}
>> +		dev_warn(&vdev->pdev->dev, "Fallback to ATSD#0\n");
>> +	}
>> +
>> +	if (of_property_read_u64(npu_node, "ibm,device-tgt-addr", &tgt)) {
>> +		dev_warn(&vdev->pdev->dev, "No ibm,device-tgt-addr found\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->mmio_atsd = mmio_atsd;
>> +	data->gpu_tgt = tgt;
>> +	data->base = memremap(data->mmio_atsd, SZ_64K, MEMREMAP_WT);
>> +	if (!data->base) {
>> +		ret = -ENOMEM;
>> +		goto free_exit;
>> +	}
>> +
>> +	ret = vfio_pci_register_dev_region(vdev,
>> +			PCI_VENDOR_ID_IBM | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
>> +			VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
>> +			&vfio_pci_npu2_regops, PAGE_SIZE,
>> +			VFIO_REGION_INFO_FLAG_READ, data);
> 
> READ|WRITE|MMAP
> 
>> +	if (ret)
>> +		goto free_exit;
>> +
>> +	return 0;
>> +
>> +free_exit:
>> +	kfree(data);
>> +
>> +	return ret;
>> +}
>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>> index 42dc1d3..1a58979 100644
>> --- a/drivers/vfio/pci/Kconfig
>> +++ b/drivers/vfio/pci/Kconfig
>> @@ -38,3 +38,7 @@ config VFIO_PCI_IGD
>>  	  and LPC bridge config space.
>>  
>>  	  To enable Intel IGD assignment through vfio-pci, say Y.
>> +
>> +config VFIO_PCI_NVLINK2
>> +	bool "VFIO PCI support for P9 Witherspoon machine with NVIDIA V100 GPUs"
>> +	depends on VFIO_PCI && PPC_POWERNV
> 

-- 
Alexey
