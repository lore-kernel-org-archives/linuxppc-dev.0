Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw08427TszDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:46:28 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 22:46:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5CEB2357805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:46:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3RCjq2C13500784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:46:00 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3RCjQ1q031494
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:45:27 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 alistair@popple.id.au, ruscur@russell.cc,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Wed, 27 Apr 2016 20:43:25 +0800
Message-Id: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vfio-pci implementation disallows to mmap the page 
containing MSI-X table in case that users can write to MSI-X
table and generate an incorrect MSIs.

However, this will cause some performance issue when there
are some critical device registers in the same page as the 
MSI-X table. We have to handle the mmio access to these 
registers in QEMU emulation rather than in guest.

To solve this issue, this series allows to mmap MSI-X table 
when hardware supports the capability of interrupt remapping 
which can ensure that a given pci device can only shoot the 
MSIs assigned for it. And we introduce a new bus_flags 
PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side 
for different archs.

The patch 3 are based on the proposed patchset[1].

[1] http://www.spinics.net/lists/kvm/msg130256.html

Yongji Xie (5):
  PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
  iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller supports IRQ remapping
  pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
  vfio-pci: Allow to mmap MSI-X table if interrupt remapping is supported

 arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
 drivers/iommu/iommu.c                     |   15 +++++++++++++++
 drivers/pci/msi.c                         |   12 ++++++++++++
 drivers/pci/probe.c                       |    3 +++
 drivers/vfio/pci/vfio_pci.c               |    7 +++++--
 drivers/vfio/pci/vfio_pci_rdwr.c          |    3 ++-
 include/linux/msi.h                       |    6 +++++-
 include/linux/pci.h                       |    1 +
 8 files changed, 51 insertions(+), 4 deletions(-)

-- 
1.7.9.5
