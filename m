Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01235DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 12:59:13 +1100 (EST)
Date: Wed, 23 Jan 2008 19:56:47 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.25' branch
Message-ID: <Pine.LNX.4.64.0801231955500.8976@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.25' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.25

to receive the following updates:

(I fixed up the memreserve patch, it builds for me on ppc64)

 Documentation/powerpc/00-INDEX                    |    3
 Documentation/powerpc/booting-without-of.txt      |   91 +
 Documentation/powerpc/qe_firmware.txt             |  295 ++++
 arch/powerpc/Kconfig                              |    3
 arch/powerpc/boot/.gitignore                      |    1
 arch/powerpc/boot/Makefile                        |   10
 arch/powerpc/boot/cuboot-824x.c                   |   53
 arch/powerpc/boot/cuboot-83xx.c                   |    3
 arch/powerpc/boot/cuboot-85xx.c                   |    5
 arch/powerpc/boot/devtree.c                       |   14
 arch/powerpc/boot/dts/adder875-redboot.dts        |  184 ++
 arch/powerpc/boot/dts/adder875-uboot.dts          |  183 ++
 arch/powerpc/boot/dts/ep8248e.dts                 |  207 +++
 arch/powerpc/boot/dts/mpc8313erdb.dts             |   49
 arch/powerpc/boot/dts/mpc832x_mds.dts             |   51
 arch/powerpc/boot/dts/mpc8349emitx.dts            |   30
 arch/powerpc/boot/dts/mpc8349emitxgp.dts          |    1
 arch/powerpc/boot/dts/mpc834x_mds.dts             |    2
 arch/powerpc/boot/dts/mpc836x_mds.dts             |    1
 arch/powerpc/boot/dts/mpc8377_mds.dts             |  279 ++++
 arch/powerpc/boot/dts/mpc8378_mds.dts             |  265 +++
 arch/powerpc/boot/dts/mpc8379_mds.dts             |  293 ++++
 arch/powerpc/boot/dts/mpc8544ds.dts               |    6
 arch/powerpc/boot/dts/mpc8572ds.dts               |    7
 arch/powerpc/boot/dts/mpc8610_hpcd.dts            |  113 +
 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |   48
 arch/powerpc/boot/dts/storcenter.dts              |  138 ++
 arch/powerpc/boot/ep8248e.c                       |   55
 arch/powerpc/boot/ops.h                           |   14
 arch/powerpc/boot/redboot-8xx.c                   |   58
 arch/powerpc/boot/redboot.h                       |   56
 arch/powerpc/boot/wrapper                         |    2
 arch/powerpc/configs/adder875-redboot_defconfig   |  798 +++++++++++
 arch/powerpc/configs/adder875-uboot_defconfig     |  798 +++++++++++
 arch/powerpc/configs/ep8248e_defconfig            |  821 +++++++++++
 arch/powerpc/configs/mpc8313_rdb_defconfig        |   46
 arch/powerpc/configs/mpc834x_itx_defconfig        |    3
 arch/powerpc/configs/mpc8610_hpcd_defconfig       |  171 ++
 arch/powerpc/configs/storcenter_defconfig         | 1174 +++++++++++++++++
 arch/powerpc/kernel/Makefile                      |    1
 arch/powerpc/kernel/head_fsl_booke.S              |   20
 arch/powerpc/kernel/pci-common.c                  |    8
 arch/powerpc/kernel/pci_32.c                      |   58
 arch/powerpc/kernel/rio.c                         |   52
 arch/powerpc/math-emu/op-4.h                      |   40
 arch/powerpc/mm/fsl_booke_mmu.c                   |    6
 arch/powerpc/mm/lmb.c                             |   13
 arch/powerpc/mm/mem.c                             |   21
 arch/powerpc/platforms/82xx/Kconfig               |   13
 arch/powerpc/platforms/82xx/Makefile              |    1
 arch/powerpc/platforms/82xx/ep8248e.c             |  324 ++++
 arch/powerpc/platforms/83xx/mpc8313_rdb.c         |   13
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    5
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |   10
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |   12
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |    5
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    5
 arch/powerpc/platforms/83xx/mpc837x_mds.c         |   56
 arch/powerpc/platforms/83xx/mpc83xx.h             |    3
 arch/powerpc/platforms/83xx/usb.c                 |   46
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |   18
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    6
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    7
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c        |   15
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   14
 arch/powerpc/platforms/8xx/Kconfig                |    9
 arch/powerpc/platforms/8xx/Makefile               |    1
 arch/powerpc/platforms/8xx/adder875.c             |  118 +
 arch/powerpc/platforms/8xx/ep88xc.c               |    5
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |    5
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |    5
 arch/powerpc/platforms/Kconfig                    |    6
 arch/powerpc/platforms/embedded6xx/Kconfig        |   23
 arch/powerpc/platforms/embedded6xx/Makefile       |    1
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2
 arch/powerpc/platforms/embedded6xx/storcenter.c   |  192 ++
 arch/powerpc/sysdev/Makefile                      |    3
 arch/powerpc/sysdev/fsl_pci.c                     |  150 --
 arch/powerpc/sysdev/fsl_rio.c                     |  932 +++++++++++++
 arch/powerpc/sysdev/fsl_rio.h                     |   20
 arch/powerpc/sysdev/fsl_soc.c                     |  103 +
 arch/powerpc/sysdev/ipic.c                        |   62
 arch/powerpc/sysdev/mpic.c                        |    4
 arch/powerpc/sysdev/qe_lib/Kconfig                |    2
 arch/powerpc/sysdev/qe_lib/qe.c                   |  247 +++
 arch/powerpc/sysdev/qe_lib/ucc_slow.c             |   10
 arch/ppc/kernel/Makefile                          |    1
 arch/ppc/kernel/rio.c                             |   52
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c      |    3
 arch/ppc/platforms/85xx/stx_gp3.c                 |    2
 arch/ppc/platforms/85xx/tqm85xx.c                 |    2
 arch/ppc/syslib/Makefile                          |    1
 arch/ppc/syslib/ppc85xx_rio.c                     |  932 -------------
 arch/ppc/syslib/ppc85xx_rio.h                     |   20
 drivers/net/fs_enet/fs_enet-main.c                |    9
 drivers/net/phy/Kconfig                           |   32
 drivers/net/phy/fixed.c                           |  445 ++----
 drivers/rapidio/rio.c                             |    5
 drivers/serial/Kconfig                            |   10
 drivers/serial/Makefile                           |    1
 drivers/serial/cpm_uart/cpm_uart_cpm2.c           |    2
 drivers/serial/ucc_uart.c                         | 1514 ++++++++++++++++++++++
 include/asm-powerpc/immap_qe.h                    |   34
 include/asm-powerpc/lmb.h                         |    1
 include/asm-powerpc/mpc8260.h                     |    1
 include/asm-powerpc/pci-bridge.h                  |    3
 include/asm-powerpc/qe.h                          |   61
 include/asm-powerpc/system.h                      |    2
 include/linux/phy_fixed.h                         |   51
 109 files changed, 10511 insertions(+), 1676 deletions(-)

Anton Vorontsov (1):
      [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes

Becky Bruce (1):
      [POWERPC] Fixup use of phys_addr_t in mpic code

Dale Farnsworth (1):
      [POWERPC] 85xx: Respect KERNELBASE, PAGE_OFFSET, and PHYSICAL_START on e500

Grant Likely (1):
      [POWERPC] 8xx: Use machine_*_initcall() hooks in platform code

Jochen Friedrich (1):
      fs_enet: Add fixed-phy support for fs_enet

John Rigby (2):
      [POWERPC] Add support for mpc512x interrupts to ipic
      [POWERPC] Add IPIC Kconfig option

Jon Loeliger (4):
      [POWERPC] Add _nmask_and_or_msr() declartion to asm-powerpc/system.h
      [POWERPC] Add StorCenter DTS first draft.
      [POWERPC] Add initial iomega StorCenter board port.
      [POWERPC] Add initial storcenter config file.

Kumar Gala (13):
      [POWERPC] Fix handling of memreserve if the range lands in highmem
      [POWERPC] Ensure we only handle PowerMac PCI bus fixup for memory resources
      [POWERPC] Fixup transparent P2P resources
      [POWERPC] FSL: Rework PCI/PCIe support for 85xx/86xx
      [POWERPC] Remove update_bridge_resource
      [POWERPC] 85xx: convert boards to use machine_device_initcall
      [POWERPC] 83xx: convert boards to use machine_device_initcall
      [POWERPC] bootwrapper: Add find_node_by_alias and dt_fixup_mac_address_by_alias
      [POWERPC] bootwrapper: convert cuboot-8{3,5}xx to dt_fixup_mac_address_by_alias
      [POWERPC] Fix incorrect interrupt map on FSL reference boards
      [RAPIDIO] Fix compile error and warning
      [POWERPC] Move RapidIO support code from arch/ppc
      [POWERPC] Fix compile error if CONFIG_STX_GP3 is defined

Li Yang (3):
      [POWERPC] 83xx: add device trees for MPC837x MDS board
      [POWERPC] 83xx: Add MPC837x USB platform support
      [POWERPC] 83xx: USB device tree cleanups

Liu Yu (1):
      [POWERPC] Fix carry bug in 128-bit unsigned integer adding

Paul Gortmaker (1):
      [POWERPC] 85xx: mpc85xx_ads: add in missing of_node_put()

Scott Wood (7):
      [POWERPC] fsl_soc: Fix get_immrbase() to use ranges, rather than reg.
      [POWERPC] 8xx: Analogue & Micro Adder875 board support.
      [POWERPC] 82xx: Embedded Planet EP8248E support
      [POWERPC] 83xx: MPC8313e RBD add NAND to device tree
      [POWERPC] 83xx: MPC8313e RDB - Add NOR flash to the device tree.
      [POWERPC] 83xx: Update MPC8313e RDB defconfig for MTD, NAND, JFFS2.
      [POWERPC] 8xx: adder875 - Fix flash bus-width and remove duplicate __initdata

Timur Tabi (4):
      [POWERPC] QE: Add ability to upload QE firmware
      [POWERPC] QE: Add support for Freescale QUICCEngine UART
      [POWERPC] qe-uart: add support for Freescale QUICCEngine UART
      [POWERPC] Update MPC8610 HPCD to support audio drivers

Vitaly Bordug (3):
      phy/fixed.c: rework to not duplicate PHY layer functionality
      [POWERPC] MPC8349E-mITX: Vitesse 7385 PHY is not connected to the MDIO bus
      [POWERPC] fsl_soc: add support to gianfar for fixed-link property

Wade Farnsworth (2):
      [POWERPC] 86xx: Add localbus and flash nodes to mpc8641_hpcn.dts
      [POWERPC] 86xx: MPC8641 HPCN - call of_platform_bus_probe()
