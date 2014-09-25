Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C03671A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 15:05:46 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Print instruction when logging unhandled exceptions
Date: Thu, 25 Sep 2014 15:05:45 +1000
Message-Id: <1411621545-19310-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is often useful to see the instruction that caused an unhandled
exception.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/traps.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0dc43f9..27e30c8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -36,10 +36,10 @@
 #include <linux/debugfs.h>
 #include <linux/ratelimit.h>
 #include <linux/context_tracking.h>
+#include <linux/uaccess.h>
 
 #include <asm/emulated_ops.h>
 #include <asm/pgtable.h>
-#include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
@@ -242,9 +242,9 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
 	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-			"at %08lx nip %08lx lr %08lx code %x\n";
+			"at %08lx nip %08lx lr %08lx code %x insn %08x\n";
 	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-			"at %016lx nip %016lx lr %016lx code %x\n";
+			"at %016lx nip %016lx lr %016lx code %x insn %08x\n";
 
 	if (!user_mode(regs)) {
 		die("Exception in kernel mode", regs, signr);
@@ -252,9 +252,18 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	}
 
 	if (show_unhandled_signals && unhandled_signal(current, signr)) {
+		u32 __user *nia = (u32 __user *)regs->nip;
+		u32 insn = 0;
+
+		pagefault_disable();
+		if (!access_ok(VERIFY_READ, nia, sizeof(*nia)) ||
+		    __get_user_inatomic(insn, nia))
+			insn = 0xffffffffUL;
+		pagefault_enable();
+
 		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 				   current->comm, current->pid, signr,
-				   addr, regs->nip, regs->link, code);
+				   addr, regs->nip, regs->link, code, insn);
 	}
 
 	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
-- 
1.9.1
