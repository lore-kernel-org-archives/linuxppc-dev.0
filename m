Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 74B442C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 08:19:04 +1100 (EST)
Date: Wed, 15 Jan 2014 22:18:59 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20140115221859.50866e87@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

please pull mpc5xxx patches for v3.14:

Switch mpc512x to the common clock framework and adapt mpc512x
drivers to use the new clock driver. Old PPC_CLOCK code is
removed entirely since there are no users any more.

All these patches have been in linux-next for more then
two weeks now.

Thanks,
Anatolij

The following changes since commit dece8ada993e1764a115bdff0f1effffaa5fc8dc:

  Merge branch 'merge' into next (2013-12-30 15:19:31 +1100)

are available in the git repository at:


  git://git.denx.de/linux-2.6-agust.git next

for you to fetch changes up to bc75059422338197ce487d338ac9c898761e1e61:

  powerpc/512x: dts: add MPC5125 clock specs (2014-01-12 18:59:50 +0100)

----------------------------------------------------------------
Gerhard Sittig (20):
      dts: mpc512x: introduce dt-bindings/clock/ header
      dts: mpc512x: add clock related device tree specs
      clk: mpc512x: introduce COMMON_CLK for MPC512x (disabled)
      clk: mpc512x: add backwards compat to the CCF code
      dts: mpc512x: add clock specs for client lookups
      clk: mpc5xxx: switch to COMMON_CLK, retire PPC_CLOCK
      spi: mpc512x: adjust to OF based clock lookup
      serial: mpc512x: adjust for OF based clock lookup
      serial: mpc512x: setup the PSC FIFO clock as well
      USB: fsl-mph-dr-of: adjust for OF based clock lookup
      mtd: mpc5121_nfc: adjust for OF based clock lookup
      fsl-viu: adjust for OF based clock lookup
      net: can: mscan: adjust to common clock support for mpc512x
      net: can: mscan: remove non-CCF code for MPC512x
      powerpc/mpc512x: improve DIU related clock setup
      clk: mpc512x: remove migration support workarounds
      powerpc/512x: clk: minor comment updates
      powerpc/512x: clk: enforce even SDHC divider values
      powerpc/512x: clk: support MPC5121/5123/5125 SoC variants
      powerpc/512x: dts: add MPC5125 clock specs

 arch/powerpc/Kconfig                          |    5 -
 arch/powerpc/boot/dts/ac14xx.dts              |    7 +
 arch/powerpc/boot/dts/mpc5121.dtsi            |  113 ++-
 arch/powerpc/boot/dts/mpc5125twr.dts          |   53 +-
 arch/powerpc/include/asm/clk_interface.h      |   20 -
 arch/powerpc/include/asm/mpc5121.h            |    7 +-
 arch/powerpc/kernel/Makefile                  |    1 -
 arch/powerpc/kernel/clock.c                   |   82 --
 arch/powerpc/platforms/512x/Kconfig           |    2 +-
 arch/powerpc/platforms/512x/Makefile          |    3 +-
 arch/powerpc/platforms/512x/clock-commonclk.c | 1221 +++++++++++++++++++++++++
 arch/powerpc/platforms/512x/clock.c           |  754 ---------------
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  169 ++--
 arch/powerpc/platforms/52xx/Kconfig           |    2 +-
 drivers/media/platform/fsl-viu.c              |    2 +-
 drivers/mtd/nand/mpc5121_nfc.c                |    2 +-
 drivers/net/can/mscan/mpc5xxx_can.c           |  270 +++---
 drivers/spi/spi-mpc512x-psc.c                 |   26 +-
 drivers/tty/serial/mpc52xx_uart.c             |   90 +-
 drivers/usb/host/fsl-mph-dr-of.c              |   13 +-
 include/dt-bindings/clock/mpc512x-clock.h     |   76 ++
 include/linux/clk-provider.h                  |   16 +
 22 files changed, 1840 insertions(+), 1094 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/clk_interface.h
 delete mode 100644 arch/powerpc/kernel/clock.c
 create mode 100644 arch/powerpc/platforms/512x/clock-commonclk.c
 delete mode 100644 arch/powerpc/platforms/512x/clock.c
 create mode 100644 include/dt-bindings/clock/mpc512x-clock.h
