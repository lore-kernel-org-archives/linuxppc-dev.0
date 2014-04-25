Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F081014135E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 19:26:13 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 00/13] Refactor pci_is_brdige() to simplify code
Date: Fri, 25 Apr 2014 17:18:22 +0800
Message-ID: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset rename the current pci_is_bridge() to pci_has_subordinate(), 
and introduce a new pci_is_bridge() which determine pci bridge by check
dev->hdr_type. The new one is more accurate. PCIe Spec define the pci
device is a bridge by the dev->hdr_type = 0x01 || 0x02.

Yijing Wang (13):
  PCI: rename pci_is_bridge() to pci_has_subordinate()
  PCI: Introduce new pci_is_bridge() helper function
  PCI: Use new pci_is_bridge() to simplify code
  x86/PCI: Use new pci_is_bridge() to simplify code
  IA64/PCI: Use new pci_is_bridge() to simplify code
  powerpc/PCI: Use new pci_is_bridge() to simplify code
  sparc/PCI: Use new pci_is_bridge() to simplify code
  PCI, rpaphp: Use new pci_is_bridge() to simplify code
  PCI, shpchp: Use new pci_is_bridge() to simplify code
  PCI, cpcihp: Use new pci_is_bridge() to simplify code
  PCI, acpiphp: Use new pci_is_bridge() to simplify code
  PCI, pcmcia: Use new pci_is_bridge() to simplify code
  PCI, pciehp: Use new pci_is_bridge() to simplify code

 arch/ia64/pci/fixup.c                  |    4 +---
 arch/powerpc/kernel/pci-hotplug.c      |    3 +--
 arch/powerpc/kernel/pci_of_scan.c      |    3 +--
 arch/sparc/kernel/pci.c                |    3 +--
 arch/x86/pci/fixup.c                   |    4 +---
 drivers/pci/hotplug/acpiphp_glue.c     |    3 +--
 drivers/pci/hotplug/cpci_hotplug_pci.c |    3 +--
 drivers/pci/hotplug/pciehp_pci.c       |    3 +--
 drivers/pci/hotplug/rpadlpar_core.c    |    3 +--
 drivers/pci/hotplug/shpchp_pci.c       |    3 +--
 drivers/pci/pci-acpi.c                 |    8 +-------
 drivers/pci/pci-driver.c               |    8 ++++----
 drivers/pci/pci.h                      |    2 +-
 drivers/pci/probe.c                    |    3 +--
 drivers/pci/setup-bus.c                |    4 +---
 drivers/pcmcia/cardbus.c               |    3 +--
 include/linux/pci.h                    |    6 ++++++
 17 files changed, 25 insertions(+), 41 deletions(-)
