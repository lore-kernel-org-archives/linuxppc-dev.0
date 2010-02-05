Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8965CB7D04
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 00:43:36 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 00/11] Update support for MPC512x
Date: Fri,  5 Feb 2010 14:42:46 +0100
Message-Id: <1265377377-29327-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, linux-usb@vger.kernel.org,
	linux-mtd@lists.infradead.org, rtc-linux@googlegroups.com,
	Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patches are based on v2.6.33-rc6 and cover the following
items:

- platform, DTS
- DMA
- DIU
- UART (without h/w flow control)
- I2C
- NAND
- RTC

The code has been tested on the Freescale/STX "MPC5121ADS" board
(board rev. 4) with a MPC5121e Rev. 2. No attempt was made to provide
backward compatibility to older silicon revisions or older revisions
of the board.

Changes since v2:
 - New cleanup patch added to avoid usage of platform specific
   clock init on non-5121 platforms
 - Comments to v2 patches addressed, detailed changelog is added
   to related patches. As a result there are 11 patches now as
   NAND and USB patches were split.

Changes since v1:
 - MPC5121 FEC support patches are removed from this patch series
   as these were not accepted
 - I2C support path is also removed, the I2C support is addressed
   by another patch series from Wolfgang Grandegger:
       i2c-mpc: add support for the Freescale MPC512x and other fixes
   Appropriate fixes for MPC5121ADS DTS are addressed by DTS patch in
   this patch series
 - Detailed changelog is added to each patch of the series


Anatolij Gustschin (10):
  powerpc/mpc5121: avoid using arch_initcall for clock init
  powerpc/mpc5121: Add machine restart support
  rtc: Add MPC5121 Real time clock driver
  mtd: Add MPC5121 NAND Flash Controller driver
  powerpc/mpc5121: create and register NFC device
  powerpc/fsl_soc.c: prepare for addition of mpc5121 USB code
  powerpc/mpc5121: add USB host support
  powerpc/mpc5121: shared DIU framebuffer support
  powerpc/mpc5121: update mpc5121ads DTS
  powerpc/mpc5121: Add default config for MPC5121

Piotr Ziecik (1):
  dma: Add MPC512x DMA driver

 Documentation/powerpc/dts-bindings/fsl/usb.txt |   22 +
 arch/powerpc/boot/dts/mpc5121ads.dts           |   55 +-
 arch/powerpc/configs/mpc512x_defconfig         | 1694 ++++++++++++++++++++++++
 arch/powerpc/include/asm/mpc5xxx.h             |   14 +-
 arch/powerpc/platforms/512x/Kconfig            |    3 +
 arch/powerpc/platforms/512x/Makefile           |    2 +-
 arch/powerpc/platforms/512x/clock.c            |    5 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c      |   10 +-
 arch/powerpc/platforms/512x/mpc5121_generic.c  |   15 +-
 arch/powerpc/platforms/512x/mpc5121_usb.c      |  138 ++
 arch/powerpc/platforms/512x/mpc512x.h          |    7 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |  331 +++++
 arch/powerpc/sysdev/fsl_soc.c                  |  230 ++--
 arch/powerpc/sysdev/fsl_soc.h                  |   10 +
 drivers/dma/Kconfig                            |    7 +
 drivers/dma/Makefile                           |    1 +
 drivers/dma/mpc512x_dma.c                      |  800 +++++++++++
 drivers/mtd/nand/Kconfig                       |    7 +
 drivers/mtd/nand/Makefile                      |    1 +
 drivers/mtd/nand/mpc5121_nfc.c                 |  916 +++++++++++++
 drivers/rtc/Kconfig                            |   10 +
 drivers/rtc/Makefile                           |    1 +
 drivers/rtc/rtc-mpc5121.c                      |  387 ++++++
 drivers/usb/host/ehci-fsl.c                    |  111 ++-
 drivers/usb/host/ehci-fsl.h                    |   19 +-
 drivers/usb/host/ehci-mem.c                    |    2 +-
 drivers/video/fsl-diu-fb.c                     |   40 +-
 {drivers/video => include/linux}/fsl-diu-fb.h  |    0
 include/linux/fsl_devices.h                    |   10 +
 29 files changed, 4661 insertions(+), 187 deletions(-)
 create mode 100644 arch/powerpc/configs/mpc512x_defconfig
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_usb.c
 create mode 100644 drivers/dma/mpc512x_dma.c
 create mode 100644 drivers/mtd/nand/mpc5121_nfc.c
 create mode 100644 drivers/rtc/rtc-mpc5121.c
 rename {drivers/video => include/linux}/fsl-diu-fb.h (100%)

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <rtc-linux@googlegroups.com>
Cc: <linux-mtd@lists.infradead.org>
Cc: <linux-usb@vger.kernel.org>
