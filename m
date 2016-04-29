Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx78L0C8LzDqlg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:05:38 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 19:05:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3DBE62CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:05:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T94uia1704294
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:05:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T94IwW032214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:04:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v4 00/11] powerpc/powernv/npu: Enable PCI pass through
 for NVLink
Date: Fri, 29 Apr 2016 18:55:13 +1000
Message-Id: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
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
degrade. More details are in 11/11.

This reworks the existing NPU support in the powernv platform and adds
VFIO support on top of that.

v4 has new patch "powerpc/powernv/npu: Add set/unset window" and bunch of
cleanups.

"vfio_pci: Test for extended capabilities if config space > 256 bytes" is
included here if anyone decides to test the patchset which will crash
without it.

This was tested on POWER8NVL platform; pvr=0x004c0100.


Please comment. Thanks.

Alex, I guess we will need your "acked-by" for
"vfio/spapr: Relax the IOMMU compatibility check" to proceed.


Alexey Kardashevskiy (11):
  vfio_pci: Test for extended capabilities if config space > 256 bytes
  vfio/spapr: Relax the IOMMU compatibility check
  powerpc/powernv: Rename pnv_pci_ioda2_tce_invalidate_entire
  powerpc/powernv: Define TCE Kill flags
  powerpc/powernv/npu: TCE Kill helpers cleanup
  powerpc/powernv/npu: Use the correct IOMMU page size
  powerpc/powernv/npu: Simplify DMA setup
  powerpc/powernv/ioda2: Export debug helper pe_level_printk()
  powerpc/powernv/npu: Add set/unset window helpers
  powerpc/powernv/npu: Rework TCE Kill handling
  powerpc/powernv/npu: Enable NVLink pass through

 arch/powerpc/platforms/powernv/npu-dma.c  | 287 ++++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 224 +++++++++++++++--------
 arch/powerpc/platforms/powernv/pci.h      |  31 ++--
 drivers/vfio/pci/vfio_pci_config.c        |  17 +-
 drivers/vfio/vfio_iommu_spapr_tce.c       |   3 +-
 5 files changed, 327 insertions(+), 235 deletions(-)

-- 
2.5.0.rc3
