Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvMWX31pDzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 01:17:28 +1000 (AEST)
Date: Fri, 23 Jun 2017 09:17:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yongji Xie
 <elohimes@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 0/3 REPOST] vfio-pci: Add support for mmapping
 MSI-X table
Message-ID: <20170623091723.1f122800@w520.home>
In-Reply-To: <82b2e63c-0a39-303c-f255-b857764fc412@ozlabs.ru>
References: <20170615054845.8428-1-aik@ozlabs.ru>
 <20170622151118.0006c3d3@w520.home>
 <82b2e63c-0a39-303c-f255-b857764fc412@ozlabs.ru>
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

On Fri, 23 Jun 2017 15:06:37 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 23/06/17 07:11, Alex Williamson wrote:
> > On Thu, 15 Jun 2017 15:48:42 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> Here is a patchset which Yongji was working on before
> >> leaving IBM LTC. Since we still want to have this functionality
> >> in the kernel (DPDK is the first user), here is a rebase
> >> on the current upstream.
> >>
> >>
> >> Current vfio-pci implementation disallows to mmap the page
> >> containing MSI-X table in case that users can write directly
> >> to MSI-X table and generate an incorrect MSIs.
> >>
> >> However, this will cause some performance issue when there
> >> are some critical device registers in the same page as the
> >> MSI-X table. We have to handle the mmio access to these
> >> registers in QEMU emulation rather than in guest.
> >>
> >> To solve this issue, this series allows to expose MSI-X table
> >> to userspace when hardware enables the capability of interrupt
> >> remapping which can ensure that a given PCI device can only
> >> shoot the MSIs assigned for it. And we introduce a new bus_flags
> >> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
> >> for different archs.
> >>
> >> The patch 3 are based on the proposed patchset[1].
> >>
> >> Changelog
> >> v3:
> >> - rebased on the current upstream  
> > 
> > There's something not forthcoming here, the last version I see from
> > Yongji is this one:
> > 
> > https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017245.html
> > 
> > Which was a 6-patch series where patches 2-4 tried to apply
> > PCI_BUS_FLAGS_MSI_REMAP for cases that supported other platforms.  That
> > doesn't exist here, so it's not simply a rebase.  Patch 1/ seems to
> > equate this new flag to the IOMMU capability IOMMU_CAP_INTR_REMAP, but
> > nothing is done here to match them together.  That patch also mentions
> > the work Eric has done for similar features on ARM, but again those
> > patches are dropped.  It seems like an incomplete feature now.  Thanks,  
> 
> 
> Thanks! I suspected this is not the latest but could not find anything
> better than we use internally for tests, and I could not reach Yongji for
> comments whether this was the latest update.
> 
> As I am reading the patches, I notice that the "msi remap" term is used all
> over the place. While this remapping capability may be the case for x86/arm
> (and therefore the IOMMU_CAP_INTR_REMAP flag makes sense), powernv does not
> do remapping but provides hardware isolation. When we are allowing MSIX BAR
> mapping to the userspace - the isolation is what we really care about. Will
> it make sense to rename PCI_BUS_FLAGS_MSI_REMAP to
> PCI_BUS_FLAGS_MSI_ISOLATED ?

I don't have a strong opinion either way, so long as it's fully
described what the flag indicates.

> Another thing - the patchset enables PCI_BUS_FLAGS_MSI_REMAP when IOMMU
> just advertises IOMMU_CAP_INTR_REMAP, not necessarily uses it, should the
> patchset actually look at something like irq_remapping_enabled in
> drivers/iommu/amd_iommu.c instead?

Interrupt remapping being enabled is implicit in IOMMU_CAP_INTR_REMAP,
neither intel or amd iommu export the capability unless enabled.
Nobody cares if it's supported but not enabled.  Thanks,

Alex

> >> v2:
> >> - Make the commit log more clear
> >> - Replace pci_bus_check_msi_remapping() with pci_bus_msi_isolated()
> >>   so that we could clearly know what the function does
> >> - Set PCI_BUS_FLAGS_MSI_REMAP in pci_create_root_bus() instead
> >>   of iommu_bus_notifier()
> >> - Reserve VFIO_REGION_INFO_FLAG_CAPS when we allow to mmap MSI-X
> >>   table so that we can know whether we allow to mmap MSI-X table
> >>   in QEMU
> >>
> >> [1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html
> >>
> >>
> >> This is based on sha1
> >> 63f700aab4c1 Linus Torvalds "Merge tag 'xtensa-20170612' of git://github.com/jcmvbkbc/linux-xtensa".
> >>
> >> Please comment. Thanks.
> >>
> >>
> >>
> >> Yongji Xie (3):
> >>   PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
> >>   pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
> >>   vfio-pci: Allow to expose MSI-X table to userspace if interrupt
> >>     remapping is enabled
> >>
> >>  include/linux/pci.h                       |  1 +
> >>  arch/powerpc/platforms/powernv/pci-ioda.c |  8 ++++++++
> >>  drivers/vfio/pci/vfio_pci.c               | 18 +++++++++++++++---
> >>  drivers/vfio/pci/vfio_pci_rdwr.c          |  3 ++-
> >>  4 files changed, 26 insertions(+), 4 deletions(-)
> >>  
> >   
> 
> 
