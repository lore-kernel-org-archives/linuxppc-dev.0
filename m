Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEA4F1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 08:25:13 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4BME4ge013730
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 18:14:04 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4BMP7b41192078
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 18:25:07 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4BIOtiF002511
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 15:24:55 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: [PATCH 0/8] pseries/iommu: bug-fixes and cleanups for dynamic dma
	windows
Date: Wed, 11 May 2011 15:24:56 -0700
Message-Id: <1305152704-4864-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches attempts to cleanup and fix some bugs related to
dynamic dma windows and kexec/kdump. They build on the three patches I
have submitted most recently:

powerpc: fix kexec with dynamic dma windows
	http://patchwork.ozlabs.org/patch/94445/
pseries/iommu: restore iommu table pointer when restoring iommu ops
	http://patchwork.ozlabs.org/patch/94909/
pseries/iommu: use correct return type in dupe_ddw_if_already_created
	http://patchwork.ozlabs.org/patch/95184/

The full series has been successfully tested with kdump/kexec on pseries
machine.

Milton Miller (8):
  pseries/iommu: add additional checks when changing iommu mask
  pseries/iommu: remove ddw property when destroying window
  pseries/iommu: find windows after kexec during boot
  pseries/iommu: cleanup ddw naming
  powerpc: override dma_get_required_mask by platform hook and ops
  dma-mapping: add get_required_mask if arch overrides default
  powerpc: use the newly added get_required_mask dma_map_ops hook
  powerpc: tidy up dma_map_ops after adding new hook

 arch/powerpc/include/asm/device.h       |    2 +
 arch/powerpc/include/asm/machdep.h      |    3 +-
 arch/powerpc/kernel/dma-iommu.c         |   28 +++++--
 arch/powerpc/kernel/dma-swiotlb.c       |   16 ++++
 arch/powerpc/kernel/dma.c               |   44 ++++++++--
 arch/powerpc/kernel/ibmebus.c           |   22 +++--
 arch/powerpc/kernel/vio.c               |   21 +++--
 arch/powerpc/platforms/cell/iommu.c     |   21 +++++
 arch/powerpc/platforms/ps3/system-bus.c |    7 ++
 arch/powerpc/platforms/pseries/iommu.c  |  142 +++++++++++++++++++------------
 include/linux/dma-mapping.h             |    3 +
 11 files changed, 224 insertions(+), 85 deletions(-)

-- 
1.7.4.1
