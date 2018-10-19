Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C79CC67863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 00:56:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0842145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 00:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="t39nXYsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0842145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bnY81wnCzF3S2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 11:56:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="t39nXYsk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="t39nXYsk"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bnVM1GM7zF3RT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 11:54:01 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id 32-v6so3808011pgu.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4WFTcOLMA75ltygT2KrzdJPVDUMV+I67iBEsAuNYnp4=;
 b=t39nXYskPZNqbejXd8vZdawboBSeKVUhC/p3g8Tn/LaC7feA7AThprbpNar9bOhcI+
 c0H4uzrfWp44gXjZZ1pmWuAEIrWAILt9zoKKWUR9c1JsZbbgschM6RTN+yLcfK6KHB5R
 oNKlH0rBYJsd1AVUk3KzKQvqeycE379JHN5roBwMyOUtL2xrjVjXG7HgbcgIQAgpoXI1
 3GFM6WsZPkSvA+PIeKzV8PDIbTNql+pa909OMC9vpHGHOc3l2qMLENx2+d2YP+yCBp0Z
 QnY7Fuvo90GjE9noM5rAPQjc/QPluyD4R7RDs7a7Q1B4Ffm/b4sq28LP0+cNr9D9PA3j
 ozfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4WFTcOLMA75ltygT2KrzdJPVDUMV+I67iBEsAuNYnp4=;
 b=FQH9zVTuJgAM+S23S6IWtcoaekQrB91uVNTNiYcGkV+Unq4Y2QyjrH0kniF2e94Nm/
 m6RQYIc5vi3a25ZaZr4oRgwMsmbutbqKS/PDqLVUvvULLynvYZRaRwx0SgwSVRwG9R6q
 CXCo4KhApsS1mXDJQe62xripMPltWELuAp7uxiNvR6H1z/oO/EQsHz/A8PCtBDF6upNf
 K9n8OM7pt9y05DWPFlwUZ2V/MSgHUR0+jjRREYy6Qb59G995O9DxzGYd+pA0YIuG8cI8
 +ivKebmMOvxV+sh4wlsncMXFO5DzWzJg07SzUiROiyV7Hu6QM4Uf/inQ8qB06Wf5xq5t
 Dheg==
X-Gm-Message-State: ABuFfojM+0kRxxDg+hkw26LAE39hG5Ru9Ol2Lu11j0uUFxXf8/AwiqWK
 +MntvGV/CngIPYReOGskmscENg==
X-Google-Smtp-Source: ACcGV63angqTGWJYADzq/AtKwDowgxa4bPGIlcXI7Y5TAtz5HUJH+nsRrqLzytioyp6q7Uo/d8WllA==
X-Received: by 2002:a63:b25e:: with SMTP id
 t30-v6mr30520033pgo.401.1539910439160; 
 Thu, 18 Oct 2018 17:53:59 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 19-v6sm36245503pft.97.2018.10.18.17.53.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Oct 2018 17:53:58 -0700 (PDT)
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
 [10de:1db1] subdriver
To: Alex Williamson <alex.williamson@redhat.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru> <20181016130824.20be215b@w520.home>
 <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
 <20181017155252.2f15d0f0@w520.home>
 <2175dbbd-21d9-df26-67f5-4b41f90ab1bc@ozlabs.ru>
 <20181018105503.088a343f@w520.home>
 <0e0db29d-a1e8-af85-b715-c1ba1a2f3875@nvidia.com>
 <20181018120502.057feb7a@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <918290dc-59c3-f269-38d4-a07d323173f9@ozlabs.ru>
Date: Fri, 19 Oct 2018 11:53:53 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018120502.057feb7a@w520.home>
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
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 19/10/2018 05:05, Alex Williamson wrote:
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
>>>>>>>>   		}  
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

It is in the device tree (phandle is a node ID).

NPU:
xscom@623fc00000000/npu@5011000

NVLinks:
xscom@623fc00000000/npu@5011000/link@0
xscom@623fc00000000/npu@5011000/link@1
xscom@623fc00000000/npu@5011000/link@2
xscom@623fc00000000/npu@5011000/link@3
xscom@623fc00000000/npu@5011000/link@5
xscom@623fc00000000/npu@5011000/link@6

GPU RAM:
memory@240000000000
memory@242000000000
memory@244000000000

GPUs:
pciex@620c3c0500000/pci@0/pci@0/pci@4/3d-controller@0
	ibm,npu property - 2 phandles of associated virtual
		bridges as in my config a GPU has 2 NVLinks
		to the CPU (or NPU in particular)
pciex@620c3c0500000/pci@0/pci@0/pci@5/3d-controller@0
pciex@620c3c0500000/pci@0/pci@0/pci@d/3d-controller@0

Virtual bridges:
pciex@6230200000000/pci@0
	ibm,gpu property - a phandle of associated GPU
	memory-region property - a phandle of a GPU RAM block
	ibm,nvlink property - a phandle of an NVLink
	ibm,device-tgt-addr property - the short physical
		address of a GPU RAM (0x00000c00.00000000
		in this example)
pciex@6230200000000/pci@0,1
pciex@6230200000000/pci@1
pciex@6230200000000/pci@1,1
pciex@6230200000000/pci@2
pciex@6230200000000/pci@2,1


-- 
Alexey
