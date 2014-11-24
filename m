Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5156B1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:33 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 04:19:30 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8D271125804B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:19:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMpcVI65601584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:21:38 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMnRt8027172
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:19:28 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH RFCv1 0/8] PCI: Slot Support PowerPC PowerNV Platform
Date: Tue, 25 Nov 2014 09:49:17 +1100
Message-Id: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches depends on the OPAL firmware changes. Please
don't consider merging it before the OPAL firmware changes get merged!

The series of patches intends to support PCI slots for OPAL firmware
based PPC PowerNV platform. The OPAL firmware exports the capabilities
to check various statuses (e.g. Power, Presence) on the specified PCI
slot via so-called runtime OPAL APIs. Apart from that, the patchset
cleans up the coding style of RPA modules and fixes PCI slots lost
on PPC pSeries platform.

PATCH[1-3]: Necessary code changes to PPC PCI subsystem in order to
            support PCI slots for PPC PowerNV platform.
PATCH[4]  : Coding style cleanup for RPA modules.
PATCH[5]  : Fix the issue that PCI slots are missed on pSeries platform
PATCH[6-8]: PCI slots support for PPC PowerNV platform

Testing
=======
With the series of patches applied, PCI slots apears from sysfs and
hotplug can be completed accordingly on PowerPC PowerNV platform.

# cat /proc/cpuinfo | grep -i powernv
platform	: PowerNV
machine		: PowerNV 8286-41A

# pwd
/sys/bus/pci/slots
# ls
C10  C11  C12  C14  C15  C6  C7  C8  C9

# lspci -s 0003::.
0003:00:00.0 PCI bridge: IBM Device 03dc
0003:01:00.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:01.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:08.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:09.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:10.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:11.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0003:09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.2 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.3 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:0f:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
# pwd
/sys/bus/pci/slots/C10
# cat address 
0003:09:00
# cat address 
0003:09:00
# cat cur_bus_speed 
5.0 GT/s PCIe
# cat max_bus_speed 
8.0 GT/s PCIe
# cat power 
1
# echo 0 > power 
# lspci -s 0003::.
0003:00:00.0 PCI bridge: IBM Device 03dc
0003:01:00.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:01.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:08.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:09.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:10.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:11.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0003:0f:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
# echo 1 > power
# lspci -s 0003::.
0003:00:00.0 PCI bridge: IBM Device 03dc
0003:01:00.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:01.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:08.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:09.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:10.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:11.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0003:09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.2 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.3 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:0f:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]

Changelog
=========
N/A

Gavin Shan (8):
  powerpc/pci: Move pcibios_find_pci_bus() around
  powerpc/pci: Don't scan empty slot
  powerpc/powernv: Export functions to retrieve slot status
  PCI/hotplug/rpa: Code cleanup
  PCI/hotplug/rpa: Create PCI slot properly
  PCI/hotplug/rpa: Abstract slot operations
  PCI/hotplug/rpa: Hierarchial slots
  PCI/hotplug/rpa: Support OPAL firmware

 arch/powerpc/include/asm/opal.h                |   6 +-
 arch/powerpc/include/asm/pnv-pci.h             |   3 +
 arch/powerpc/kernel/pci-hotplug.c              |  41 ++-
 arch/powerpc/platforms/powernv/eeh-ioda.c      |  34 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/pci.c           |  38 ++
 arch/powerpc/platforms/powernv/pci.h           |   1 +
 arch/powerpc/platforms/pseries/pci_dlpar.c     |  32 --
 drivers/pci/hotplug/Kconfig                    |   4 +-
 drivers/pci/hotplug/Makefile                   |   4 +-
 drivers/pci/hotplug/rpadlpar_core.c            | 102 +++---
 drivers/pci/hotplug/rpaphp.h                   |  93 +++--
 drivers/pci/hotplug/rpaphp_core.c              | 480 ++++++++-----------------
 drivers/pci/hotplug/rpaphp_opal.c              | 241 +++++++++++++
 drivers/pci/hotplug/rpaphp_pci.c               | 135 -------
 drivers/pci/hotplug/rpaphp_rtas.c              | 330 +++++++++++++++++
 drivers/pci/hotplug/rpaphp_slot.c              | 147 --------
 17 files changed, 920 insertions(+), 773 deletions(-)
 create mode 100644 drivers/pci/hotplug/rpaphp_opal.c
 delete mode 100644 drivers/pci/hotplug/rpaphp_pci.c
 create mode 100644 drivers/pci/hotplug/rpaphp_rtas.c
 delete mode 100644 drivers/pci/hotplug/rpaphp_slot.c

-- 
1.8.3.2
