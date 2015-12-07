Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C458C1A0D8C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 00:35:01 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 7 Dec 2015 13:34:57 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C34961B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 13:35:22 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB7DYsoQ7602684
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2015 13:34:54 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB7DYr69031106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2015 06:34:54 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 <stable@vger.kernel.org>
Subject: [PATCH] cxl: Set endianess of kernel contexts
Date: Mon,  7 Dec 2015 14:34:40 +0100
Message-Id: <1449495280-18819-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A process element (defined in CAIA) keeps track of the endianess of
contexts through the Little Endian (LE) bit of the State Register. It
is currently set for user contexts, but was somehow forgotten for
kernel contexts, so this patch fixes it.
It could lead to erratic behavior from an AFU when the context is
attached through the kernel API.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Suggested-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> # 4.3+
---
cxl kernel API is supported starting with 4.3 (for cxlflash)

 drivers/misc/cxl/native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index d2e75c8..f409097 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -497,6 +497,7 @@ static u64 calculate_sr(struct cxl_context *ctx)
 {
 	u64 sr = 0;
 
+	set_endian(sr);
 	if (ctx->master)
 		sr |= CXL_PSL_SR_An_MP;
 	if (mfspr(SPRN_LPCR) & LPCR_TC)
@@ -506,7 +507,6 @@ static u64 calculate_sr(struct cxl_context *ctx)
 		sr |= CXL_PSL_SR_An_HV;
 	} else {
 		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
-		set_endian(sr);
 		sr &= ~(CXL_PSL_SR_An_HV);
 		if (!test_tsk_thread_flag(current, TIF_32BIT))
 			sr |= CXL_PSL_SR_An_SF;
-- 
1.9.1
