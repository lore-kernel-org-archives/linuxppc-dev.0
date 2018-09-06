Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425fGP15c0zF3MP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 21:58:04 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 062A6418F9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 11:58:01 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A--El7dLXqXC for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  6 Sep 2018 14:57:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id DFCDC40311
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 14:57:59 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v2 0/5] powerpc/powernv/pci: Discover surprise-hotplugged PCIe
 devices during rescan
Date: Thu, 6 Sep 2018 14:57:47 +0300
Message-ID: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
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
serie is intended to solve the first of two problems from the list below:

I   PowerNV doesn't discover new hotplugged PCIe devices
II  EEH is falsely triggered when poking empty slots during the PCIe rescan
III The PCI subsystem is not prepared to runtime changes of BAR addresses
IV  Device drivers don't track changes of their BAR addresses
V   Allow the moving BARs of working devices to make space for new ones
VI  Add support for PCIe bridge hotplug

Tested on:
 - POWER8 PowerNV+OPAL ppc64le (our Vesnin server) with pci=realloc;
 - POWER8 IBM 8247-42L (pSeries);
 - POWER8 IBM 8247-42L (PowerNV+OPAL) with pci=realloc.

Changes since v1:
 - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
 - Fixed build for ppc64e when CONFIG_EEH is disabled;
 - Fixed code style warnings.

Sergey Miroshnichenko (5):
  powerpc/pci: Access PCI config space directly w/o pci_dn
  powerpc/pci: Create pci_dn on demand
  powerpc/pci: Use DT to create pci_dn for root bridges only
  powerpc/powernv/pci: Enable reassigning the bus numbers
  PCI/powerpc/eeh: Add pcibios hooks for preparing to rescan

 arch/powerpc/include/asm/eeh.h               |  2 +
 arch/powerpc/kernel/eeh.c                    | 12 +++
 arch/powerpc/kernel/pci_dn.c                 | 82 +++++++++++++----
 arch/powerpc/kernel/rtas_pci.c               | 97 +++++++++++++-------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++
 arch/powerpc/platforms/powernv/pci.c         | 65 ++++++++-----
 drivers/pci/probe.c                          | 14 +++
 include/linux/pci.h                          |  2 +
 8 files changed, 225 insertions(+), 71 deletions(-)

-- 
2.17.1
