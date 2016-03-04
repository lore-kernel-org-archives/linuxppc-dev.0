Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 241491A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:26:53 +1100 (AEDT)
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:26:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id EEBD917D805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:27:14 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BQnVv852478
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:26:49 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BQmVg007020
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:26:49 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 03/20] cxl: Define process problem state area at attach
 time only
Date: Fri,  4 Mar 2016 12:26:27 +0100
Message-Id: <1457090804-9719-4-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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
Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
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
