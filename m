Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP2Yn3zgTzDw33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:02:37 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id x23so1086115pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:02:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Alan Modra <amodra@gmail.com>
Subject: [PATCH 3/3] powerpc/64e: don't branch to dot symbols
Date: Thu, 24 Nov 2016 00:02:09 +1100
Message-Id: <20161123130209.1667-4-npiggin@gmail.com>
In-Reply-To: <20161123130209.1667-1-npiggin@gmail.com>
References: <20161123130209.1667-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This converts one that was missed by b1576fec7f4d ("powerpc: No need
to use dot symbols when branching to a function").

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 38a1f96..45b453e 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -923,10 +923,10 @@ kernel_dbg_exc:
 			        PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x340)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.save_nvgprs
+	bl	save_nvgprs
 	INTS_RESTORE_HARD
-	bl	.unknown_exception
-	b	.ret_from_except
+	bl	unknown_exception
+	b	ret_from_except
 
 /*
  * An interrupt came in while soft-disabled; We mark paca->irq_happened
-- 
2.10.2
