Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0050.outbound.protection.outlook.com [104.47.33.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttpKz6j2kzDqGS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:21:43 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dpaa_eth: Initialize CGR structure before init
Date: Wed, 4 Jan 2017 13:21:30 +0200
Message-ID: <1483528890-8621-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1483528890-8621-1-git-send-email-madalin.bucur@nxp.com>
References: <1483528890-8621-1-git-send-email-madalin.bucur@nxp.com>
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

From: Roy Pledge <roy.pledge@nxp.com>

The QBMan CGR options needs to be zeroed before calling the init
function

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 77517aa..c9b7ad6 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -733,6 +733,7 @@ static int dpaa_eth_cgr_init(struct dpaa_priv *priv)
 	priv->cgr_data.cgr.cb = dpaa_eth_cgscn;
 
 	/* Enable Congestion State Change Notifications and CS taildrop */
+	memset(&initcgr, 0, sizeof(initcgr));
 	initcgr.we_mask = cpu_to_be16(QM_CGR_WE_CSCN_EN | QM_CGR_WE_CS_THRES);
 	initcgr.cgr.cscn_en = QM_CGR_EN;
 
@@ -2422,6 +2423,7 @@ static int dpaa_ingress_cgr_init(struct dpaa_priv *priv)
 	}
 
 	/* Enable CS TD, but disable Congestion State Change Notifications. */
+	memset(&initcgr, 0, sizeof(initcgr));
 	initcgr.we_mask = cpu_to_be16(QM_CGR_WE_CS_THRES);
 	initcgr.cgr.cscn_en = QM_CGR_EN;
 	cs_th = DPAA_INGRESS_CS_THRESHOLD;
-- 
2.1.0
