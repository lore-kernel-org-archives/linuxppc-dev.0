Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 214521A095F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:33:21 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>, <shawn.guo@linaro.org>
Subject: [PATCH v2 1/2] ARM: imx: Add the secondary request into the structure
 for imx-sdma
Date: Thu, 24 Jul 2014 16:35:28 +0800
Message-ID: <e47c36814695fd8c88ef063a9771cf097a128ec0.1406189745.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1406189745.git.nicoleotsuka@gmail.com>
References: <cover.1406189745.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, robh+dt@kernel.org, galak@codeaurora.org,
 grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SDMA supports device to device (per_2_per) scripts to handle DMA transfering
between two peripheral devices. The per_2_per script, however, needs two dma
requests from two sides while the current structure only defined one request.

So this patch just simply adds the secondary request so as to let SDMA and
its user to add its implementation later.

[ Both change in the SDMA driver and its users like Freescale ASRC ASoC driver
  should be taken along with this change in order to truly support per_2_per
  sciprts. However, we here make an expediency by adding this first so that
  we can add either side later since this patch won't break any function and
  meanwhile it can make merge window more smoothly: we don't need to apply the
  change inside dmaengine branch via ASoC tree any more. -- Nicolin ]

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/linux/platform_data/dma-imx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 7aa0e89..6a1357d 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -51,6 +51,7 @@ enum imx_dma_prio {
 
 struct imx_dma_data {
 	int dma_request; /* DMA request line */
+	int dma_request2; /* secondary DMA request line */
 	enum sdma_peripheral_type peripheral_type;
 	int priority;
 };
-- 
1.8.4
