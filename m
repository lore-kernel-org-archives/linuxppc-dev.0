Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2AE1A0CCB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 17:30:27 +1000 (AEST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH Part3 v11 0/9] Remove platform pci_domain_nr()
Date: Fri, 8 May 2015 15:22:50 +0800
Message-ID: <1431069779-29346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liviu Dudau <liviu@dudau.co.uk>, linux-ia64@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-pci@vger.kernel.org,
 Yijing Wang <wangyijing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is splitted out from previous patchset
"Refine PCI scan interfaces and make generic pci host bridge".
It try to clean up all platform pci_domain_nr(), save domain
in pci_host_bridge, so we could get domain number from the
common interface.

You could pull it from https://github.com/YijingWang/linux-pci.git enumer11

Yijing Wang (9):
  PCI: Save domain in pci_host_bridge
  PCI: Move pci_bus_assign_domain_nr() declaration into
    drivers/pci/pci.h
  PCI: Remove declaration for pci_get_new_domain_nr()
  PCI: Introduce pci_host_assign_domain_nr() to assign domain
  powerpc/PCI: Rename pcibios_root_bridge_prepare() to
    pcibios_root_bus_prepare()
  PCI: Make pci_host_bridge hold sysdata in drvdata
  PCI: Create pci host bridge prior to root bus
  PCI: Remove platform specific pci_domain_nr()
  PCI: Remove pci_bus_assign_domain_nr()

 arch/alpha/include/asm/pci.h             |    2 -
 arch/alpha/kernel/pci.c                  |    4 +-
 arch/alpha/kernel/sys_nautilus.c         |    2 +-
 arch/arm/kernel/bios32.c                 |    2 +-
 arch/arm/mach-dove/pcie.c                |    2 +-
 arch/arm/mach-iop13xx/pci.c              |    4 +-
 arch/arm/mach-mv78xx0/pcie.c             |    2 +-
 arch/arm/mach-orion5x/pci.c              |    4 +-
 arch/frv/mb93090-mb00/pci-vdk.c          |    3 +-
 arch/ia64/include/asm/pci.h              |    1 -
 arch/ia64/pci/pci.c                      |    6 +-
 arch/ia64/sn/kernel/io_init.c            |    4 +-
 arch/m68k/coldfire/pci.c                 |    2 +-
 arch/microblaze/pci/pci-common.c         |   15 +----
 arch/mips/include/asm/pci.h              |    2 -
 arch/mips/pci/pci.c                      |    4 +-
 arch/mn10300/unit-asb2305/pci.c          |    3 +-
 arch/powerpc/include/asm/machdep.h       |    2 +-
 arch/powerpc/kernel/pci-common.c         |   21 ++-----
 arch/powerpc/platforms/pseries/pci.c     |    2 +-
 arch/powerpc/platforms/pseries/pseries.h |    2 +-
 arch/powerpc/platforms/pseries/setup.c   |    2 +-
 arch/s390/pci/pci.c                      |   10 +---
 arch/sh/drivers/pci/pci.c                |    4 +-
 arch/sh/include/asm/pci.h                |    2 -
 arch/sparc/kernel/leon_pci.c             |    2 +-
 arch/sparc/kernel/pci.c                  |   21 +------
 arch/sparc/kernel/pcic.c                 |    2 +-
 arch/tile/include/asm/pci.h              |    2 -
 arch/tile/kernel/pci.c                   |    4 +-
 arch/tile/kernel/pci_gx.c                |    4 +-
 arch/unicore32/kernel/pci.c              |    2 +-
 arch/x86/include/asm/pci.h               |    6 --
 arch/x86/pci/acpi.c                      |    6 +-
 arch/x86/pci/common.c                    |    2 +-
 arch/xtensa/kernel/pci.c                 |    2 +-
 drivers/parisc/dino.c                    |    2 +-
 drivers/parisc/lba_pci.c                 |    2 +-
 drivers/pci/host/pci-versatile.c         |    3 +-
 drivers/pci/host/pci-xgene.c             |    2 +-
 drivers/pci/host/pcie-designware.c       |    2 +-
 drivers/pci/host/pcie-iproc.c            |    2 +-
 drivers/pci/host/pcie-xilinx.c           |    2 +-
 drivers/pci/hotplug/ibmphp_core.c        |    2 +-
 drivers/pci/pci.c                        |   31 ++++++++--
 drivers/pci/pci.h                        |    1 +
 drivers/pci/probe.c                      |   94 +++++++++++++++++-------------
 drivers/pci/xen-pcifront.c               |    2 +-
 include/linux/pci.h                      |   27 ++-------
 49 files changed, 145 insertions(+), 187 deletions(-)
