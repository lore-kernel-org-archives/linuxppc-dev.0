Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF1Vk3dTgzDqcS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 15:46:38 +1000 (AEST)
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4P5i1si003562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:46:36 -0400
Message-Id: <201605250546.u4P5i1si003562@mx0a-001b2d01.pphosted.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 234qhw7x4e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:46:35 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 25 May 2016 11:16:32 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7A4BFE0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 11:19:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P5kSxD44499040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 11:16:28 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P5kNjP001501
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 11:16:27 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160524205519.GA16463@localhost>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
 bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 alistair@popple.id.au, ruscur@russell.cc
Date: Wed, 25 May 2016 13:46:23 +0800
MIME-Version: 1.0
In-Reply-To: <20160524205519.GA16463@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/5/25 4:55, Bjorn Helgaas wrote:

> On Wed, Apr 27, 2016 at 08:43:26PM +0800, Yongji Xie wrote:
>> We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
>> which indicates all devices on the bus are protected by the
>> hardware which supports IRQ remapping(intel naming).
> This changelog is ambiguous.  It's possible that there is hardware
> that *supports* IRQ remapping, but does not actually *do* IRQ
> remapping.  For example, an IRQ remapping capability may be present
> but not enabled.
>
> I think your intent is to set this flag only when MSI remapping is
> actually *enabled* for all devices on the bus.

Yes. This is exactly my intent. Thank you for the correction!

> I'd also like to know exactly what protection is implied by
> PCI_BUS_FLAGS_MSI_REMAP and IOMMU_CAP_INTR_REMAP.  I guess it means a
> device can only generate MSIs to a certain set of CPUs?  I assume the
> remapping hardware only checks the target address, not the data being
> written?

When IRQ remapping is enabled, the hardware will check both target
address and data, then compute the interrupt_index from them.
Interrupt_index will be used to find a specific Interrupt Remapping Table
Entry containing some fields which could be used to identify a device or
a group of devices(these devices should be in the same isolation domain).
Then hardware can use this to verify the interrupt request. If the interrupt
request is not from the specific devices, it will be blocked.

So this flag indicate that the hardware can ensure that a given PCI device
can only shoot the MSIs assigned for it. When there is something wrong
with MSI in device or device driver, this can prevent all damage from it.

Regards,
Yongji
