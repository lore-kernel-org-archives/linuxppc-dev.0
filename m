Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by lists.ozlabs.org (Postfix) with ESMTP id ACD0F1A00DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 23:09:33 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add pci_enable_msi_partial() to conserve MSI-related
 resources
Date: Tue, 10 Jun 2014 15:10:29 +0200
Message-Id: <cover.1402405331.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alexander Gordeev <agordeev@redhat.com>, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new pci_enable_msi_partial() interface and use it to
conserve on othewise wasted interrupt resources.

AHCI driver is the first user which would conserve on
10 out of 16 unused MSI vectors on some Intel chipsets.

Cc: linux-doc@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-ide@vger.kernel.org
Cc: linux-pci@vger.kernel.org

Alexander Gordeev (3):
  PCI/MSI: Add pci_enable_msi_partial()
  PCI/MSI/x86: Support pci_enable_msi_partial()
  AHCI: Use pci_enable_msi_partial() to conserve on 10/16 MSIs

 Documentation/PCI/MSI-HOWTO.txt |   36 ++++++++++++++--
 arch/mips/pci/msi-octeon.c      |    2 +-
 arch/powerpc/kernel/msi.c       |    4 +-
 arch/s390/pci/pci.c             |    2 +-
 arch/x86/include/asm/pci.h      |    3 +-
 arch/x86/include/asm/x86_init.h |    3 +-
 arch/x86/kernel/apic/io_apic.c  |    2 +-
 arch/x86/kernel/x86_init.c      |    4 +-
 arch/x86/pci/xen.c              |    9 +++-
 drivers/ata/ahci.c              |    4 +-
 drivers/iommu/irq_remapping.c   |   10 ++--
 drivers/pci/msi.c               |   83 ++++++++++++++++++++++++++++++++++-----
 include/linux/msi.h             |    5 +-
 include/linux/pci.h             |    3 +
 14 files changed, 134 insertions(+), 36 deletions(-)

-- 
1.7.7.6
