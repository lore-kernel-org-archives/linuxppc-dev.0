Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 292F71A15E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:02:53 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 00/20] Use msi_chip to configure MSI/MSI-X in all platforms
Date: Tue, 12 Aug 2014 15:25:53 +0800
Message-ID: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Yijing Wang <wangyijing@huawei.com>, "H.
 Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is mainly to use msi_chip instead of currently weak arch functions
across all platforms. Also clean up current MSI code and make drivers support
MSI easier.  

Yijing Wang (20):
  x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()
  MSI: Clean up struct msi_chip argument
  PCI/MSI: Remove useless bus->msi assignment
  MSI: Remove the redundant irq_set_chip_data()
  MSI: Refactor struct msi_chip to become more common
  PCI/MSI: Introduce arch_get_match_msi_chip() to find the match
    msi_chip
  x86/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
  x86/xen/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
  irq_remapping/MSI: Use msi_chip instead of arch func to configure
    MSI/MSI-X
  x86/MSI: Remove unused MSI weak arch functions
  MIPS/Octeon/MSI: Use msi_chip instead of arch func to configure
    MSI/MSI-X
  MIPS/Xlp/MSI: Use msi_chip instead of arch func to configure
    MSI/MSI-X
  MIPS/xlr/MSI: Use msi_chip instead of arch func to configure
    MSI/MSI-X
  Powerpc/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
  s390/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
  arm/iop13xx/MSI: Use msi_chip instead of arch func to configure
    MSI/MSI-X
  IA64/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
  Sparc/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
  tile/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
  PCI/MSI: Clean up unused MSI arch functions

 arch/arm/mach-iop13xx/include/mach/pci.h |    2 +
 arch/arm/mach-iop13xx/iq81340mc.c        |    1 +
 arch/arm/mach-iop13xx/iq81340sc.c        |    1 +
 arch/arm/mach-iop13xx/msi.c              |   14 +++-
 arch/arm/mach-iop13xx/pci.c              |    6 ++
 arch/ia64/kernel/msi_ia64.c              |   18 +++-
 arch/mips/pci/msi-octeon.c               |   45 ++++------
 arch/mips/pci/msi-xlp.c                  |   15 +++-
 arch/mips/pci/pci-xlr.c                  |   19 +++-
 arch/powerpc/kernel/msi.c                |   23 ++++--
 arch/s390/pci/pci.c                      |   16 +++-
 arch/sparc/kernel/pci.c                  |   18 +++-
 arch/tile/kernel/pci_gx.c                |   20 +++-
 arch/x86/include/asm/pci.h               |    4 +-
 arch/x86/include/asm/x86_init.h          |    3 -
 arch/x86/kernel/apic/io_apic.c           |   35 +++++++-
 arch/x86/kernel/x86_init.c               |   34 -------
 arch/x86/pci/xen.c                       |  139 ++++++++++++++++--------------
 drivers/iommu/irq_remapping.c            |   13 ++-
 drivers/irqchip/irq-armada-370-xp.c      |   12 +--
 drivers/pci/host/pci-tegra.c             |    9 ++-
 drivers/pci/host/pcie-designware.c       |    6 +-
 drivers/pci/host/pcie-rcar.c             |    9 ++-
 drivers/pci/msi.c                        |  118 ++++++++++++--------------
 drivers/pci/probe.c                      |    1 -
 include/linux/msi.h                      |   13 ++--
 26 files changed, 338 insertions(+), 256 deletions(-)
