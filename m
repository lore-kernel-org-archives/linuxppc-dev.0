Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E61A61A15E1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:50 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 468A62CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9H40M1245554
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:17:05 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dkQd008873
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:46 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 00/12] vfio: pci: Enable DDW and in-kernel acceleration
Date: Tue, 15 Jul 2014 19:39:32 +1000
Message-Id: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes use of kernel patchsets:
[PATCH v1 00/16] powernv: vfio: Add Dynamic DMA windows (DDW)
[PATCH v1 0/7] powerpc/iommu: kvm: Enable MultiTCE support
[PATCH v1 00/13] powerpc: kvm: Enable in-kernel acceleration for VFIO

I am posting it for reference here, reviews are still welcome but not required :)


Alexey Kardashevskiy (12):
  spapr_iommu: Disable in-kernel IOMMU tables for >4GB windows
  spapr_pci: Make find_phb()/find_dev() public
  spapr_iommu: Make spapr_tce_find_by_liobn() public
  linux headers update for DDW
  spapr_rtas: Add Dynamic DMA windows (DDW) RTAS calls support
  spapr: Add "ddw" machine option
  spapr_pci: Enable DDW
  spapr_pci_vfio: Enable DDW
  vfio: Enable DDW ioctls to VFIO IOMMU driver
  headers: update for KVM_CAP_SPAPR_TCE_64 and VFIO KVM device
  target-ppc: kvm: make use of KVM_CREATE_SPAPR_TCE_64
  vfio: Enable in-kernel acceleration via VFIO KVM device

 hw/misc/vfio.c                    |  45 ++++++
 hw/ppc/Makefile.objs              |   3 +
 hw/ppc/spapr.c                    |  15 ++
 hw/ppc/spapr_iommu.c              |   6 +-
 hw/ppc/spapr_pci.c                |  84 +++++++++--
 hw/ppc/spapr_pci_vfio.c           |  95 ++++++++++++
 hw/ppc/spapr_rtas_ddw.c           | 296 ++++++++++++++++++++++++++++++++++++++
 include/hw/misc/vfio.h            |   5 +
 include/hw/pci-host/spapr.h       |  25 ++++
 include/hw/ppc/spapr.h            |   8 +-
 linux-headers/asm-mips/kvm_para.h |   6 +-
 linux-headers/asm-powerpc/kvm.h   |   9 ++
 linux-headers/linux/kvm.h         |  12 ++
 linux-headers/linux/kvm_para.h    |   3 +
 linux-headers/linux/vfio.h        |  37 ++++-
 target-ppc/kvm.c                  |  47 ++++--
 target-ppc/kvm_ppc.h              |  10 +-
 trace-events                      |   4 +
 vl.c                              |   4 +
 19 files changed, 683 insertions(+), 31 deletions(-)
 create mode 100644 hw/ppc/spapr_rtas_ddw.c

-- 
2.0.0
