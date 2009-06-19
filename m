Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C85BEB7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 15:56:33 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4F3EDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 15:56:32 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 15:56:15 +1000
Message-Id: <1245390975.16880.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here's another batch to finally drain my queue. There will be bug fixes
coming but they don't need to be before -rc1. The only "feature" I'm
still considering merging this time around and that isn't there yet is
the support for irqtrace/lockdep on ppc32 since it's a useful debug
tool, and mostly should be a nop unless lockdep is enabled.

The following changes since commit 0732f87761dbe417cb6e084b712d07e879e876ef:
  Linus Torvalds (1):
        Merge branch 'for_linus' of git://git.kernel.org/.../tytso/ext4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Vorontsov (2):
      powerpc/83xx: Update sdhci nodes per new bindings
      powerpc/5200: convert mpc52xx_psc_spi to use cs_control callback

Becky Bruce (1):
      powerpc: Add 86xx support for SWIOTLB

Benjamin Herrenschmidt (5):
      powerpc: Fix invalid construct in our CPU selection Kconfig
      powerpc: Add memory clobber to mtspr()
      Merge commit 'origin/master' into next
      Merge commit 'origin/master' into next
      Merge commit 'gcl/merge' into next

Dave Liu (1):
      serial: Make ucc_uart work in HW UART mode

Dave Mitchell (1):
      of_serial: Add UPF_FIXED_TYPE flag

Geert Uytterhoeven (3):
      net/ps3: gelic - Add missing annotations
      ps3rom: Use ps3_system_bus_[gs]et_drvdata() instead of direct access
      usb/ps3: Add missing annotations

Gerhard Pircher (1):
      powerpc: Enable additional BAT registers in setup_745x_specifics()

Grant Likely (1):
      fbdev/xilinxfb: Fix improper casting and tighen up probe path

Haiying Wang (1):
      powerpc/85xx: Add UCC6 and UCC8 nodes in SGMII mode for MPC8569MDS

Heiko Schocher (1):
      83xx: add support for the kmeter1 board.

Kevin Hao (1):
      powerpc/85xx: Add nor flash partitions for mpc8569mds

Kumar Gala (1):
      powerpc/85xx: Add SWIOTLB support to FSL boards

Martyn Welch (1):
      powerpc/86xx: Add I2C device mappings in DTS for SBC610

Michael Ellerman (1):
      powerpc: Add configurable -Werror for arch/powerpc

Mike Frysinger (1):
      drivers/hvc: Add missing __devexit_p()

Nate Case (6):
      powerpc/fsl-booke: Enable L1 cache on e500v1/e500v2/e500mc CPUs
      powerpc/85xx: cuboot - Fix up ethernet3 MAC address on MPC85xx
      powerpc/85xx: Add platform support for X-ES MPC85xx boards
      powerpc/85xx: Add dts files for X-ES MPC85xx boards
      powerpc/85xx: Add defconfig for X-ES MPC85xx boards
      powerpc/bootwrapper: Custom build options for XPedite52xx targets

Peter Korsgaard (1):
      powerpc/mpc83xx: Fix usb mux setup for mpc834x

Sean MacLennan (1):
      powerpc/warp: Fix ISA_DMA_THRESHOLD default

Timur Tabi (1):
      powerpc: Introduce macro spin_event_timeout()

Wolfgang Denk (2):
      powerpc/mpc8272ads: fix device tree for 8 MB flash size
      powerpc/5xxx: Add common mpc5xxx_get_bus_frequency() function

Wolfram Sang (2):
      powerpc/5200: Update pcm030.dts to add i2c eeprom and delete cruft
      powerpc/5121: make clock debug output more readable

Yang Li (1):
      rio: warn_unused_result warnings fix

leon.woestenberg@gmail.com (1):
      powerpc/83xx: Add MSI interrupts to DTS of MPC8315E-RDB

mware@internode.on.net (1):
      powerpc/fsl: Increase the number of possible localbus banks

 arch/powerpc/Kconfig.debug                        |   17 +
 arch/powerpc/boot/cuboot-85xx.c                   |    2 +
 arch/powerpc/boot/dts/asp834x-redboot.dts         |    2 +-
 arch/powerpc/boot/dts/gef_sbc610.dts              |   10 +
 arch/powerpc/boot/dts/kmeter1.dts                 |  520 ++++++
 arch/powerpc/boot/dts/mpc8272ads.dts              |   19 +-
 arch/powerpc/boot/dts/mpc8315erdb.dts             |   15 +
 arch/powerpc/boot/dts/mpc8349emitx.dts            |    2 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8377_mds.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8378_mds.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8379_mds.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8569mds.dts              |   87 +-
 arch/powerpc/boot/dts/pcm030.dts                  |   26 +-
 arch/powerpc/boot/dts/sbc8349.dts                 |    2 +-
 arch/powerpc/boot/dts/xcalibur1501.dts            |  696 ++++++++
 arch/powerpc/boot/dts/xpedite5200.dts             |  466 ++++++
 arch/powerpc/boot/dts/xpedite5200_xmon.dts        |  506 ++++++
 arch/powerpc/boot/dts/xpedite5301.dts             |  640 ++++++++
 arch/powerpc/boot/dts/xpedite5330.dts             |  707 ++++++++
 arch/powerpc/boot/dts/xpedite5370.dts             |  638 ++++++++
 arch/powerpc/boot/wrapper                         |    4 +
 arch/powerpc/configs/83xx/kmeter1_defconfig       |  908 ++++++++++
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   | 1821 +++++++++++++++++++++
 arch/powerpc/include/asm/delay.h                  |   36 +
 arch/powerpc/include/asm/fsl_lbc.h                |    4 +-
 arch/powerpc/include/asm/mpc52xx.h                |    2 +-
 arch/powerpc/include/asm/{mpc512x.h => mpc5xxx.h} |   10 +-
 arch/powerpc/include/asm/reg.h                    |    3 +-
 arch/powerpc/include/asm/reg_booke.h              |    2 +
 arch/powerpc/kernel/Makefile                      |    2 +
 arch/powerpc/kernel/cpu_setup_6xx.S               |    3 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S         |   49 +-
 arch/powerpc/kvm/Makefile                         |    2 +
 arch/powerpc/lib/Makefile                         |    2 +
 arch/powerpc/mm/Makefile                          |    2 +
 arch/powerpc/oprofile/Makefile                    |    2 +
 arch/powerpc/platforms/44x/warp.c                 |    8 +-
 arch/powerpc/platforms/512x/clock.c               |   10 +-
 arch/powerpc/platforms/512x/mpc512x.h             |    1 -
 arch/powerpc/platforms/512x/mpc512x_shared.c      |   23 -
 arch/powerpc/platforms/52xx/mpc52xx_common.c      |   32 +-
 arch/powerpc/platforms/83xx/Kconfig               |    7 +
 arch/powerpc/platforms/83xx/Makefile              |    1 +
 arch/powerpc/platforms/83xx/kmeter1.c             |  191 +++
 arch/powerpc/platforms/83xx/mpc83xx.h             |    4 +-
 arch/powerpc/platforms/83xx/usb.c                 |   10 +-
 arch/powerpc/platforms/85xx/Kconfig               |   13 +
 arch/powerpc/platforms/85xx/Makefile              |    1 +
 arch/powerpc/platforms/85xx/mpc8536_ds.c          |   17 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |   19 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   20 +
 arch/powerpc/platforms/85xx/xes_mpc85xx.c         |  282 ++++
 arch/powerpc/platforms/86xx/Kconfig               |    1 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   15 +
 arch/powerpc/platforms/Kconfig.cputype            |    9 +-
 arch/powerpc/platforms/Makefile                   |    2 +
 arch/powerpc/sysdev/Makefile                      |    5 +
 arch/powerpc/sysdev/mpc5xxx_clocks.c              |   33 +
 arch/powerpc/xmon/Makefile                        |    2 +
 drivers/ata/pata_mpc52xx.c                        |    2 +-
 drivers/char/hvc_iseries.c                        |    2 +-
 drivers/char/hvc_vio.c                            |    2 +-
 drivers/char/hvcs.c                               |    2 +-
 drivers/i2c/busses/i2c-mpc.c                      |    2 +-
 drivers/net/fec_mpc52xx.c                         |    2 +-
 drivers/net/fec_mpc52xx_phy.c                     |    2 +-
 drivers/net/ps3_gelic_net.c                       |   22 +-
 drivers/net/ps3_gelic_wireless.c                  |    6 +-
 drivers/rapidio/rio-scan.c                        |   43 +-
 drivers/rapidio/rio-sysfs.c                       |    6 +-
 drivers/scsi/ps3rom.c                             |   10 +-
 drivers/serial/mpc52xx_uart.c                     |    5 +-
 drivers/serial/of_serial.c                        |    2 +-
 drivers/serial/ucc_uart.c                         |   19 +-
 drivers/spi/mpc52xx_psc_spi.c                     |   22 +-
 drivers/usb/host/ehci-ps3.c                       |    4 +-
 drivers/usb/host/ohci-ps3.c                       |    4 +-
 drivers/video/xilinxfb.c                          |   59 +-
 drivers/watchdog/mpc5200_wdt.c                    |    2 +-
 include/linux/fsl_devices.h                       |    4 -
 84 files changed, 7916 insertions(+), 233 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/kmeter1.dts
 create mode 100644 arch/powerpc/boot/dts/xcalibur1501.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5200.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5200_xmon.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5301.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5330.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5370.dts
 create mode 100644 arch/powerpc/configs/83xx/kmeter1_defconfig
 create mode 100644 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
 rename arch/powerpc/include/asm/{mpc512x.h => mpc5xxx.h} (65%)
 create mode 100644 arch/powerpc/platforms/83xx/kmeter1.c
 create mode 100644 arch/powerpc/platforms/85xx/xes_mpc85xx.c
 create mode 100644 arch/powerpc/sysdev/mpc5xxx_clocks.c
