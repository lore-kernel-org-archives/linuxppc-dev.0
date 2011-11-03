Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DF1B6B6F83
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 05:28:08 +1100 (EST)
Date: Thu, 3 Nov 2011 13:27:56 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1111031327060.9315@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit 7680057cc4c7d9caada12767831bfd9738dd7b43:

  powerpc: Don't try OPAL takeover on old 970 blades (2011-09-29 17:04:59 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Anatolij Gustschin (1):
      powerpc/85xx: fix PHYS_64BIT selection for P1022DS

Becky Bruce (3):
      powerpc: Update mpc85xx/corenet 32-bit defconfigs
      powerpc: Update corenet64_smp_defconfig
      powerpc/fsl-booke: Fix settlbcam for 64-bit

Bharat Bhushan (1):
      powerpc: e500mc: Fix: use CONFIG_PPC_E500MC in idle_e500.S

Dmitry Eremin-Solenikov (4):
      powerpc/85xx: sbc8560 - correct compilation if CONFIG_PHYS_ADDR_T_64BIT is set
      powerpc/85xx: ksi8560 - declare that localbus is compatbile with simple-bus
      powerpc/85xx: sbc8560 - declare that localbus is compatbile with simple-bus
      powerpc/mpc8349emitx: mark localbus as compatible with simple-bus

Fabio Baltieri (1):
      powerpc/83xx: Add shutdown request support to MCU handling on MPC8349 MITX

Felix Radensky (1):
      powerpc/8xxx: Fix interrupt handling in MPC8xxx GPIO driver

Holger Brunck (1):
      powerpc/82xx: updates for mgcoge

Hongjun Chen (1):
      powerpc/cpm: Clear muram before it is in use.

Kumar Gala (6):
      powerpc/85xx: Rename PowerPC core nodes to match other e500mc based .dts
      powerpc/fsl-booke: Handle L1 D-cache parity error correctly on e500mc
      powerpc: respect mem= setting for early memory limit setup
      powerpc/fsl-booke: Fix setup_initial_memory_limit to not blindly map
      powerpc/85xx: Setup secondary cores PIR with hard SMP id
      powerpc/85xx: Add 'fsl,pq3-gpio' compatiable for GPIO driver

Liu Yu (3):
      powerpc/math_emu/efp: Use pr_debug instead of printk
      powerpc/math_emu/efp: No need to round if the result is exact
      powerpc/math_emu/efp: Look for errata handler when type mismatches

Martyn Welch (1):
      powerpc/86xx: Correct Gianfar support for GE boards

Matthew McClintock (4):
      powerpc/85xx: Fix support for enabling doorbells for IPIs
      powerpc/85xx: issue 15 EOI after core reset for FSL CoreNet devices
      powerpc/fsl_booke: Fix comment in head_fsl_booke.S
      powerpc/85xx: Make kexec to interate over online cpus

Mihai Caraman (1):
      drivers/virt: add ioctl for 32-bit compat on 64-bit to fsl-hv-manager

Mingkai Hu (1):
      powerpc/85xx: Rename p2040_rdb.c to p2041_rdb.c

Shengzhou Liu (1):
      powerpc/p3060qds: Add support for P3060QDS board

Stephen George (1):
      powerpc/85xx: Adding DCSR node to dtsi device trees

Timur Tabi (3):
      powerpc/fsl_msi: fix support for multiple MSI ranges
      powerpc/85xx: clean up FPGA device tree nodes for Freecsale QorIQ boards
      powerpc/fsl_msi: add support for "msi-address-64" property

 .../devicetree/bindings/powerpc/fsl/board.txt      |   30 +-
 .../devicetree/bindings/powerpc/fsl/dcsr.txt       |  395 ++++++++++++++++++++
 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |   42 ++
 arch/powerpc/boot/dts/gef_ppc9a.dts                |   33 ++-
 arch/powerpc/boot/dts/gef_sbc310.dts               |   33 ++-
 arch/powerpc/boot/dts/gef_sbc610.dts               |   33 ++-
 arch/powerpc/boot/dts/ksi8560.dts                  |    2 +-
 arch/powerpc/boot/dts/mgcoge.dts                   |    9 +
 arch/powerpc/boot/dts/mpc8349emitx.dts             |    3 +-
 arch/powerpc/boot/dts/p1022ds.dts                  |    2 +-
 arch/powerpc/boot/dts/p2020ds.dts                  |    5 +
 .../boot/dts/{p2040rdb.dts => p2041rdb.dts}        |   17 +-
 .../boot/dts/{p2040si.dtsi => p2041si.dtsi}        |  135 +++++--
 arch/powerpc/boot/dts/p3041ds.dts                  |    8 +-
 arch/powerpc/boot/dts/p3041si.dtsi                 |   71 ++++-
 .../boot/dts/{p2040rdb.dts => p3060qds.dts}        |  142 ++++++--
 .../boot/dts/{p2040si.dtsi => p3060si.dtsi}        |  314 ++++++++++------
 arch/powerpc/boot/dts/p4080ds.dts                  |   12 +-
 arch/powerpc/boot/dts/p4080si.dtsi                 |  114 +++++-
 arch/powerpc/boot/dts/p5020ds.dts                  |    8 +-
 arch/powerpc/boot/dts/p5020si.dtsi                 |   68 ++++-
 arch/powerpc/boot/dts/sbc8560.dts                  |    2 +-
 arch/powerpc/configs/corenet32_smp_defconfig       |   11 +-
 arch/powerpc/configs/corenet64_smp_defconfig       |    5 -
 arch/powerpc/configs/mgcoge_defconfig              |   27 +-
 arch/powerpc/configs/mpc85xx_defconfig             |    5 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    6 +-
 arch/powerpc/include/asm/reg_booke.h               |    3 +
 arch/powerpc/kernel/head_fsl_booke.S               |    4 +-
 arch/powerpc/kernel/idle_e500.S                    |    2 +-
 arch/powerpc/kernel/prom.c                         |    5 +-
 arch/powerpc/kernel/traps.c                        |    9 +-
 arch/powerpc/math-emu/math_efp.c                   |  100 +++---
 arch/powerpc/mm/fsl_booke_mmu.c                    |   43 ++-
 arch/powerpc/mm/mmu_decl.h                         |    2 +
 arch/powerpc/mm/tlb_nohash.c                       |   21 +-
 arch/powerpc/platforms/82xx/km82xx.c               |    4 +
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |   58 +++-
 arch/powerpc/platforms/85xx/Kconfig                |   20 +-
 arch/powerpc/platforms/85xx/Makefile               |    3 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |   11 +-
 .../platforms/85xx/{p2040_rdb.c => p2041_rdb.c}    |   18 +-
 .../platforms/85xx/{p2040_rdb.c => p3060_qds.c}    |   31 +-
 arch/powerpc/platforms/85xx/sbc8560.c              |    2 +-
 arch/powerpc/platforms/85xx/smp.c                  |   12 +-
 arch/powerpc/platforms/Kconfig                     |    2 +-
 arch/powerpc/sysdev/cpm_common.c                   |    3 +-
 arch/powerpc/sysdev/fsl_msi.c                      |   28 +-
 arch/powerpc/sysdev/fsl_msi.h                      |    3 +-
 arch/powerpc/sysdev/mpic.c                         |   10 +
 drivers/gpio/gpio-mpc8xxx.c                        |    3 +
 drivers/virt/fsl_hypervisor.c                      |    1 +
 52 files changed, 1527 insertions(+), 403 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/dcsr.txt
 copy arch/powerpc/boot/dts/{p2040rdb.dts => p2041rdb.dts} (95%)
 copy arch/powerpc/boot/dts/{p2040si.dtsi => p2041si.dtsi} (80%)
 rename arch/powerpc/boot/dts/{p2040rdb.dts => p3060qds.dts} (62%)
 rename arch/powerpc/boot/dts/{p2040si.dtsi => p3060si.dtsi} (65%)
 copy arch/powerpc/platforms/85xx/{p2040_rdb.c => p2041_rdb.c} (82%)
 rename arch/powerpc/platforms/85xx/{p2040_rdb.c => p3060_qds.c} (73%)
