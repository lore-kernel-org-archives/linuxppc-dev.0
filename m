Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 May 2007 17:17:17 +1000
Subject: [RFC/PATCH 5/6] powerpc: remove some useless ifdef's in ptrace
Message-Id: <20070530071728.BD588DE021@ozlabs.org>
Cc: ulrich.weigand@de.ibm.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CHECK_FULL_REGS() exist on both 32 and 64 bits, so there's no need
to make it conditional on CONFIG_PPC32

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/ptrace.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-30 16:02:55.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-30 16:02:55.000000000 +1000
@@ -371,9 +371,7 @@ long arch_ptrace(struct task_struct *chi
 #endif
 			break;
 
-#ifdef CONFIG_PPC32
 		CHECK_FULL_REGS(child->thread.regs);
-#endif
 		if (index < PT_FPR0) {
 			tmp = ptrace_get_reg(child, (int) index);
 		} else {
@@ -410,9 +408,7 @@ long arch_ptrace(struct task_struct *chi
 #endif
 			break;
 
-#ifdef CONFIG_PPC32
 		CHECK_FULL_REGS(child->thread.regs);
-#endif
 		if (index == PT_ORIG_R3)
 			break;
 		if (index < PT_FPR0) {
