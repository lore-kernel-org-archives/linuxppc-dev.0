Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFC3D2C0374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:33:32 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>, <shawn.guo@linaro.org>, <broonie@kernel.org>
Subject: [PATCH 1/3] dma: imx-sdma: Add ssi dual fifo script support
Date: Tue, 29 Oct 2013 20:33:15 +0800
Message-ID: <9ed025d4e98f716ba80b27acaaa98f43ad3bd75a.1383047327.git.b42378@freescale.com>
In-Reply-To: <cover.1383047327.git.b42378@freescale.com>
References: <cover.1383047327.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, b32955@freescale.com, dmaengine@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's a script for SSI missing in current sdma script list. Thus add it.
This script would allow SSI use its dual fifo mode to transimit/receive
data without occasional hardware underrun/overrun.

This patch also fixed a counting error for total number of scripts.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 drivers/dma/imx-sdma.c                                 | 6 +++++-
 include/linux/platform_data/dma-imx-sdma.h             | 2 ++
 include/linux/platform_data/dma-imx.h                  | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 4fa814d..3b933c5 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -42,6 +42,7 @@ The full ID of peripheral types can be found below.
 	19	IPU Memory
 	20	ASRC
 	21	ESAI
+	22	SSI Dual FIFO
 
 The third cell specifies the transfer priority as below.
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fc43603..695871f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -724,6 +724,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
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
@@ -1237,7 +1241,7 @@ static void sdma_issue_pending(struct dma_chan *chan)
 		sdma_enable_channel(sdma, sdmac->channel);
 }
 
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	37
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 3a39428..19cfa9a 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -43,6 +43,8 @@ struct sdma_script_start_addrs {
 	s32 dptc_dvfs_addr;
 	s32 utra_addr;
 	s32 ram_code_start_addr;
+	s32 mcu_2_ssish_addr;
+	s32 ssish_2_mcu_addr;
 };
 
 /**
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
