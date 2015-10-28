Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E84B1A0232
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 16:02:58 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 0/2] Add support for Nvlink
Date: Wed, 28 Oct 2015 16:00:00 +1100
Message-Id: <1446008402-24892-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for Nvlink, a high speed interconnect that is
used in conjunction with PCI-E to create a high bandwidth interface
between GPU and CPU.

As the Nvlink hardware interface is similar to IBM's existing PCIe
host bridges no major new kernel or user interfaces are added by this
patch series. Instead the links are treated as standard PCIe devices
sitting under a Nvlink specific PHB type. This allows existing kernel
interfaces to be used for the management and control of the links.

Alistair Popple (2):
  Revert "powerpc/pci: Remove unused struct pci_dn.pcidev field"
  platforms/powernv: Add support for Nvlink NPUs

 arch/powerpc/include/asm/pci-bridge.h     |   1 +
 arch/powerpc/include/asm/pci.h            |   4 +
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 267 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 105 ++++++++++--
 arch/powerpc/platforms/powernv/pci.c      |   4 +
 arch/powerpc/platforms/powernv/pci.h      |  10 ++
 7 files changed, 381 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/npu-dma.c

--
2.1.4
