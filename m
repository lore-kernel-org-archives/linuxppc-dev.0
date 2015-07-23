Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D57611A036E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 20:21:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [PATCH 05/11] powerpc: Rework syscall_get_arguments() so there is
 only one loop
Date: Thu, 23 Jul 2015 20:21:05 +1000
Message-Id: <1437646871-3195-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently syscall_get_arguments() has two loops, one for compat and one
for regular tasks. In prepartion for the next patch, which changes which
registers we use, switch it to only have one loop, so we only have one
place to update.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/syscall.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index cabe90133e69..403e2303fe18 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -64,19 +64,16 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
+	unsigned long mask = -1UL;
+
 	BUG_ON(i + n > 6);
-#ifdef CONFIG_PPC64
-	if (test_tsk_thread_flag(task, TIF_32BIT)) {
-		/*
-		 * Zero-extend 32-bit argument values.  The high bits are
-		 * garbage ignored by the actual syscall dispatch.
-		 */
-		while (n-- > 0)
-			args[n] = (u32) regs->gpr[3 + i + n];
-		return;
-	}
+
+#ifdef CONFIG_COMPAT
+	if (test_tsk_thread_flag(task, TIF_32BIT))
+		mask = 0xffffffff;
 #endif
-	memcpy(args, &regs->gpr[3 + i], n * sizeof(args[0]));
+	while (n--)
+		args[n] = regs->gpr[3 + i + n] & mask;
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
-- 
2.1.0
