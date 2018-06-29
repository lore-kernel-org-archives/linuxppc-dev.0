Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H7hd4LMPzF1RL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 17:34:55 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, alistair@popple.id.au, aik@ozlabs.ru,
 tpearson@raptorengineering.com, Russell Currey <ruscur@russell.cc>
Subject: [PATCH 0/3] PCI DMA pseudo-bypass for powernv
Date: Fri, 29 Jun 2018 17:34:34 +1000
Message-Id: <20180629073437.4060-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches implement a new set of DMA operations designed to allow
devices that cannot address bit 59 to use more than 32-bit DMA.

The previous implementation for PHB3 assumed contiguous memory, which
is no longer the case on POWER9 and possibly later.  As a result, a new
approach was necessary, which is what this new implementation does.

These patches aren't perfect yet - most notably, there is no
implementation of unmap() - once a TCE is created it is never freed.
For the most part this isn't an issue, but could potentially be a
problem for a device that can't address many bits and maps *a lot* of
memory.

I have a much more complex implementation in the back that I will post
in future, but until that's ready and fully tested, I believe the
drastic performance improvement is worth getting this upstream sooner
rather than later.

Thanks to Benjamin Herrenschmidt, Alistair Popple and Timothy Pearson
for their help.

Russell Currey (3):
  powerpc/powernv/pci: Track largest available TCE order per PHB
  powerpc/powernv: DMA operations for discontiguous allocation
  powerpc/powernv/pci: Track TCE tables in debugfs

 arch/powerpc/include/asm/dma-mapping.h    |   1 +
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/pci-dma.c  | 243 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 132 +++++++-----
 arch/powerpc/platforms/powernv/pci.h      |  10 +
 5 files changed, 334 insertions(+), 54 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pci-dma.c

-- 
2.17.1
