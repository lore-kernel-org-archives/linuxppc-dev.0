Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBFD81A1052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 15:48:04 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A4317140291
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2015 15:48:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 7 Jul 2015 15:48:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4FC802CE804E
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2015 15:48:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t675lsdA54853764
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2015 15:48:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t675lSAj016163
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2015 15:47:29 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 2/2] cxl: Fail mmap if requested mapping is larger than
 assigned problem state area
Date: Tue,  7 Jul 2015 15:45:46 +1000
Message-Id: <1436247946-16292-2-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1436247946-16292-1-git-send-email-imunsie@au.ibm.com>
References: <1436247946-16292-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch makes the mmap call fail outright if the requested region is
larger than the problem state area assigned to the context so the error
is reported immediately rather than waiting for an attempt to access an
address out of bounds.

Although we never expect users to map more than the assigned problem
state area and are not aware of anyone doing this (other than for
testing), this does have the potential to break users if someone has
used a larger range regardless. I'm submitting it for consideration, but
if this change is not considered acceptable the previous patch is
sufficient to prevent access out of bounds without breaking anyone.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 6c1ce51..1287148 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -145,8 +145,16 @@ static const struct vm_operations_struct cxl_mmap_vmops = {
  */
 int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma)
 {
+	u64 start = vma->vm_pgoff << PAGE_SHIFT;
 	u64 len = vma->vm_end - vma->vm_start;
-	len = min(len, ctx->psn_size);
+
+	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
+		if (start + len > ctx->afu->adapter->ps_size)
+			return -EINVAL;
+	} else {
+		if (start + len > ctx->psn_size)
+			return -EINVAL;
+	}
 
 	if (ctx->afu->current_mode != CXL_MODE_DEDICATED) {
 		/* make sure there is a valid per process space for this AFU */
-- 
2.1.4
