Return-Path: <B42378@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7A522C044E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 17:33:10 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <s.hauer@pengutronix.de>, <timur@tabi.org>, <shawn.guo@linaro.org>,
 <broonie@kernel.org>
Subject: [PATCH v2 1/4] dma: imx-sdma: Add sdma firmware version 2 support
Date: Thu, 31 Oct 2013 14:32:03 +0800
Message-ID: <cfe6edbff010aefc8a35df8a719b26bd238cb3cc.1383197521.git.b42378@freescale.com>
In-Reply-To: <cover.1383197521.git.b42378@freescale.com>
References: <cover.1383197521.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 galak@codeaurora.org, dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On i.MX5/6 series, SDMA is using new version firmware to support SSI
dual FIFO feature and HDMI Audio (i.MX6Q/DL only). Thus add it.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 drivers/dma/imx-sdma.c                     | 15 ++++++++++++++-
 include/linux/platform_data/dma-imx-sdma.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fc43603..c7ece8d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -323,6 +323,7 @@ struct sdma_engine {
 	struct clk			*clk_ipg;
 	struct clk			*clk_ahb;
 	spinlock_t			channel_0_lock;
+	u32				script_number;
 	struct sdma_script_start_addrs	*script_addrs;
 	const struct sdma_driver_data	*drvdata;
 };
@@ -1238,6 +1239,7 @@ static void sdma_issue_pending(struct dma_chan *chan)
 }
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
@@ -1246,7 +1248,7 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
 	s32 *saddr_arr = (u32 *)sdma->script_addrs;
 	int i;
 
-	for (i = 0; i < SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1; i++)
+	for (i = 0; i < sdma->script_number; i++)
 		if (addr_arr[i] > 0)
 			saddr_arr[i] = addr_arr[i];
 }
@@ -1272,6 +1274,17 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 		goto err_firmware;
 	if (header->ram_code_start + header->ram_code_size > fw->size)
 		goto err_firmware;
+	switch (header->version_major) {
+		case 1:
+			sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1;
+			break;
+		case 2:
+			sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2;
+			break;
+		default:
+			dev_err(sdma->dev, "unknown firmware version\n");
+			return;
+	}
 
 	addr = (void *)header + header->script_addrs_start;
 	ram_code = (void *)header + header->ram_code_start;
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 3a39428..14ca582 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -43,6 +43,9 @@ struct sdma_script_start_addrs {
 	s32 dptc_dvfs_addr;
 	s32 utra_addr;
 	s32 ram_code_start_addr;
+	s32 mcu_2_ssish_addr;
+	s32 ssish_2_mcu_addr;
+	s32 hdmi_dma_addr;
 };
 
 /**
-- 
1.8.4
