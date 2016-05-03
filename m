Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWM5nGjzDqwx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:23 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8B44A2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UAIt12190122
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436Tipd022900
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:45 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 0/7] Enable ZONE_DEVICE on POWER
Date: Tue,  3 May 2016 11:59:19 +0530
Message-Id: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series enables ZONE_DEVICE support on POWER. The TEST patches are
just example usage of this newly enabled zone. Here are some of the logs
from the example device driver. This demonstrates how struct pages can
be allocated inside the device memory range itself and how usable memory
will be less than the total memory mapped in this way.

[    0.462493] RMEM: Driver loaded
[    0.462502] RMEM: Reserved memory sections
[    0.462504] RMEM: Base b10000000 Size: 10000000 Node: 0
[    0.462507] RMEM: Base b20000000 Size: 10000000 Node: 0
[    0.462510] RMEM: Base b30000000 Size: 10000000 Node: 0
[    0.462512] RMEM: Base b40000000 Size: 10000000 Node: 0
[    0.462515] RMEM: Base b50000000 Size: 10000000 Node: 0
[    0.462517] RMEM: Base b60000000 Size: 10000000 Node: 0
[    0.462520] RMEM: Base b70000000 Size: 10000000 Node: 0
[    0.462522] RMEM: Base b80000000 Size: 10000000 Node: 0
[    0.462525] RMEM: Base b90000000 Size: 10000000 Node: 0
[    0.462527] RMEM: Base ba0000000 Size: 10000000 Node: 0
[    0.462530] RMEM: Base bb0000000 Size: 10000000 Node: 0
[    0.462532] RMEM: Base bc0000000 Size: 10000000 Node: 0
[    0.462535] RMEM: Base bd0000000 Size: 10000000 Node: 0
[    0.462537] RMEM: Base be0000000 Size: 10000000 Node: 0
[    0.462540] RMEM: Base bf0000000 Size: 10000000 Node: 0
[    0.462611] RMEM: vmemmap backing (f000000001000000 40b000000)
[    0.462617] RMEM: vmemmap backing (f000000000000000 40c000000)
[    0.462800] RMEM: vmemmap backing (f000000002000000 b10000000)
[    0.462804] RMEM: vmemmap backing (f000000001000000 40b000000)
[    0.462807] RMEM: vmemmap backing (f000000000000000 40c000000)
[    0.462810] RMEM: Read access complete (c000000b10000000 8000000)
[    0.462813] RMEM: altmap->base_pfn 724992
[    0.462815] RMEM: altmap->reserve 0
[    0.462817] RMEM: altmap->free 256
[    0.462818] RMEM: altmap->align 0
[    0.462820] RMEM: altmap->alloc 256
[    0.462822] RMEM: pagemap            (c000000002060018)
[    0.462824] RMEM: dev_pagemap        (c000000002060060)
[    0.462827] RMEM: pfn range (b1100 b1800)
[    1.264550] RMEM: Driver now owns PFN(b1100....b1800)
[    1.264552] RMEM: Data integrity test successful

Thoughts, suggestions, inputs and comments welcome. Thank you.

Anshuman Khandual (5):
  powerpc/mm: Make vmemmap_populate accommodate ZONE_DEVICE memory
  powerpc/mm: Enable support for ZONE_DEVICE on PPC_BOOK3S_64 platforms
  mm/memremap: Export pfn_first, pfn_end, find_pagemap functions
  TEST: Reserve system memory to be emulated as device memory
  TEST: Driver to test device memory through ZONE_DEVICE

Oliver O'Halloran (2):
  powerpc/mm: Define TOP_ZONE as a constant
  powerpc/mm: Set MAX_ZONE_PFN to 0 for all zones beyond TOP_ZONE

 arch/powerpc/Kconfig                    |   4 +
 arch/powerpc/include/asm/prom.h         |  15 +++
 arch/powerpc/kernel/prom.c              |  11 ++
 arch/powerpc/mm/init_64.c               |  18 +++-
 arch/powerpc/mm/mem.c                   |  28 ++---
 arch/powerpc/platforms/pseries/Makefile |   2 +-
 arch/powerpc/platforms/pseries/rmem.c   | 186 ++++++++++++++++++++++++++++++++
 include/linux/memremap.h                |  18 ++++
 kernel/memremap.c                       |  15 ++-
 mm/Kconfig                              |   2 +-
 10 files changed, 280 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/rmem.c

-- 
1.8.3.1
