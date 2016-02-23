Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 218841A034B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 03:22:07 +1100 (AEDT)
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 16:22:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CF0432190023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:21:46 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NGM2wH65142884
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:02 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NGM1qu008737
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:22:02 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 03/18] cxl: Define process problem state area at attach
 time only
Date: Tue, 23 Feb 2016 17:21:44 +0100
Message-Id: <1456244519-18934-4-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CXL kernel API was defining the process problem state area during
context initialization, making it possible to map the problem state
area before attaching the context. This won't work on a powerVM
guest. So force the logical behavior, like in userspace: attach first,
then map the problem state area.
Remove calls to cxl_assign_psn_space during init. The function is
already called on the attach paths.

Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index ea3eeb7..b45d857 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -51,8 +51,6 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 	if (rc)
 		goto err_mapping;
 
-	cxl_assign_psn_space(ctx);
-
 	return ctx;
 
 err_mapping:
@@ -207,7 +205,6 @@ EXPORT_SYMBOL_GPL(cxl_stop_context);
 void cxl_set_master(struct cxl_context *ctx)
 {
 	ctx->master = true;
-	cxl_assign_psn_space(ctx);
 }
 EXPORT_SYMBOL_GPL(cxl_set_master);
 
@@ -325,15 +322,11 @@ EXPORT_SYMBOL_GPL(cxl_start_work);
 
 void __iomem *cxl_psa_map(struct cxl_context *ctx)
 {
-	struct cxl_afu *afu = ctx->afu;
-	int rc;
-
-	rc = cxl_afu_check_and_enable(afu);
-	if (rc)
+	if (ctx->status != STARTED)
 		return NULL;
 
 	pr_devel("%s: psn_phys%llx size:%llx\n",
-		 __func__, afu->psn_phys, afu->adapter->ps_size);
+		__func__, ctx->psn_phys, ctx->psn_size);
 	return ioremap(ctx->psn_phys, ctx->psn_size);
 }
 EXPORT_SYMBOL_GPL(cxl_psa_map);
-- 
1.9.1
