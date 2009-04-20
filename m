Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50DA8DE0D9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 02:27:04 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, fujita.tomonori@lab.ntt.co.jp
Subject: [PATCH 0/5] SWIOTLB for ppc/mpc86xx
Date: Mon, 20 Apr 2009 11:26:43 -0500
Message-Id: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series allows the use of swiotlb on mpc86xx, with 85xx 
support soon to follow.  The most notable change here is the addition
of addr_needs_map to dma_ops.  This is used to tell if a device
can reach an address without bounce buffering.  I believe that patches
will be coming out soon to make dma_ops non-arch-specific, and
I expect to see something similar there as well.

I've also changed sg_dma_len to be the same on both 32 and 64-bit.
We now look at sg->dma_length in both cases (see patch log).

The dma_window* elements in the pci_controller struct are hoisted
out of an #ifdef CONFIG_PPC64 so we can use them to store off
information about how much memory is mapped via the inbound pci
windows.

A dma-swiotlb.c is created in arch/powerpc/kernel to contain
all the platform-specific iotlb code.

Finally, hooks are provided to allow enabling of this feature on 
86xx via Kconfig, and a 36-bit device tree for 8641hpcn is provided.

Ye Olde Diffstat:

 arch/powerpc/Kconfig                       |    2 +-
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts |  597 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/dma-mapping.h     |   11 +
 arch/powerpc/include/asm/pci-bridge.h      |    6 +-
 arch/powerpc/include/asm/scatterlist.h     |    6 +-
 arch/powerpc/include/asm/swiotlb.h         |   24 ++
 arch/powerpc/kernel/Makefile               |    1 +
 arch/powerpc/kernel/dma-swiotlb.c          |  161 ++++++++
 arch/powerpc/kernel/dma.c                  |    2 +-
 arch/powerpc/kernel/setup_32.c             |    4 +
 arch/powerpc/sysdev/fsl_pci.c              |    4 +
 11 files changed, 809 insertions(+), 9 deletions(-)

Cheers,
Becky
