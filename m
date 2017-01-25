Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7yDT35DBzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 08:02:33 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0PKwgls005130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 16:02:30 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 286rd646ur-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 16:02:30 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 16:02:30 -0500
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, wvoigt@us.ibm.com, nfont@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, tlfalcon@linux.vnet.ibm.com
Subject: [PATCH net 3/5] ibmvnic: Fix endian error when requesting device
 capabilites
Date: Wed, 25 Jan 2017 15:02:21 -0600
In-Reply-To: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Message-Id: <1485378143-5084-3-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a IBM VNIC client driver requests a faulty device setting, the
server returns an acceptable value for the client to request.
This 64 bit value was incorrectly being swapped as a 32 bit value,
resulting in loss of data. This patch corrects that by using
the 64 bit swap function.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index f95f6a4..ec4eaed 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2388,10 +2388,10 @@ static void handle_request_cap_rsp(union ibmvnic_crq *crq,
 	case PARTIALSUCCESS:
 		dev_info(dev, "req=%lld, rsp=%ld in %s queue, retrying.\n",
 			 *req_value,
-			 (long int)be32_to_cpu(crq->request_capability_rsp.
+			 (long int)be64_to_cpu(crq->request_capability_rsp.
 					       number), name);
 		release_sub_crqs_no_irqs(adapter);
-		*req_value = be32_to_cpu(crq->request_capability_rsp.number);
+		*req_value = be64_to_cpu(crq->request_capability_rsp.number);
 		init_sub_crqs(adapter, 1);
 		return;
 	default:
-- 
1.8.3.1
