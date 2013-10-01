Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 99C8D2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 13:54:31 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] iommu: Support pages size other than 4K
Date: Tue,  1 Oct 2013 13:54:08 +1000
Message-Id: <1380599650-9541-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches adds support for iommu page sizes other than
4K. Currently iommu page sizes are hardcoded to 4K. This series does
not actually change the page size but adds support for doing so.

It has been tested on a pSeries machine.

Alistair Popple (2):
  iommu: Add support for iommu page sizes other than 4K
  iommu: Update platform initialisation of iommu to use it_page_shift

 arch/powerpc/include/asm/iommu.h       |   28 ++++++++------
 arch/powerpc/kernel/dma-iommu.c        |    4 +-
 arch/powerpc/kernel/iommu.c            |   64 ++++++++++++++++----------------
 arch/powerpc/kernel/vio.c              |   20 +++++-----
 arch/powerpc/platforms/cell/iommu.c    |   14 ++++---
 arch/powerpc/platforms/powernv/pci.c   |    3 +-
 arch/powerpc/platforms/pseries/iommu.c |   10 +++--
 arch/powerpc/platforms/pseries/setup.c |    4 +-
 drivers/net/ethernet/ibm/ibmveth.c     |    9 +++--
 9 files changed, 85 insertions(+), 71 deletions(-)

-- 
1.7.10.4
