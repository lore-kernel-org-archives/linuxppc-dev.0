Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6974FDDF7D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:15:26 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/16] Add support for MPC512x
Date: Wed,  6 May 2009 22:15:07 +0200
Message-Id: <1241640919-4650-1-git-send-email-wd@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch series brings support for the Freescale MPC512x
processsors up to date:

[PATCH 01/12] fs_enet: Use defines to set driver tunables.
	      Cc: <netdev@vger.kernel.org>
[PATCH 02/12] fs_enet: Add MPC5121 FEC support.
	      Cc: <netdev@vger.kernel.org>
[PATCH 03/12] fs_enet: Add FEC TX Alignment workaround for MPC5121.
	      Cc: <netdev@vger.kernel.org>
[PATCH 04/12] mpc5121: Added reset module registers representation.
[PATCH 05/12] mpc5121ads: Added Reset Module node to DTS.
[PATCH 06/12] mpc5121: Added NAND Flash Controller driver.
	      Cc: <linux-mtd@lists.infradead.org>
[PATCH 07/12] mpc5121ads: Clean up and fix NAND description in mpc5121ads DTS.
[PATCH 08/12] mpc5121: Added I2C support.
	      Cc: <linux-i2c@vger.kernel.org>
[PATCH 09/12] mpc5121ads: Added I2C RTC node to mpc5121ads DTS.
[PATCH 10/12] mpc5121: Add MPC5121 Real time clock driver.
	      Cc: <rtc-linux@googlegroups.com>
[PATCH 11/12] mpc5121: Added MPC512x DMA driver.
[PATCH 12/12] mpc5121: Added default config for MPC5121.

The patches are based on v2.6.30-rc4 and cover the following
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

The work for this project has been approved as OSADL project by a
majority of OSADL members and funded by OSADL membership fees in 2009;
for details please see www.osadl.org.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
Summary statistics:

 arch/powerpc/boot/dts/aria.dts                 |  410 ++++++
 arch/powerpc/boot/dts/mpc5121ads.dts           |   25 +-
 arch/powerpc/configs/512x/aria_defconfig       | 1789 ++++++++++++++++++++++++
 arch/powerpc/configs/512x/mpc5121ads_defconfig | 1190 ++++++++++++++++
 arch/powerpc/configs/mpc5121_defconfig         | 1158 +++++++++++++++
 arch/powerpc/include/asm/mpc5121_fec.h         |  111 ++
 arch/powerpc/include/asm/mpc5121_nfc.h         |  100 ++
 arch/powerpc/include/asm/mpc512x.h             |   13 +
 arch/powerpc/platforms/512x/Kconfig            |    9 +
 arch/powerpc/platforms/512x/Makefile           |    1 +
 arch/powerpc/platforms/512x/aria.c             |   73 +
 arch/powerpc/platforms/512x/mpc5121_ads.c      |    2 +
 arch/powerpc/platforms/512x/mpc5121_generic.c  |    1 +
 arch/powerpc/platforms/512x/mpc512x.h          |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |   26 +
 drivers/dma/Kconfig                            |    7 +
 drivers/dma/Makefile                           |    1 +
 drivers/dma/mpc512x_dma.c                      |  642 +++++++++
 drivers/dma/mpc512x_dma.h                      |  192 +++
 drivers/i2c/busses/Kconfig                     |    9 +-
 drivers/mtd/nand/Kconfig                       |    7 +
 drivers/mtd/nand/Makefile                      |    1 +
 drivers/mtd/nand/mpc5121_nfc.c                 |  855 +++++++++++
 drivers/net/fs_enet/Kconfig                    |   13 +-
 drivers/net/fs_enet/fs_enet-main.c             |   67 +-
 drivers/net/fs_enet/fs_enet.h                  |    6 +
 drivers/net/fs_enet/mac-fec.c                  |   30 +-
 drivers/net/fs_enet/mii-fec.c                  |   13 +-
 drivers/rtc/Kconfig                            |   10 +
 drivers/rtc/Makefile                           |    1 +
 drivers/rtc/rtc-mpc5121.c                      |  408 ++++++
 31 files changed, 7146 insertions(+), 25 deletions(-)
