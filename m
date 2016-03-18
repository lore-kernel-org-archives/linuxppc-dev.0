Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRBc43XMbzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 15:11:16 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 18 Mar 2016 14:11:14 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D8A4F2CE8060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 15:10:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2I4AhEd27590806
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 15:10:51 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2I4AJDm010060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 15:10:19 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, benh@kernel.crashing.org
Subject: [PATCH] cxl: fix setting of _PAGE_USER bit when handling page faults
Date: Fri, 18 Mar 2016 15:01:21 +1100
Message-Id: <1458273681-18588-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When handling page faults, cxl_handle_page_fault() checks whether the page
should be accessible by userspace and have its _PAGE_USER access bit set.
_PAGE_USER should be set if the context's kernel flag isn't set, or if the
page falls outside of kernel memory.

However, the check currently uses the wrong operator, causing it to always
evalute to true. As such, we always set the _PAGE_USER bit, even when it
should be restricted to the kernel.

Fix the check so that the _PAGE_USER bit is set only as intended.

Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for
userspace access")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Found by Coverity Scan.

Currently, this should only affect cxlflash.
---
 drivers/misc/cxl/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 9a8650b..a76cb8a 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 	access = _PAGE_PRESENT;
 	if (dsisr & CXL_PSL_DSISR_An_S)
 		access |= _PAGE_RW;
-	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
+	if ((!ctx->kernel) || !(dar & (1ULL << 63)))
 		access |= _PAGE_USER;
 
 	if (dsisr & DSISR_NOHPTE)
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
