Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E1581A0205
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Feb 2016 00:29:14 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Sat, 6 Feb 2016 13:29:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 97BE717D8042
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 13:29:22 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u16DT9A410355174
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 6 Feb 2016 13:29:09 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u16DT9do004094
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 6 Feb 2016 06:29:09 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 03/18] cxl: Define process problem state area at attach
 time only
Date: Sat,  6 Feb 2016 14:28:50 +0100
Message-Id: <1454765345-7417-4-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cxl kernel API was defining the process problem state area during
context initialization, making it possible to map the problem state
area before attaching the context. This won't work on a powerVM
guest. So do the logical thing, like in userspace: attach first, then
map the problem state area.
Remove calls to cxl_assign_psn_space during init. The function is
already called on the attach paths.

Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index ea3eeb7..fde5bb4 100644
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
 
-- 
1.9.1
