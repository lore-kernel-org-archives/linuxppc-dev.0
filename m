Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-la0-x22e.google.com (mail-la0-x22e.google.com
 [IPv6:2a00:1450:4010:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B11E01A0EAA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 00:26:35 +1100 (AEDT)
Received: by labhs14 with SMTP id hs14so6096621lab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 05:26:31 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH] cxl: Remove useless precision specifiers
Date: Fri, 20 Feb 2015 14:26:22 +0100
Message-Id: <1424438782-31545-1-git-send-email-linux@rasmusvillemoes.dk>
Cc: linuxppc-dev@lists.ozlabs.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C99 says that a precision given as simply '.' with no following digits
or * should be interpreted as 0. The kernel's printf implementation,
however, treats this case as if the precision was omitted. C99 also
says that if both the precision and value are 0, no digits should be
printed. Even if the kernel followed C99 to the letter, I don't think
that would be particularly useful in these cases, so just remove the
precision specifiers.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/misc/cxl/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index c8929c526691..46635a8dbeae 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -147,7 +147,7 @@ static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
 	if (dsisr & CXL_PSL_DSISR_An_PE)
 		return handle_psl_slice_error(ctx, dsisr, irq_info->errstat);
 	if (dsisr & CXL_PSL_DSISR_An_AE) {
-		pr_devel("CXL interrupt: AFU Error %.llx\n", irq_info->afu_err);
+		pr_devel("CXL interrupt: AFU Error %llx\n", irq_info->afu_err);
 
 		if (ctx->pending_afu_err) {
 			/*
@@ -158,7 +158,7 @@ static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
 			 * probably best that we log them somewhere:
 			 */
 			dev_err_ratelimited(&ctx->afu->dev, "CXL AFU Error "
-					    "undelivered to pe %i: %.llx\n",
+					    "undelivered to pe %i: %llx\n",
 					    ctx->pe, irq_info->afu_err);
 		} else {
 			spin_lock(&ctx->lock);
-- 
2.1.3
