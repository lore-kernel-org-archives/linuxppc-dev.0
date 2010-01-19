Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 01DF2B7D30
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 07:24:16 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/11] Update support for MPC512x
Date: Tue, 19 Jan 2010 21:24:02 +0100
Message-Id: <1263932653-3634-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
	rtc-linux@googlegroups.com, Dan Williams <dan.j.williams@intel.com>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch series brings support for the Freescale MPC512x
processsors up to date:

[PATCH 01/11] fs_enet: Add support for MPC512x to fs_enet driver
[PATCH 02/11] fs_enet: Add FEC TX Alignment workaround for MPC5121
[PATCH 03/11] powerpc/mpc5121: Add machine restart support
[PATCH 04/11] i2c-mpc: Add MPC5121 I2C bus support
[PATCH 05/11] rtc: Add MPC5121 Real time clock driver
[PATCH 06/11] mtd: Add NAND Flash Controller driver
[PATCH 07/11] dma: Add MPC512x DMA driver
[PATCH 08/11] powerpc/mpc5121: add USB host support
[PATCH 09/11] powerpc/mpc512x: shared DIU framebuffer support
[PATCH 10/11] powerpc/mpc5121: update mpc5121ads DTS
[PATCH 11/11] powerpc/mpc5121: Add default config for MPC5121ADS

The patches are based on v2.6.33-rc4 and cover the following
items:

- platform, DTS
- DMA
- FEC Ethernet
- UART (without h/w flow control)
- I2C
- NAND
- RTC

The code has been tested on the Freescale/STX "MPC5121ADS" board
(board rev. 4) with a MPC5121e Rev. 2. No attempt was made to provide
backward compatibility to older silicon revisions or older revisions
of the board.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <netdev@vger.kernel.org>
Cc: <linux-i2c@vger.kernel.org>
Cc: <rtc-linux@googlegroups.com>
Cc: <linux-mtd@lists.infradead.org>
Cc: <linux-usb@vger.kernel.org>
---
 Documentation/powerpc/dts-bindings/fsl/usb.txt |    8 +
 arch/powerpc/boot/dts/mpc5121ads.dts           |   35 +-
 arch/powerpc/configs/512x/mpc5121ads_defconfig | 1662 ++++++++++++++++++++++++
 arch/powerpc/include/asm/mpc5xxx.h             |   14 +-
 arch/powerpc/platforms/512x/Kconfig            |    6 +
 arch/powerpc/platforms/512x/Makefile           |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c      |    9 +
 arch/powerpc/platforms/512x/mpc5121_generic.c  |   13 +
 arch/powerpc/platforms/512x/mpc5121_usb.c      |  117 ++
 arch/powerpc/platforms/512x/mpc512x.h          |    5 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |  320 +++++-
 arch/powerpc/sysdev/fsl_soc.c                  |   10 +
 arch/powerpc/sysdev/fsl_soc.h                  |   10 +
 drivers/dma/Kconfig                            |    7 +
 drivers/dma/Makefile                           |    1 +
 drivers/dma/mpc512x_dma.c                      |  636 +++++++++
 drivers/dma/mpc512x_dma.h                      |  192 +++
 drivers/i2c/busses/Kconfig                     |    9 +-
 drivers/i2c/busses/i2c-mpc.c                   |   23 +
 drivers/mtd/nand/Kconfig                       |    7 +
 drivers/mtd/nand/Makefile                      |    1 +
 drivers/mtd/nand/mpc5121_nfc.c                 |  916 +++++++++++++
 drivers/net/fs_enet/Kconfig                    |   10 +-
 drivers/net/fs_enet/fs_enet-main.c             |   43 +
 drivers/net/fs_enet/fs_enet.h                  |   40 +-
 drivers/net/fs_enet/mac-fec.c                  |  132 ++-
 drivers/net/fs_enet/mii-fec.c                  |   55 +-
 drivers/net/fs_enet/mpc5121_fec.h              |   64 +
 drivers/net/fs_enet/mpc8xx_fec.h               |   37 +
 drivers/rtc/Kconfig                            |   10 +
 drivers/rtc/Makefile                           |    1 +
 drivers/rtc/rtc-mpc5121.c                      |  408 ++++++
 drivers/usb/host/ehci-fsl.c                    |  213 +++-
 drivers/usb/host/ehci-fsl.h                    |   19 +-
 drivers/usb/host/ehci-mem.c                    |    2 +-
 drivers/video/fsl-diu-fb.c                     |   40 +-
 drivers/video/fsl-diu-fb.h                     |  223 ----
 include/linux/fsl-diu-fb.h                     |  223 ++++
 include/linux/fsl_devices.h                    |   10 +
 39 files changed, 5193 insertions(+), 340 deletions(-)
