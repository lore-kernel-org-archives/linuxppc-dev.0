Return-Path: <Andrew.Murray@arm.com>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.21])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59D802C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 19:49:58 +1000 (EST)
From: Andrew Murray <Andrew.Murray@arm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 microblaze-uclinux@itee.uq.edu.au
Subject: [RFC PATCH 0/3] Unify definations of struct pci_controller
Date: Thu, 25 Apr 2013 10:49:17 +0100
Message-Id: <1366883360-14061-1-git-send-email-Andrew.Murray@arm.com>
Cc: monstr@monstr.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, Andrew Murray <Andrew.Murray@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerPC and Microblaze have nearly identical definations of struct
pci_controller - this patch unifies them in asm-generic to reduce
code duplication and to allow new architectures to reuse.

This patchset follows and depends on "of/pci: Provide common
support for PCI DT parsing" which provided common 'ranges' parsing
code which uses an architecture defined struct pci_controller. This
patch is currently in Jason Coopers mvebu-next/pcie branch.

It is hoped this will pave the way for providing common
implementations of commonly duplicated functions found across the
architectures such as pcibios_alloc|free_controller and
pcibios_setup_phb_resources type functions.

Andrew Murray (3):
  powerpc: Move struct pci_controller to asm-generic
  microblaze: Use asm-generic version of pci_controller
  pci: Use common definations of INDIRECT_TYPE_*

 arch/microblaze/include/asm/pci-bridge.h |   70 +-----------------------
 arch/powerpc/include/asm/pci-bridge.h    |   82 ---------------------------
 arch/powerpc/sysdev/fsl_pci.c            |   16 +++---
 arch/powerpc/sysdev/indirect_pci.c       |   20 +++---
 arch/powerpc/sysdev/ppc4xx_pci.c         |    4 +-
 arch/powerpc/sysdev/xilinx_pci.c         |    2 +-
 include/asm-generic/pci-bridge.h         |   90 ++++++++++++++++++++++++++++++
 7 files changed, 112 insertions(+), 172 deletions(-)
