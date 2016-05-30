Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJHjd4wlyzDqcn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:37:25 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UDY4Ad016621
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:37:23 -0400
Message-Id: <201605301337.u4UDY4Ad016621@mx0a-001b2d01.pphosted.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238j3yprx0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:37:23 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 30 May 2016 23:37:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C463C3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:37:18 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UDbA7G1769982
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:37:18 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UDajVn001656
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:36:46 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 0/6] vfio-pci: Add support for mmapping MSI-X table
Date: Mon, 30 May 2016 21:32:07 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vfio-pci implementation disallows to mmap the page
containing MSI-X table in case that users can write directly
to MSI-X table and generate an incorrect MSIs.

However, this will cause some performance issue when there
are some critical device registers in the same page as the 
MSI-X table. We have to handle the mmio access to these
registers in QEMU emulation rather than in guest.

To solve this issue, this series allows to expose MSI-X table
to userspace when hardware enables the capability of interrupt
remapping which can ensure that a given PCI device can only
shoot the MSIs assigned for it. And we introduce a new bus_flags
PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
for different archs.

The patch 3 are based on the proposed patchset[1].

Changelog v2: 
- Make the commit log more clear
- Replace pci_bus_check_msi_remapping() with pci_bus_msi_isolated()
  so that we could clearly know what the function does
- Set PCI_BUS_FLAGS_MSI_REMAP in pci_create_root_bus() instead
  of iommu_bus_notifier()
- Reserve VFIO_REGION_INFO_FLAG_CAPS when we allow to mmap MSI-X
  table so that we can know whether we allow to mmap MSI-X table
  in QEMU

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Yongji Xie (6):
  PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller enables IRQ remapping
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
  iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu driver initialization
  pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
  vfio-pci: Allow to expose MSI-X table to userspace if interrupt remapping is enabled

 arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
 drivers/iommu/iommu.c                     |    8 ++++++++
 drivers/pci/msi.c                         |   15 +++++++++++++++
 drivers/pci/probe.c                       |    7 +++++++
 drivers/vfio/pci/vfio_pci.c               |   17 ++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c          |    3 ++-
 include/linux/msi.h                       |    5 ++++-
 include/linux/pci.h                       |    1 +
 8 files changed, 59 insertions(+), 5 deletions(-)

-- 
1.7.9.5
