Return-Path: <m.szyprowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13]) by ozlabs.org (Postfix) with ESMTP id 00329B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:43:32 +1100 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.13]) by mailout3.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1J00EXAQ41PD60@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:13 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J00216Q471V@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:21 +0100 (BST)
Date: Tue, 27 Mar 2012 15:42:34 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 00/14] DMA-mapping framework redesign preparation
To: linux-kernel@vger.kernel.org
Message-id: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
Cc: linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 x86@kernel.org, Matt Turner <mattst88@gmail.com>,
 Dezhong Diao <dediao@cisco.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au,
 linaro-mm-sig@lists.linaro.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, discuss@x86-64.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Richard Kuo <rkuo@codeaurora.org>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
 Kyungmin Park <kyungmin.park@samsung.com>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

This is an updated version of the DMA-mapping framework redesign
preparation patches, which resolves issues pointed by Linus:

https://lkml.org/lkml/2012/3/23/305

These patches are the first step to clean up a bit dma-mapping api and
introduce support for architecture specific performance improving hints
in a generic way.

For more information please refer to the thread with the first version
of the patches:

https://lkml.org/lkml/2011/12/23/97


Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Andrzej Pietrasiewicz (8):
  X86 & IA64: adapt for dma_map_ops changes
  MIPS: adapt for dma_map_ops changes
  PowerPC: adapt for dma_map_ops changes
  SPARC: adapt for dma_map_ops changes
  Alpha: adapt for dma_map_ops changes
  SH: adapt for dma_map_ops changes
  Microblaze: adapt for dma_map_ops changes
  Unicore32: adapt for dma_map_ops changes

Marek Szyprowski (6):
  common: dma-mapping: introduce alloc_attrs and free_attrs methods
  Hexagon: adapt for dma_map_ops changes
  common: dma-mapping: remove old alloc_coherent and free_coherent
    methods
  common: dma-mapping: introduce mmap method
  common: DMA-mapping: add WRITE_COMBINE attribute
  common: DMA-mapping: add NON-CONSISTENT attribute

 Documentation/DMA-attributes.txt          |   19 +++++++++++++++++++
 arch/alpha/include/asm/dma-mapping.h      |   18 ++++++++++++------
 arch/alpha/kernel/pci-noop.c              |   10 ++++++----
 arch/alpha/kernel/pci_iommu.c             |   10 ++++++----
 arch/hexagon/include/asm/dma-mapping.h    |   18 ++++++++++++------
 arch/hexagon/kernel/dma.c                 |    9 +++++----
 arch/ia64/hp/common/sba_iommu.c           |   11 ++++++-----
 arch/ia64/include/asm/dma-mapping.h       |   18 ++++++++++++------
 arch/ia64/kernel/pci-swiotlb.c            |   14 +++++++++++---
 arch/ia64/sn/pci/pci_dma.c                |    9 +++++----
 arch/microblaze/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/microblaze/kernel/dma.c              |   10 ++++++----
 arch/mips/cavium-octeon/dma-octeon.c      |   12 ++++++------
 arch/mips/include/asm/dma-mapping.h       |   18 ++++++++++++------
 arch/mips/mm/dma-default.c                |    8 ++++----
 arch/powerpc/include/asm/dma-mapping.h    |   24 ++++++++++++++++--------
 arch/powerpc/kernel/dma-iommu.c           |   10 ++++++----
 arch/powerpc/kernel/dma-swiotlb.c         |    4 ++--
 arch/powerpc/kernel/dma.c                 |   10 ++++++----
 arch/powerpc/kernel/ibmebus.c             |   10 ++++++----
 arch/powerpc/kernel/vio.c                 |   14 ++++++++------
 arch/powerpc/platforms/cell/iommu.c       |   16 +++++++++-------
 arch/powerpc/platforms/ps3/system-bus.c   |   13 +++++++------
 arch/sh/include/asm/dma-mapping.h         |   28 ++++++++++++++++++----------
 arch/sh/kernel/dma-nommu.c                |    4 ++--
 arch/sh/mm/consistent.c                   |    6 ++++--
 arch/sparc/include/asm/dma-mapping.h      |   18 ++++++++++++------
 arch/sparc/kernel/iommu.c                 |   10 ++++++----
 arch/sparc/kernel/ioport.c                |   18 ++++++++++--------
 arch/sparc/kernel/pci_sun4v.c             |    9 +++++----
 arch/unicore32/include/asm/dma-mapping.h  |   18 ++++++++++++------
 arch/unicore32/mm/dma-swiotlb.c           |   18 ++++++++++++++++--
 arch/x86/include/asm/dma-mapping.h        |   26 ++++++++++++++++----------
 arch/x86/kernel/amd_gart_64.c             |   11 ++++++-----
 arch/x86/kernel/pci-calgary_64.c          |    9 +++++----
 arch/x86/kernel/pci-dma.c                 |    3 ++-
 arch/x86/kernel/pci-nommu.c               |    6 +++---
 arch/x86/kernel/pci-swiotlb.c             |   17 +++++++++++++----
 arch/x86/xen/pci-swiotlb-xen.c            |    4 ++--
 drivers/iommu/amd_iommu.c                 |   10 ++++++----
 drivers/iommu/intel-iommu.c               |    9 +++++----
 drivers/xen/swiotlb-xen.c                 |    5 +++--
 include/linux/dma-attrs.h                 |    2 ++
 include/linux/dma-mapping.h               |   13 +++++++++----
 include/xen/swiotlb-xen.h                 |    6 ++++--
 45 files changed, 355 insertions(+), 198 deletions(-)

-- 
1.7.1.569.g6f426
