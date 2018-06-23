Return-Path: <tpearson@raptorengineering.com>
Received: from mail.rptsys.com (mail.rptsys.com [192.119.205.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Csp71VDdzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 09:58:23 +1000 (AEST)
Date: Sat, 23 Jun 2018 18:52:02 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <1564865529.2569245.1529797922226.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 0/7] Add initial version of "cognitive DMA"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 (PHB4) requires all peripherals using DMA to be either restricted
to 32-bit windows or capable of accessing the entire 64 bits of memory
space.  Some devices, such as most GPUs, can only address up to a certain
number of bits (approximately 40, in many cases), while at the same time
it is highly desireable to use a larger DMA space than the fallback 32 bits.

This series adds something called "cognitive DMA", which is a form of dynamic
TCE allocation.  This allows the peripheral to DMA to host addresses mapped in
1G (PHB4) or 256M (PHB3) chunks, and is transparent to the peripheral and its
driver stack.

This series has been tested on a Talos II server with a Radeon WX4100 and
a wide range of OpenGL applications.  While there is still work, notably
involving what happens if a peripheral attempts to DMA close to a TCE
window boundary, this series greatly improves functionality for AMD GPUs
on POWER9 devices over the existing 32-bit DMA support.

Russell Currey (4):
  powerpc/powernv/pci: Track largest available TCE order per PHB
  powerpc/powernv: DMA operations for discontiguous allocation
  powerpc/powernv/pci: Track DMA and TCE tables in debugfs
  powerpc/powernv/pci: Safety fixes for pseudobypass TCE allocation

Timothy Pearson (3):
  powerpc/powernv/pci: Export pnv_pci_ioda2_tce_invalidate_pe
  powerpc/powernv/pci: Invalidate TCE cache after DMA map setup
  powerpc/powernv/pci: Don't use the lower 4G TCEs in pseudo-DMA mode

 arch/powerpc/include/asm/dma-mapping.h    |   1 +
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/pci-dma.c  | 320 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 169 ++++++++----
 arch/powerpc/platforms/powernv/pci.h      |  11 +
 5 files changed, 452 insertions(+), 51 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pci-dma.c

-- 
2.17.1
