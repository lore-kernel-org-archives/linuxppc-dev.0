Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:46 +1000
Subject: [PATCH 10/21] powerpc: Allow ptrace write to pt_regs trap and orig_r3
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051550.C152BDDF07@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows a ptracer to write to the "trap" and "orig_r3" words
of the pt_regs.

This, along with a subsequent patch to the signal restart code, should
enable gdb to properly handle syscall restarting after executing a separate
function (at least when there's no restart block).

This patch also removes ptrace32.c code toying directly with the registers
and makes it use the ptrace_get/put_reg() accessors for everything so that
the logic for checking what is permitted is in only one place.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/ptrace.c   |    9 ++++++---
 arch/powerpc/kernel/ptrace32.c |   27 ++++++++++++++-------------
 2 files changed, 20 insertions(+), 16 deletions(-)

Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-06-04 14:42:13.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-06-04 14:42:26.000000000 +1000
@@ -75,10 +75,15 @@ int ptrace_put_reg(struct task_struct *t
 	if (task->thread.regs == NULL)
 		return -EIO;
 
-	if (regno <= PT_MAX_PUT_REG) {
+	if (regno <= PT_MAX_PUT_REG || regno == PT_TRAP) {
 		if (regno == PT_MSR)
 			data = (data & MSR_DEBUGCHANGE)
 				| (task->thread.regs->msr & ~MSR_DEBUGCHANGE);
+		/* We prevent mucking around with the reserved area of trap
+		 * which are used internally by the kernel
+		 */
+		if (regno == PT_TRAP)
+			data &= 0xfff0;
 		((unsigned long *)task->thread.regs)[regno] = data;
 		return 0;
 	}
@@ -409,8 +414,6 @@ long arch_ptrace(struct task_struct *chi
 			break;
 
 		CHECK_FULL_REGS(child->thread.regs);
-		if (index == PT_ORIG_R3)
-			break;
 		if (index < PT_FPR0) {
 			ret = ptrace_put_reg(child, index, data);
 		} else {
Index: linux-cell/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace32.c	2007-06-04 14:42:13.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace32.c	2007-06-04 14:43:22.000000000 +1000
@@ -206,7 +206,9 @@ long compat_sys_ptrace(int request, int 
 		else
 			part = 0;  /* want the 1st half of the register (left-most). */
 
-		/* Validate the input - check to see if address is on the wrong boundary or beyond the end of the user area */
+		/* Validate the input - check to see if address is on the wrong boundary
+		 * or beyond the end of the user area
+		 */
 		if ((addr & 3) || numReg > PT_FPSCR)
 			break;
 
@@ -270,8 +272,6 @@ long compat_sys_ptrace(int request, int 
 		if ((addr & 3) || (index > PT_FPSCR32))
 			break;
 
-		if (index == PT_ORIG_R3)
-			break;
 		if (index < PT_FPR0) {
 			ret = ptrace_put_reg(child, index, data);
 		} else {
@@ -302,24 +302,25 @@ long compat_sys_ptrace(int request, int 
 		/* Determine which register the user wants */
 		index = (u64)addr >> 2;
 		numReg = index / 2;
+
 		/*
 		 * Validate the input - check to see if address is on the
 		 * wrong boundary or beyond the end of the user area
 		 */
 		if ((addr & 3) || (numReg > PT_FPSCR))
 			break;
-		/* Insure it is a register we let them change */
-		if ((numReg == PT_ORIG_R3)
-				|| ((numReg > PT_CCR) && (numReg < PT_FPR0)))
-			break;
-		if (numReg >= PT_FPR0) {
+		if (numReg < PT_FPR0) {
+			unsigned long freg = ptrace_get_reg(child, numReg);
+			if (index % 2)
+				freg = (freg & ~0xfffffffful) | (data & 0xfffffffful);
+			else
+				freg = (freg & 0xfffffffful) | (data << 32);
+			ret = ptrace_put_reg(child, numReg, freg);
+		} else {
 			flush_fp_to_thread(child);
+			((unsigned int *)child->thread.regs)[index] = data;
+			ret = 0;
 		}
-		if (numReg == PT_MSR)
-			data = (data & MSR_DEBUGCHANGE)
-				| (child->thread.regs->msr & ~MSR_DEBUGCHANGE);
-		((u32*)child->thread.regs)[index] = data;
-		ret = 0;
 		break;
 	}
 
