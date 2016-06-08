Return-Path: <eric.auger@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPgNX3mnCzDqGR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 17:41:16 +1000 (AEST)
Subject: Re: [RESEND PATCH v2 0/6] vfio-pci: Add support for mmapping MSI-X
 table
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
References: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 kevin.tian@intel.com, David.Laight@ACULAB.COM
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e03d36bb-c8ff-ec95-780e-5f625bdaf78e@redhat.com>
Date: Wed, 8 Jun 2016 09:41:05 +0200
MIME-Version: 1.0
In-Reply-To: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Yongji,

Le 02/06/2016 à 08:09, Yongji Xie a écrit :
> Current vfio-pci implementation disallows to mmap the page
> containing MSI-X table in case that users can write directly
> to MSI-X table and generate an incorrect MSIs.
> 
> However, this will cause some performance issue when there
> are some critical device registers in the same page as the 
> MSI-X table. We have to handle the mmio access to these
> registers in QEMU emulation rather than in guest.
> 
> To solve this issue, this series allows to expose MSI-X table
> to userspace when hardware enables the capability of interrupt
> remapping which can ensure that a given PCI device can only
> shoot the MSIs assigned for it. And we introduce a new bus_flags
> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
> for different archs.
> 
> The patch 3 are based on the proposed patchset[1].
You may have noticed I sent a respin of [1] yesterday:
http://www.gossamer-threads.com/lists/linux/kernel/2455187.

Unfortunately you will see I removed the patch defining the new
msi_domain_info MSI_FLAG_IRQ_REMAPPING flag you rely on in this series.
I did so because I was not using it anymore. At the beginning this was
used to detect whether the MSI assignment was safe but this
method was covering cases where the MSI controller was
upstream to the IOMMU. So now I rely on a mechanism where MSI controller
are supposed to register their MSI doorbells and tag whether it is safe.

I don't know yet how this change will be welcomed though. Depending
on reviews/discussions, might happen we revert to the previous flag.

If you need the feature you can embed the used patches in your series and
follow the review process separately. Sorry for the setback.

Best Regards

Eric
> 
> Changelog v2: 
> - Make the commit log more clear
> - Replace pci_bus_check_msi_remapping() with pci_bus_msi_isolated()
>   so that we could clearly know what the function does
> - Set PCI_BUS_FLAGS_MSI_REMAP in pci_create_root_bus() instead
>   of iommu_bus_notifier()
> - Reserve VFIO_REGION_INFO_FLAG_CAPS when we allow to mmap MSI-X
>   table so that we can know whether we allow to mmap MSI-X table
>   in QEMU
> 
> [1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html
> 
> Yongji Xie (6):
>   PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
>   PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller enables IRQ remapping
>   PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
>   iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu driver initialization
>   pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
>   vfio-pci: Allow to expose MSI-X table to userspace if interrupt remapping is enabled
> 
>  arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
>  drivers/iommu/iommu.c                     |    8 ++++++++
>  drivers/pci/msi.c                         |   15 +++++++++++++++
>  drivers/pci/probe.c                       |    7 +++++++
>  drivers/vfio/pci/vfio_pci.c               |   17 ++++++++++++++---
>  drivers/vfio/pci/vfio_pci_rdwr.c          |    3 ++-
>  include/linux/msi.h                       |    5 ++++-
>  include/linux/pci.h                       |    1 +
>  8 files changed, 59 insertions(+), 5 deletions(-)
> 
