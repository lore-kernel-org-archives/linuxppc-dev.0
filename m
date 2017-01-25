Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7yDZ2grXzDq6x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 08:02:38 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0PKwjrQ019784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 16:02:36 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2870k3pr97-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 16:02:35 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 16:02:33 -0500
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, wvoigt@us.ibm.com, nfont@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, tlfalcon@linux.vnet.ibm.com
Subject: [PATCH net 5/5] ibmvnic: init completion struct before requesting
 long term mapped buffers
Date: Wed, 25 Jan 2017 15:02:23 -0600
In-Reply-To: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Message-Id: <1485378143-5084-5-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initialize this completion structure before requesting that
a buffer be long-term mapped . This fix resolves a bug where firmware
sends a response before the structure is initialized.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index ec6c5fe..d1ffc61 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -189,9 +189,9 @@ static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 	}
 	ltb->map_id = adapter->map_id;
 	adapter->map_id++;
+	init_completion(&adapter->fw_done);
 	send_request_map(adapter, ltb->addr,
 			 ltb->size, ltb->map_id);
-	init_completion(&adapter->fw_done);
 	wait_for_completion(&adapter->fw_done);
 	return 0;
 }
-- 
1.8.3.1
