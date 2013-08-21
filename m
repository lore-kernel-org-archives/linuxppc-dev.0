Return-Path: <B42378@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 004972C0112
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 13:02:30 +1000 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <broonie@kernel.org>, <s.hauer@pengutronix.de>
Subject: [PATCH v10 0/2] Add freescale S/PDIF CPU DAI and machine drivers
Date: Wed, 21 Aug 2013 11:13:15 +0800
Message-ID: <cover.1377054540.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org,
 festevam@gmail.com, timur@tabi.org, rob.herring@calxeda.com,
 tomasz.figa@gmail.com, p.zabel@pengutronix.de, R65777@freescale.com,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changelog:
v9->v10:
 * Removed "dummy" words from binding doc in PATCH-2.
v8->v9:
 * Use bool instead of atomic_t.
 * Use clk_prepare_enable() instead.
 * Dropped dumpregs().
 * Dropped unnecessary clk_round_rate().
 * Dropped unused clock source enum.
 * Revised dev_err() message.
v7->v8:
 * Revised DT binding doc.
 * Revised dev_err() error msg.
 * Check return value of clk_set_rate().
v6->v7:
 * Removed extra comma in array.
 * Revised some comments.
 * Added some dev_err().
 * Check the return value of soft reset.
 * Use bitrev8() instead of extra reverse_bits().
 * Use cache_bypass as default for regmap.
v5->v6:
 * Sorted out rxtx clk source in DT binding.
 * Use devm_xxxx() functions.
 * Use platform_get_resource() instead.
v4->v5:
 * Dropped rx/tx-clksrc-names DT bindings.
 * Use standard clock binding instead to pass the clock source list.
 * Update the compatible list by using "imx35", the first SoC that has spdif.
v3->v4:
 * Use regmap for CPU DAI driver.
 * Use individual clock source for 32KHz, 44KHz, 48KHz playback.
 * Determine clock source configuration from 'clocks' entry.
 * Added imx53 to compatible list, merged imx6q and imx6dl in the list.
 * Improve the algorism of reverse_bits().
 * Dropped the unneeded clk_put().
v2->v3:
 * Removed a wrong tag from the commit of patch-1.
v1->v2:
 * Dropped one applied patch for spdif dummy codec drivers.
 * Use generic DMA DT binding.
 * Let spdif controller driver calculate the clock div.
 * Added one optional clock source for spdif tx.
 * Reivsed documentation accordingly.

Nicolin Chen (2):
  ASoC: fsl: Add S/PDIF CPU DAI driver
  ASoC: fsl: Add S/PDIF machine driver

 .../devicetree/bindings/sound/fsl,spdif.txt        |   54 +
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +
 sound/soc/fsl/Kconfig                              |   14 +
 sound/soc/fsl/Makefile                             |    4 +
 sound/soc/fsl/fsl_spdif.c                          | 1236 ++++++++++++++++++++
 sound/soc/fsl/fsl_spdif.h                          |  191 +++
 sound/soc/fsl/imx-spdif.c                          |  134 +++
 7 files changed, 1662 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/fsl/imx-spdif.c
