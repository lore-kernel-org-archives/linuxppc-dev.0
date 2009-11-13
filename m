Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8AFFB6F2B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 00:40:37 +1100 (EST)
Date: Fri, 13 Nov 2009 07:40:30 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: pull request for next
Message-ID: <Pine.LNX.4.64.0911130740080.840@localhost.localdomain>
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

The following changes since commit 0526484aa345adbf790d1201a6f5d09be0a648a3:
  Benjamin Herrenschmidt (1):
        Merge commit 'origin/master' into next

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Anton Vorontsov (18):
      powerpc/qe: Increase MAX_QE_RISC to 4
      powerpc/qe: Add qe_upload_firmware() stub for non-QE builds
      powerpc/qe: Make qe_reset() code path safe for repeated invocation
      powerpc/qe: QE also shuts down on MPC8568
      powerpc/cpm: Remove SPI defines and spi structs
      powerpc/qe&cpm2: Avoid redefinitions in CPM2 and QE headers
      powerpc/cpm: Move CPMFCR_* defines into cpm.h
      powerpc/qe&cpm: Implement static inline stubs for non-QE/CPM builds
      spi_mpc8xxx: Fix uninitialized variable
      spi_mpc8xxx: Factor out SPI mode change steps into a call
      spi_mpc8xxx: Turn qe_mode into flags
      spi_mpc8xxx: Add support for QE DMA mode and CPM1/CPM2 chips
      powerpc/qe: Implement QE driver for handling resume on MPC85xx
      powerpc/85xx/86xx: Add suspend/resume support
      powerpc/85xx: Add power management support for MPC85xxMDS boards
      powerpc/86xx: Add power management support for MPC8610HPCD boards
      powerpc/83xx: Add power management support for MPC83xx QE boards
      powerpc/fsl: Make fsl_deep_sleep() usable w/ modules and non-83xx builds

Kumar Gala (3):
      powerpc/85xx: Kconfig cleanup
      powerpc/fsl-booke: Rework TLB CAM code
      powerpc/fsl: Add PCI device ids for new QoirQ chips

Martyn Welch (3):
      powerpc/86xx: Enable NVRAM on GE Fanuc's SBC610
      powerpc/86xx: Support for NVRAM on GE Fanuc's SBC310
      powerpc/86xx: Support for NVRAM on GE Fanuc's PPC9A

Poonam Aggrwal (2):
      powerpc/85xx: Create dts for each core in CAMP mode for P2020RDB
      powerpc/85xx: Added P1020RDB Platform support.

 Documentation/powerpc/dts-bindings/fsl/board.txt |    4 +
 arch/powerpc/Kconfig                             |   11 +-
 arch/powerpc/boot/dts/gef_ppc9a.dts              |    6 +
 arch/powerpc/boot/dts/gef_sbc310.dts             |    6 +
 arch/powerpc/boot/dts/gef_sbc610.dts             |    6 +
 arch/powerpc/boot/dts/kmeter1.dts                |    7 +
 arch/powerpc/boot/dts/mpc832x_mds.dts            |    9 +
 arch/powerpc/boot/dts/mpc832x_rdb.dts            |    9 +
 arch/powerpc/boot/dts/mpc836x_mds.dts            |    9 +
 arch/powerpc/boot/dts/mpc836x_rdk.dts            |    9 +
 arch/powerpc/boot/dts/mpc8568mds.dts             |  119 +++--
 arch/powerpc/boot/dts/mpc8569mds.dts             |  111 +++--
 arch/powerpc/boot/dts/mpc8610_hpcd.dts           |   26 +
 arch/powerpc/boot/dts/p1020rdb.dts               |  477 +++++++++++++++++
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts    |  363 +++++++++++++
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts    |  184 +++++++
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig    |    2 +-
 arch/powerpc/configs/86xx/gef_sbc310_defconfig   |    2 +-
 arch/powerpc/configs/86xx/gef_sbc610_defconfig   |    4 +-
 arch/powerpc/include/asm/cpm.h                   |   82 +++
 arch/powerpc/include/asm/cpm1.h                  |   45 --
 arch/powerpc/include/asm/cpm2.h                  |   47 --
 arch/powerpc/include/asm/immap_cpm2.h            |    2 +-
 arch/powerpc/include/asm/immap_qe.h              |    8 +-
 arch/powerpc/include/asm/qe.h                    |   43 ++-
 arch/powerpc/kernel/asm-offsets.c                |    3 -
 arch/powerpc/kernel/head_fsl_booke.S             |   22 -
 arch/powerpc/mm/fsl_booke_mmu.c                  |  132 +++--
 arch/powerpc/mm/mmu_decl.h                       |   11 -
 arch/powerpc/platforms/83xx/suspend.c            |    1 +
 arch/powerpc/platforms/85xx/Kconfig              |   11 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c        |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c        |   34 ++-
 arch/powerpc/platforms/86xx/Kconfig              |    3 +
 arch/powerpc/platforms/86xx/gef_ppc9a.c          |    5 +
 arch/powerpc/platforms/86xx/gef_sbc310.c         |    5 +
 arch/powerpc/platforms/86xx/gef_sbc610.c         |    5 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c       |   48 ++-
 arch/powerpc/platforms/Kconfig                   |    2 +-
 arch/powerpc/platforms/Kconfig.cputype           |   17 +-
 arch/powerpc/platforms/Makefile                  |    2 +-
 arch/powerpc/sysdev/Makefile                     |    1 +
 arch/powerpc/sysdev/cpm_common.c                 |    5 +-
 arch/powerpc/sysdev/fsl_pci.c                    |   18 +-
 arch/powerpc/sysdev/fsl_pmc.c                    |   88 +++
 arch/powerpc/sysdev/fsl_soc.c                    |    2 +-
 arch/powerpc/sysdev/qe_lib/qe.c                  |   61 ++-
 drivers/spi/Kconfig                              |    3 -
 drivers/spi/spi_mpc8xxx.c                        |  623 +++++++++++++++++++---
 drivers/usb/gadget/fsl_qe_udc.h                  |   15 -
 include/linux/fsl_devices.h                      |    6 +-
 include/linux/pci_ids.h                          |   14 +
 52 files changed, 2308 insertions(+), 421 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
 create mode 100644 arch/powerpc/sysdev/fsl_pmc.c
