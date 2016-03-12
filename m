Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE0FB1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2016 14:15:44 +1100 (AEDT)
Date: Fri, 11 Mar 2016 21:15:35 -0600
From: Scott Wood <oss@buserror.net>
To: benh@kernel.crashing.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20160312031535.GA24351@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include 8xx optimizations, 32-bit checksum optimizations, 86xx
consolidation, e5500/e6500 cpu hotplug, more fman and other dt bits, and
minor fixes/cleanup.

The following changes since commit ee3b93ebfbed6279f7a329001433c75c50ddfcc9:

  powerpc/mm: Move hash64 tlbflush code into a new header (2016-03-03 21:19:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to fba4e9f9898ab181703723b9890ba29345edfe08:

  powerpc/fsl/dts: Add "jedec,spi-nor" flash compatible (2016-03-11 20:06:41 -0600)

----------------------------------------------------------------
Alessio Igor Bogani (6):
      powerpc/86xx: Consolidate common platform code
      powerpc/86xx: Update defconfigs
      powerpc/86xx: Switch to kconfig fragments approach
      powerpc/86xx: Move dts files to fsl directory
      powerpc/86xx: Update device tree
      powerpc/86xx: Introduce and use common dtsi

Bartlomiej Zolnierkiewicz (4):
      powerpc/83xx: disable IDE subsystem in mpc834x_itx_defconfig
      powerpc/85xx: disable IDE subsystem in ksi8560_defconfig
      powerpc/85xx: disable IDE subsystem in stx_gp3_defconfig
      powerpc/86xx: disable IDE subsystem in mpc8610_hpcd_defconfig

Christophe Leroy (31):
      powerpc: unexport csum_tcpudp_magic
      powerpc: mark xer clobbered in csum_add()
      powerpc32: checksum_wrappers_64 becomes checksum_wrappers
      powerpc: inline ip_fast_csum()
      powerpc32: rewrite csum_partial_copy_generic() based on copy_tofrom_user()
      powerpc32: optimise a few instructions in csum_partial()
      powerpc32: optimise csum_partial() loop
      powerpc: simplify csum_add(a, b) in case a or b is constant 0
      powerpc/885: set SDCR to 0x40
      powerpc/8xx: CONFIG_DEBUG_PAGEALLOC requires ITLBmiss for kernel addresses
      powerpc: optimise csum_partial() call when len is constant
      powerpc/8xx: Save r3 all the time in DTLB miss handler
      powerpc/8xx: Map linear kernel RAM with 8M pages
      powerpc: Update documentation for noltlbs kernel parameter
      powerpc/8xx: move setup_initial_memory_limit() into 8xx_mmu.c
      powerpc32: Fix pte_offset_kernel() to return NULL for bad pages
      powerpc32: refactor x_mapped_by_bats() and x_mapped_by_tlbcam() together
      powerpc32: Remove useless/wrong MMU:setio progress message
      powerpc32: remove ioremap_base
      powerpc/8xx: Add missing SPRN defines into reg_8xx.h
      powerpc/8xx: Handle CPU6 ERRATA directly in mtspr() macro
      powerpc/8xx: remove special handling of CPU6 errata in set_dec()
      powerpc/8xx: rewrite set_context() in C
      powerpc/8xx: rewrite flush_instruction_cache() in C
      powerpc: add inline functions for cache related instructions
      powerpc32: Remove clear_pages() and define clear_page() inline
      powerpc32: move xxxxx_dcache_range() functions inline
      powerpc: Simplify test in __dma_sync()
      powerpc32: small optimisation in flush_icache_range()
      powerpc32: Remove one insn in mulhdu
      powerpc32: PAGE_EXEC required for inittext

Hou Zhiqiang (1):
      powerpc/fsl/dts: Add "jedec,spi-nor" flash compatible

Igal Liberman (3):
      powerpc/fsl: Update fman dt binding with pcs-phy and tbi-phy
      powerpc/mpc85xx: Add MDIO bus muxing support to the board device tree(s)
      powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree

Raghav Dogra (1):
      powerpc/fsl-lbc: Modify suspend/resume entry sequence

Saurabh Sengar (2):
      qe: Make cpm_muram_alloc_common static
      qe: Use GFP_ATOMIC while spin_lock_irqsave is held

Wang Dongsheng (1):
      Documentation: dt: binding: fsl: add devicetree binding for describing RCPM

Xuelin Shi (1):
      powerpc/p5040: Add device node for RAID Engine

Zhao Qiang (2):
      qe/ic: fix a buffer overflow error and add check elsewhere
      powerpc/T104xRDB: add tdm riser card node to device tree

chenhui zhao (6):
      powerpc/mm: any thread in one core can be the first to setup TLB1
      powerpc/cache: add cache flush operation for various e500
      powerpc/rcpm: add RCPM driver
      powerpc/mpc85xx: refactor the PM operations
      powerpc/mpc85xx: Add hotplug support on E5500 and E500MC cores
      powerpc/mpc85xx: Add CPU hotplug support for E6500

 .../devicetree/bindings/powerpc/fsl/fman.txt       |  40 ++
 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  63 +++
 Documentation/kernel-parameters.txt                |   2 +-
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/Makefile                              |  10 +
 arch/powerpc/boot/dts/fsl/b4860qds.dts             |  60 ++-
 arch/powerpc/boot/dts/fsl/b4qds.dtsi               |  53 ++-
 arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi          |   2 +-
 arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi          |   2 +-
 arch/powerpc/boot/dts/fsl/c293pcie.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts            | 216 ++++++++++
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts           | 260 ++++++++++++
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts           | 214 ++++++++++
 arch/powerpc/boot/dts/fsl/kmcoge4.dts              |   4 +-
 arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi           |   8 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn.dts   | 347 +++-------------
 .../boot/dts/{ => fsl}/mpc8641_hpcn_36b.dts        | 330 ++-------------
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi      | 120 ++++++
 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi       |  58 +++
 arch/powerpc/boot/dts/fsl/mvme2500.dts             |   4 +-
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi            |   2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi         |   2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts          |   2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb.dtsi            |   2 +-
 arch/powerpc/boot/dts/fsl/p1021mds.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi         |   2 +-
 arch/powerpc/boot/dts/fsl/p1022ds.dtsi             |   2 +-
 arch/powerpc/boot/dts/fsl/p1022rdk.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/p1024rdb.dtsi            |   2 +-
 arch/powerpc/boot/dts/fsl/p1025rdb.dtsi            |   2 +-
 arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi         |   2 +-
 arch/powerpc/boot/dts/fsl/p2020rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/p2041rdb.dts             |  94 ++++-
 arch/powerpc/boot/dts/fsl/p3041ds.dts              | 114 ++++-
 arch/powerpc/boot/dts/fsl/p4080ds.dts              | 186 ++++++++-
 arch/powerpc/boot/dts/fsl/p5020ds.dts              | 114 ++++-
 arch/powerpc/boot/dts/fsl/p5040ds.dts              | 236 ++++++++++-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   6 +
 .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |   5 +
 .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |   5 +
 arch/powerpc/boot/dts/fsl/sbc8641d.dts             | 203 +++++++++
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |  43 +-
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |   6 +-
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |  47 ++-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts             |  32 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts             |  30 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts          |  18 +-
 arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi          |   2 +-
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi            | 180 +++++++-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |  40 +-
 arch/powerpc/boot/dts/fsl/t2080qds.dts             | 158 ++++++-
 arch/powerpc/boot/dts/fsl/t2080rdb.dts             |  67 ++-
 arch/powerpc/boot/dts/fsl/t2081qds.dts             | 221 +++++++++-
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi            |   6 +-
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi            |   2 +-
 arch/powerpc/boot/dts/fsl/t4240qds.dts             | 402 +++++++++++++++++-
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             | 151 ++++++-
 arch/powerpc/boot/dts/gef_ppc9a.dts                | 425 -------------------
 arch/powerpc/boot/dts/gef_sbc310.dts               | 459 ---------------------
 arch/powerpc/boot/dts/gef_sbc610.dts               | 423 -------------------
 arch/powerpc/boot/dts/sbc8641d.dts                 | 447 --------------------
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |   1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig        |   1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig        |   2 -
 arch/powerpc/configs/86xx-hw.config                | 104 +++++
 arch/powerpc/configs/86xx-smp.config               |   2 +
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig      | 216 ----------
 arch/powerpc/configs/86xx/gef_sbc310_defconfig     | 214 ----------
 arch/powerpc/configs/86xx/gef_sbc610_defconfig     | 273 ------------
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig   | 110 -----
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig   | 156 -------
 arch/powerpc/configs/86xx/sbc8641d_defconfig       | 246 -----------
 arch/powerpc/configs/mpc86xx_basic_defconfig       |  10 +
 arch/powerpc/configs/mpc86xx_defconfig             | 162 --------
 arch/powerpc/include/asm/cache.h                   |  19 +
 arch/powerpc/include/asm/cacheflush.h              |  54 ++-
 arch/powerpc/include/asm/checksum.h                | 141 +++++--
 arch/powerpc/include/asm/cputable.h                |   8 +
 arch/powerpc/include/asm/cputhreads.h              |  15 +
 arch/powerpc/include/asm/fsl_pm.h                  |  51 +++
 arch/powerpc/include/asm/mmu-8xx.h                 |   4 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |   5 +-
 arch/powerpc/include/asm/page_32.h                 |  17 +-
 arch/powerpc/include/asm/reg.h                     |   2 +
 arch/powerpc/include/asm/reg_8xx.h                 |  93 +++++
 arch/powerpc/include/asm/smp.h                     |   4 +
 arch/powerpc/include/asm/time.h                    |   6 +-
 arch/powerpc/kernel/asm-offsets.c                  |   1 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          | 112 +++++
 arch/powerpc/kernel/cputable.c                     |   4 +
 arch/powerpc/kernel/head_64.S                      |  97 +++++
 arch/powerpc/kernel/head_8xx.S                     | 108 ++---
 arch/powerpc/kernel/head_fsl_booke.S               |  74 ----
 arch/powerpc/kernel/misc_32.S                      | 107 +----
 arch/powerpc/kernel/ppc_ksyms.c                    |   2 +
 arch/powerpc/kernel/ppc_ksyms_32.c                 |   1 -
 arch/powerpc/kernel/smp.c                          |   7 +-
 arch/powerpc/lib/Makefile                          |   3 +-
 arch/powerpc/lib/checksum_32.S                     | 398 +++++++++++-------
 arch/powerpc/lib/checksum_64.S                     |  31 +-
 ...{checksum_wrappers_64.c => checksum_wrappers.c} |   0
 arch/powerpc/lib/ppc_ksyms.c                       |   4 +-
 arch/powerpc/mm/8xx_mmu.c                          | 141 +++++++
 arch/powerpc/mm/Makefile                           |   1 +
 arch/powerpc/mm/dma-noncoherent.c                  |   2 +-
 arch/powerpc/mm/fsl_booke_mmu.c                    |   6 +-
 arch/powerpc/mm/init_32.c                          |  23 --
 arch/powerpc/mm/mmu_decl.h                         |  26 +-
 arch/powerpc/mm/pgtable_32.c                       |  52 +--
 arch/powerpc/mm/ppc_mmu_32.c                       |   4 +-
 arch/powerpc/mm/tlb_nohash.c                       |   4 +-
 arch/powerpc/platforms/85xx/Kconfig                |   1 +
 arch/powerpc/platforms/85xx/Makefile               |   1 +
 arch/powerpc/platforms/85xx/common.c               |   3 +
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c       | 106 +++++
 arch/powerpc/platforms/85xx/smp.c                  | 312 +++++++-------
 arch/powerpc/platforms/85xx/smp.h                  |   1 +
 arch/powerpc/platforms/86xx/Makefile               |   2 +-
 arch/powerpc/platforms/86xx/common.c               |  43 ++
 arch/powerpc/platforms/86xx/gef_ppc9a.c            |  32 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c           |  32 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c           |  32 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |  20 +-
 arch/powerpc/platforms/86xx/mpc86xx.h              |   2 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |  21 +-
 arch/powerpc/platforms/86xx/sbc8641d.c             |  32 +-
 arch/powerpc/platforms/embedded6xx/mpc10x.h        |  10 -
 arch/powerpc/sysdev/Kconfig                        |   5 +
 arch/powerpc/sysdev/Makefile                       |   1 +
 arch/powerpc/sysdev/cpm1.c                         |   5 +-
 arch/powerpc/sysdev/fsl_lbc.c                      |  49 ++-
 arch/powerpc/sysdev/fsl_rcpm.c                     | 385 +++++++++++++++++
 drivers/soc/fsl/qe/qe_common.c                     |  66 +--
 drivers/soc/fsl/qe/qe_ic.c                         |  11 +-
 include/linux/fsl/guts.h                           | 105 +++++
 include/soc/fsl/qe/qe.h                            |   2 -
 153 files changed, 5691 insertions(+), 4736 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/rcpm.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/gef_sbc310.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/gef_sbc610.dts
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn.dts (53%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn_36b.dts (51%)
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/sbc8641d.dts
 delete mode 100644 arch/powerpc/boot/dts/gef_ppc9a.dts
 delete mode 100644 arch/powerpc/boot/dts/gef_sbc310.dts
 delete mode 100644 arch/powerpc/boot/dts/gef_sbc610.dts
 delete mode 100644 arch/powerpc/boot/dts/sbc8641d.dts
 create mode 100644 arch/powerpc/configs/86xx-hw.config
 create mode 100644 arch/powerpc/configs/86xx-smp.config
 delete mode 100644 arch/powerpc/configs/86xx/gef_ppc9a_defconfig
 delete mode 100644 arch/powerpc/configs/86xx/gef_sbc310_defconfig
 delete mode 100644 arch/powerpc/configs/86xx/gef_sbc610_defconfig
 delete mode 100644 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
 delete mode 100644 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
 delete mode 100644 arch/powerpc/configs/86xx/sbc8641d_defconfig
 create mode 100644 arch/powerpc/configs/mpc86xx_basic_defconfig
 delete mode 100644 arch/powerpc/configs/mpc86xx_defconfig
 create mode 100644 arch/powerpc/include/asm/fsl_pm.h
 rename arch/powerpc/lib/{checksum_wrappers_64.c => checksum_wrappers.c} (100%)
 create mode 100644 arch/powerpc/mm/8xx_mmu.c
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
 create mode 100644 arch/powerpc/platforms/86xx/common.c
 create mode 100644 arch/powerpc/sysdev/fsl_rcpm.c
