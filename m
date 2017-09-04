Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm3Sm4mGKzDqjv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 18:50:00 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v848mjFj089271
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Sep 2017 04:49:57 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cs2fgu9u5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Sep 2017 04:49:57 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 4 Sep 2017 18:49:54 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v848mbFK38666254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Sep 2017 18:48:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v848mSNH031761
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Sep 2017 18:48:29 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [PATCH v2] cxl: Set the valid bit in PE for dedicated mode
Date: Mon,  4 Sep 2017 14:18:25 +0530
Message-Id: <20170904084825.22172-1-vaibhav@linux.vnet.ibm.com>
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
Changelog:

v2 -> Removed a call to smp_wmb() after setting the bit [Michael Ellerman]
---

 drivers/misc/cxl/native.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 4a82c313cf71..75df74d59527 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -897,6 +897,14 @@ int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
 	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
 		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
 
+	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
+	/*
+	 * Ideally we should do a wmb() here to make sure the changes to the
+	 * PE are visible to the card before we call afu_enable.
+	 * On ppc64 though all mmios are preceded by a 'sync' instruction hence
+	 * we dont dont need one here.
+	 */
+
 	result = cxl_ops->afu_reset(afu);
 	if (result)
 		return result;
-- 
2.13.5
