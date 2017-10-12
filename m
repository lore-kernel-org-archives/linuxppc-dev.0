Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCJD702rtzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 15:44:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 2/3] powerpc/watchdog: regs can't be null in
 soft_nmi_interrupt()
Date: Thu, 12 Oct 2017 15:44:33 +1100
Message-Id: <1507783474-28210-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1507783474-28210-1-git-send-email-mpe@ellerman.id.au>
References: <1507783474-28210-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

soft_nmi_interrupt() is called directly from the asm exception
handling code, which passes regs as a pointer to the stack. So regs
can't be NULL, it may be full of junk, but that's a separate problem.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/watchdog.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 937cb92374c7..2494cbe34132 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -238,10 +238,7 @@ void soft_nmi_interrupt(struct pt_regs *regs)
 		pr_emerg("CPU %d self-detected hard LOCKUP\n", cpu);
 		print_modules();
 		print_irqtrace_events(current);
-		if (regs)
-			show_regs(regs);
-		else
-			dump_stack();
+		show_regs(regs);
 
 		wd_smp_unlock(&flags);
 
-- 
2.7.4
