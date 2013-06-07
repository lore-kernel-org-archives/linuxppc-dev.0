Return-Path: <anton@samba.org>
Date: Fri, 7 Jun 2013 15:42:54 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Print instruction when logging unhandled exceptions
Message-ID: <20130607154254.4b001093@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

We print all ones if the get_user fails, do we want to go to
the added effort of printing XXXXXXXX like we do in the oops
code?

Index: b/arch/powerpc/kernel/traps.c
===================================================================
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -242,9 +242,9 @@ void _exception(int signr, struct pt_reg
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
@@ -252,9 +252,14 @@ void _exception(int signr, struct pt_reg
 	}
 
 	if (show_unhandled_signals && unhandled_signal(current, signr)) {
+		u32 insn;
+
+		if (get_user(insn, (u32 __user *)(regs->nip)))
+			insn = 0xffffffff;
+
 		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 				   current->comm, current->pid, signr,
-				   addr, regs->nip, regs->link, code);
+				   addr, regs->nip, regs->link, code, insn);
 	}
 
 	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
