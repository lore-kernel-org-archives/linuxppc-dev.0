Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0149.outbound.protection.outlook.com [207.46.163.149])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 871202C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 11:45:06 +1100 (EST)
Date: Fri, 10 Jan 2014 18:44:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git
Message-ID: <20140111004451.GA7353@home.buserror.net>
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

Highlights include 32-bit booke relocatable support, e6500 hardware
tablewalk support, various e500 SPE fixes, some new/revived boards, and
e6500 deeper idle and altivec powerdown modes.

The following changes since commit dece8ada993e1764a115bdff0f1effffaa5fc8dc:

  Merge branch 'merge' into next (2013-12-30 15:19:31 +1100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to d064f30e5063ec54ab50af08c64fb5055e759bfd:

  powerpc/fsl_pci: add versionless pci compatible (2014-01-10 17:38:56 -0600)

----------------------------------------------------------------
Anton Blanchard (1):
      drivers/tty: ehv_bytechan fails to build as a module

Christian Engelmayer (1):
      powerpc/sysdev: Fix a pci section mismatch for Book E

Diana Craciun (1):
      powerpc: Replaced tlbilx with tlbwe in the initialization code

Joseph Myers (6):
      powerpc: fix exception clearing in e500 SPE float emulation
      powerpc: fix e500 SPE float rounding inexactness detection
      math-emu: fix floating-point to integer unsigned saturation
      math-emu: fix floating-point to integer overflow detection
      powerpc: fix e500 SPE float to integer and fixed-point conversions
      powerpc: fix e500 SPE float SIGFPE generation

Kevin Hao (11):
      powerpc/85xx: don't init the mpic ipi for the SoC which has doorbell support
      powerpc/fsl_booke: protect the access to MAS7
      powerpc/fsl_booke: introduce get_phys_addr function
      powerpc: introduce macro LOAD_REG_ADDR_PIC
      powerpc: enable the relocatable support for the fsl booke 32bit kernel
      powerpc/fsl_booke: set the tlb entry for the kernel address in AS1
      powerpc: introduce early_get_first_memblock_info
      powerpc/fsl_booke: introduce map_mem_in_cams_addr
      powerpc/fsl_booke: make sure PAGE_OFFSET map to memstart_addr for relocatable kernel
      powerpc/fsl_booke: smp support for booting a relocatable kernel above 64M
      powerpc/fsl_booke: enable the relocatable for the kdump kernel

LEROY Christophe (1):
      powerpc 8xx: defconfig: slice by 4 is more efficient than the default slice by 8 on Powerpc 8xx.

Lijun Pan (1):
      powerpc/85xx: Merge 85xx/p1023_defconfig into mpc85xx_smp and mpc85xx

Mihai Caraman (1):
      powerpc/booke64: Add LRAT error exception handler

Paul Gortmaker (1):
      powerpc: fix 8xx and 6xx final link failures

Scott Wood (5):
      powerpc/fsl-booke: Use SPRN_SPRGn rather than mfsprg/mtsprg
      powerpc: add barrier after writing kernel PTE
      powerpc/e6500: TLB miss handler with hardware tablewalk support
      powerpc/fsl-book3e-64: Use paca for hugetlb TLB1 entry selection
      powerpc/booke-64: fix tlbsrx. path in bolted tlb handler

Shaohui Xie (1):
      powerpc/85xx: handle the eLBC error interrupt if it exists in dts

Shengzhou Liu (2):
      powerpc/85xx/dts: add third elo3 dma component
      powerpc/fsl_pci: add versionless pci compatible

Stephen Chivers (1):
      powerpc/embedded6xx: Add support for Motorola/Emerson MVME5100

Wang Dongsheng (9):
      powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0 define
      powerpc/85xx: add hardware automatically enter altivec idle state
      powerpc/85xx: add hardware automatically enter pw20 state
      powerpc/85xx: add sysfs for pw20 state and altivec idle
      powerpc/p1022ds: fix rtc compatible string
      powerpc/p1022ds: add a interrupt for rtc node
      powerpc/mpic_timer: fix the time is not accurate caused by GTCRR toggle bit
      powerpc/mpic_timer: fix convert ticks to time subtraction overflow
      powerpc/dts: fix lbc lack of error interrupt

Xie Xiaobo (2):
      powerpc/85xx: Add QE common init function
      powerpc/85xx: Add TWR-P1025 board support

Zhao Qiang (3):
      powerpc/p1010rdb:update dts to adapt to both old and new p1010rdb
      powerpc/p1010rdb:update mtd of nand to adapt to both old and new p1010rdb
      powerpc/p1010rdb-pa: modify phy interrupt.

 .../devicetree/bindings/video/ssd1289fb.txt        |  13 +
 arch/powerpc/Kconfig                               |   5 +-
 arch/powerpc/boot/Makefile                         |   7 +-
 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi          |  82 ++++++
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/mvme5100.dts                 | 185 ++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pa.dts              |  23 ++
 arch/powerpc/boot/dts/p1010rdb-pa.dtsi             |  85 ++++++
 .../dts/{p1010rdb_36b.dts => p1010rdb-pa_36b.dts}  |  47 +--
 arch/powerpc/boot/dts/p1010rdb-pb.dts              |  35 +++
 arch/powerpc/boot/dts/p1010rdb-pb_36b.dts          |  58 ++++
 arch/powerpc/boot/dts/p1010rdb.dts                 |  66 -----
 arch/powerpc/boot/dts/p1010rdb.dtsi                |  43 +--
 arch/powerpc/boot/dts/p1010rdb_32b.dtsi            |  79 ++++++
 arch/powerpc/boot/dts/p1010rdb_36b.dtsi            |  79 ++++++
 arch/powerpc/boot/dts/p1022ds.dtsi                 |   3 +-
 arch/powerpc/boot/dts/p1025twr.dts                 |  95 +++++++
 arch/powerpc/boot/dts/p1025twr.dtsi                | 280 ++++++++++++++++++
 arch/powerpc/boot/mvme5100.c                       |  27 ++
 arch/powerpc/boot/wrapper                          |   4 +
 arch/powerpc/configs/85xx/p1023_defconfig          | 188 ------------
 arch/powerpc/configs/adder875_defconfig            |   1 +
 arch/powerpc/configs/ep88xc_defconfig              |   1 +
 arch/powerpc/configs/mpc85xx_defconfig             |   3 +
 arch/powerpc/configs/mpc85xx_smp_defconfig         |   3 +
 arch/powerpc/configs/mpc866_ads_defconfig          |   1 +
 arch/powerpc/configs/mpc885_ads_defconfig          |   1 +
 arch/powerpc/configs/mvme5100_defconfig            | 144 ++++++++++
 arch/powerpc/configs/tqm8xx_defconfig              |   1 +
 arch/powerpc/include/asm/fsl_lbc.h                 |   2 +-
 arch/powerpc/include/asm/kvm_asm.h                 |   1 +
 arch/powerpc/include/asm/mmu-book3e.h              |  13 +
 arch/powerpc/include/asm/mmu.h                     |  21 +-
 arch/powerpc/include/asm/paca.h                    |   6 +
 arch/powerpc/include/asm/ppc_asm.h                 |  13 +
 arch/powerpc/include/asm/processor.h               |   6 +-
 arch/powerpc/include/asm/reg.h                     |   2 +
 arch/powerpc/include/asm/reg_booke.h               |  10 +
 arch/powerpc/kernel/asm-offsets.c                  |   9 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |  54 ++++
 arch/powerpc/kernel/exceptions-64e.S               |  27 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S      |   2 +
 arch/powerpc/kernel/head_fsl_booke.S               | 266 +++++++++++++++--
 arch/powerpc/kernel/paca.c                         |   5 +
 arch/powerpc/kernel/process.c                      |  30 +-
 arch/powerpc/kernel/prom.c                         |  41 ++-
 arch/powerpc/kernel/setup_64.c                     |  31 ++
 arch/powerpc/kernel/swsusp_booke.S                 |  32 +--
 arch/powerpc/kernel/sysfs.c                        | 316 +++++++++++++++++++++
 arch/powerpc/kvm/bookehv_interrupts.S              |   2 +
 arch/powerpc/math-emu/math_efp.c                   | 316 ++++++++++++++++-----
 arch/powerpc/mm/fsl_booke_mmu.c                    |  80 +++++-
 arch/powerpc/mm/hugetlbpage-book3e.c               |  54 +++-
 arch/powerpc/mm/mem.c                              |   6 +
 arch/powerpc/mm/mmu_decl.h                         |   2 +
 arch/powerpc/mm/pgtable_32.c                       |   1 +
 arch/powerpc/mm/pgtable_64.c                       |  12 +
 arch/powerpc/mm/tlb_low_64e.S                      | 174 +++++++++++-
 arch/powerpc/mm/tlb_nohash.c                       |  93 ++++--
 arch/powerpc/mm/tlb_nohash_low.S                   |   4 +-
 arch/powerpc/platforms/85xx/Kconfig                |   6 +
 arch/powerpc/platforms/85xx/Makefile               |   1 +
 arch/powerpc/platforms/85xx/common.c               |  38 +++
 arch/powerpc/platforms/85xx/mpc85xx.h              |   6 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |  29 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  25 +-
 arch/powerpc/platforms/85xx/smp.c                  |  17 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            | 147 ++++++++++
 arch/powerpc/platforms/embedded6xx/Kconfig         |  13 +-
 arch/powerpc/platforms/embedded6xx/Makefile        |   1 +
 arch/powerpc/platforms/embedded6xx/mvme5100.c      | 221 ++++++++++++++
 arch/powerpc/sysdev/fsl_lbc.c                      |  31 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   3 +-
 arch/powerpc/sysdev/indirect_pci.c                 |   6 +-
 arch/powerpc/sysdev/mpic_timer.c                   |  10 +-
 drivers/tty/Kconfig                                |   2 +-
 include/linux/of_fdt.h                             |   1 +
 include/math-emu/op-common.h                       |   9 +-
 81 files changed, 3154 insertions(+), 614 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/ssd1289fb.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/mvme5100.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dtsi
 rename arch/powerpc/boot/dts/{p1010rdb_36b.dts => p1010rdb-pa_36b.dts} (64%)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
 delete mode 100644 arch/powerpc/boot/dts/p1010rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb_32b.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1010rdb_36b.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1025twr.dts
 create mode 100644 arch/powerpc/boot/dts/p1025twr.dtsi
 create mode 100644 arch/powerpc/boot/mvme5100.c
 delete mode 100644 arch/powerpc/configs/85xx/p1023_defconfig
 create mode 100644 arch/powerpc/configs/mvme5100_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/twr_p102x.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/mvme5100.c
