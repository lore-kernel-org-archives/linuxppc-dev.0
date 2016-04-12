Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkgMR34kjzDqBC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:38:57 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 Apr 2016 18:38:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AB80C2BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:38:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3C8cfam36176088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:38:50 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3C8cHxE008819
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:38:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v3 0/9] powerpc/powernv/npu: Enable PCI pass through
 for NVLink
Date: Tue, 12 Apr 2016 18:37:41 +1000
Message-Id: <1460450270-42354-1-git-send-email-aik@ozlabs.ru>
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

There was no v2 of this patchset, just a last patch, this is why this
is v3 and most changes went to "powerpc/powernv/npu: Enable NVLink pass through".

This was tested on POWER8NVL platform. pvr=0x004c0100.

Please comment. Thanks.


Alexey Kardashevskiy (9):
  vfio/spapr: Relax the IOMMU compatibility check
  powerpc/powernv: Rename pnv_pci_ioda2_tce_invalidate_entire
  powerpc/powernv: Define TCE Kill flags
  powerpc/powernv/npu: TCE Kill helpers cleanup
  powerpc/powernv/npu: Use the correct IOMMU page size
  powerpc/powernv/npu: Simplify DMA setup
  powerpc/powernv/npu: Rework TCE Kill handling
  powerpc/powernv/ioda2: Export debug helper pe_level_printk()
  powerpc/powernv/npu: Enable NVLink pass through

 arch/powerpc/platforms/powernv/npu-dma.c  | 340 +++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 227 +++++++++++++-------
 arch/powerpc/platforms/powernv/pci.h      |  31 +--
 drivers/vfio/vfio_iommu_spapr_tce.c       |   3 +-
 4 files changed, 360 insertions(+), 241 deletions(-)

-- 
2.5.0.rc3
