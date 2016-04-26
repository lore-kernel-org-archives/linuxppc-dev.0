Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvTPM4ZVczDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 02:41:11 +1000 (AEST)
Date: Tue, 26 Apr 2016 10:40:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
 bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org, corbet@lwn.net,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc
Subject: Re: [RFC v6 00/10] vfio-pci: Allow to mmap sub-page MMIO BARs and
 MSI-X table
Message-ID: <20160426104058.250c7e61@t450s.home>
In-Reply-To: <571DEC01.5040802@linux.vnet.ibm.com>
References: <1460976816-29294-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <571DEC01.5040802@linux.vnet.ibm.com>
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

On Mon, 25 Apr 2016 18:05:53 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> Hi Alex,
> 
> Any comment?

TBH, I shuffled this to the bottom of the review pile because you're
depending on a patch series for ARM MSI mapping that's still very much
in flux.  You've really got 3 or 4 separate patch series here that
should be separated so they can be sent as non-RFC and you can start
making progress.  For instance, patches 1-4 are PCI-core enabling
PAGE_SIZE aligned BARs, patch 5 discovers PAGE_SIZE aligned BARs and
enables mmapping them through vfio.  Now that you're using shadow
resources to attempt to reserve the remainder of the page in patch 5,
doesn't that make it independent of patches 1-4?  These could be sent
as separate series in parallel.  Patches 6-9 are another separate
series, but here you start to depend on the changes happening with ARM
MSI mapping to determine whether we have real interrupt isolation. Once
that gets settled, patch 10 becomes a much less controversial follow-on
patch.  Thanks,

Alex

> On 2016/4/18 18:53, Yongji Xie wrote:
> > Current vfio-pci implementation disallows to mmap
> > sub-page(size < PAGE_SIZE) MMIO BARs and MSI-X table. This is because
> > sub-page BARs' mmio page may be shared with other BARs and MSI-X table
> > should not be accessed directly from the guest for security reasons.
> >
> > But it will easily cause some performance issues for mmio accesses
> > in guest when vfio passthrough sub-page BARs or BARs containing MSI-X
> > table on PPC64 platform. This is because PAGE_SIZE is 64KB by default
> > on PPC64 platform and the big page may easily hit the sub-page MMIO
> > BARs' unmmapping and cause the unmmaping of the mmio page which
> > MSI-X table locate in, which lead to mmio emulation in host.
> >
> > For sub-page MMIO BARs' unmmapping, this patchset modifies
> > resource_alignment kernel parameter to enforce the alignment of all
> > MMIO BARs to be at least PAGE_SZIE so that sub-page BAR's mmio page
> > will not be shared with other BARs. And we also add shadow resources
> > to the vfio device and put them into the holes of mmio pages in case
> > that hot-add device's BARs are assigned into the holes. Then we can
> > mmap sub-page MMIO BARs safely.
> >
> > For MSI-X table's unmmapping, we think MSI-X table is safe to access
> > directly from userspace if hardware supports the capability of
> > interrupt remapping which can ensure that a given pci device can
> > only shoot the MSIs assigned for it. But the implenmentation of
> > this capability is arch-independent. To have a universal way
> > to test this capability on PCI side for different archs, we introduce
> > a new bus_flags PCI_BUS_FLAGS_MSI_REMAP.
> >
> > With this patchset applied, we can get almost 100% improvement on
> > performance for small block 4k random read when we passthrough a FC
> > HBA containing sub-page BARs and MSI-X BARs to guest on PPC64 in
> > our test.
> >
> > The patch 8 are based on the proposed patchset[2].
> >
> > Changelog v6:
> > - Rebase on vfio/next with patchset[2] applied
> > - Fix some bugs of v5
> > - Add three patches to make PCI_BUS_FLAGS_MSI_REMAP as
> >    a universal flag to test IRQ remapping
> >
> > Changelog v5:
> > - Rebase on vfio/next
> > - Change the order of patch 1,2,3
> > - Move the warning "resource_alignment will not work with
> >    PCI_PROBE_ONLY set" from documentation to kernel log
> > - Remove IORESOURCE_WINDOW
> > - Add description for parameter "resize"
> > - Add PCIBIOS_MIN_ALIGNMENT to force all MMIO BARs to
> >    get minimum alignment
> > - Add shadow resources to make sure sub-page BAR's mmio
> >    page will not be shared with hot-add BARs.
> > - Add a new bit to pci_bus_flags to indicate the capbility
> >    of interrupt remapping on PPC64
> > - Remove IOMMU_CAP_INTR_REMAP on PPC64
> > - Add a property msi_remap to vfio_pci_device to cache the
> >    capbility of interrupt remapping
> >
> > Changelog v4:
> > - Rebase on v4.5-rc6 with patchset[1] applied.
> > - Remove resource_page_aligned kernel parameter
> > - Fix some problems with resource_alignment kernel parameter
> > - Modify resource_alignment kernel parameter to support multiple
> >    devices.
> > - Remove host bridge attribute: msi_filtered
> > - Use IOMMU_CAP_INTR_REMAP to check if MSI-X table can be mmapped
> > - Add IOMMU_CAP_INTR_REMAP for IODA host bridge on PPC64 platform
> >
> > Changelog v3:
> > - Rebase on new linux kernel mainline with the patchset[1] applied.
> > - Add a function to check whether PCI BARs'mmio page is shared with
> >    other BARs.
> > - Add a host bridge attribute to indicate PCI host bridge support
> >    filtering of MSIs.
> > - Use the new host bridge attribute to check if MSI-X table can
> >    be mmapped instead of CONFIG_EEH.
> > - Remove Kconfig option VFIO_PCI_MMAP_MSIX
> >
> > Changelog v2:
> > - Rebase on v4.4-rc6 with the patchset[1] applied.
> > - Use kernel parameter to enforce all MMIO BARs to be page aligned
> >    on PCI core code instead of doing it on PPC64 arch code.
> > - Remove flags: VFIO_DEVICE_FLAGS_PCI_PAGE_ALIGNED
> >
> > [1] http://www.spinics.net/lists/kvm/msg127812.html
> > [2] http://www.spinics.net/lists/kvm/msg130256.html
> >
> > Yongji Xie (10):
> >    PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
> >    PCI: Do not Use IORESOURCE_STARTALIGN to identify bridge resources
> >    PCI: Add a new option for resource_alignment to reassign alignment
> >    PCI: Add support for enforcing all MMIO BARs to be page aligned
> >    vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio page is exclusive
> >    PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
> >    iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
> >    PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller supports IRQ remapping
> >    pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
> >    vfio-pci: Allow to mmap MSI-X table if interrupt remapping is supported
> >
> >   Documentation/kernel-parameters.txt       |    7 +-
> >   arch/powerpc/include/asm/pci.h            |    2 +
> >   arch/powerpc/platforms/powernv/pci-ioda.c |    8 +++
> >   drivers/iommu/iommu.c                     |   15 +++++
> >   drivers/pci/msi.c                         |   12 ++++
> >   drivers/pci/pci.c                         |  105 +++++++++++++++++++++++------
> >   drivers/pci/probe.c                       |    3 +
> >   drivers/pci/setup-bus.c                   |    9 ++-
> >   drivers/vfio/pci/vfio_pci.c               |   65 +++++++++++++++---
> >   drivers/vfio/pci/vfio_pci_private.h       |    8 +++
> >   drivers/vfio/pci/vfio_pci_rdwr.c          |    3 +-
> >   include/linux/msi.h                       |    6 +-
> >   include/linux/pci.h                       |    1 +
> >   13 files changed, 208 insertions(+), 36 deletions(-)
> >  
> 
