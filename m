Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428k0J2FFdzF38f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:56:31 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 45E9441909
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 11:56:28 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hzuYf5xr5Bwa for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 11 Sep 2018 14:56:27 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 40DD1411D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 14:56:27 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v3 0/6] powerpc/powernv/pci: Discover surprise-hotplugged PCIe
 devices during rescan
Date: Tue, 11 Sep 2018 14:56:14 +0300
Message-ID: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset allows hotplugged PCIe devices to be enumerated during a bus
rescan being issued via sysfs on PowerNV platforms, when the "Presence
Detect Changed" interrupt is not available.

As a first part of our work on adding support for hotplugging PCIe bridges
full of devices (without special requirement such as Hot-Plug Controller,
reservation of bus numbers and memory regions by firmware, etc.), this
serie is intended to solve the first two problems of the listed below:

I   PowerNV doesn't discover new hotplugged PCIe devices
II  EEH is falsely triggered when poking empty slots during the PCIe rescan
III The PCI subsystem is not prepared to runtime changes of BAR addresses
IV  Device drivers don't track changes of their BAR addresses
V   BARs of working devices don't move to make space for new ones
VI  PCIe bridge hotplug is not supported

Tested on:
 - POWER8 PowerNV+OPAL ppc64le (our Vesnin server) w/ and w/o pci=realloc;
 - POWER8 IBM 8247-42L (pSeries);
 - POWER8 IBM 8247-42L (PowerNV+OPAL) w/ and w/o pci=realloc.

Changes since v2:
 - Don't reassign bus numbers on PowerNV by default (to retain the default
   behavior), but only when pci=realloc is passed;
 - Less code affected;
 - pci_add_device_node_info is refactored with add_one_dev_pci_data;
 - Minor code cleanup.

Changes since v1:
 - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
 - Fixed build for ppc64e when CONFIG_EEH is disabled;
 - Fixed code style warnings.

Sergey Miroshnichenko (6):
  powerpc/pci: Access PCI config space directly w/o pci_dn
  powerpc/pci: Create pci_dn on demand
  powerpc/pci: Use DT to create pci_dn for root bridges only
  powerpc/powernv/pci: Enable reassigning the bus numbers
  PCI/powerpc/eeh: Add pcibios hooks for preparing to rescan
  powerpc/pci: Reduce code duplication in pci_add_device_node_info

 arch/powerpc/include/asm/eeh.h               |   2 +
 arch/powerpc/kernel/eeh.c                    |  12 ++
 arch/powerpc/kernel/pci_dn.c                 | 119 ++++++++++++++-----
 arch/powerpc/kernel/rtas_pci.c               |  97 ++++++++++-----
 arch/powerpc/platforms/powernv/eeh-powernv.c |  22 ++++
 arch/powerpc/platforms/powernv/pci.c         |  64 ++++++----
 drivers/pci/probe.c                          |  14 +++
 include/linux/pci.h                          |   2 +
 8 files changed, 253 insertions(+), 79 deletions(-)

-- 
2.17.1
