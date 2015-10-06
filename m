Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7A0D1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 01:19:57 +1100 (AEDT)
Received: from /spool/local
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 6 Oct 2015 15:19:52 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A165B1B08084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 15:19:51 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t96EJofi37290110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 14:19:50 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t96EJnRM000790
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 08:19:50 -0600
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] cxl: Fix number of allocated pages in SPA
Date: Tue,  6 Oct 2015 16:19:49 +0200
Message-Id: <1444141189-16621-1-git-send-email-clombard@linux.vnet.ibm.com>
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
The field 'num_procs' of the structure cxl_afu is not updated to the
right value (maximum number of processes that can be supported by
the AFU) when the pages are allocated (i.e. when  cxl_alloc_spa() is called).
The number of allocates pages depends on the max number of processes.

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
