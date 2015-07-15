Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8F981A1D4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 17:37:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [RFC PATCH 01/12] powerpc/kernel: Get pt_regs from r9 before calling
 do_syscall_trace_enter()
Date: Wed, 15 Jul 2015 17:37:03 +1000
Message-Id: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
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
index 579e0f9a2d57..0796c487d3db 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -243,7 +243,9 @@ syscall_error:
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
