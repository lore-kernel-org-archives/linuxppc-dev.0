Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CF971A010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 18:49:04 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 13:19:01 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u277mxeE42467444
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 13:18:59 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u277mmso009481
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 13:18:50 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 0/7] vfio-pci: Allow to mmap sub-page MMIO BARs and
 MSI-X table
Date: Mon,  7 Mar 2016 15:48:31 +0800
Message-Id: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

But these will easily cause some performance issues for mmio accesses
in guest when vfio passthrough sub-page BARs or BARs containing MSI-X
table on PPC64 platform. This is because PAGE_SIZE is 64KB by default
on PPC64 platform and the big page may easily hit the sub-page MMIO
BARs' unmmapping and cause the unmmaping of the mmio page which
MSI-X table locate in, which lead to mmio emulation in host.

For sub-page MMIO BARs' unmmapping, this patchset modifies
resource_alignment kernel parameter to enforce the alignment of all
MMIO BARs to be at least PAGE_SZIE so that sub-page BAR's mmio page
will not be shared with other BARs. Then we can mmap sub-page MMIO BARs
in vfio-pci driver with the modified resource_alignment.

For MSI-X table's unmmapping, we think MSI-X table is safe to access
directly from userspace if PCI host bridge support filtering of MSIs
which can ensure that a given pci device can only shoot the MSIs
assigned for it. So we allow to mmap MSI-X table if
IOMMU_CAP_INTR_REMAP was set. And we add IOMMU_CAP_INTR_REMAP for
IODA host bridge on PPC64 platform.

With this patchset applied, we can get almost 100% improvement on
performance for mmio accesses when we passthrough sub-page BARs to guest
in our test.

The two vfio related patches(patch 5 and patch 6) are based on the
proposed patchset[1].

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
		VFIO_DEVICE_FLAGS_PCI_MSIX_MMAP
- Add a Kconfig option to support for mmapping MSI-X table.

[1] http://www.spinics.net/lists/kvm/msg127812.html

Yongji Xie (7):
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Use IORESOURCE_WINDOW to identify bridge resources
  PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
  PCI: Modify resource_alignment to support multiple devices
  vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio page is exclusive
  vfio-pci: Allow to mmap MSI-X table if IOMMU_CAP_INTR_REMAP was set
  powerpc/powernv/pci-ioda: Add IOMMU_CAP_INTR_REMAP for IODA host bridge

 Documentation/kernel-parameters.txt       |    9 ++-
 arch/powerpc/platforms/powernv/pci-ioda.c |   17 ++++
 drivers/pci/pci.c                         |  126 ++++++++++++++++++++++++-----
 drivers/pci/probe.c                       |    3 +-
 drivers/pci/setup-bus.c                   |   21 ++---
 drivers/vfio/pci/vfio_pci.c               |   15 +++-
 drivers/vfio/pci/vfio_pci_rdwr.c          |    4 +-
 include/linux/pci.h                       |    4 +
 8 files changed, 162 insertions(+), 37 deletions(-)

-- 
1.7.9.5
