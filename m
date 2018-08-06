Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kdp971lGzF3HM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 23:31:10 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w76DOWHs002814
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2018 09:31:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kpm97ydc8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Aug 2018 09:31:07 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 6 Aug 2018 09:31:06 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Bryant G. Ly" <bryantly@linux.ibm.com>
Subject: [PATCH] misc: ibmvsm: Fix wrong assignment of return code
Date: Mon,  6 Aug 2018 08:31:00 -0500
Message-Id: <1533562260-11456-1-git-send-email-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Bryant G. Ly" <bryantly@linux.ibm.com>

Currently the assignment is flipped and rc is always 0.

Signed-off-by: Bryant G. Ly <bryantly@linux.ibm.com>
Reviewed-by: Bradley Warrum <bwarrum@us.ibm.com>
---
 drivers/misc/ibmvmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index 8f82bb9..b8aaa68 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -2131,7 +2131,7 @@ static int ibmvmc_init_crq_queue(struct crq_server_adapter *adapter)
 	retrc = plpar_hcall_norets(H_REG_CRQ,
 				   vdev->unit_address,
 				   queue->msg_token, PAGE_SIZE);
-	retrc = rc;
+	rc = retrc;
 
 	if (rc == H_RESOURCE)
 		rc = ibmvmc_reset_crq_queue(adapter);
-- 
2.7.2
