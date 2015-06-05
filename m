Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C0F61A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 09:06:26 +1000 (AEST)
Date: Fri, 5 Jun 2015 18:06:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20150605230611.GA6492@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include more 8xx optimizations, an e6500 hugetlb optimization,
QMan device tree nodes, t1024/t1023 support, and various fixes and
cleanup.

The following changes since commit 763d2d8df1ee2b92ff09cd58f6034021e2cabf6d:

  powerpc/powernv: Move dma_set_mask() from pnv_phb to pci_controller_ops (2015-06-02 13:18:49 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to f1b3b4450dcbfd0098b6fc3b00f4880701550c83:

  powerpc/85xx: Replace CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760 (2015-06-05 01:54:00 -0500)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      powerpc/85xx: Replace CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760

Igal Liberman (4):
      powerpc/dts: Unify B4 mux nodes
      dt/bindings: fsl/guts: Added global-utilities compatibles
      powerpc/dts: Fix incorrect clock-names property
      powerpc/fsl: Add FMan Port 10G compatibles

Kevin Hao (1):
      powerpc: mpc85xx: flush the l1 cache before cpu down in kexec

Kumar Gala (1):
      powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to device tree(s)

LEROY Christophe (9):
      powerpc/8xx: mmu_virtual_psize incorrect for 16k pages
      powerpc/8xx: macro for handling CPU15 errata
      powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
      powerpc/8xx: dont save CR in SCRATCH registers
      powerpc/8xx: Use SPRG2 instead of DAR for saving r3
      powerpc/8xx: Add support for TASK_SIZE greater than 0x80000000
      powerpc/8xx: mark _PAGE_SHARED all types of kernel pages
      powerpc/8xx: Handle PAGE_USER via APG bits
      powerpc/8xx: Implementation of PAGE_EXEC

Scott Wood (4):
      powerpc/e6500: Optimize hugepage TLB misses
      powerpc/e500mc: Remove dead L2 flushing code in idle_e500.S
      powerpc/mm: Use PFN_PHYS() in devmem_is_allowed()
      powerpc/qman: Change fsl,qman-channel-id to cell-index

Shengzhou Liu (4):
      powerpc/fsl-booke: Add device tree support for T1024/T1023 SoC
      powerpc/fsl-booke: Add T1024 QDS board support
      powerpc/fsl-booke: Add T1024 RDB board support
      powerpc/fsl-booke: Add T1023 RDB board support

Xie Xiaobo (1):
      powerpc/85xx: p1025twr: add module conditional to fix QE-uart issue

 .../devicetree/bindings/powerpc/fsl/fman.txt       |  13 +
 .../devicetree/bindings/powerpc/fsl/guts.txt       |   5 +
 .../devicetree/bindings/soc/fsl/qman-portals.txt   |   4 +-
 arch/powerpc/boot/dts/b4qds.dtsi                   |  12 +
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |  15 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |  84 +++++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           | 118 ++++++++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |  43 +++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  13 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  13 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  13 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  13 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  13 +
 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi |  20 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        | 330 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi        | 100 +++++++
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |  87 ++++++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  78 +++++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        | 130 +++++++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        | 318 ++++++++++++++++++++
 arch/powerpc/boot/dts/kmcoge4.dts                  |  12 +
 arch/powerpc/boot/dts/oca4080.dts                  |  12 +
 arch/powerpc/boot/dts/p1023rdb.dts                 |  12 +
 arch/powerpc/boot/dts/p2041rdb.dts                 |  12 +
 arch/powerpc/boot/dts/p3041ds.dts                  |  12 +
 arch/powerpc/boot/dts/p4080ds.dts                  |  12 +
 arch/powerpc/boot/dts/p5020ds.dts                  |  12 +
 arch/powerpc/boot/dts/p5040ds.dts                  |  12 +
 arch/powerpc/boot/dts/t1023rdb.dts                 | 151 ++++++++++
 arch/powerpc/boot/dts/t1024qds.dts                 | 251 ++++++++++++++++
 arch/powerpc/boot/dts/t1024rdb.dts                 | 185 ++++++++++++
 arch/powerpc/boot/dts/t104xqds.dtsi                |  12 +
 arch/powerpc/boot/dts/t104xrdb.dtsi                |  12 +
 arch/powerpc/boot/dts/t208xqds.dtsi                |  12 +
 arch/powerpc/boot/dts/t208xrdb.dtsi                |  12 +
 arch/powerpc/boot/dts/t4240qds.dts                 |  12 +
 arch/powerpc/boot/dts/t4240rdb.dts                 |  12 +
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |   2 +-
 arch/powerpc/include/asm/cputable.h                |   2 +-
 arch/powerpc/include/asm/mmu-8xx.h                 |  33 +++
 arch/powerpc/include/asm/pgtable-ppc32.h           |  19 --
 arch/powerpc/include/asm/pte-8xx.h                 |  31 +-
 arch/powerpc/kernel/head_8xx.S                     | 110 ++++---
 arch/powerpc/kernel/idle_e500.S                    |   9 -
 arch/powerpc/mm/mem.c                              |   2 +-
 arch/powerpc/mm/tlb_low_64e.S                      |  51 +++-
 arch/powerpc/platforms/85xx/Kconfig                |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |   3 +
 arch/powerpc/platforms/85xx/smp.c                  |  51 +---
 arch/powerpc/platforms/85xx/twr_p102x.c            |   4 +-
 50 files changed, 2313 insertions(+), 183 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/t1023rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t1024qds.dts
 create mode 100644 arch/powerpc/boot/dts/t1024rdb.dts
