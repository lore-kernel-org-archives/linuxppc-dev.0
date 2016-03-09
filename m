Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F6601A004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:13 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2EFA1357805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296TviH53281012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:08 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296TWgn009802
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:33 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 00/10] powerpc/powernv/npu: Enable PCI pass through for
 NVLink
Date: Wed,  9 Mar 2016 17:28:56 +1100
Message-Id: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IBM POWER8 NVlink systems contain usual Tesla K40-ish GPUs but also
contain a couple of really fast links between GPU and CPU. These links
are exposed to the userspace by the OPAL firmware as bridges.
In order to make these links work when GPU is passed to the guest,
these bridges need to be passed as well; otherwise performance will
degrade. More details are in 10/10.

This reworks the existing NPU support in the powernv platform and adds
VFIO support on top of that.

This was tested on POWER8NVL platform. pvr=0x004c0100.

Please comment. Thanks.


Alexey Kardashevskiy (10):
  vfio/spapr: Relax the IOMMU compatibility check
  powerpc/powernv: Rename pnv_pci_ioda2_tce_invalidate_entire
  powerpc/powernv: Define TCE Kill flags
  powerpc/powernv/npu: TCE Kill helpers cleanup
  powerpc/powernv/npu: Use the correct IOMMU page size
  powerpc/powernv/npu: Simplify DMA setup
  powerpc/powernv/npu: Rework TCE Kill handling
  powerpc/powernv/npu: Add NPU devices to IOMMU group
  powerpc/powernv/ioda2: Export some helpers
  powerpc/powernv/npu: Enable passing through via VFIO

 arch/powerpc/platforms/powernv/npu-dma.c  | 387 ++++++++++++++++++------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 134 +++++------
 arch/powerpc/platforms/powernv/pci.h      |  32 +--
 drivers/vfio/vfio_iommu_spapr_tce.c       |   3 +-
 4 files changed, 309 insertions(+), 247 deletions(-)

-- 
2.5.0.rc3
