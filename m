Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 069B1B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 13:27:17 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] powerpc: use asm-generic/dma-mapping-common.h
Date: Fri, 24 Jul 2009 12:24:10 +0900
Message-Id: <1248405855-15546-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset converts POWERPC to use asm-generic/dma-mapping-common.h.

The major change is removing addr_needs_map in struct dma_mapping_ops
(1/5):

http://marc.info/?t=124719060200001&r=1&w=2

This is on the top of my swiotlb cleanup patchset:

http://marc.info/?l=linuxppc-embedded&m=124718920320951&w=2

The patchset also is available via a git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git powerpc


=
 arch/powerpc/Kconfig                       |    2 +-
 arch/powerpc/include/asm/device.h          |    7 +-
 arch/powerpc/include/asm/dma-mapping.h     |  308 ++--------------------------
 arch/powerpc/include/asm/pci.h             |    4 +-
 arch/powerpc/include/asm/swiotlb.h         |    8 +-
 arch/powerpc/kernel/dma-iommu.c            |    2 +-
 arch/powerpc/kernel/dma-swiotlb.c          |   50 ++---
 arch/powerpc/kernel/dma.c                  |    2 +-
 arch/powerpc/kernel/ibmebus.c              |    2 +-
 arch/powerpc/kernel/pci-common.c           |    6 +-
 arch/powerpc/kernel/vio.c                  |    2 +-
 arch/powerpc/platforms/85xx/mpc8536_ds.c   |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    3 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    3 +-
 arch/powerpc/platforms/cell/iommu.c        |    2 +-
 arch/powerpc/platforms/ps3/system-bus.c    |    4 +-
 include/linux/dma-mapping.h                |    1 +
 18 files changed, 63 insertions(+), 349 deletions(-)
