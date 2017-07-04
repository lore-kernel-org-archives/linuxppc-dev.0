Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x27Xn4f3MzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 01:42:01 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v64Fe6Vu057152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 11:41:58 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bgay4k4au-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 11:41:58 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 4 Jul 2017 16:41:56 +0100
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH] cxl: Fix is_page_fault() for POWER9
Date: Tue,  4 Jul 2017 17:41:52 +0200
Message-Id: <1499182912-26730-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <christophe_lombard@fr.ibm.cm>

The function is_page_fault(), for POWER9, lists the Translation Checkout
Responses where the page fault will be handled by copro_handle_mm_fault().
This list is too restrictive and not necessary.

This patches removes this restriction and all page faults, whatever the
reason, will be handled. In this case, the interruption is always
acknowledged.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

---
This patch applies on top of this patch:
 https://git.kernel.org/powerpc/c/3ced8d73006321bd2a0412fa0ff4b0
---
 drivers/misc/cxl/fault.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 6eed7d0..0cf7f4a 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -204,22 +204,11 @@ static bool cxl_is_segment_miss(struct cxl_context *ctx, u64 dsisr)
 
 static bool cxl_is_page_fault(struct cxl_context *ctx, u64 dsisr)
 {
-	u64 crs; /* Translation Checkout Response Status */
-
 	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_An_DM))
 		return true;
 
-	if (cxl_is_power9()) {
-		crs = (dsisr & CXL_PSL9_DSISR_An_CO_MASK);
-		if ((crs == CXL_PSL9_DSISR_An_PF_SLR) ||
-		    (crs == CXL_PSL9_DSISR_An_PF_RGC) ||
-		    (crs == CXL_PSL9_DSISR_An_PF_RGP) ||
-		    (crs == CXL_PSL9_DSISR_An_PF_HRH) ||
-		    (crs == CXL_PSL9_DSISR_An_PF_STEG) ||
-		    (crs == CXL_PSL9_DSISR_An_URTCH)) {
-			return true;
-		}
-	}
+	if (cxl_is_power9())
+		return true;
 
 	return false;
 }
-- 
2.7.4
