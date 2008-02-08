Return-Path: <hugh@veritas.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B466DDF06
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 06:31:23 +1100 (EST)
Date: Fri, 8 Feb 2008 18:25:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: fix DEBUG_PREEMPT warning when warning
Message-ID: <Pine.LNX.4.64.0802081823400.6273@blonde.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc show_regs prints CPU using smp_processor_id: change that to
raw_smp_processor_id, so that when it's showing a WARN_ON backtrace without
preemption disabled, DEBUG_PREEMPT doesn't mess up that warning with its own.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 powerpc/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.24-git18/arch/powerpc/kernel/process.c	2008-01-24 22:58:37.000000000 +0000
+++ linux/arch/powerpc/kernel/process.c	2008-02-08 12:01:31.000000000 +0000
@@ -462,7 +462,7 @@ void show_regs(struct pt_regs * regs)
 	       current, task_pid_nr(current), current->comm, task_thread_info(current));
 
 #ifdef CONFIG_SMP
-	printk(" CPU: %d", smp_processor_id());
+	printk(" CPU: %d", raw_smp_processor_id());
 #endif /* CONFIG_SMP */
 
 	for (i = 0;  i < 32;  i++) {
