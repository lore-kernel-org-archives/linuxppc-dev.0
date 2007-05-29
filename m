Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 29 May 2007 16:45:24 +1000
Subject: [RFC/PATCH 5/5] powerpc: Allow ptrace write to pt_regs trap
Message-Id: <20070529064535.0C1E0DDFBC@ozlabs.org>
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

This patch allows a ptracer to write to the "trap" word of the
pt_regs. This, along with the previous patch, should enable gdb
to properly handle syscall restarting after executing a separate
function (at least when there's no restart block).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/ptrace-common.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-cell/arch/powerpc/kernel/ptrace-common.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace-common.h	2007-05-29 16:22:07.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace-common.h	2007-05-29 16:42:04.000000000 +1000
@@ -41,10 +41,15 @@ static inline int put_reg(struct task_st
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
+			data &= 0xff00;
 		((unsigned long *)task->thread.regs)[regno] = data;
 		return 0;
 	}
