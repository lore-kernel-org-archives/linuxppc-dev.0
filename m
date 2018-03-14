Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401Xqj25sMzDqhy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 00:38:41 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 camelia.groza@nxp.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 5/5] dpaa_eth: remove duplicate increment of the tx_errors
 counter
Date: Wed, 14 Mar 2018 08:37:32 -0500
Message-Id: <20180314133732.24068-6-madalin.bucur@nxp.com>
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
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

From: Camelia Groza <camelia.groza@nxp.com>

The tx_errors counter is incremented by the dpaa_xmit caller.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 76b3c9e..fd43f98 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2021,7 +2021,6 @@ static inline int dpaa_xmit(struct dpaa_priv *priv,
 	}
 
 	if (unlikely(err < 0)) {
-		percpu_stats->tx_errors++;
 		percpu_stats->tx_fifo_errors++;
 		return err;
 	}
-- 
2.1.0
