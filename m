Return-Path: <jike.song@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWZPk6m33zDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 11:19:05 +1000 (AEST)
Message-ID: <59924B85.5040405@intel.com>
Date: Tue, 15 Aug 2017 09:16:53 +0800
From: Jike Song <jike.song@intel.com>
MIME-Version: 1.0
To: Robin Murphy <robin.murphy@arm.com>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
In-Reply-To: <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/14/2017 09:12 PM, Robin Murphy wrote:
> On 14/08/17 10:45, Alexey Kardashevskiy wrote:
>> Folks,
>>
>> Is there anything to change besides those compiler errors and David's
>> comment in 5/5? Or the while patchset is too bad? Thanks.
> 
> While I now understand it's not the low-level thing I first thought it
> was, so my reasoning has changed, personally I don't like this approach
> any more than the previous one - it still smells of abusing external
> APIs to pass information from one part of VFIO to another (and it has
> the same conceptual problem of attributing something to interrupt
> sources that is actually a property of the interrupt target).
> 
> Taking a step back, though, why does vfio-pci perform this check in the
> first place? If a malicious guest already has control of a device, any
> kind of interrupt spoofing it could do by fiddling with the MSI-X
> message address/data it could simply do with a DMA write anyway, so the
> security argument doesn't stand up in general (sure, not all PCIe
> devices may be capable of arbitrary DMA, but that seems like more of a
> tenuous security-by-obscurity angle to me).

Hi Robin,

DMA writes will be translated (thereby censored) by DMA Remapping hardware,
while MSI/MSI-X will not. Is this different for non-x86?

--
Thanks,
Jike

> Besides, with Type1 IOMMU
> the fact that we've let a device be assigned at all means that this is
> already a non-issue (because either the hardware provides isolation or
> the user has explicitly accepted the consequences of an unsafe
> configuration) - from patch #4 that's apparently the same for SPAPR TCE,
> in which case it seems this flag doesn't even need to be propagated and
> could simply be assumed always.
> 
> On the other hand, if the check is not so much to mitigate malicious
> guests attacking the system as to prevent dumb guests breaking
> themselves (e.g. if some or all of the MSI-X capability is actually
> emulated), then allowing things to sometimes go wrong on the grounds of
> an irrelevant hardware feature doesn't seem correct :/
> 
> Robin.
> 
>> On 07/08/17 17:25, Alexey Kardashevskiy wrote:
>>> This is a followup for "[PATCH kernel v4 0/6] vfio-pci: Add support for mmapping MSI-X table"
>>> http://www.spinics.net/lists/kvm/msg152232.html
>>>
>>> This time it is using "caps" in IOMMU groups. The main question is if PCI
>>> bus flags or IOMMU domains are still better (and which one).
>>
>>>
>>>
>>>
>>> Here is some background:
>>>
>>> Current vfio-pci implementation disallows to mmap the page
>>> containing MSI-X table in case that users can write directly
>>> to MSI-X table and generate an incorrect MSIs.
>>>
>>> However, this will cause some performance issue when there
>>> are some critical device registers in the same page as the
>>> MSI-X table. We have to handle the mmio access to these
>>> registers in QEMU emulation rather than in guest.
>>>
>>> To solve this issue, this series allows to expose MSI-X table
>>> to userspace when hardware enables the capability of interrupt
>>> remapping which can ensure that a given PCI device can only
>>> shoot the MSIs assigned for it. And we introduce a new bus_flags
>>> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
>>> for different archs.
>>>
>>>
>>> This is based on sha1
>>> 26c5cebfdb6c "Merge branch 'parisc-4.13-4' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux"
>>>
>>> Please comment. Thanks.
>>>
>>> Changelog:
>>>
>>> v5:
>>> * redid the whole thing via so-called IOMMU group capabilities
>>>
>>> v4:
>>> * rebased on recent upstream
>>> * got all 6 patches from v2 (v3 was missing some)
>>>
>>>
>>>
>>>
>>> Alexey Kardashevskiy (5):
>>>   iommu: Add capabilities to a group
>>>   iommu: Set IOMMU_GROUP_CAP_ISOLATE_MSIX if MSI controller enables IRQ
>>>     remapping
>>>   iommu/intel/amd: Set IOMMU_GROUP_CAP_ISOLATE_MSIX if IRQ remapping is
>>>     enabled
>>>   powerpc/iommu: Set IOMMU_GROUP_CAP_ISOLATE_MSIX
>>>   vfio-pci: Allow to expose MSI-X table to userspace when safe
>>>
>>>  include/linux/iommu.h            | 20 ++++++++++++++++++++
>>>  include/linux/vfio.h             |  1 +
>>>  arch/powerpc/kernel/iommu.c      |  1 +
>>>  drivers/iommu/amd_iommu.c        |  3 +++
>>>  drivers/iommu/intel-iommu.c      |  3 +++
>>>  drivers/iommu/iommu.c            | 35 +++++++++++++++++++++++++++++++++++
>>>  drivers/vfio/pci/vfio_pci.c      | 20 +++++++++++++++++---
>>>  drivers/vfio/pci/vfio_pci_rdwr.c |  5 ++++-
>>>  drivers/vfio/vfio.c              | 15 +++++++++++++++
>>>  9 files changed, 99 insertions(+), 4 deletions(-)
>>>
>>
>>
> 
