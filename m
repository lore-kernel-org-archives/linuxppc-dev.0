Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADE8C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 01:52:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACBB218FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 01:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="gdrLQ3pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACBB218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LWpy335LzDrB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 12:52:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="gdrLQ3pf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="gdrLQ3pf"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LWm53FRXzDqsl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 12:50:12 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id j10so1738599pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 17:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RNt3Mr74e51bUHZMfuNTErYfyJTzgY6uGW97mK8aCnY=;
 b=gdrLQ3pfe8cC1w9p1Qy36bwFBZJ8oDpSCeLxhTtVIDfMjHIw701JmLz/jGEUJl09u5
 W5RUvTTuHO941SiHBD8VYYeg+WMiA43BWcNIq1LZz6nZYPJfMWqFUEp+eQl9L12P8RtM
 zjrBzs3YnTmQRp0FaeXVfQRTR7G/8ywuUkDtwNPegFjObT3RiPNxc8P9uEPvZbSsylbB
 NFXtqTtCMYCZi68Nn7c4xVUbQK/+9uZVhr2vf6aJf7p6DJhFtwvmfQr8JWilA+qOvHNp
 KshzaJB6PCrpLvdTna9hxZfMJ8MeXxNtfGNR3rCzmifF1dod5HxIHoKB+D0H6W7fudqC
 7EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RNt3Mr74e51bUHZMfuNTErYfyJTzgY6uGW97mK8aCnY=;
 b=M3bREWoWkjCMTATlWjkcyc6pp2CNWXi6wvua7JnHe2h3CTrRDyr2IFDpPKUIaRVKsc
 rxyYspptlNiGTlVD5uporEwQPx9FnsYRMhR9BgecS/C0+xnw9Jnkh8XX1zZzW4CUMSWJ
 8tSYNe4lwht14e2J7WLGEbp+FQptZQdqaVfjqloBtw2PQvF0H4w75visIgtYZNR4iyZp
 vSCDvIUvIpOhi5t1V17ZYIQG6IWeHOSXcfvXuHLKoB/+qGy6tYhKHV4so72RQ85WeDGF
 pLXOTJ6U3Y2K/0Yls6heYi8yoMsMpYn4VHB9cCEyNIv55rBF1rxsqn1gl2sU4tz9y1np
 mweg==
X-Gm-Message-State: AA+aEWY1woAH69UcglxHHMLFsPTICh0jl5EJ5CZ2TCTzjNAAQpZjUTP+
 uN8/55xn2BMuCBeHCrEJ1l2SNg==
X-Google-Smtp-Source: AFSGD/UW64IFqs7227DWoEGpaXXb+ebiuSmrSNEYSiyY+5DdQJNPO2aIVk6Rjqg06EdJpE6YzcIlDg==
X-Received: by 2002:a62:8096:: with SMTP id j144mr572917pfd.140.1545357010948; 
 Thu, 20 Dec 2018 17:50:10 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id u126sm45128080pgb.2.2018.12.20.17.50.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 17:50:10 -0800 (PST)
Subject: Re: [PATCH kernel v7 20/20] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] subdriver
To: Alex Williamson <alex.williamson@redhat.com>
References: <20181220082350.58113-1-aik@ozlabs.ru>
 <20181220082350.58113-21-aik@ozlabs.ru> <20181220094604.7d172cbe@x1.home>
 <8c4ee37c-8759-a618-0c38-034210858b89@ozlabs.ru>
 <20181220183750.44535f1c@x1.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <b296128d-be96-8683-b0c0-1eac0a7f18ca@ozlabs.ru>
Date: Fri, 21 Dec 2018 12:50:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181220183750.44535f1c@x1.home>
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
Cc: Christoph Hellwig <hch@infradead.org>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 21/12/2018 12:37, Alex Williamson wrote:
> On Fri, 21 Dec 2018 12:23:16 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 21/12/2018 03:46, Alex Williamson wrote:
>>> On Thu, 20 Dec 2018 19:23:50 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>   
>>>> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
>>>> pluggable PCIe devices but still have PCIe links which are used
>>>> for config space and MMIO. In addition to that the GPUs have 6 NVLinks
>>>> which are connected to other GPUs and the POWER9 CPU. POWER9 chips
>>>> have a special unit on a die called an NPU which is an NVLink2 host bus
>>>> adapter with p2p connections to 2 to 3 GPUs, 3 or 2 NVLinks to each.
>>>> These systems also support ATS (address translation services) which is
>>>> a part of the NVLink2 protocol. Such GPUs also share on-board RAM
>>>> (16GB or 32GB) to the system via the same NVLink2 so a CPU has
>>>> cache-coherent access to a GPU RAM.
>>>>
>>>> This exports GPU RAM to the userspace as a new VFIO device region. This
>>>> preregisters the new memory as device memory as it might be used for DMA.
>>>> This inserts pfns from the fault handler as the GPU memory is not onlined
>>>> until the vendor driver is loaded and trained the NVLinks so doing this
>>>> earlier causes low level errors which we fence in the firmware so
>>>> it does not hurt the host system but still better be avoided; for the same
>>>> reason this does not map GPU RAM into the host kernel (usual thing for
>>>> emulated access otherwise).
>>>>
>>>> This exports an ATSD (Address Translation Shootdown) register of NPU which
>>>> allows TLB invalidations inside GPU for an operating system. The register
>>>> conveniently occupies a single 64k page. It is also presented to
>>>> the userspace as a new VFIO device region. One NPU has 8 ATSD registers,
>>>> each of them can be used for TLB invalidation in a GPU linked to this NPU.
>>>> This allocates one ATSD register per an NVLink bridge allowing passing
>>>> up to 6 registers. Due to the host firmware bug (just recently fixed),
>>>> only 1 ATSD register per NPU was actually advertised to the host system
>>>> so this passes that alone register via the first NVLink bridge device in
>>>> the group which is still enough as QEMU collects them all back and
>>>> presents to the guest via vPHB to mimic the emulated NPU PHB on the host.
>>>>
>>>> In order to provide the userspace with the information about GPU-to-NVLink
>>>> connections, this exports an additional capability called "tgt"
>>>> (which is an abbreviated host system bus address). The "tgt" property
>>>> tells the GPU its own system address and allows the guest driver to
>>>> conglomerate the routing information so each GPU knows how to get directly
>>>> to the other GPUs.
>>>>
>>>> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
>>>> know LPID (a logical partition ID or a KVM guest hardware ID in other
>>>> words) and PID (a memory context ID of a userspace process, not to be
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
>>>> The V100 GPUs do not advertise any of these capabilities via the config
>>>> space and there are more than just one device ID so this relies on
>>>> the platform to tell whether these GPUs have special abilities such as
>>>> NVLinks.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v6.1:
>>>> * fixed outdated comment about VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD
>>>>
>>>> v6:
>>>> * reworked capabilities - tgt for nvlink and gpu and link-speed
>>>> for nvlink only
>>>>
>>>> v5:
>>>> * do not memremap GPU RAM for emulation, map it only when it is needed
>>>> * allocate 1 ATSD register per NVLink bridge, if none left, then expose
>>>> the region with a zero size
>>>> * separate caps per device type
>>>> * addressed AW review comments
>>>>
>>>> v4:
>>>> * added nvlink-speed to the NPU bridge capability as this turned out to
>>>> be not a constant value
>>>> * instead of looking at the exact device ID (which also changes from system
>>>> to system), now this (indirectly) looks at the device tree to know
>>>> if GPU and NPU support NVLink
>>>>
>>>> v3:
>>>> * reworded the commit log about tgt
>>>> * added tracepoints (do we want them enabled for entire vfio-pci?)
>>>> * added code comments
>>>> * added write|mmap flags to the new regions
>>>> * auto enabled VFIO_PCI_NVLINK2 config option
>>>> * added 'tgt' capability to a GPU so QEMU can recreate ibm,npu and ibm,gpu
>>>> references; there are required by the NVIDIA driver
>>>> * keep notifier registered only for short time
>>>> ---
>>>>  drivers/vfio/pci/Makefile           |   1 +
>>>>  drivers/vfio/pci/trace.h            | 102 ++++++
>>>>  drivers/vfio/pci/vfio_pci_private.h |  14 +
>>>>  include/uapi/linux/vfio.h           |  37 +++
>>>>  drivers/vfio/pci/vfio_pci.c         |  27 +-
>>>>  drivers/vfio/pci/vfio_pci_nvlink2.c | 482 ++++++++++++++++++++++++++++
>>>>  drivers/vfio/pci/Kconfig            |   6 +
>>>>  7 files changed, 667 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/vfio/pci/trace.h
>>>>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
>>>>  
>>> ...  
>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>> index 8131028..5562587 100644
>>>> --- a/include/uapi/linux/vfio.h
>>>> +++ b/include/uapi/linux/vfio.h
>>>> @@ -353,6 +353,21 @@ struct vfio_region_gfx_edid {
>>>>  #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>>>>  };
>>>>  
>>>> +/*
>>>> + * 10de vendor sub-type
>>>> + *
>>>> + * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
>>>> + */
>>>> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
>>>> +
>>>> +/*
>>>> + * 1014 vendor sub-type
>>>> + *
>>>> + * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
>>>> + * to do TLB invalidation on a GPU.
>>>> + */
>>>> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>>>> +
>>>>  /*
>>>>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>>>>   * which allows direct access to non-MSIX registers which happened to be within
>>>> @@ -363,6 +378,28 @@ struct vfio_region_gfx_edid {
>>>>   */
>>>>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>>>>  
>>>> +/*
>>>> + * Capability with compressed real address (aka SSA - small system address)
>>>> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
>>>> + */
>>>> +#define VFIO_REGION_INFO_CAP_NVLINK2_SSATGT	4
>>>> +
>>>> +struct vfio_region_info_cap_nvlink2_ssatgt {
>>>> +	struct vfio_info_cap_header header;
>>>> +	__u64 tgt;
>>>> +};
>>>> +
>>>> +/*
>>>> + * Capability with an NVLink link speed.
>>>> + */  
>>>
>>> I was really hoping for something more like SSATGT above indicating the
>>> intended users and purpose, and an update to SSATGT since it's now used
>>> by both the GPU and NPU2.  This comment is correct, but it's basically
>>> useless, it doesn't provide any information that isn't readily apparent
>>> from the structure definition.  AIUI, SSATGT is used not only for the
>>> GPU to determine where its RAM is mapped on the system bus, but also by
>>> the NPU2 to associate itself to a GPU, right?  
>>
>> Correct. It could be improved by
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5562587..ff238ef9c 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -380,7 +380,8 @@ struct vfio_region_gfx_edid {
>>
>>  /*
>>   * Capability with compressed real address (aka SSA - small system address)
>> - * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
>> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing
>> + * and by the userspace to associate a NVLink bridge with a GPU.
>>   */
>>  #define VFIO_REGION_INFO_CAP_NVLINK2_SSATGT    4
>>
>>
>>
>>> And the link speed here
>>> is consumed by the NPU2 in order to fill in DT information for the
>>> guest for compatibility and possibly routing optimizations?  
>>
>>
>> It is just some speed number, 8 or 9, one works and the other does not,
>> depending on the actual system. The NVIDIA driver handles it in the
>> binary blob. The existing comment is not much use but I am really not
>> sure what other comment could be useful in here.
> 
> So why do we need to expose it?  "Exposed on NPU2 devices for userspace
> to export to guest VM via DT(?) or else <something bad happens/doesn't
> work> in the guest".  Work with me, there must be some justification
> for why it gets exposed, not just what it is.  Thanks,


How about this?

/*
 * Capability with an NVLink link speed. The value is read by
 * the NVlink2 bridge driver from the bridge's "ibm,nvlink-speed"
 * property in the device tree. The value is fixed in the hardware
 * and failing to provide the correct value results in the link
 * not working with no indication from the driver why.
 */

Thanks,


-- 
Alexey
