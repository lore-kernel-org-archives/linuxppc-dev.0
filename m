Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA5ECDE42
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 00:34:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828AA21470
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 00:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bCR+2FE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828AA21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42b95n719RzF3Ny
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 11:34:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bCR+2FE6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bCR+2FE6"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42b9323J45zF3SX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 11:31:41 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id f8-v6so13315169pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Us8OI9BdCuHCVwE6cL5/K0uzKRFHQCsI88KvUXReT4M=;
 b=bCR+2FE6B4jEHIn15ccseY9STUfUsyExGS2SZcm/YIbjpnlKwjX3/XSCiTWuL+NQ9W
 gSYhGy9jaXHaj+Hj5l901Mpdt1XjuFz7eR8S1lvU1roIkQbkNwXhVShl9tKVhB9oKFwG
 h1HDvKfpkGjVVWUfgzHBYU5Zy9hyuXKBIkL+m8GqVOyF2BzmP2ZBkG3h9hrppYZibqSQ
 fc+v3Nl4nQQ1BtvgaKut40IB9whBrDX/DtR9dhYeHDFxKLpA9nSZr+1qVmcXQ0kueBXI
 l8Wvjl6omHR13ZShDxC6lkuThTIBTAUPjdwScUQcwXieP2l/Sr1W/xjITZSIPTh/AMbk
 FkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Us8OI9BdCuHCVwE6cL5/K0uzKRFHQCsI88KvUXReT4M=;
 b=pzXeyIY7G4eHagJWxohTqhLSszFun3Ot7kWrZi+AkzISJQRx++1yU3x5KFbaMjq4OJ
 /tEan2JlhSqNB4+IKeFrfFK4z9jYYLnQqOu4FC2oGf+WnuJY4rB+4RTUnQxqpCYdydsE
 FnDUEPpjzA9mdsbT8Gw3G/u98sgLYb9G3fIZe3MwoIeUPgcy+pCzI1k49uP3PpJLfy98
 fapl6nannugjUs47cEmAR4HfajeoMSue7eF6cNcnH/BYodEeSGXIas8ypS+fVBI9bGiK
 TTZYXIrCA36BJ68+gJ750xynOpSqgFNqH+q++ycdjt3iaONRi+XvT9z75I//cFiqO/0l
 hBTA==
X-Gm-Message-State: ABuFfoiJihxBOcP3oUe9HL85smGemLpliK+yznNaSc2FTS0Vhp8eYP4W
 1Rl+UGjXTyLT4PsDUX9LDLx3jw==
X-Google-Smtp-Source: ACcGV63VcdJJWVBpgdRy4A98AwMkWFcQhMIvVNL6vDIiX3NEbiq73WToSAR/Ji03aRNifjFPK6m52A==
X-Received: by 2002:a62:11cb:: with SMTP id
 72-v6mr28217037pfr.120.1539822699474; 
 Wed, 17 Oct 2018 17:31:39 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e189-v6sm3230170pfa.91.2018.10.17.17.31.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Oct 2018 17:31:38 -0700 (PDT)
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
 [10de:1db1] subdriver
To: Alex Williamson <alex.williamson@redhat.com>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru> <20181016130824.20be215b@w520.home>
 <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
 <20181017155252.2f15d0f0@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <2175dbbd-21d9-df26-67f5-4b41f90ab1bc@ozlabs.ru>
Date: Thu, 18 Oct 2018 11:31:33 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017155252.2f15d0f0@w520.home>
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



On 18/10/2018 08:52, Alex Williamson wrote:
> On Wed, 17 Oct 2018 12:19:20 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 17/10/2018 06:08, Alex Williamson wrote:
>>> On Mon, 15 Oct 2018 20:42:33 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>   
>>>> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
>>>> pluggable PCIe devices but implement PCIe links for config space and MMIO.
>>>> In addition to that the GPUs are interconnected to each other and also
>>>> have direct links to the P9 CPU. The links are NVLink2 and provide direct
>>>> access to the system RAM for GPUs via NPU (an NVLink2 "proxy" on P9 chip).
>>>> These systems also support ATS (address translation services) which is
>>>> a part of the NVLink2 prototol. Such GPUs also share on-board RAM
>>>> (16GB in tested config) to the system via the same NVLink2 so a CPU has
>>>> cache-coherent access to a GPU RAM.
>>>>
>>>> This exports GPU RAM to the userspace as a new PCI region. This
>>>> preregisters the new memory as device memory as it might be used for DMA.
>>>> This inserts pfns from the fault handler as the GPU memory is not onlined
>>>> until the NVIDIA driver is loaded and trained the links so doing this
>>>> earlier produces low level errors which we fence in the firmware so
>>>> it does not hurt the host system but still better to avoid.
>>>>
>>>> This exports ATSD (Address Translation Shootdown) register of NPU which
>>>> allows the guest to invalidate TLB. The register conviniently occupies
>>>> a single 64k page. Since NPU maps the GPU memory, it has a "tgt" property
>>>> (which is an abbreviated host system bus address). This exports the "tgt"
>>>> as a capability so the guest can program it into the GPU so the GPU can
>>>> know how to route DMA trafic.  
>>>
>>> I'm not really following what "tgt" is and why it's needed.  Is the GPU
>>> memory here different than the GPU RAM region above?  Why does the user
>>> need the host system bus address of this "tgt" thing?  Are we not able
>>> to relocate it in guest physical address space, does this shootdown
>>> only work in the host physical address space and therefore we need this
>>> offset?  Please explain, I'm confused.  
>>
>>
>> This "tgt" is made of:
>> - "memory select" (bits 45, 46)
>> - "group select" (bits 43, 44)
>> - "chip select" (bit 42)
>> - chip internal address (bits 0..41)
>>
>> These are internal to GPU and this is where GPU RAM is mapped into the
>> GPU's real space, this fits 46 bits.
>>
>> On POWER9 CPU the bits are different and higher so the same memory is
>> mapped higher on P9 CPU. Just because we can map it higher, I guess.
>>
>> So it is not exactly the address but this provides the exact physical
>> location of the memory.
>>
>> We have a group of 3 interconnected GPUs, they got their own
>> memory/group/chip numbers. The GPUs use ATS service to translate
>> userspace to physical (host or guest) addresses. Now a GPU needs to know
>> which specific link to use for a specific physical address, in other
>> words what this physical address belongs to - a CPU or one of GPUs. This
>> is when "tgt" is used by the GPU hardware.
> 
> Clear as mud ;) 

/me is sad. I hope Piotr explained it better...


> So tgt, provided by the npu2 capability of the ATSD
> region of the NPU tells the GPU (a completely separate device) how to
> route it its own RAM via its NVLink interface?  How can one tgt
> indicate the routing for multiple interfaces?

This NVLink DMA is using direct host physical addresses (no IOMMU, no
filtering) which come from ATS. So unless we tell the GPU its own
address range on the host CPU, it will route trafic via CPU. And the
driver can also discover the NVLink topology and tell each GPU physical
addresses of peer GPUs.



> 
>> A GPU could run all the DMA trafic via the system bus indeed, just not
>> as fast.
>>
>> I am also struggling here and adding an Nvidia person in cc: (I should
>> have done that when I posted the patches, my bad) to correct when/if I
>> am wrong.
>>
>>
>>
>>>    
>>>> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
>>>> know LPID (a logical partition ID or a KVM guest hardware ID in other
>>>> words) and PID (a memory context ID of an userspace process, not to be
>>>> confused with a linux pid). This assigns a GPU to LPID in the NPU and
>>>> this is why this adds a listener for KVM on an IOMMU group. A PID comes
>>>> via NVLink from a GPU and NPU uses a PID wildcard to pass it through.
>>>>
>>>> This requires coherent memory and ATSD to be available on the host as
>>>> the GPU vendor only supports configurations with both features enabled
>>>> and other configurations are known not to work. Because of this and
>>>> because of the ways the features are advertised to the host system
>>>> (which is a device tree with very platform specific properties),
>>>> this requires enabled POWERNV platform.
>>>>
>>>> This hardcodes the NVLink2 support for specific vendor and device IDs
>>>> as there is no reliable way of knowing about coherent memory and ATS
>>>> support. The GPU has an unique vendor PCIe capability 0x23 but it was
>>>> confirmed that it does not provide required information (and it is still
>>>> undisclosed what it actually does).
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>  drivers/vfio/pci/Makefile           |   1 +
>>>>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>>>>  include/uapi/linux/vfio.h           |  18 ++
>>>>  drivers/vfio/pci/vfio_pci.c         |  37 +++-
>>>>  drivers/vfio/pci/vfio_pci_nvlink2.c | 409 ++++++++++++++++++++++++++++++++++++
>>>>  drivers/vfio/pci/Kconfig            |   4 +
>>>>  6 files changed, 469 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
>>>>
>>>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>>>> index 76d8ec0..9662c06 100644
>>>> --- a/drivers/vfio/pci/Makefile
>>>> +++ b/drivers/vfio/pci/Makefile
>>>> @@ -1,5 +1,6 @@
>>>>  
>>>>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>>>>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>>>> +vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
>>>>  
>>>>  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
>>>> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
>>>> index 93c1738..7639241 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_private.h
>>>> +++ b/drivers/vfio/pci/vfio_pci_private.h
>>>> @@ -163,4 +163,6 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
>>>>  	return -ENODEV;
>>>>  }
>>>>  #endif
>>>> +extern int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev);
>>>> +extern int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev);
>>>>  #endif /* VFIO_PCI_PRIVATE_H */
>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>> index f378b98..9e9a8d3 100644
>>>> --- a/include/uapi/linux/vfio.h
>>>> +++ b/include/uapi/linux/vfio.h
>>>> @@ -303,6 +303,12 @@ struct vfio_region_info_cap_type {
>>>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>>>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>>>>  
>>>> +/* NVIDIA GPU NVlink2 RAM */
>>>> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
>>>> +
>>>> +/* IBM NPU NVlink2 ATSD */
>>>> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>>>> +  
>>>
>>> Please include some of the description in the commitlog here for
>>> reference.  Also please be explicit that these are vendor defined
>>> regions and note the numerical vendor ID associated with them.  
>>
>> These are PCI region subtypes which are not from any PCI spec and which
>> we define as we like, are not they all "vendor"?
> 
> No, it's not entirely obvious that they're vendor regions, I had to
> look at the usage later in the patch.  See linux-next where Gerd has
> added an EDID region which is not a vendor region.  You make use of
> these by masking VFIO_REGION_TYPE_PCI_VENDOR_TYPE into the type, which
> indicates they are a PCI vendor type region, which means they are
> associated to a specific vendor.  That vendor should be explicitly,
> numerically, indicated (some hardware vendors own multiple PCI vendor
> IDs or may acquire more).

Ah, I see now. ok.


>>>>  /*
>>>>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>>>>   * which allows direct access to non-MSIX registers which happened to be within
>>>> @@ -313,6 +319,18 @@ struct vfio_region_info_cap_type {
>>>>   */
>>>>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>>>>  
>>>> +/*
>>>> + * Capability with compressed real address (aka SSA - small system address)
>>>> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
>>>> + */
>>>> +#define VFIO_REGION_INFO_CAP_NPU2		4
>>>> +
>>>> +struct vfio_region_info_cap_npu2 {
>>>> +	struct vfio_info_cap_header header;
>>>> +	__u64 tgt;
>>>> +	/* size is defined in VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM */  
>>>
>>> But this is a capability for the IBM_NVLINK2_ATSD?  What is the
>>> relevance of this comment?  Is this capability relevant to the RAM or
>>> ATSD?  
>>
>> It is relevant to NPU (NVLink host bus adapter of POWER9) which maps the
>> GPU RAM to the system bus and acts as a proxy to nestMMU (NVIDIA's unit
>> in POWER9 CPU) for ATS/ATSD services so it is a property of NPU. But
>> then one might ask "wait, here is the address, where is the size then",
>>  hence the comment...
> 
> So the tgt field within the npu2 capability of the ATSD region on the
> NPU device describes the GPU internal address of the GPU RAM which is
> described by the NVLINK2 RAM region on the GPU device... *twitch*  What
> business does the NPU have exposing this piece of information and how
> is it related to the ATSD region/register? 

NPU is the source of the information on the host. ATSD is just another
feature of NPU.

> Is this tgt base used in
> the process of doing address translation shootdowns?

No, only routing.


>>>> +};
>>>> +
>>>>  /**
>>>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>>>>   *				    struct vfio_irq_info)
>>>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>>>> index 4a3b93e..e9afd43 100644
>>>> --- a/drivers/vfio/pci/vfio_pci.c
>>>> +++ b/drivers/vfio/pci/vfio_pci.c
>>>> @@ -224,6 +224,16 @@ static bool vfio_pci_nointx(struct pci_dev *pdev)
>>>>  	return false;
>>>>  }
>>>>  
>>>> +int __weak vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
>>>> +{
>>>> +	return -ENODEV;
>>>> +}
>>>> +
>>>> +int __weak vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>>>> +{
>>>> +	return -ENODEV;
>>>> +}
>>>> +
>>>>  static int vfio_pci_enable(struct vfio_pci_device *vdev)
>>>>  {
>>>>  	struct pci_dev *pdev = vdev->pdev;
>>>> @@ -302,14 +312,37 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>>>>  		if (ret) {
>>>>  			dev_warn(&vdev->pdev->dev,
>>>>  				 "Failed to setup Intel IGD regions\n");
>>>> -			vfio_pci_disable(vdev);
>>>> -			return ret;
>>>> +			goto disable_exit;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
>>>> +	    pdev->device == 0x1db1) {
>>>> +		ret = vfio_pci_nvdia_v100_nvlink2_init(vdev);
>>>> +		if (ret) {
>>>> +			dev_warn(&vdev->pdev->dev,
>>>> +				 "Failed to setup NVIDIA NV2 RAM region\n");
>>>> +			goto disable_exit;
>>>> +		}
>>>> +	}  
>>>
>>> This device ID is not unique to POWER9 Witherspoon systems, I see your
>>> comment in the commitlog, but this is clearly going to generate a
>>> dev_warn and failure on an x86 system with the same hardware.  Perhaps
>>> this could be masked off with IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2) like
>>> the IGD code above this chunk does?  
>>
>> Right, will fix.
>>
>>
>>>> +
>>>> +	if (pdev->vendor == PCI_VENDOR_ID_IBM &&
>>>> +			pdev->device == 0x04ea) {
>>>> +		ret = vfio_pci_ibm_npu2_init(vdev);
>>>> +		if (ret) {
>>>> +			dev_warn(&vdev->pdev->dev,
>>>> +					"Failed to setup NVIDIA NV2 ATSD region\n");
>>>> +			goto disable_exit;
>>>>  		}  
>>>
>>> So the NPU is also actually owned by vfio-pci and assigned to the VM?  
>>
>> Yes. On a running system it looks like:
>>
>> 0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
>> 0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
>> 0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
>> 0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
>> 0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
>> 0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
>> 0035:00:00.0 PCI bridge: IBM Device 04c1
>> 0035:01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>> 0035:02:04.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>> 0035:02:05.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>> 0035:02:0d.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
>> (rev a1
>> 0035:04:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
>> (rev a1)
>> 0035:05:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
>> (rev a1)
>>
>> One "IBM Device" bridge represents one NVLink2, i.e. a piece of NPU.
>> They all and 3 GPUs go to the same IOMMU group and get passed through to
>> a guest.
>>
>> The entire NPU does not have representation via sysfs as a whole though.
> 
> So the NPU is a bridge, but it uses a normal header type so vfio-pci
> will bind to it? 

An NPU is a NVLink bridge, it is not PCI in any sense. We (the host
powerpc firmware known as "skiboot" or "opal") have chosen to emulate a
virtual bridge per 1 NVLink on the firmware level. So for each physical
NPU there are 6 virtual bridges. So the NVIDIA driver does not need to
know much about NPUs.

> And the ATSD register that we need on it is not
> accessible through these PCI representations of the sub-pieces of the
> NPU?  Thanks,

No, only via the device tree. The skiboot puts the ATSD register address
to the PHB's DT property called 'ibm,mmio-atsd' of these virtual bridges.



-- 
Alexey
