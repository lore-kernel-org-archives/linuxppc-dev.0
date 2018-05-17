Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mg6h3vn1zF15L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 15:37:16 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, mikey@neuling.org
Subject: [PATCH 2/2] powerpc/ptrace: Fix setting 512B aligned breakpoints with
 PTRACE_SET_DEBUGREG
Date: Thu, 17 May 2018 15:37:15 +1000
Message-Id: <20180517053715.24011-2-mikey@neuling.org>
In-Reply-To: <20180517053715.24011-1-mikey@neuling.org>
References: <20180517053715.24011-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In this change:
  e2a800beac powerpc/hw_brk: Fix off by one error when validating DAWR region end

We fixed setting the DAWR end point to its max value via
PPC_PTRACE_SETHWDEBUG. Unfortunately we broke PTRACE_SET_DEBUGREG when
setting a 512 byte aligned breakpoint.

PTRACE_SET_DEBUGREG currently sets the length of the breakpoint to
zero (memset() in hw_breakpoint_init()).  This worked with
arch_validate_hwbkpt_settings() before the above patch was applied but
is now broken if the breakpoint is 512byte aligned.

This sets the length of the breakpoint to 8 bytes when using
PTRACE_SET_DEBUGREG.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@vger.kernel.org # 3.10+
---
 arch/powerpc/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d23cf632ed..0f63dd5972 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2443,6 +2443,7 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	/* Create a new breakpoint request if one doesn't exist already */
 	hw_breakpoint_init(&attr);
 	attr.bp_addr = hw_brk.address;
+	attr.bp_len = 8;
 	arch_bp_generic_fields(hw_brk.type,
 			       &attr.bp_type);
 
-- 
2.14.1
