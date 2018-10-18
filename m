Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F65C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 18:42:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7CA20644
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 18:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VJNlv7sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7CA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bdG41FZgzF3HS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:42:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="VJNlv7sb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=pjaroszynski@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="VJNlv7sb"; 
 dkim-atps=neutral
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bdCG2wJ1zF3FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 05:40:26 +1100 (AEDT)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5bc8d3910000>; Thu, 18 Oct 2018 11:40:17 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 18 Oct 2018 11:40:22 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 18 Oct 2018 11:40:22 -0700
Received: from [10.2.169.16] (10.2.169.16) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 18 Oct
 2018 18:40:19 +0000
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
 [10de:1db1] subdriver
To: Alex Williamson <alex.williamson@redhat.com>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru> <20181016130824.20be215b@w520.home>
 <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
 <20181017155252.2f15d0f0@w520.home>
 <2175dbbd-21d9-df26-67f5-4b41f90ab1bc@ozlabs.ru>
 <20181018105503.088a343f@w520.home>
 <0e0db29d-a1e8-af85-b715-c1ba1a2f3875@nvidia.com>
 <20181018120502.057feb7a@w520.home>
X-Nvconfidentiality: public
From: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Message-ID: <a8a71caf-bf86-ecd4-cb38-9e138e616994@nvidia.com>
Date: Thu, 18 Oct 2018 11:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181018120502.057feb7a@w520.home>
X-Originating-IP: [10.2.169.16]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL104.nvidia.com (172.18.146.11)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1539888018; bh=xff4byW8Ey2P82ogfJqmPee1R4zE/JaHqL+TmF0hNxs=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=VJNlv7sbz/vpPKFPITx96HuYX/v4ZRbPwcZY65260fnLViuQG2YfOHTVqeqjLtTgu
 sPPgKHp0MnoVLYrbLRmajC/TRuyvZGKdrKPK8RZGEaW9hr7gZo14bdZZ0ZsOv5rq9E
 8UvGkP8Ql/E0wMldzrRFFnHhqpkW8Uo5vcw4LEMMB2GZrIiBSui3gS9KE2YGofkTC/
 TGOfY7zkzxHyc9qNQUwLWfLUnxZKVKOhxAG4Rd9OUMrR1MFUEk33YGiJM+bpnq2dHn
 Os/wqkD2fD6i2fDLC7hPqGPaSKCAHvCIL91QHiGaXPnhdNoEPyQScXvwvKdzF49clO
 ecvLfKmecWMxQ==
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
Cc: Reza Arbab <arbab@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/18/18 11:05 AM, Alex Williamson wrote:
> On Thu, 18 Oct 2018 10:37:46 -0700
> Piotr Jaroszynski <pjaroszynski@nvidia.com> wrote:
> 
>> On 10/18/18 9:55 AM, Alex Williamson wrote:
>>> On Thu, 18 Oct 2018 11:31:33 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>    
>>>> On 18/10/2018 08:52, Alex Williamson wrote:
>>>>> On Wed, 17 Oct 2018 12:19:20 +1100
>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>       
>>>>>> On 17/10/2018 06:08, Alex Williamson wrote:
>>>>>>> On Mon, 15 Oct 2018 20:42:33 +1100
>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>> +
>>>>>>>> +	if (pdev->vendor == PCI_VENDOR_ID_IBM &&
>>>>>>>> +			pdev->device == 0x04ea) {
>>>>>>>> +		ret = vfio_pci_ibm_npu2_init(vdev);
>>>>>>>> +		if (ret) {
>>>>>>>> +			dev_warn(&vdev->pdev->dev,
>>>>>>>> +					"Failed to setup NVIDIA NV2 ATSD region\n");
>>>>>>>> +			goto disable_exit;
>>>>>>>>    		}
>>>>>>>
>>>>>>> So the NPU is also actually owned by vfio-pci and assigned to the VM?
>>>>>>
>>>>>> Yes. On a running system it looks like:
>>>>>>
>>>>>> 0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
>>>>>> 0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
>>>>>> 0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
>>>>>> 0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
>>>>>> 0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
>>>>>> 0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
>>>>>> 0035:00:00.0 PCI bridge: IBM Device 04c1
>>>>>> 0035:01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>>>>>> 0035:02:04.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>>>>>> 0035:02:05.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>>>>>> 0035:02:0d.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
>>>>>> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
>>>>>> (rev a1
>>>>>> 0035:04:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
>>>>>> (rev a1)
>>>>>> 0035:05:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
>>>>>> (rev a1)
>>>>>>
>>>>>> One "IBM Device" bridge represents one NVLink2, i.e. a piece of NPU.
>>>>>> They all and 3 GPUs go to the same IOMMU group and get passed through to
>>>>>> a guest.
>>>>>>
>>>>>> The entire NPU does not have representation via sysfs as a whole though.
>>>>>
>>>>> So the NPU is a bridge, but it uses a normal header type so vfio-pci
>>>>> will bind to it?
>>>>
>>>> An NPU is a NVLink bridge, it is not PCI in any sense. We (the host
>>>> powerpc firmware known as "skiboot" or "opal") have chosen to emulate a
>>>> virtual bridge per 1 NVLink on the firmware level. So for each physical
>>>> NPU there are 6 virtual bridges. So the NVIDIA driver does not need to
>>>> know much about NPUs.
>>>>   
>>>>> And the ATSD register that we need on it is not
>>>>> accessible through these PCI representations of the sub-pieces of the
>>>>> NPU?  Thanks,
>>>>
>>>> No, only via the device tree. The skiboot puts the ATSD register address
>>>> to the PHB's DT property called 'ibm,mmio-atsd' of these virtual bridges.
>>>
>>> Ok, so the NPU is essential a virtual device already, mostly just a
>>> stub.  But it seems that each NPU is associated to a specific GPU, how
>>> is that association done?  In the use case here it seems like it's just
>>> a vehicle to provide this ibm,mmio-atsd property to guest DT and the tgt
>>> routing information to the GPU.  So if both of those were attached to
>>> the GPU, there'd be no purpose in assigning the NPU other than it's in
>>> the same IOMMU group with a type 0 header, so something needs to be
>>> done with it.  If it's a virtual device, perhaps it could have a type 1
>>> header so vfio wouldn't care about it, then we would only assign the
>>> GPU with these extra properties, which seems easier for management
>>> tools and users.  If the guest driver needs a visible NPU device, QEMU
>>> could possibly emulate one to make the GPU association work
>>> automatically.  Maybe this isn't really a problem, but I wonder if
>>> you've looked up the management stack to see what tools need to know to
>>> assign these NPU devices and whether specific configurations are
>>> required to make the NPU to GPU association work.  Thanks,
>>
>> I'm not that familiar with how this was originally set up, but note that
>> Alexey is just making it work exactly like baremetal does. The baremetal
>> GPU driver works as-is in the VM and expects the same properties in the
>> device-tree. Obviously it doesn't have to be that way, but there is
>> value in keeping it identical.
>>
>> Another probably bigger point is that the NPU device also implements the
>> nvlink HW interface and is required for actually training and
>> maintaining the link up. The driver in the guest trains the links by
>> programming both the GPU end and the NPU end of each link so the NPU
>> device needs to be exposed to the guest.
> 
> Ok, so there is functionality in assigning the NPU device itself, it's
> not just an attachment point for meta data.  But it still seems there
> must be some association of NPU to GPU, the tgt address seems to pair
> the NPU with a specific GPU, they're not simply a fungible set of NPUs
> and GPUs.  Is that association explicit anywhere or is it related to
> the topology or device numbering that needs to match between the host
> and guest?  Thanks,

GPUs are linked to NPU devices through device tree properties, I think. 
Linux has a helper to look up linked NPU devices for a PCI device 
pnv_pci_get_npu_dev() here:
https://elixir.bootlin.com/linux/latest/source/arch/powerpc/platforms/powernv/npu-dma.c#L86
 From what Alexey said, it sounds like the NPU devices are actually 
virtualized by the firmware, but they do map to real hardware in the end 
and each GPU needs to be accompanied by the same NPU devices as on 
baremetal. Currently, there are two types of P9+GV100 systems, one with 
2 CPU<->GPU links per GPU and hence 2 linked NPU devices per GPU. And a 
second system with 3 CPU<->GPU links per GPU and hence 3 linked NPU 
devices per GPU.

Having the user assign all the NPUs and GPUs correctly does seem a bit 
cumbersome, but maybe higher level tools on top of qemu can simplify 
that somehow by pulling them in automatically? FWIW, whenever a GPU is 
assigned to a guest, its linked NPU devices are likely not very useful 
to anything else so grouping them together somehow would make sense.

> 
> Alex
> 

