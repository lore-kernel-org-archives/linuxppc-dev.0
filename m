Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0044.outbound.protection.outlook.com [104.47.37.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfCg21nJ7zDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 01:38:06 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <camelia.groza@nxp.com>,
 <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net-next v2 10/10] dpaa_eth: enable context-A stashing
Date: Thu, 9 Mar 2017 16:37:05 +0200
Message-ID: <1489070225-7891-11-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1489070225-7891-1-git-send-email-madalin.bucur@nxp.com>
References: <1489070225-7891-1-git-send-email-madalin.bucur@nxp.com>
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
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 1b3ea38..aa769cb 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1052,7 +1052,8 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
 		/* Initialization common to all ingress queues */
 		if (dpaa_fq->flags & QMAN_FQ_FLAG_NO_ENQUEUE) {
 			initfq.we_mask |= cpu_to_be16(QM_INITFQ_WE_CONTEXTA);
-			initfq.fqd.fq_ctrl |= cpu_to_be16(QM_FQCTRL_HOLDACTIVE);
+			initfq.fqd.fq_ctrl |= cpu_to_be16(QM_FQCTRL_HOLDACTIVE |
+						QM_FQCTRL_CTXASTASHING);
 			initfq.fqd.context_a.stashing.exclusive =
 				QM_STASHING_EXCL_DATA | QM_STASHING_EXCL_CTX |
 				QM_STASHING_EXCL_ANNOTATION;
-- 
2.1.0
