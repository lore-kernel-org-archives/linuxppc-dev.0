Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL70W4B14zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 23:11:39 +1000 (AEST)
Date: Thu, 2 Jun 2016 07:11:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: Re: [RESEND PATCH v2 0/6] vfio-pci: Add support for mmapping MSI-X
 table
Message-ID: <20160602071132.273c64c7@ul30vt.home>
In-Reply-To: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


AFAICT, you posted this *3* days ago, has something changed here or is
this just expedited nagging for review?  This also depends on a
non-upstream series and crosses multiple functional areas, all of which
make it difficult for maintainers to actually do anything with this
series.  Thanks,

Alex

On Thu,  2 Jun 2016 14:09:57 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

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
