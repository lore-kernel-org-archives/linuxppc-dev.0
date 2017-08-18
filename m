Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0082.outbound.protection.outlook.com [104.47.38.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYcQQ2T0lzDrMw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 18:56:46 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] dpaa_eth: check allocation result
Date: Fri, 18 Aug 2017 11:56:28 +0300
Message-ID: <1503046588-24349-7-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1503046588-24349-1-git-send-email-madalin.bucur@nxp.com>
References: <1503046588-24349-1-git-send-email-madalin.bucur@nxp.com>
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

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ef30038..ff7f153 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2557,6 +2557,9 @@ static struct dpaa_bp *dpaa_bp_alloc(struct device *dev)
 
 	dpaa_bp->bpid = FSL_DPAA_BPID_INV;
 	dpaa_bp->percpu_count = devm_alloc_percpu(dev, *dpaa_bp->percpu_count);
+	if (!dpaa_bp->percpu_count)
+		return ERR_PTR(-ENOMEM);
+
 	dpaa_bp->config_count = FSL_DPAA_ETH_MAX_BUF_COUNT;
 
 	dpaa_bp->seed_cb = dpaa_bp_seed;
-- 
2.1.0
