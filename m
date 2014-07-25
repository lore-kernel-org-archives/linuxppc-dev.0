Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACFDE1A0950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 14:01:47 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH v3 0/2] Add Freescale ASRC driver
Date: Fri, 25 Jul 2014 12:03:57 +0800
Message-ID: <cover.1406259578.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, robh+dt@kernel.org, galak@codeaurora.org,
 grant.likely@linaro.org, tklauser@distanz.ch, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches add Freescale ASRC module driver support along
with the extra request in imx-sdma structure required by SDMA Device
to Device script.

The previous version has been in the maillist for nearly six months
without any comment and reply. So I decide to drop the SDMA part's
change since this series focus on ASRC support (Later, we can send
SDMA part separately.) so that ASRC driver may get upstream first.

Changelog
v3:
 * PATCH-1: Added an Acked-by from Shawn Guo
 * PATCH-2: Dropped THIS_MODULE as Tobias suggests
 * PATCH-2: Use dma_coerce_mask_and_coherent() in fsl_asrc_dma_pcm_new()
 * PATCH-2: Added substream check in fsl_asrc_dma_pcm_new()
v2:
 * PATCH-1: Dropped the change to SDMA driver.
 * PATCH-2: Dropped useless member in private data structures.
 * PATCH-2: Refined some comments in fsl_asrc_dma.c driver.
 * PATCH-2: Refined commit comments.

Nicolin Chen (2):
  ARM: imx: Add the secondary request into the structure for imx-sdma
  ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers

 .../devicetree/bindings/sound/fsl,asrc.txt         |   62 ++
 include/linux/platform_data/dma-imx.h              |    1 +
 sound/soc/fsl/Kconfig                              |    9 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/fsl_asrc.c                           | 1030 ++++++++++++++++++++
 sound/soc/fsl/fsl_asrc.h                           |  461 +++++++++
 sound/soc/fsl/fsl_asrc_dma.c                       |  386 ++++++++
 7 files changed, 1951 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
 create mode 100644 sound/soc/fsl/fsl_asrc.c
 create mode 100644 sound/soc/fsl/fsl_asrc.h
 create mode 100644 sound/soc/fsl/fsl_asrc_dma.c

-- 
1.8.4
