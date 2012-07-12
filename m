Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC4B42C0208
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2012 08:00:55 +1000 (EST)
Date: Thu, 12 Jul 2012 17:00:41 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1207121700110.17046@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit db9112173b185995b80f56e136bd2ae44e4e6366:

  powerpc: Turn on BPF_JIT in ppc64_defconfig (2012-07-10 19:19:02 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Christian Herzig (1):
      powerpc/83xx: fix RGMII AC values workaround for km83xx

Gustavo Zacarias (1):
      powerpc/p1010rdb: add EEPROMs to device tree

Holger Brunck (3):
      powerpc/83xx: use for_each_node_by_name for km83xx.c
      powerpc/83xx: update defconfig for kmeter1
      powerpc/82xx: add SPI support for mgcoge

Jerry Huang (1):
      powerpc/p1022ds: Add RTC support

Jia Hongtao (3):
      powerpc/85xx: MPC8572DS - Fix eTSEC is not available on core1 of AMP boot
      powerpc/85xx: MPC8572DS - Update the MSI interrupts into 4-cell format
      powerpc/85xx: Add phy nodes in SGMII mode for MPC8536/44/72DS & P2020DS

Kim Phillips (1):
      powerpc/fsl: Distribute interrupts on all CPUs by default

Kokoris, Ioannis (1):
      powerpc/qe: set IReady in QE Microcode Upload

Liu Yu (1):
      powerpc/e500: make load_up_spe a normal fuction

Matias Garcia (1):
      powerpc/fsl/pci: Fix when quirk_fsl_pcie_header is freed up

Paul Gortmaker (1):
      powerpc: remove Wind River SBC8560 support

Prabhakar Kushwaha (1):
      powerpc/85xx: Add BSC9131 RDB Support

Scott Wood (3):
      powerpc/fsl-pci: get PCI init out of board files
      powerpc/mpc85xx_ds: convert to unified PCI init
      powerpc/e500: add paravirt QEMU platform

Sebastian Andrzej Siewior (1):
      Revert "powerpc/85xx: p2020rdb - move the NAND address."

Shaohui Xie (3):
      powerpc/p2041rdb: add NAND node in device tree
      powerpc/watchdog: replace CONFIG_FSL_BOOKE with CONFIG_PPC_FSL_BOOK3E
      powerpc/watchdog: move booke watchdog param related code to setup-common.c

Shawn Guo (1):
      powerpc: select PPC_CLOCK unconditionally for FSL_SOC

Shengzhou Liu (3):
      powerpc/85xx: Enable MTD/NOR/NAND options by default in defconfig
      powerpc/85xx: Update corenet32_smp_defconfig
      powerpc/85xx: Update corenet64_smp_defconfig

Tang Yuantian (2):
      powerpc/85xx: Add P1024rdb board support
      powerpc/85xx: Add P1024rdb dts support

Timur Tabi (2):
      powerpc/85xx: use the BRx registers to enable indirect mode on the P1022DS
      Revert "powerpc/p3060qds: Add support for P3060QDS board"

Varun Sethi (1):
      powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for FSL MPIC.

Xu Jiucheng (1):
      powerpc/85xx: Rename P1021RDB-PC device trees to be consistent

Zhicheng Fan (1):
      powerpc/85xx: Add ucc uart support for p1025rdb

 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/boot/Makefile                         |    1 -
 arch/powerpc/boot/dts/bsc9131rdb.dts               |   34 ++
 arch/powerpc/boot/dts/bsc9131rdb.dtsi              |  142 +++++++
 arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi      |  193 ++++++++++
 .../dts/{p1021rdb.dts => fsl/bsc9131si-pre.dtsi}   |   79 +---
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi        |   16 +-
 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi        |  302 ---------------
 arch/powerpc/boot/dts/mgcoge.dts                   |   23 ++
 arch/powerpc/boot/dts/mpc8536ds.dtsi               |    8 +
 arch/powerpc/boot/dts/mpc8544ds.dtsi               |    9 +
 arch/powerpc/boot/dts/mpc8572ds.dtsi               |   17 +
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts     |    8 +-
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts     |   11 +-
 arch/powerpc/boot/dts/p1010rdb.dtsi                |   12 +
 .../boot/dts/{p1021rdb.dtsi => p1021rdb-pc.dtsi}   |    2 +-
 .../boot/dts/{p1021rdb.dts => p1021rdb-pc_32b.dts} |    4 +-
 .../dts/{p1021rdb_36b.dts => p1021rdb-pc_36b.dts}  |    4 +-
 arch/powerpc/boot/dts/p1022ds.dtsi                 |   20 +-
 .../boot/dts/{p1021rdb.dtsi => p1024rdb.dtsi}      |   94 ++---
 .../dts/{fsl/p3060si-pre.dtsi => p1024rdb_32b.dts} |  126 +++----
 .../dts/{p1021rdb_36b.dts => p1024rdb_36b.dts}     |   43 +--
 arch/powerpc/boot/dts/p1025rdb.dtsi                |   40 ++
 arch/powerpc/boot/dts/p2020ds.dtsi                 |   10 +
 arch/powerpc/boot/dts/p2020rdb.dts                 |    2 +-
 arch/powerpc/boot/dts/p2041rdb.dts                 |   41 ++-
 arch/powerpc/boot/dts/p3060qds.dts                 |  242 ------------
 arch/powerpc/boot/dts/sbc8560.dts                  |  406 --------------------
 arch/powerpc/configs/83xx/kmeter1_defconfig        |   22 +-
 arch/powerpc/configs/85xx/sbc8560_defconfig        |   65 ----
 arch/powerpc/configs/corenet32_smp_defconfig       |   10 +-
 arch/powerpc/configs/corenet64_smp_defconfig       |   66 +++-
 arch/powerpc/configs/mgcoge_defconfig              |   12 +-
 arch/powerpc/configs/mpc85xx_defconfig             |   24 ++
 arch/powerpc/configs/mpc85xx_smp_defconfig         |   25 ++
 arch/powerpc/include/asm/immap_qe.h                |    4 +-
 arch/powerpc/include/asm/qe.h                      |    1 +
 arch/powerpc/kernel/head_fsl_booke.S               |   23 +-
 arch/powerpc/kernel/setup-common.c                 |   27 ++
 arch/powerpc/kernel/setup_32.c                     |   24 --
 arch/powerpc/platforms/82xx/km82xx.c               |    5 +
 arch/powerpc/platforms/83xx/km83xx.c               |  100 ++++--
 arch/powerpc/platforms/85xx/Kconfig                |   43 ++-
 arch/powerpc/platforms/85xx/Makefile               |    4 +-
 arch/powerpc/platforms/85xx/bsc913x_rdb.c          |   67 ++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   97 ++----
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   22 +
 arch/powerpc/platforms/85xx/p1022_ds.c             |  106 +++++-
 arch/powerpc/platforms/85xx/p3060_qds.c            |   77 ----
 arch/powerpc/platforms/85xx/qemu_e500.c            |   72 ++++
 arch/powerpc/platforms/85xx/sbc8560.c              |  254 ------------
 arch/powerpc/platforms/Kconfig.cputype             |    4 +
 arch/powerpc/sysdev/fsl_pci.c                      |   73 ++++-
 arch/powerpc/sysdev/fsl_pci.h                      |    8 +
 arch/powerpc/sysdev/mpic.c                         |    2 +-
 arch/powerpc/sysdev/qe_lib/qe.c                    |    3 +
 drivers/watchdog/Kconfig                           |    8 +-
 drivers/watchdog/booke_wdt.c                       |    4 +-
 58 files changed, 1321 insertions(+), 1822 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/bsc9131rdb.dts
 create mode 100644 arch/powerpc/boot/dts/bsc9131rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
 copy arch/powerpc/boot/dts/{p1021rdb.dts => fsl/bsc9131si-pre.dtsi} (52%)
 delete mode 100644 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
 copy arch/powerpc/boot/dts/{p1021rdb.dtsi => p1021rdb-pc.dtsi} (99%)
 rename arch/powerpc/boot/dts/{p1021rdb.dts => p1021rdb-pc_32b.dts} (97%)
 copy arch/powerpc/boot/dts/{p1021rdb_36b.dts => p1021rdb-pc_36b.dts} (97%)
 rename arch/powerpc/boot/dts/{p1021rdb.dtsi => p1024rdb.dtsi} (79%)
 rename arch/powerpc/boot/dts/{fsl/p3060si-pre.dtsi => p1024rdb_32b.dts} (51%)
 rename arch/powerpc/boot/dts/{p1021rdb_36b.dts => p1024rdb_36b.dts} (71%)
 delete mode 100644 arch/powerpc/boot/dts/p3060qds.dts
 delete mode 100644 arch/powerpc/boot/dts/sbc8560.dts
 delete mode 100644 arch/powerpc/configs/85xx/sbc8560_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/bsc913x_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p3060_qds.c
 create mode 100644 arch/powerpc/platforms/85xx/qemu_e500.c
 delete mode 100644 arch/powerpc/platforms/85xx/sbc8560.c
