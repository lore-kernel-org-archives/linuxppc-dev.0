Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2A5C1A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 20:21:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [PATCH 04/11] powerpc: Don't negate error in
 syscall_set_return_value()
Date: Thu, 23 Jul 2015 20:21:04 +1000
Message-Id: <1437646871-3195-4-git-send-email-mpe@ellerman.id.au>
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

Currently the only caller of syscall_set_return_value() is seccomp
filter, which is not enabled on powerpc.

This means we have not noticed that our implementation of
syscall_set_return_value() negates error, even though the value passed
in is already negative.

So remove the negation in syscall_set_return_value(), and expect the
caller to do it like all other implementations do.

Also add a comment about the ccr handling.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/syscall.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index c6239dabcfb1..cabe90133e69 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -44,9 +44,15 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
+	/*
+	 * In the general case it's not obvious that we must deal with CCR
+	 * here, as the syscall exit path will also do that for us. However
+	 * there are some places, eg. the signal code, which check ccr to
+	 * decide if the value in r3 is actually an error.
+	 */
 	if (error) {
 		regs->ccr |= 0x10000000L;
-		regs->gpr[3] = -error;
+		regs->gpr[3] = error;
 	} else {
 		regs->ccr &= ~0x10000000L;
 		regs->gpr[3] = val;
-- 
2.1.0
