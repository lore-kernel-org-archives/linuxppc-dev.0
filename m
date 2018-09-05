Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4257FR5cN5zF38j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 01:40:21 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id A0355418F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 15:40:18 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3m8mnWcldPNh for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  5 Sep 2018 18:40:17 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id DBB19404D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 18:40:17 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH 0/5] powerpc/pci/hotplug: Discover surprise-hotplugged PCIe
 devices during rescan
Date: Wed, 5 Sep 2018 18:40:03 +0300
Message-ID: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
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
rescan being issued via sysfs, when the "Presence Detect Changed" interrupt
is not available.

As a first part of our work on adding support for hotplugging PCIe bridges
full of devices without special requirement such as Hot-Plug Controller,
reservation of bus numbers and memory regions by firmware, etc., this serie
is intended to solve the first two problems from the list below:

 I   PowerNV doesn't discover new hotplugged PCIe devices
 II  EEH is falsely triggered when poking empty slots during PCIe rescan on PowerNV
 III The PCI subsystem is not prepared to runtime changes of BAR addresses
 IV  Device drivers don't track changes of their BAR addresses
 V   Move BARs of working devices to make space for new ones
 VI  Add support for PCIe bridge hotplug

Sergey Miroshnichenko (5):
  powerpc/pci: Access PCI config space directly w/o pci_dn
  powerpc/pci: Create pci_dn on demand
  powerpc/pci: Use DT to create pci_dn for root bridges only
  powerpc/powernv/pci: Enable reassigning the bus numbers
  PCI/powerpc/eeh: Add pcibios hooks for preparing to rescan

 arch/powerpc/include/asm/eeh.h               |  2 +
 arch/powerpc/kernel/eeh.c                    | 14 +++
 arch/powerpc/kernel/pci_dn.c                 | 75 ++++++++++++-----
 arch/powerpc/kernel/rtas_pci.c               | 89 ++++++++++++--------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 20 +++++
 arch/powerpc/platforms/powernv/pci.c         | 55 +++++++-----
 drivers/pci/probe.c                          | 14 +++
 include/linux/pci.h                          |  2 +
 8 files changed, 197 insertions(+), 74 deletions(-)

-- 
2.17.1
