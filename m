Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 79BFF2C0090
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 10:57:57 +1100 (EST)
Date: Wed, 20 Feb 2013 00:57:47 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20130220005747.582ca0ba@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

Please pull mpc5xxx patches for v3.9. The bestcomm driver is
moved to drivers/dma (so it will be usable for ColdFire).
mpc5121 now provides common dtsi file and existing mpc5121 device
trees use it. There are some minor clock init and sparse fixes
and updates for various 5200 device tree files from Grant. Some
fixes for bugs in the mpc5121 DIU driver are also included here
(Andrew Morton suggested to push them via my mpc5xxx tree).

All these patches have already been in linux-next for a while.

Thanks!

Anatolij


The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git next

Anatolij Gustschin (11):
      powerpc/mpc5121: add common .dtsi and use it in mpc5121ads.dts
      powerpc/mpc5121: pdm360ng.dts: use common mpc5121.dtsi
      mpc5121: remove obsolete cell-index property from PSC clock code
      mpc5121: don't check PSC ac97 using node name
      powerpc/512x: initialize clocks before bus probing
      drivers/video: fsl-diu-fb: fix pixel formats for 24 and 16 bpp
      drivers/video: fsl-diu-fb: fix bugs in interrupt handling
      powerpc/512x: add function for chip select parameter configuration
      powerpc/mpc512x: fix noderef sparse warnings
      powerpc/mpc512x: fix sparce warnings for non static symbols
      powerpc/mpc5xxx: fix sparse warning for non static symbol

Grant Likely (2):
      powerpc/5200: Add Lite5200 on-board LEDs as devices
      powerpc/5200: Use the gpt* labels to simplify mpc5200 dts files

Philippe De Muyter (1):
      powerpc, dma: move bestcomm driver from arch/powerpc/sysdev to drivers/dma

 arch/powerpc/boot/dts/a3m071.dts                   |    6 +-
 arch/powerpc/boot/dts/a4m072.dts                   |   27 +-
 arch/powerpc/boot/dts/cm5200.dts                   |    6 +-
 arch/powerpc/boot/dts/digsy_mtc.dts                |   14 +-
 arch/powerpc/boot/dts/lite5200b.dts                |   23 +-
 arch/powerpc/boot/dts/media5200.dts                |    6 +-
 arch/powerpc/boot/dts/motionpro.dts                |   26 +-
 arch/powerpc/boot/dts/mpc5121.dtsi                 |  410 ++++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121ads.dts               |  319 ++-------------
 arch/powerpc/boot/dts/mpc5200b.dtsi                |   25 +-
 arch/powerpc/boot/dts/mucmc52.dts                  |   48 +--
 arch/powerpc/boot/dts/o2d.dtsi                     |   27 +-
 arch/powerpc/boot/dts/pcm030.dts                   |   48 +--
 arch/powerpc/boot/dts/pcm032.dts                   |   45 +--
 arch/powerpc/boot/dts/pdm360ng.dts                 |  273 ++------------
 arch/powerpc/boot/dts/uc101.dts                    |   52 +--
 arch/powerpc/include/asm/mpc5121.h                 |   17 +
 arch/powerpc/platforms/512x/clock.c                |   34 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   32 ++-
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c      |    6 +-
 arch/powerpc/platforms/Kconfig                     |    2 -
 arch/powerpc/sysdev/Makefile                       |    1 -
 arch/powerpc/sysdev/mpc5xxx_clocks.c               |    4 +-
 drivers/Makefile                                   |    2 +-
 drivers/ata/pata_mpc52xx.c                         |    6 +-
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 .../sysdev => drivers/dma}/bestcomm/Kconfig        |    0
 .../sysdev => drivers/dma}/bestcomm/Makefile       |    0
 .../powerpc/sysdev => drivers/dma}/bestcomm/ata.c  |    6 +-
 .../dma}/bestcomm/bcom_ata_task.c                  |    0
 .../dma}/bestcomm/bcom_fec_rx_task.c               |    0
 .../dma}/bestcomm/bcom_fec_tx_task.c               |    0
 .../dma}/bestcomm/bcom_gen_bd_rx_task.c            |    0
 .../dma}/bestcomm/bcom_gen_bd_tx_task.c            |    0
 .../sysdev => drivers/dma}/bestcomm/bestcomm.c     |    6 +-
 .../powerpc/sysdev => drivers/dma}/bestcomm/fec.c  |    6 +-
 .../sysdev => drivers/dma}/bestcomm/gen_bd.c       |    6 +-
 .../powerpc/sysdev => drivers/dma}/bestcomm/sram.c |    2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |    4 +-
 drivers/video/fsl-diu-fb.c                         |   64 ++--
 .../sysdev => include/linux/fsl}/bestcomm/ata.h    |    0
 .../linux/fsl}/bestcomm/bestcomm.h                 |    0
 .../linux/fsl}/bestcomm/bestcomm_priv.h            |    0
 .../sysdev => include/linux/fsl}/bestcomm/fec.h    |    0
 .../sysdev => include/linux/fsl}/bestcomm/gen_bd.h |    0
 .../sysdev => include/linux/fsl}/bestcomm/sram.h   |    0
 sound/soc/fsl/mpc5200_dma.c                        |    4 +-
 48 files changed, 716 insertions(+), 844 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5121.dtsi
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/Kconfig (100%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/Makefile (100%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/ata.c (97%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/bcom_ata_task.c (100%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/bcom_fec_rx_task.c (100%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/bcom_fec_tx_task.c (100%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/bcom_gen_bd_rx_task.c (100%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/bcom_gen_bd_tx_task.c (100%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/bestcomm.c (99%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/fec.c (98%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/gen_bd.c (98%)
 rename {arch/powerpc/sysdev => drivers/dma}/bestcomm/sram.c (99%)
 rename {arch/powerpc/sysdev => include/linux/fsl}/bestcomm/ata.h (100%)
 rename {arch/powerpc/sysdev => include/linux/fsl}/bestcomm/bestcomm.h (100%)
 rename {arch/powerpc/sysdev => include/linux/fsl}/bestcomm/bestcomm_priv.h (100%)
 rename {arch/powerpc/sysdev => include/linux/fsl}/bestcomm/fec.h (100%)
 rename {arch/powerpc/sysdev => include/linux/fsl}/bestcomm/gen_bd.h (100%)
 rename {arch/powerpc/sysdev => include/linux/fsl}/bestcomm/sram.h (100%)
