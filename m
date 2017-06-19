Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe44::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrvQk5s4CzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:04:46 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Madalin
 Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 1/2] fsl/fman: propagate dma_ops
Date: Mon, 19 Jun 2017 18:04:16 +0300
Message-ID: <1497884657-3744-2-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1497884657-3744-1-git-send-email-madalin.bucur@nxp.com>
References: <1497884657-3744-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure dma_ops are set, to be later used by the Ethernet driver.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 0b31f85..6e67d22f 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -623,6 +623,8 @@ static struct platform_device *dpaa_eth_add_device(int fman_id,
 		goto no_mem;
 	}
 
+	set_dma_ops(&pdev->dev, get_dma_ops(priv->dev));
+
 	ret = platform_device_add_data(pdev, &data, sizeof(data));
 	if (ret)
 		goto err;
-- 
2.1.0
