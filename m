Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB95AC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 06:04:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2437520672
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 06:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2437520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431Qkn04H0zDqTy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 17:04:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 431QV10P9NzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 16:53:45 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id E51BCAE8001D;
 Fri, 23 Nov 2018 00:53:09 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v4 00/19] powerpc/powernv/npu,
 vfio: NVIDIA V100 + P9 passthrough
Date: Fri, 23 Nov 2018 16:52:45 +1100
Message-Id: <20181123055304.25116-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is for passing through NVIDIA V100 GPUs on POWER9 systems.
19/19 has the details of hardware setup.

This implements support for NVIDIA V100 GPU with coherent memory and
NPU/ATS support available in the POWER9 CPU. The aim is to support
unmodified vendor driver in the guest.

This is pushed to (both guest and host kernels):
https://github.com/aik/linux/tree/nv2-stage7

Matching qemu is pushed to github:
https://github.com/aik/qemu/tree/nv2-stage6

Skiboot bits are here:
https://github.com/aik/skiboot/tree/nv2-stage4

The individual patches have changelogs. Some were dropped as not required
or quite useless.


Please comment. Thanks.



Alexey Kardashevskiy (19):
  powerpc/ioda/npu: Call skiboot's hot reset hook when disabling NPU2
  powerpc/mm/iommu/vfio_spapr_tce: Change mm_iommu_get to reference a
    region
  powerpc/vfio/iommu/kvm: Do not pin device memory
  powerpc/powernv: Move npu struct from pnv_phb to pci_controller
  powerpc/powernv/npu: Move OPAL calls away from context manipulation
  powerpc/pseries/iommu: Use memory@ nodes in max RAM address
    calculation
  powerpc/pseries/npu: Enable platform support
  powerpc/pseries: Remove IOMMU API support for non-LPAR systems
  powerpc/powernv/pseries: Rework device adding to IOMMU groups
  powerpc/iommu_api: Move IOMMU groups setup to a single place
  powerpc/powernv: Reference iommu_table while it is linked to a group
  powerpc/powernv: Add purge cache OPAL call
  powerpc/powernv/npu: Move single TVE handling to NPU PE
  powerpc/powernv/npu: Convert NPU IOMMU helpers to
    iommu_table_group_ops
  powerpc/powernv/npu: Add compound IOMMU groups
  powerpc/powernv/npu: Add release_ownership hook
  vfio_pci: Allow mapping extra regions
  vfio_pci: Allow regions to add own capabilities
  vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver

 drivers/vfio/pci/Makefile                     |   1 +
 arch/powerpc/include/asm/iommu.h              |  17 +-
 arch/powerpc/include/asm/mmu_context.h        |   9 +-
 arch/powerpc/include/asm/opal-api.h           |   3 +-
 arch/powerpc/include/asm/opal.h               |   1 +
 arch/powerpc/include/asm/pci-bridge.h         |   1 +
 arch/powerpc/include/asm/pci.h                |   4 +
 arch/powerpc/platforms/powernv/pci.h          |  30 +-
 drivers/vfio/pci/trace.h                      | 102 ++++
 drivers/vfio/pci/vfio_pci_private.h           |   8 +
 include/uapi/linux/vfio.h                     |  27 +
 arch/powerpc/kernel/iommu.c                   |  67 +--
 arch/powerpc/kvm/book3s_64_vio.c              |  18 +-
 arch/powerpc/mm/mmu_context_iommu.c           | 103 +++-
 arch/powerpc/platforms/powernv/npu-dma.c      | 529 +++++++++++++++---
 arch/powerpc/platforms/powernv/opal.c         |   1 +
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |   3 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     | 231 ++++----
 arch/powerpc/platforms/powernv/pci.c          |  43 +-
 arch/powerpc/platforms/pseries/iommu.c        |  89 ++-
 arch/powerpc/platforms/pseries/pci.c          |  22 +
 drivers/vfio/pci/vfio_pci.c                   |  52 +-
 drivers/vfio/pci/vfio_pci_nvlink2.c           | 448 +++++++++++++++
 drivers/vfio/vfio_iommu_spapr_tce.c           |  65 ++-
 .../powerpc/platforms/powernv/opal-wrappers.S |   1 +
 drivers/vfio/pci/Kconfig                      |   6 +
 26 files changed, 1492 insertions(+), 389 deletions(-)
 create mode 100644 drivers/vfio/pci/trace.h
 create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c

-- 
2.17.1

