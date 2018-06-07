Return-Path: <yangbo.lu@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411W9z3hWmzF1RX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 13:24:38 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 01/10] fsl/fman: share the event interrupt
Date: Thu,  7 Jun 2018 11:22:47 +0800
Message-Id: <20180607032256.39802-2-yangbo.lu@nxp.com>
In-Reply-To: <20180607032256.39802-1-yangbo.lu@nxp.com>
References: <20180607032256.39802-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to share fman event interrupt because
the 1588 timer driver will also use this interrupt.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
---
 drivers/net/ethernet/freescale/fman/fman.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 9530405..c415ac6 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2801,7 +2801,8 @@ static irqreturn_t fman_irq(int irq, void *handle)
 	of_node_put(muram_node);
 	of_node_put(fm_node);
 
-	err = devm_request_irq(&of_dev->dev, irq, fman_irq, 0, "fman", fman);
+	err = devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED,
+			       "fman", fman);
 	if (err < 0) {
 		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, irq, err);
-- 
1.7.1
