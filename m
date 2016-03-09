Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ECE21A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 22:53:23 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 11:53:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A1BF3219005E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 11:52:58 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29BrFbd61931600
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 11:53:15 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29ArGNb015866
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 03:53:17 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Remove dead code
Date: Wed,  9 Mar 2016 12:53:13 +0100
Message-Id: <1457524393-6717-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function cxl_get_phys_dev() was removed from the kernel API by a
previous patch, but it's actually dead code. Remove it.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 2107c94..8075823 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -68,15 +68,6 @@ struct cxl_context *cxl_get_context(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(cxl_get_context);
 
-struct device *cxl_get_phys_dev(struct pci_dev *dev)
-{
-	struct cxl_afu *afu;
-
-	afu = cxl_pci_to_afu(dev);
-
-	return afu->adapter->dev.parent;
-}
-
 int cxl_release_context(struct cxl_context *ctx)
 {
 	if (ctx->status >= STARTED)
-- 
1.9.1
