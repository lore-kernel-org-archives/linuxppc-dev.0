Return-Path: <nacc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD7C5B6F06
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 04:33:26 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HIWSq011870
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 13:18:32 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98HXKv81720378
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 13:33:20 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o98HXJuk025469
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 13:33:20 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 00/11] ppc: enable dynamic dma window support
Date: Fri,  8 Oct 2010 10:33:01 -0700
Message-Id: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The following series, which builds upon the series of cleanups I posted
on 9/15 as "ppc iommu cleanups", enables the pseries firmware feature
dynamic dma windows. This feature will allow future devices to have a
64-bit DMA mapping covering all memory, coexisting with a smaller IOMMU
window in 32-bit PCI space.

Comments requested and welcome!

Nishanth Aravamudan (11):
  macio: ensure all dma routines get copied over
  ppc: allow direct and iommu to coexist
  ppc: Create ops to choose between direct window and iommu based on
    device mask
  ppc: add memory_hotplug_max
  ppc: do not search for dma-window property on dlpar remove
  ppc: checking for pdn->parent is redundant
  ppc/iommu: do not need to check for dma_window == NULL
  ppc/iommu: remove unneeded pci_dma_bus_setup_pSeriesLP
  ppc/iommu: pass phb only to iommu_table_setparms_lpar
  ppc/iommu: add routines to pseries iommu to map tces 1-1
  ppc: add dynamic dma window support

 arch/powerpc/include/asm/device.h      |   20 +-
 arch/powerpc/include/asm/dma-mapping.h |    6 +-
 arch/powerpc/include/asm/iommu.h       |    6 +-
 arch/powerpc/include/asm/mmzone.h      |    5 +
 arch/powerpc/kernel/Makefile           |    2 +-
 arch/powerpc/kernel/dma-choose64.c     |  167 +++++++++++
 arch/powerpc/mm/numa.c                 |   26 ++
 arch/powerpc/platforms/pseries/iommu.c |  475 +++++++++++++++++++++++++++----
 drivers/macintosh/macio_asic.c         |    7 +-
 9 files changed, 635 insertions(+), 79 deletions(-)
 create mode 100644 arch/powerpc/kernel/dma-choose64.c
