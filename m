Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EC06DDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:33:21 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] [POWERPC] Fix register labels on show_regs() message for
	4xx/Book-E
Date: Thu, 26 Jul 2007 01:32:39 -0500
Message-Id: <1185431571224-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In a show_regs()  message The DEAR and ESR were reported as
DAR and DSISR which only exist on classic parts.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 84f000a..a83727b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -423,7 +423,11 @@ void show_regs(struct pt_regs * regs)
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if (trap == 0x300 || trap == 0x600)
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
+#else
 		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);
+#endif
 	printk("TASK = %p[%d] '%s' THREAD: %p",
 	       current, current->pid, current->comm, task_thread_info(current));
 
-- 
1.5.2.2
