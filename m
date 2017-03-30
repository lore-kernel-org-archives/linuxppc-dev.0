Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0065.outbound.protection.outlook.com [104.47.32.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv52K3Z0GzDqLT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 00:24:25 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH] dpaa_eth: use AVOIDBLOCK for Tx confirmation queues
Date: Thu, 30 Mar 2017 16:24:15 +0300
Message-ID: <1490880255-13503-1-git-send-email-madalin.bucur@nxp.com>
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

The AVOIDBLOCK flag determines the Tx confirmation queues processing
to be redirected to any available CPU when the current one is slow
in processing them. This may result in a higher Tx confirmation
interrupt count but may reduce pressure on a certain CPU that with
the previous setting would process all Tx confirmation frames.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index d4bb8bf..9a520e4 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -974,7 +974,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
 		 * Tx Confirmation FQs.
 		 */
 		if (dpaa_fq->fq_type == FQ_TYPE_TX_CONFIRM)
-			initfq.fqd.fq_ctrl |= cpu_to_be16(QM_FQCTRL_HOLDACTIVE);
+			initfq.fqd.fq_ctrl |= cpu_to_be16(QM_FQCTRL_AVOIDBLOCK);
 
 		/* FQ placement */
 		initfq.we_mask |= cpu_to_be16(QM_INITFQ_WE_DESTWQ);
-- 
2.1.0
