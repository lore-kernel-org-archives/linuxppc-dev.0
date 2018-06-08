Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4128F40NtgzF363
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 14:14:31 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id j20-v6so5944783pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 21:14:31 -0700 (PDT)
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA Tesla
 V100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm-ppc@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607110409.5057ebac@w520.home>
 <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
 <20180607161541.21df6434@w520.home>
 <f0561258-698c-9086-255d-ff6c1aa16cfd@ozlabs.ru>
 <20180607214455.51ecfa1a@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ff6de203-9287-8158-f0fb-ee9146245bea@ozlabs.ru>
Date: Fri, 8 Jun 2018 14:14:23 +1000
MIME-Version: 1.0
In-Reply-To: <20180607214455.51ecfa1a@w520.home>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/6/18 1:44 pm, Alex Williamson wrote:
> On Fri, 8 Jun 2018 13:08:54 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 8/6/18 8:15 am, Alex Williamson wrote:
>>> On Fri, 08 Jun 2018 07:54:02 +1000
>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>>   
>>>> On Thu, 2018-06-07 at 11:04 -0600, Alex Williamson wrote:  
>>>>>
>>>>> Can we back up and discuss whether the IOMMU grouping of NVLink
>>>>> connected devices makes sense?  AIUI we have a PCI view of these
>>>>> devices and from that perspective they're isolated.  That's the view of
>>>>> the device used to generate the grouping.  However, not visible to us,
>>>>> these devices are interconnected via NVLink.  What isolation properties
>>>>> does NVLink provide given that its entire purpose for existing seems to
>>>>> be to provide a high performance link for p2p between devices?    
>>>>
>>>> Not entire. On POWER chips, we also have an nvlink between the device
>>>> and the CPU which is running significantly faster than PCIe.
>>>>
>>>> But yes, there are cross-links and those should probably be accounted
>>>> for in the grouping.  
>>>
>>> Then after we fix the grouping, can we just let the host driver manage
>>> this coherent memory range and expose vGPUs to guests?  The use case of
>>> assigning all 6 GPUs to one VM seems pretty limited.  (Might need to
>>> convince NVIDIA to support more than a single vGPU per VM though)  
>>
>> These are physical GPUs, not virtual sriov-alike things they are
>> implementing as well elsewhere.
> 
> vGPUs as implemented on M- and P-series Teslas aren't SR-IOV like
> either.  That's why we have mdev devices now to implement software
> defined devices.  I don't have first hand experience with V-series, but
> I would absolutely expect a PCIe-based Tesla V100 to support vGPU.

So assuming V100 can do vGPU, you are suggesting ditching this patchset and
using mediated vGPUs instead, correct?


>> My current understanding is that every P9 chip in that box has some NVLink2
>> logic on it so each P9 is directly connected to 3 GPUs via PCIe and
>> 2xNVLink2, and GPUs in that big group are interconnected by NVLink2 links
>> as well.
>>
>> From small bits of information I have it seems that a GPU can perfectly
>> work alone and if the NVIDIA driver does not see these interconnects
>> (because we do not pass the rest of the big 3xGPU group to this guest), it
>> continues with a single GPU. There is an "nvidia-smi -r" big reset hammer
>> which simply refuses to work until all 3 GPUs are passed so there is some
>> distinction between passing 1 or 3 GPUs, and I am trying (as we speak) to
>> get a confirmation from NVIDIA that it is ok to pass just a single GPU.
>>
>> So we will either have 6 groups (one per GPU) or 2 groups (one per
>> interconnected group).
> 
> I'm not gaining much confidence that we can rely on isolation between
> NVLink connected GPUs, it sounds like you're simply expecting that
> proprietary code from NVIDIA on a proprietary interconnect from NVIDIA
> is going to play nice and nobody will figure out how to do bad things
> because... obfuscation?  Thanks,

Well, we already believe that a proprietary firmware of a sriov-capable
adapter like Mellanox ConnextX is not doing bad things, how is this
different in principle?


ps. their obfuscation is funny indeed :)
-- 
Alexey
