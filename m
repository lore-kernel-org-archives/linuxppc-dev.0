Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F03591A1052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 15:48:03 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C30F2140291
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2015 15:48:03 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 7 Jul 2015 15:48:03 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7BA592BB0040
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2015 15:47:58 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t675loVL26542282
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2015 15:47:58 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t675lPpO016107
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2015 15:47:26 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] cxl: Fix off by one error allowing subsequent mmap page
 to be accessed
Date: Tue,  7 Jul 2015 15:45:45 +1000
Message-Id: <1436247946-16292-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

It was discovered that if a process mmaped their problem state area they
were able to access one page more than expected, potentially allowing
them to access the problem state area of an unrelated process.

This was due to a simple off by one error in the mmap fault handler
introduced in 0712dc7e73e59d79bcead5d5520acf4e9e917e87 ("cxl: Fix issues
when unmapping contexts"), which is fixed in this patch.

Cc: stable@vger.kernel.org
Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 2a4c80a..6c1ce51 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -113,11 +113,11 @@ static int cxl_mmap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 
 	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
 		area = ctx->afu->psn_phys;
-		if (offset > ctx->afu->adapter->ps_size)
+		if (offset >= ctx->afu->adapter->ps_size)
 			return VM_FAULT_SIGBUS;
 	} else {
 		area = ctx->psn_phys;
-		if (offset > ctx->psn_size)
+		if (offset >= ctx->psn_size)
 			return VM_FAULT_SIGBUS;
 	}
 
-- 
2.1.4
