Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A73BB1A0704
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 14:27:37 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so65827649pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 19:27:35 -0800 (PST)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id eg2sm6894642pbc.38.2015.11.18.19.27.34
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Nov 2015 19:27:35 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove unused function trace_syscall()
Date: Thu, 19 Nov 2015 14:26:28 +1100
Message-Id: <1447903588-610-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function has been unused since commit 14cf11af6cf6 ("powerpc: Merge enough
to start building in arch/powerpc."), so remove it.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/traps.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 37de90f8a845..b6becc795bb5 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1313,13 +1313,6 @@ void nonrecoverable_exception(struct pt_regs *regs)
 	die("nonrecoverable exception", regs, SIGKILL);
 }
 
-void trace_syscall(struct pt_regs *regs)
-{
-	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld    %s\n",
-	       current, task_pid_nr(current), regs->nip, regs->link, regs->gpr[0],
-	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3], print_tainted());
-}
-
 void kernel_fp_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
-- 
2.5.0
