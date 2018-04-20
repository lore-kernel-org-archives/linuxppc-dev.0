Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SQn11lXWzF245
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2018 05:25:40 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3KJO331131714
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:25:38 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hfkwp68h1-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:25:37 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 20 Apr 2018 15:25:36 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH net] ibmvnic: Clean actual number of RX or TX pools
Date: Fri, 20 Apr 2018 14:25:32 -0500
Message-Id: <1524252332-10272-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoid using value stored in the login response buffer when
cleaning TX and RX buffer pools since these could be inconsistent
depending on the device state. Instead use the field in the driver's
private data that tracks the number of active pools.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 2df01ad..6e8d6a6 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1128,7 +1128,7 @@ static void clean_rx_pools(struct ibmvnic_adapter *adapter)
 	if (!adapter->rx_pool)
 		return;
 
-	rx_scrqs = be32_to_cpu(adapter->login_rsp_buf->num_rxadd_subcrqs);
+	rx_scrqs = adapter->num_active_rx_pools;
 	rx_entries = adapter->req_rx_add_entries_per_subcrq;
 
 	/* Free any remaining skbs in the rx buffer pools */
@@ -1177,7 +1177,7 @@ static void clean_tx_pools(struct ibmvnic_adapter *adapter)
 	if (!adapter->tx_pool || !adapter->tso_pool)
 		return;
 
-	tx_scrqs = be32_to_cpu(adapter->login_rsp_buf->num_txsubm_subcrqs);
+	tx_scrqs = adapter->num_active_tx_pools;
 
 	/* Free any remaining skbs in the tx buffer pools */
 	for (i = 0; i < tx_scrqs; i++) {
-- 
1.8.3.1
