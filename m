Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0tLm1yTYzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 21:42:40 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 5 May 2016 17:12:34 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 58A34E0062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 17:15:31 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u45BgacW21365210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:12:36 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u45BgRiI028925
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:12:30 +0530
Subject: Re: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
To: David Laight <David.Laight@ACULAB.COM>,
 "'Tian, Kevin'" <kevin.tian@intel.com>,
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
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
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
 "alistair@popple.id.au" <alistair@popple.id.au>,
 "ruscur@russell.cc" <ruscur@russell.cc>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
Date: Thu, 5 May 2016 19:42:38 +0800
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David and Kevin,

On 2016/5/5 17:54, David Laight wrote:

> From: Tian, Kevin
>> Sent: 05 May 2016 10:37
> ...
>>> Acutually, we are not aimed at accessing MSI-X table from
>>> guest. So I think it's safe to passthrough MSI-X table if we
>>> can make sure guest kernel would not touch MSI-X table in
>>> normal code path such as para-virtualized guest kernel on PPC64.
>>>
>> Then how do you prevent malicious guest kernel accessing it?
> Or a malicious guest driver for an ethernet card setting up
> the receive buffer ring to contain a single word entry that
> contains the address associated with an MSI-X interrupt and
> then using a loopback mode to cause a specific packet be
> received that writes the required word through that address.
>
> Remember the PCIe cycle for an interrupt is a normal memory write
> cycle.
>
> 	David
>

If we have enough permission to load a malicious driver or
kernel, we can easily break the guest without exposed
MSI-X table.

I think it should be safe to expose MSI-X table if we can
make sure that malicious guest driver/kernel can't use
the MSI-X table to break other guest or host. The
capability of IRQ remapping could provide this
kind of protection.

Thanks,
Yongji
