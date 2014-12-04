Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2B551A0CC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:54:58 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 11:24:56 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4C679E0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 11:25:22 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45t4fb58982494
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 11:25:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45soEK004660
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 11:24:51 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 0/5] PCI Hotplug Driver for PowerPC PowerNV
Date: Thu,  4 Dec 2014 16:54:43 +1100
Message-Id: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches depends on the OPAL firmware changes. If the firmware
doesn't have the changes, PCI hotplug slots won't be populated properly.
Other than that, no more problems found.

A new driver "powernv-php.ko" is introduced by the patchset to support
PCI hotplug for PowerNV platform. The device tree is scanned when the
driver is loaded. If any PCI device node is equipped with property "ibm,
slot-pluggable" and "ibm,reset-by-firmware", it's regarded as hotpluggable
slot and the driver creates/registers slot for it. After that, the sysfs
entries can be used to operate the slot.

PATCH[1-4]: Necessary code changes to PPC PCI subsystem in order to
            support PCI slots for PPC PowerNV platform.
PATCH[5]  : powernv-php driver to support PCI hotplug for PowerNV
            platform.

Testing
=======
# cat /proc/cpuinfo | grep -i powernv
platform        : PowerNV
machine         : PowerNV 8286-41A

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
v1 -> v2:
        * Separate powernv-php driver to support PCI hotplug for
	  PowerNV platform.
	* Check if the OPAL API supported by firmware before calling
          into it, which is necessary for back-compability.
        * Separate patch for factoring pnv_pci_poll().

Gavin Shan (5):
  powerpc/pci: Move pcibios_find_pci_bus() around
  powerpc/pci: Don't scan empty slot
  powerpc/powernv: Introduce pnv_pci_poll()
  powerpc/powernv: Functions to retrieve PCI slot status
  PCI/hotplug: PowerPC PowerNV PCI hotplug driver

 arch/powerpc/include/asm/opal.h                |   4 +
 arch/powerpc/include/asm/pnv-pci.h             |   3 +
 arch/powerpc/kernel/pci-hotplug.c              |  39 ++-
 arch/powerpc/platforms/powernv/eeh-ioda.c      |  28 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/pci.c           |  43 +++
 arch/powerpc/platforms/powernv/pci.h           |   1 +
 arch/powerpc/platforms/pseries/pci_dlpar.c     |  32 ---
 drivers/pci/hotplug/Kconfig                    |  12 +
 drivers/pci/hotplug/Makefile                   |   4 +
 drivers/pci/hotplug/powernv_php.c              | 126 ++++++++
 drivers/pci/hotplug/powernv_php.h              |  70 +++++
 drivers/pci/hotplug/powernv_php_slot.c         | 382 +++++++++++++++++++++++++
 13 files changed, 687 insertions(+), 59 deletions(-)
 create mode 100644 drivers/pci/hotplug/powernv_php.c
 create mode 100644 drivers/pci/hotplug/powernv_php.h
 create mode 100644 drivers/pci/hotplug/powernv_php_slot.c

Thanks,
Gavin
