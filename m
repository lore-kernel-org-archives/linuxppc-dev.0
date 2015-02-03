Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1791C1A0A96
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 04:21:17 +1100 (AEDT)
Date: Tue, 3 Feb 2015 11:20:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20150203172056.GA14407@SnaresPenguin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include 8xx optimizations, some more work on datapath device
tree content, e300 machine check support, t1040 corenet error reporting,
and various cleanups and fixes.

The following changes since commit 31494cf3532cfee0bf5c913ac9962971aab7b1d4:

  powerpc/powernv: Don't alloc IRQ map if necessary (2015-01-28 15:28:10 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 0dc294f717d41bfbafc746a7a96a7bc0f114c20c:

  powerpc/mm: bail out early when flushing TLB page (2015-01-30 18:39:00 -0600)

----------------------------------------------------------------
Alessio Igor Bogani (2):
      powerpc/85xx: Add support for Emerson/Artesyn MVME2500.
      powerpc: dts: pq3/85xx: Fix GPIO address

Alexandru-Cezar Sardan (1):
      perf/powerpc: reset event hw state when adding it to the PMU

Andy Fleming (1):
      powerpc/config: Enable MDIO support

Arseny Solokha (1):
      powerpc/mm: bail out early when flushing TLB page

Brian Norris (1):
      powerpc: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)

Emil Medve (4):
      powerpc/dts: Remove T4240 emulator support
      powerpc: Remove duplicate tlbcam_index declarations
      dt/bindings: b/qman: Fix the alloc-ranges in the example(s)
      dt/bindings: b/qman: Add phandle to the portals

Esben Haabendal (1):
      powerpc: Add machine_check cpu function for e300c3 cpus

Kim Phillips (1):
      powerpc/fsl_pci: Fix pci stack build bug with FRAME_WARN

Kumar Gala (2):
      powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA BMan
      powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA QMan

LEROY Christophe (9):
      powerpc32: adds handling of _PAGE_RO
      powerpc/8xx: use _PAGE_RO instead of _PAGE_RW
      powerpc/8xx: reduce pressure on TLB due to context switches
      powerpc/8xx: remove remaining unnecessary code in FixupDAR
      powerpc/8xx: remove tests on PGDIR entry validity
      powerpc32: Use kmem_cache memory for PGDIR
      powerpc/8xx: Take benefit of aligned PGDIR
      powerpc/8xx: Optimise access to swapper_pg_dir
      powerpc/8xx: Remove duplicated code in set_context()

Markus Elfring (1):
      PowerPC-83xx: Deletion of an unnecessary check before the function call "of_node_put"

Rickard Strandqvist (1):
      powerpc/qe: Use strlcpy()

Scott Wood (2):
      powerpc/mpc85xx: Add ranges to etsec2 nodes
      memory/fsl-corenet-cf: Add t1040 support

Shaohui Xie (1):
      power/fsl: add MDIO dt binding for FMan

Tom Huynh (1):
      powerpc/perf: fix fsl_emb_pmu_start to write correct pmc value

 .../devicetree/bindings/powerpc/fsl/fman.txt       |  70 +++++
 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  14 +-
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi          |   6 +-
 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi |  90 +++++++
 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi         |  41 +++
 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi | 101 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi         |  41 +++
 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi         |  41 +++
 arch/powerpc/boot/dts/mvme2500.dts                 | 280 ++++++++++++++++++++
 arch/powerpc/boot/dts/t4240emu.dts                 | 281 ---------------------
 arch/powerpc/configs/corenet32_smp_defconfig       |   2 +
 arch/powerpc/configs/corenet64_smp_defconfig       |   5 +
 arch/powerpc/configs/mpc85xx_defconfig             |  16 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 +
 arch/powerpc/include/asm/pci-bridge.h              |   4 +
 arch/powerpc/include/asm/pgtable-ppc32.h           |  23 +-
 arch/powerpc/include/asm/pgtable.h                 |   7 +-
 arch/powerpc/include/asm/pte-8xx.h                 |   9 +-
 arch/powerpc/include/asm/pte-common.h              |  25 +-
 arch/powerpc/kernel/cputable.c                     |   1 +
 arch/powerpc/kernel/head_8xx.S                     | 123 ++++-----
 arch/powerpc/mm/fsl_booke_mmu.c                    |   2 -
 arch/powerpc/mm/mmu_context_nohash.c               |  43 +++-
 arch/powerpc/mm/pgtable_32.c                       |  19 +-
 arch/powerpc/mm/tlb_nohash.c                       |   5 +-
 arch/powerpc/perf/core-fsl-emb.c                   |  10 +-
 arch/powerpc/platforms/83xx/usb.c                  |   3 +-
 arch/powerpc/platforms/85xx/Kconfig                |   6 +
 arch/powerpc/platforms/85xx/Makefile               |   1 +
 arch/powerpc/platforms/85xx/mvme2500.c             |  74 ++++++
 arch/powerpc/sysdev/fsl_pci.c                      |  11 +-
 arch/powerpc/sysdev/indirect_pci.c                 |  25 +-
 arch/powerpc/sysdev/qe_lib/qe.c                    |   6 +-
 drivers/memory/fsl-corenet-cf.c                    |  36 ++-
 38 files changed, 1011 insertions(+), 426 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi
 create mode 100644 arch/powerpc/boot/dts/mvme2500.dts
 delete mode 100644 arch/powerpc/boot/dts/t4240emu.dts
 create mode 100644 arch/powerpc/platforms/85xx/mvme2500.c
