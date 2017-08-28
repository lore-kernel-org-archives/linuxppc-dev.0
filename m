Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgdl60KZZzDqSb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:17:05 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S4DgdB088120
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 00:17:04 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cm2pe1nej-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 00:17:03 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 14:17:01 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7S4Fj3C39649474
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:15:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7S4FjUD020015
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:15:46 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [PATCH] cxl: Set the valid bit in PE for dedicated mode
Date: Mon, 28 Aug 2017 09:45:22 +0530
Message-Id: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure to set the valid-bit in software-state field of the
populated PE. This was earlier missing for dedicated mode AFUs, hence
was causing a PSL freeze when the AFU was activated.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/native.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 4a82c313cf71..0e748c682ee9 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -897,6 +897,10 @@ int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
 	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
 		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
 
+	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
+	/* Make sure the changes to the PE are visible to the card */
+	smp_wmb();
+
 	result = cxl_ops->afu_reset(afu);
 	if (result)
 		return result;
-- 
2.13.5
