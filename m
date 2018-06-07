Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411zpM1ng2zF343
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 07:54:18 +1000 (AEST)
Message-ID: <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA
 Tesla V100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm-ppc@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
Date: Fri, 08 Jun 2018 07:54:02 +1000
In-Reply-To: <20180607110409.5057ebac@w520.home>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607110409.5057ebac@w520.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-07 at 11:04 -0600, Alex Williamson wrote:
> 
> Can we back up and discuss whether the IOMMU grouping of NVLink
> connected devices makes sense?  AIUI we have a PCI view of these
> devices and from that perspective they're isolated.  That's the view of
> the device used to generate the grouping.  However, not visible to us,
> these devices are interconnected via NVLink.  What isolation properties
> does NVLink provide given that its entire purpose for existing seems to
> be to provide a high performance link for p2p between devices?

Not entire. On POWER chips, we also have an nvlink between the device
and the CPU which is running significantly faster than PCIe.

But yes, there are cross-links and those should probably be accounted
for in the grouping.

> > Each bridge represents an additional hardware interface called "NVLink2",
> > it is not a PCI link but separate but. The design inherits from original
> > NVLink from POWER8.
> > 
> > The new feature of V100 is 16GB of cache coherent memory on GPU board.
> > This memory is presented to the host via the device tree and remains offline
> > until the NVIDIA driver loads, trains NVLink2 (via the config space of these
> > bridges above) and the nvidia-persistenced daemon then onlines it.
> > The memory remains online as long as nvidia-persistenced is running, when
> > it stops, it offlines the memory.
> > 
> > The amount of GPUs suggest passing them through to a guest. However,
> > in order to do so we cannot use the NVIDIA driver so we have a host with
> > a 128GB window (bigger or equal to actual GPU RAM size) in a system memory
> > with no page structs backing this window and we cannot touch this memory
> > before the NVIDIA driver configures it in a host or a guest as
> > HMI (hardware management interrupt?) occurs.
> 
> Having a lot of GPUs only suggests assignment to a guest if there's
> actually isolation provided between those GPUs.  Otherwise we'd need to
> assign them as one big group, which gets a lot less useful.  Thanks,
> 
> Alex
> 
> > On the example system the GPU RAM windows are located at:
> > 0x0400 0000 0000
> > 0x0420 0000 0000
> > 0x0440 0000 0000
> > 0x2400 0000 0000
> > 0x2420 0000 0000
> > 0x2440 0000 0000
> > 
> > So the complications are:
> > 
> > 1. cannot touch the GPU memory till it is trained, i.e. cannot add ptes
> > to VFIO-to-userspace or guest-to-host-physical translations till
> > the driver trains it (i.e. nvidia-persistenced has started), otherwise
> > prefetching happens and HMI occurs; I am trying to get this changed
> > somehow;
> > 
> > 2. since it appears as normal cache coherent memory, it will be used
> > for DMA which means it has to be pinned and mapped in the host. Having
> > no page structs makes it different from the usual case - we only need
> > translate user addresses to host physical and map GPU RAM memory but
> > pinning is not required.
> > 
> > This series maps GPU RAM via the GPU vfio-pci device so QEMU can then
> > register this memory as a KVM memory slot and present memory nodes to
> > the guest. Unless NVIDIA provides an userspace driver, this is no use
> > for things like DPDK.
> > 
> > 
> > There is another problem which the series does not address but worth
> > mentioning - it is not strictly necessary to map GPU RAM to the guest
> > exactly where it is in the host (I tested this to some extent), we still
> > might want to represent the memory at the same offset as on the host
> > which increases the size of a TCE table needed to cover such a huge
> > window: (((0x244000000000 + 0x2000000000) >> 16)*8)>>20 = 4556MB
> > I am addressing this in a separate patchset by allocating indirect TCE
> > levels on demand and using 16MB IOMMU pages in the guest as we can now
> > back emulated pages with the smaller hardware ones.
> > 
> > 
> > This is an RFC. Please comment. Thanks.
> > 
> > 
> > 
> > Alexey Kardashevskiy (5):
> >   vfio/spapr_tce: Simplify page contained test
> >   powerpc/iommu_context: Change referencing in API
> >   powerpc/iommu: Do not pin memory of a memory device
> >   vfio_pci: Allow mapping extra regions
> >   vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] [10de:1db1] subdriver
> > 
> >  drivers/vfio/pci/Makefile              |   1 +
> >  arch/powerpc/include/asm/mmu_context.h |   5 +-
> >  drivers/vfio/pci/vfio_pci_private.h    |  11 ++
> >  include/uapi/linux/vfio.h              |   3 +
> >  arch/powerpc/kernel/iommu.c            |   8 +-
> >  arch/powerpc/mm/mmu_context_iommu.c    |  70 +++++++++---
> >  drivers/vfio/pci/vfio_pci.c            |  19 +++-
> >  drivers/vfio/pci/vfio_pci_nvlink2.c    | 190 +++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_iommu_spapr_tce.c    |  42 +++++---
> >  drivers/vfio/pci/Kconfig               |   4 +
> >  10 files changed, 319 insertions(+), 34 deletions(-)
> >  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
> > 
