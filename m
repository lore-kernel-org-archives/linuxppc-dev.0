Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 617ED1A0BB4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:41:11 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 00/16] Refine PCI host bridge scan interfaces
Date: Mon, 17 Nov 2014 18:21:34 +0800
Message-ID: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>, Suravee.Suthikulpanit@amd.com,
 Yijing Wang <wangyijing@huawei.com>, linux-ia64@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is based Linux 3.18-rc1 and Lorenzo Pieralisi's
arm PCI domain cleanup patches, link: 
https://patchwork.ozlabs.org/patch/407585/

Current pci scan interfaces like pci_scan_root_bus() and directly
call pci_create_root_bus()/pci_scan_child_bus() lack flexiblity.
Some platform infos like PCI domain and msi_chip have to be
associated to PCI bus by some arch specific function.
We want to make a generic pci_host_bridge, and make it hold
the platform infos or hook. Then we could eliminate the lots
of arch pci_domain_nr, also we could associate some platform 
ops something like pci_get_msi_chip(struct pci_dev *dev)
with pci_host_bridge to avoid introduce arch weak functions.

This RFC version not for all platforms, just applied the new
scan interface in x86/arm/powerpc/ia64, I will refresh other
platforms after the core pci scan interfaces are ok.

Only test in x86.

Thanks!
Yijing.

Yijing Wang (16):
  PCI: Enhance pci_scan_root_bus() to support default IO/MEM resources
  PCI: Use pci_scan_root_bus() instead of pci_scan_bus()
  PCI: Clean up pci_scan_bus()
  PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()
  PCI: Use pci_scan_root_bus() instead of pci_scan_bus_parented()
  PCI: Use u32 type to combine PCI domain and bus number
  PCI: Separate pci_host_bridge creation out of pci_create_root_bus()
  PCI: Introduce pci_scan_host_bridge() and pci_host_info
  PCI: Associate .get_msi_ctrl() with pci_host_bridge
  PCI: Add of_scan_bus() to pci_host_info
  x86/PCI: Use pci_scan_host_bridge() instead of pci_create_root_bus()
  ia64/PCI: Remove the redundant bus variable
  ia64/PCI: Use pci_scan_host_bridge() to refactor pci_acpi_scan_root()
  arm/PCI: Introduce pci_get_domain_nr()
  arm/PCI: Use pci_scan_host_bridge() instead of pci_scan_root_bus()
  powerpc/PCI: Use pci_scan_host_bridge() to scan PCI bus

 arch/alpha/include/asm/pci.h      |    2 +-
 arch/alpha/kernel/pci.c           |    1 +
 arch/alpha/kernel/sys_nautilus.c  |    3 +-
 arch/arm/include/asm/mach/pci.h   |   10 ++
 arch/arm/kernel/bios32.c          |   60 +++++++----
 arch/cris/include/asm/pci.h       |    2 +-
 arch/frv/mb93090-mb00/pci-vdk.c   |    8 +-
 arch/ia64/include/asm/pci.h       |    2 +-
 arch/ia64/pci/pci.c               |   85 +++++++--------
 arch/ia64/sn/kernel/io_init.c     |    2 +
 arch/m68k/coldfire/pci.c          |    3 +-
 arch/microblaze/pci/pci-common.c  |    2 +-
 arch/mips/include/asm/pci.h       |    2 +-
 arch/mips/pci/pci.c               |    1 +
 arch/mn10300/include/asm/pci.h    |    2 +-
 arch/mn10300/unit-asb2305/pci.c   |    7 +-
 arch/powerpc/kernel/pci-common.c  |   81 ++++++++------
 arch/s390/pci/pci.c               |    2 +-
 arch/sh/drivers/pci/pci.c         |    1 +
 arch/sh/include/asm/pci.h         |    2 +-
 arch/sparc/include/asm/pci_32.h   |    2 +-
 arch/sparc/include/asm/pci_64.h   |    2 +-
 arch/sparc/kernel/leon_pci.c      |    1 +
 arch/sparc/kernel/pcic.c          |    5 +-
 arch/tile/kernel/pci.c            |    3 +-
 arch/tile/kernel/pci_gx.c         |    3 +-
 arch/unicore32/kernel/pci.c       |    4 +-
 arch/x86/include/asm/pci.h        |    2 +-
 arch/x86/pci/acpi.c               |   65 +++++++-----
 arch/x86/pci/amd_bus.c            |    2 +-
 arch/x86/pci/common.c             |   27 ++++--
 arch/xtensa/include/asm/pci.h     |    2 +-
 arch/xtensa/kernel/pci.c          |    1 +
 drivers/parisc/dino.c             |    4 +-
 drivers/pci/host-bridge.c         |  104 ++++++++++++++++++
 drivers/pci/host/pci-xgene.c      |    2 +-
 drivers/pci/hotplug/ibmphp_core.c |    6 +-
 drivers/pci/probe.c               |  214 +++++++++++++++++++------------------
 drivers/pci/xen-pcifront.c        |    6 +-
 include/linux/pci.h               |   41 ++++++-
 include/uapi/linux/pci.h          |    3 +
 41 files changed, 497 insertions(+), 280 deletions(-)
