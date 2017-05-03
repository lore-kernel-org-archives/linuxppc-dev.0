Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJ0sc6fD4zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 00:29:24 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v43ESvCa097644
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 10:29:18 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a790serfm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 10:29:17 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 3 May 2017 15:29:15 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: alistair@popple.id.au, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [RFC 2/2] cxl: Mark context requiring global TLBIs
Date: Wed,  3 May 2017 16:29:06 +0200
In-Reply-To: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170503142906.29220-3-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL needs to see all TLBI pertinent to the memory contexts used on
the cxl adapter. For the hash memory model, it was done by making all
TLBIs global as soon as the cxl driver is in us. For radix, we need
something similar, but we can refine and only convert to global the
invalidations for contexts actually used by the device.

So mark the contexts being attached to the cxl adapter as requiring
global TLBIs.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c  | 5 ++++-
 drivers/misc/cxl/file.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1a138c83f877..86b2ad86fdee 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -347,7 +347,10 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 			cxl_context_mm_count_put(ctx);
 		goto out;
 	}
-
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (ctx->mm)
+		mm_context_set_global_tlbi(&ctx->mm->context);
+#endif
 	ctx->status = STARTED;
 out:
 	mutex_unlock(&ctx->status_mutex);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 17b433f1ce23..c7ead488eee2 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -239,7 +239,10 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 		cxl_context_mm_count_put(ctx);
 		goto out;
 	}
-
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (ctx->mm)
+		mm_context_set_global_tlbi(&ctx->mm->context);
+#endif
 	ctx->status = STARTED;
 	rc = 0;
 out:
-- 
2.11.0
