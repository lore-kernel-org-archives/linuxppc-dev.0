Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE6BB1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 00:01:34 +1000 (AEST)
Received: from /spool/local
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 15:01:29 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D3C8F17D8069
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 15:01:26 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92E1Qvr35389592
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 14:01:26 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92D1RE5000652
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 07:01:27 -0600
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Fix number of allocated pages in SPA
Date: Fri,  2 Oct 2015 16:01:25 +0200
Message-Id: <1443794485-30565-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the initialisation of the num_procs to before the SPA
allocation.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index b37f2e8..d2e75c8 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -457,6 +457,7 @@ static int activate_afu_directed(struct cxl_afu *afu)
 
 	dev_info(&afu->dev, "Activating AFU directed mode\n");
 
+	afu->num_procs = afu->max_procs_virtualised;
 	if (afu->spa == NULL) {
 		if (cxl_alloc_spa(afu))
 			return -ENOMEM;
@@ -468,7 +469,6 @@ static int activate_afu_directed(struct cxl_afu *afu)
 	cxl_p1n_write(afu, CXL_PSL_ID_An, CXL_PSL_ID_An_F | CXL_PSL_ID_An_L);
 
 	afu->current_mode = CXL_MODE_DIRECTED;
-	afu->num_procs = afu->max_procs_virtualised;
 
 	if ((rc = cxl_chardev_m_afu_add(afu)))
 		return rc;
-- 
1.9.1
