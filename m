Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzXx74M6RzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 17:34:19 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 3 May 2016 13:04:13 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 493E0E0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 13:07:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u437Y9Z758916994
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 13:04:09 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u437Y4gg030583
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 13:04:08 +0530
Subject: Re: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "joro@8bytes.org"
 <joro@8bytes.org>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>,
 "zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
 "nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
 "eric.auger@linaro.org" <eric.auger@linaro.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
 "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
 "alistair@popple.id.au" <alistair@popple.id.au>,
 "ruscur@russell.cc" <ruscur@russell.cc>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
Date: Tue, 3 May 2016 15:34:11 +0800
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/5/3 14:22, Tian, Kevin wrote:

>> From: Yongji Xie [mailto:xyjxie@linux.vnet.ibm.com]
>> Sent: Tuesday, May 03, 2016 2:08 PM
>>
>> On 2016/5/3 13:34, Tian, Kevin wrote:
>>
>>>> From: Yongji Xie
>>>> Sent: Wednesday, April 27, 2016 8:43 PM
>>>>
>>>> This patch enables mmapping MSI-X tables if hardware supports
>>>> interrupt remapping which can ensure that a given pci device
>>>> can only shoot the MSIs assigned for it.
>>>>
>>>> With MSI-X table mmapped, we also need to expose the
>>>> read/write interface which will be used to access MSI-X table.
>>>>
>>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>> A curious question here. Does "allow to mmap MSI-X" essentially
>>> mean that KVM guest can directly read/write physical MSI-X
>>> structure then?
>>>
>>> Thanks
>>> Kevin
>>>
>> Here we just allow to mmap MSI-X table in kernel. It doesn't
>> mean all KVM guest can directly read/write physical MSI-X
>> structure. This should be decided by QEMU. For PPC64
>> platform, we would allow to passthrough the MSI-X table
>> because we know guest kernel would not write physical
>> MSI-X structure when enabling MSI.
>>
> A bit confused here. If guest kernel doesn't need to write
> physical MSI-X structure, what's the point of passing through
> the table then?

We want to allow the MSI-X table because there may be
some critical registers in the same page as the MSI-X table.
We have to handle the mmio access to these register in QEMU
rather than in guest if mmapping MSI-X table is disallowed.

> I think the key whether MSI-X table can be passed through
> is related to where hypervisor control is deployed. At least
> for x86:
>
> - When irq remapping is not enabled, host/hypervisor needs
> to control physical interrupt message including vector/dest/etc.
> directly in MSI-X structure, so we cannot allow a guest to
> access it;
>
> - when irq remapping is enabled, host/hypervisor can control
> interrupt routing in irq remapping table. However MSI-X
> also needs to be configured as remappable format. In this
> manner we also cannot allow direct access from guest.
>
> The only sane case to pass through MSI-X structure, is a
> mechanism similar to irq remapping but w/o need to change
> original MSI-X format so direct access from guest side is
> safe. Is it the case in PPC64?
>
> Thanks
> Kevin

Acutually, we are not aimed at accessing MSI-X table from
guest. So I think it's safe to passthrough MSI-X table if we
can make sure guest kernel would not touch MSI-X table in
normal code path such as para-virtualized guest kernel on PPC64.

Thanks,
Yongji
