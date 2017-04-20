Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7p5C0PNjzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 15:55:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org,
	dan.carpenter@oracle.com
Subject: [PATCH] powerpc/xive: Fix missing check of rc != OPAL_BUSY
Date: Thu, 20 Apr 2017 15:55:55 +1000
Message-Id: <1492667755-16810-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Carpenter noticed that the code in __xive_native_disable_queue() has a for
loop with an unconditional break in the middle, which doesn't make a lot of
sense.

What the code's supposed to do is loop as long as OPAL says it's busy, if we get
any other return code, either success or failure, then we should break the loop.

So add the missing check.

Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/sysdev/xive/native.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 5fae59186cb2..1a726229a427 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -180,6 +180,7 @@ static void __xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio)
 	/* Disable the queue in HW */
 	for (;;) {
 		rc = opal_xive_set_queue_info(vp_id, prio, 0, 0, 0);
+		if (rc != OPAL_BUSY)
 			break;
 		msleep(1);
 	}
-- 
2.7.4
