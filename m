Return-Path: <guangyu.chen@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CC042C034F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 22:33:09 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
 <s.hauer@pengutronix.de>, <timur@tabi.org>, <shawn.guo@linaro.org>,
 <broonie@kernel.org>
Subject: [PATCH v5 2/4] dma: imx-sdma: Add new dma type for ssi dual fifo
 script
Date: Fri, 8 Nov 2013 19:32:52 +0800
Message-ID: <ea134688ce580e1159a22a9c5666b3e568f23963.1383910029.git.b42378@freescale.com>
In-Reply-To: <cover.1383910029.git.b42378@freescale.com>
References: <cover.1383910029.git.b42378@freescale.com>
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

This patch adds a new DMA_TYPE for SSI dual FIFO script, included
in SDMA firmware version 2. This script would allow SSI use dual
fifo mode to transimit/receive data without occasional hardware
underrun/overrun.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 drivers/dma/imx-sdma.c                                 | 4 ++++
 include/linux/platform_data/dma-imx.h                  | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 4fa814d..68b83ec 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -42,6 +42,7 @@ The full ID of peripheral types can be found below.
 	19	IPU Memory
 	20	ASRC
 	21	ESAI
+	22	SSI Dual FIFO	(needs firmware ver >= 2)
 
 The third cell specifies the transfer priority as below.
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c7ece8d..efaa9a9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -725,6 +725,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_app_addr;
 		break;
+	case IMX_DMATYPE_SSI_DUAL:
+		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
+		break;
 	case IMX_DMATYPE_SSI_SP:
 	case IMX_DMATYPE_MMC:
 	case IMX_DMATYPE_SDHC:
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index beac6b8..bcbc6c3 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -39,6 +39,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_IPU_MEMORY,	/* IPU Memory */
 	IMX_DMATYPE_ASRC,	/* ASRC */
 	IMX_DMATYPE_ESAI,	/* ESAI */
+	IMX_DMATYPE_SSI_DUAL,	/* SSI Dual FIFO */
 };
 
 enum imx_dma_prio {
-- 
1.8.4
