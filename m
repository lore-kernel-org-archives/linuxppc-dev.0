Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpQ5m6vkQzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:55:08 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 20:55:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C15EB2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:55:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IAstqM37748808
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:55:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IAsUw9009776
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:54:31 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, corbet@lwn.net, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 eric.auger@linaro.org, will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
 alistair@popple.id.au, ruscur@russell.cc,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 00/10] vfio-pci: Allow to mmap sub-page MMIO BARs and MSI-X
 table
Date: Mon, 18 Apr 2016 18:53:36 +0800
Message-Id: <1460976816-29294-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vfio-pci implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs and MSI-X table. This is because
sub-page BARs' mmio page may be shared with other BARs and MSI-X table
should not be accessed directly from the guest for security reasons.

But it will easily cause some performance issues for mmio accesses
in guest when vfio passthrough sub-page BARs or BARs containing MSI-X
table on PPC64 platform. This is because PAGE_SIZE is 64KB by default
on PPC64 platform and the big page may easily hit the sub-page MMIO
BARs' unmmapping and cause the unmmaping of the mmio page which
MSI-X table locate in, which lead to mmio emulation in host.

For sub-page MMIO BARs' unmmapping, this patchset modifies
resource_alignment kernel parameter to enforce the alignment of all 
MMIO BARs to be at least PAGE_SZIE so that sub-page BAR's mmio page
will not be shared with other BARs. And we also add shadow resources
to the vfio device and put them into the holes of mmio pages in case
that hot-add device's BARs are assigned into the holes. Then we can 
mmap sub-page MMIO BARs safely.

For MSI-X table's unmmapping, we think MSI-X table is safe to access
directly from userspace if hardware supports the capability of  
interrupt remapping which can ensure that a given pci device can 
only shoot the MSIs assigned for it. But the implenmentation of  
this capability is arch-independent. To have a universal way 
to test this capability on PCI side for different archs, we introduce
a new bus_flags PCI_BUS_FLAGS_MSI_REMAP.

With this patchset applied, we can get almost 100% improvement on
performance for small block 4k random read when we passthrough a FC
HBA containing sub-page BARs and MSI-X BARs to guest on PPC64 in
our test.

The patch 8 are based on the proposed patchset[2].

Changelog v6: 
- Rebase on vfio/next with patchset[2] applied
- Fix some bugs of v5
- Add three patches to make PCI_BUS_FLAGS_MSI_REMAP as
  a universal flag to test IRQ remapping

Changelog v5:
- Rebase on vfio/next
- Change the order of patch 1,2,3
- Move the warning "resource_alignment will not work with
  PCI_PROBE_ONLY set" from documentation to kernel log
- Remove IORESOURCE_WINDOW
- Add description for parameter "resize"
- Add PCIBIOS_MIN_ALIGNMENT to force all MMIO BARs to
  get minimum alignment
- Add shadow resources to make sure sub-page BAR's mmio
  page will not be shared with hot-add BARs.
- Add a new bit to pci_bus_flags to indicate the capbility
  of interrupt remapping on PPC64
- Remove IOMMU_CAP_INTR_REMAP on PPC64
- Add a property msi_remap to vfio_pci_device to cache the
  capbility of interrupt remapping

Changelog v4:
- Rebase on v4.5-rc6 with patchset[1] applied.
- Remove resource_page_aligned kernel parameter
- Fix some problems with resource_alignment kernel parameter
- Modify resource_alignment kernel parameter to support multiple
  devices.
- Remove host bridge attribute: msi_filtered
- Use IOMMU_CAP_INTR_REMAP to check if MSI-X table can be mmapped
- Add IOMMU_CAP_INTR_REMAP for IODA host bridge on PPC64 platform

Changelog v3:
- Rebase on new linux kernel mainline with the patchset[1] applied.
- Add a function to check whether PCI BARs'mmio page is shared with
  other BARs.
- Add a host bridge attribute to indicate PCI host bridge support
  filtering of MSIs.
- Use the new host bridge attribute to check if MSI-X table can
  be mmapped instead of CONFIG_EEH.
- Remove Kconfig option VFIO_PCI_MMAP_MSIX

Changelog v2:
- Rebase on v4.4-rc6 with the patchset[1] applied.
- Use kernel parameter to enforce all MMIO BARs to be page aligned
  on PCI core code instead of doing it on PPC64 arch code.
- Remove flags: VFIO_DEVICE_FLAGS_PCI_PAGE_ALIGNED

[1] http://www.spinics.net/lists/kvm/msg127812.html
[2] http://www.spinics.net/lists/kvm/msg130256.html

Yongji Xie (10):
  PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
  PCI: Do not Use IORESOURCE_STARTALIGN to identify bridge resources
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Add support for enforcing all MMIO BARs to be page aligned
  vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio page is exclusive
  PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
  iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller supports IRQ remapping
  pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
  vfio-pci: Allow to mmap MSI-X table if interrupt remapping is supported

 Documentation/kernel-parameters.txt       |    7 +-
 arch/powerpc/include/asm/pci.h            |    2 +
 arch/powerpc/platforms/powernv/pci-ioda.c |    8 +++
 drivers/iommu/iommu.c                     |   15 +++++
 drivers/pci/msi.c                         |   12 ++++
 drivers/pci/pci.c                         |  105 +++++++++++++++++++++++------
 drivers/pci/probe.c                       |    3 +
 drivers/pci/setup-bus.c                   |    9 ++-
 drivers/vfio/pci/vfio_pci.c               |   65 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_private.h       |    8 +++
 drivers/vfio/pci/vfio_pci_rdwr.c          |    3 +-
 include/linux/msi.h                       |    6 +-
 include/linux/pci.h                       |    1 +
 13 files changed, 208 insertions(+), 36 deletions(-)

-- 
1.7.9.5
