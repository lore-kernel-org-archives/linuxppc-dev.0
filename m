Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 172DD2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 21:26:14 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] fs_enet: update clock names to comply with FEC binding
Date: Mon, 24 Feb 2014 11:25:55 +0100
Message-Id: <1393237557-31406-1-git-send-email-gsi@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

a recent FEC binding document update that was motivated by i.MX
development revealed that ARM and PowerPC implementations in Linux
did not agree on the clock names to use for the FEC nodes

change the OF clock lookup to prefer "ipg" over "per", which
improves compliance with the binding, and keeps compatibility
with former device trees

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 62f042d4aaa9..ce20184b96cb 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1037,11 +1037,20 @@ static int fs_enet_probe(struct platform_device *ofdev)
 			fpi->use_rmii = 1;
 	}
 
-	/* make clock lookup non-fatal (the driver is shared among platforms),
+	/* the driver is shared across several PowerPC platforms, not all
+	 * of them provide COMMON_CLK support, and newer kernels are supposed
+	 * to keep working with older DT blobs, so clock lookup is non-fatal
+	 *
 	 * but require enable to succeed when a clock was specified/found,
 	 * keep a reference to the clock upon successful acquisition
+	 *
+	 * the FEC binding is shared with ARM platforms, so we lookup several
+	 * clock names to prefer the common naming convention yet support
+	 * names that were used before unification
 	 */
-	clk = devm_clk_get(&ofdev->dev, "per");
+	clk = devm_clk_get(&ofdev->dev, "ipg");
+	if (IS_ERR(clk))
+		clk = devm_clk_get(&ofdev->dev, "per");
 	if (!IS_ERR(clk)) {
 		err = clk_prepare_enable(clk);
 		if (err) {
-- 
1.7.10.4
