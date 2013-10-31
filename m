Return-Path: <B42378@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 039852C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 00:44:36 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>, <shawn.guo@linaro.org>, <broonie@kernel.org>,
 <s.hauer@pengutronix.de>
Subject: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
Date: Thu, 31 Oct 2013 21:44:12 +0800
Message-ID: <cover.1383226444.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changelog
v4:
 * PATCH-3: Drop useless register configuration.
 *
 * Nothing changes for the other three patches
v3:
 * PATCH-1: Add comments to indicate the end of v1 and v2 array.
 * PATCH-3: Use better way to keep watermark as even number.
 *
 * Nothing changes for PATCH-2 and PATCH-4
v2:
 * Instead of adding rogue scripts to current SDMA driver based on firmware
 * V1, we define the new SDMA firmware as version 2 and bisect the PATCH-1
 * to two patches: The first is to add version check code to the SDMA driver;
 * And the second is to add SSI dual FIFO DMATYPE.
 *
 * Nothing changes for the last two patches.
v1:
 * SSI can reduce hardware overrun/underrun possibility when using dual
 * fifo mode. To support this mode, we need to first update sdma sciprt
 * list, and then enable dual fifo BIT in SSI driver, and last update DT
 * bindings of i.MX series.
 *
 * ! This series of patches has a direct dependency between them. When
 * ! applying them, we need to apply to one single branch. Otherwise,
 * ! it would break currect branches.

Nicolin Chen (4):
  dma: imx-sdma: Add sdma firmware version 2 support
  dma: imx-sdma: Add new dma type for ssi dual fifo script
  ASoC: fsl_ssi: Add dual fifo mode support
  ARM: dts: imx: use dual-fifo sdma script for ssi

 .../devicetree/bindings/dma/fsl-imx-sdma.txt          |  1 +
 arch/arm/boot/dts/imx51.dtsi                          |  4 ++--
 arch/arm/boot/dts/imx53.dtsi                          |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi                        | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi                         | 12 ++++++------
 drivers/dma/imx-sdma.c                                | 19 ++++++++++++++++++-
 include/linux/platform_data/dma-imx-sdma.h            |  5 +++++
 include/linux/platform_data/dma-imx.h                 |  1 +
 sound/soc/fsl/fsl_ssi.c                               | 18 +++++++++++++++++-
 9 files changed, 58 insertions(+), 18 deletions(-)

-- 
1.8.4
