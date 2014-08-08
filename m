Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9AE81A0A47
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 20:53:15 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Make Synchronous and Asynchronous modes
 exclusive
Date: Fri, 8 Aug 2014 18:41:19 +0800
Message-ID: <1407494479-9877-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Li.Xiubo@freescale.com, galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous patch (ASoC: fsl_sai: Add asynchronous mode support) added
new Device Tree bindings for Asynchronous and Synchronous modes support.
However, these two shall not be present at the same time.

So this patch just simply makes them exclusive so as to avoid incorrect
Device Tree binding usage.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 +--
 sound/soc/fsl/fsl_sai.c                             | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 77864f4..dc9f9c3 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -38,8 +38,7 @@ Note:
   default synchronous mode (sync Rx with Tx) will be used, which means both
   transimitter and receiver will send and receive data by following clocks
   of transimitter.
-- fsl,sai-asynchronous will be ignored if fsl,sai-synchronous-rx property is
-  already present.
+- fsl,sai-asynchronous and fsl,sai-synchronous-rx are exclusive.
 
 Example:
 sai2: sai@40031000 {
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ef7c758..4c9e71c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -634,6 +634,13 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	fsl_sai_dai.symmetric_channels = 1;
 	fsl_sai_dai.symmetric_samplebits = 1;
 
+	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL) &&
+	    of_find_property(np, "fsl,sai-asynchronous", NULL)) {
+		/* error out if both synchronous and asynchronous are present */
+		dev_err(&pdev->dev, "invalid binding for synchronous mode\n");
+		return -EINVAL;
+	}
+
 	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL)) {
 		/* Sync Rx with Tx */
 		sai->synchronous[RX] = false;
-- 
1.8.4
