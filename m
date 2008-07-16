Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA12BDE0D8
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:09:24 +1000 (EST)
Date: Wed, 16 Jul 2008 18:02:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [UPDATE][FOR 2.6.27] Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0807161801360.26841@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'powerpc-next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

Note: this tree is based on Linus's master as I need to revert a commit he
applied to the ep8248e board.

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt                |  189 ++--
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/gpio.txt      |   38
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt    |   53 -
 Documentation/powerpc/dts-bindings/fsl/mcu-mpc8349emitx.txt |   17
 Documentation/powerpc/dts-bindings/fsl/pmc.txt              |   63 +
 Documentation/powerpc/dts-bindings/fsl/tsec.txt             |   31
 Documentation/powerpc/dts-bindings/fsl/upm-nand.txt         |   28
 Documentation/powerpc/dts-bindings/gpio/led.txt             |   15
 arch/powerpc/Kconfig                                        |   14
 arch/powerpc/boot/dts/mpc7448hpc2.dts                       |   24
 arch/powerpc/boot/dts/mpc8313erdb.dts                       |  241 +++--
 arch/powerpc/boot/dts/mpc8610_hpcd.dts                      |   14
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig              |    8
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig              |    8
 arch/powerpc/configs/mpc85xx_defconfig                      |    8
 arch/powerpc/configs/mpc8610_hpcd_defconfig                 |  121 ++
 arch/powerpc/configs/mpc8641_hpcn_defconfig                 |    8
 arch/powerpc/kernel/head_fsl_booke.S                        |  187 +---
 arch/powerpc/platforms/52xx/Kconfig                         |    1
 arch/powerpc/platforms/82xx/Kconfig                         |    1
 arch/powerpc/platforms/82xx/ep8248e.c                       |    4
 arch/powerpc/platforms/83xx/Kconfig                         |    3
 arch/powerpc/platforms/83xx/Makefile                        |    2
 arch/powerpc/platforms/83xx/mpc831x_rdb.c                   |    1
 arch/powerpc/platforms/83xx/mpc832x_mds.c                   |    1
 arch/powerpc/platforms/83xx/mpc832x_rdb.c                   |    1
 arch/powerpc/platforms/83xx/mpc834x_itx.c                   |    1
 arch/powerpc/platforms/83xx/mpc834x_mds.c                   |    1
 arch/powerpc/platforms/83xx/mpc836x_mds.c                   |    1
 arch/powerpc/platforms/83xx/mpc836x_rdk.c                   |    1
 arch/powerpc/platforms/83xx/mpc837x_mds.c                   |    1
 arch/powerpc/platforms/83xx/mpc837x_rdb.c                   |    1
 arch/powerpc/platforms/83xx/mpc83xx.h                       |    5
 arch/powerpc/platforms/83xx/pci.c                           |   91 --
 arch/powerpc/platforms/83xx/sbc834x.c                       |    1
 arch/powerpc/platforms/83xx/suspend-asm.S                   |  533 ++++++++++++
 arch/powerpc/platforms/83xx/suspend.c                       |  388 ++++++++
 arch/powerpc/platforms/83xx/usb.c                           |   24
 arch/powerpc/platforms/85xx/Kconfig                         |    3
 arch/powerpc/platforms/85xx/mpc85xx_ds.c                    |    2
 arch/powerpc/platforms/86xx/Kconfig                         |    3
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c                  |   87 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c                  |    2
 arch/powerpc/platforms/Kconfig                              |    6
 arch/powerpc/platforms/Kconfig.cputype                      |    2
 arch/powerpc/platforms/fsl_uli1575.c                        |  117 ++
 arch/powerpc/platforms/iseries/Kconfig                      |    1
 arch/powerpc/platforms/ps3/Kconfig                          |    1
 arch/powerpc/platforms/pseries/Kconfig                      |    1
 arch/powerpc/sysdev/fsl_pci.c                               |   61 +
 arch/powerpc/sysdev/fsl_pci.h                               |    1
 arch/powerpc/sysdev/fsl_soc.c                               |   90 --
 arch/powerpc/sysdev/fsl_soc.h                               |    1
 arch/powerpc/sysdev/ipic.c                                  |   71 +
 arch/powerpc/sysdev/qe_lib/qe.c                             |    6
 arch/powerpc/sysdev/qe_lib/ucc.c                            |    6
 arch/powerpc/sysdev/qe_lib/ucc_fast.c                       |   16
 drivers/net/fs_enet/Makefile                                |    5
 drivers/net/fs_enet/fs_enet-main.c                          |  310 ------
 drivers/net/fs_enet/fs_enet.h                               |    4
 drivers/net/fs_enet/mac-fcc.c                               |   67 -
 drivers/net/fs_enet/mac-fec.c                               |   23
 drivers/net/fs_enet/mac-scc.c                               |   37
 drivers/net/fs_enet/mii-bitbang.c                           |  107 --
 drivers/net/fs_enet/mii-fec.c                               |  144 ---
 drivers/net/gianfar.c                                       |  122 ++
 drivers/net/gianfar.h                                       |   12
 drivers/net/gianfar_ethtool.c                               |   41
 include/asm-powerpc/pgtable-ppc32.h                         |   15
 include/asm-powerpc/reg.h                                   |    4
 include/asm-powerpc/ucc_fast.h                              |    8
 include/linux/fs_enet_pd.h                                  |    4
 include/linux/fsl_devices.h                                 |    7
 73 files changed, 2163 insertions(+), 1353 deletions(-)

Andy Fleming (2):
      powerpc: Add support for multiple gfar mdio interfaces
      powerpc: Fix a bunch of sparse warnings in the qe_lib

Anton Vorontsov (6):
      powerpc/83xx: fix ULPI setup for MPC8315 processors
      powerpc/fsl_soc: gianfar: don't probe disabled devices
      powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs bindings
      powerpc/fsl_uli1575: fix RTC quirk to work on MPC8572DS and MPC8610HPCD
      powerpc/85xx/86xx: some refactoring for fsl_uli1575 code
      powerpc/86xx: mpc8610_hpcd - add support for ULI RTC

Jochen Friedrich (1):
      powerpc: Add documentation for CPM GPIO banks

John Rigby (2):
      powerpc: pci config cleanup
      powerpc: Move mpc83xx_add_bridge to fsl_pci.c

Kumar Gala (6):
      fs_enet: Remove !CONFIG_PPC_CPM_NEW_BINDING code
      powerpc: Remove Kconfig PPC_CPM_NEW_BINDING
      powerpc: rework FSL Book-E PTE access and TLB miss
      powerpc/fsl: Minor TLBSYNC cleanup for FSL Book-E
      powerpc/ep8248e: Unconditionally select PHYLIB for mdio_bitbang
      Revert "powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET"

Paul Gortmaker (1):
      powerpc/mpc7448: add alias list to DTS, clean out old chosen node

Scott Wood (6):
      powerpc: Document Freescale power management nodes, and the sleep property.
      powerpc: Update example SOC node in booting-without-of.txt.
      powerpc/mpc83xx: Power Management support
      powerpc/mpc8313erdb: Add power management to the device tree.
      gianfar: Add magic packet and suspend/resume support.
      Add fsl,magic-packet to, and clean up, the gianfar binding.

Timur Tabi (1):
      powerpc: fix ALSA options in Freescale 85xx and 86xx defconfigs
