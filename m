Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPQD319vnzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 17:47:47 +1100 (AEDT)
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
 chenhui.zhao@freescale.com
Date: Tue, 15 Mar 2016 01:47:38 -0500
Message-Id: <1458024458-19206-1-git-send-email-oss@buserror.net>
Subject: [PATCH] powerpc/book3e-64: Use hardcoded mttmr opcode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This preserves the ability to build using older binutils (reportedly <=
2.22).

Signed-off-by: Scott Wood <oss@buserror.net>
Cc: chenhui.zhao@freescale.com
---
 arch/powerpc/kernel/head_64.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2916283..4286775 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -41,6 +41,7 @@
 #include <asm/ptrace.h>
 #include <asm/hw_irq.h>
 #include <asm/cputhreads.h>
+#include <asm/ppc-opcode.h>
 
 /* The physical memory is laid out such that the secondary processor
  * spin code sits at 0x0000...0x00ff. On server, the vectors follow
@@ -207,12 +208,12 @@ _GLOBAL(book3e_start_thread)
 	/* If the thread id is invalid, just exit. */
 	b	13f
 10:
-	mttmr	TMRN_IMSR0, r5
-	mttmr	TMRN_INIA0, r4
+	MTTMR(TMRN_IMSR0, 5)
+	MTTMR(TMRN_INIA0, 4)
 	b	12f
 11:
-	mttmr	TMRN_IMSR1, r5
-	mttmr	TMRN_INIA1, r4
+	MTTMR(TMRN_IMSR1, 5)
+	MTTMR(TMRN_INIA1, 4)
 12:
 	isync
 	li	r6, 1
-- 
2.5.0
