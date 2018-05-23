Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rhQ40jXlzF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:49:31 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NIho4x087119
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j5cvk2p4r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:29 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 23 May 2018 12:49:29 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/8] ibmvnic: Return error code if init interrupted
 by transport event
Date: Wed, 23 May 2018 13:37:58 -0500
In-Reply-To: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Message-Id: <1527100682-23099-5-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If device init is interrupted by a failover, set the init return
code so that it can be checked and handled appropriately by the
init routine.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7083519..f1f744e 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4249,7 +4249,10 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 			dev_info(dev, "Partner initialized\n");
 			adapter->from_passive_init = true;
 			adapter->failover_pending = false;
-			complete(&adapter->init_done);
+			if (!completion_done(&adapter->init_done)) {
+				complete(&adapter->init_done);
+				adapter->init_done_rc = -EIO;
+			}
 			ibmvnic_reset(adapter, VNIC_RESET_FAILOVER);
 			break;
 		case IBMVNIC_CRQ_INIT_COMPLETE:
-- 
2.7.5
