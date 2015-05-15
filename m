Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 768DE1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:29:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 1/3] powerpc/kernel: Get pt_regs from r9 before calling
 do_syscall_trace_enter()
Date: Fri, 15 May 2015 18:29:38 +1000
Message-Id: <1431678580-11160-1-git-send-email-mpe@ellerman.id.au>
Cc: strosake@linux.vnet.ibm.com, bogdan.purcareata@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To call do_syscall_trace_enter() we need pt_regs in r3, but we don't need
to recalculate it based on r1, it's already in r9.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index afbc20019c2e..b55c393310f3 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -236,7 +236,9 @@ syscall_error:
 /* Traced system call support */
 syscall_dotrace:
 	bl	save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+
+	/* Get pt_regs into r3 */
+	mr	r3, r9
 	bl	do_syscall_trace_enter
 	/*
 	 * Restore argument registers possibly just changed.
-- 
2.1.0
