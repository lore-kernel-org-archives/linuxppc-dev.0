Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406A61A106E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 13:48:16 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, gwshan@linux.vnet.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v3 0/3] Add support for NVLink
Date: Thu, 17 Dec 2015 13:43:10 +1100
Message-Id: <1450320193-20116-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for NVLink, a high speed interconnect that is
used in conjunction with PCI-E to create a high bandwidth interface
between GPU and CPU.

As the NVLink hardware interface is similar to IBM's existing PCIe
host bridges no major new kernel or user interfaces are added by this
patch series. Instead the links are treated as standard PCIe devices
sitting under a NVLink specific PHB type. This allows existing kernel
interfaces to be used for the management and control of the links.

Alistair Popple (3):
  Revert "powerpc/pci: Remove unused struct pci_dn.pcidev field"
  powerpc: Add __raw_rm_writeq() function
  platforms/powernv: Add support for Nvlink NPUs

 arch/powerpc/include/asm/io.h             |  11 +
 arch/powerpc/include/asm/pci-bridge.h     |   1 +
 arch/powerpc/include/asm/pci.h            |   4 +
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 348 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 149 +++++++++++--
 arch/powerpc/platforms/powernv/pci.c      |   4 +
 arch/powerpc/platforms/powernv/pci.h      |  19 ++
 8 files changed, 515 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/npu-dma.c

--
2.1.4
