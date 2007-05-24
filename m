Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 24 May 2007 15:41:04 +1000
Subject: [PATCH] powerpc: Fix ppc32 single step out of syscalls
Message-Id: <20070524054107.89531DDDF8@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ppc32 kernel didn't properly set/clear the TIF_SINGLESTEP
flag causing return from syscalls to not SIGTRAP, thus executing
one more instruction before stopping again.

This fixes it. The ptrace code is a bit of a mess, and is overdue
of at least a -proper- 32/64 bits split and possibly more cleanups
but this minimum fix should be ok for 2.6.22

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

 arch/powerpc/kernel/ptrace.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-24 15:18:42.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-24 15:19:15.000000000 +1000
@@ -218,6 +218,7 @@ set_single_step(struct task_struct *task
 		regs->msr |= MSR_SE;
 #endif
 	}
+	set_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
 static inline void
@@ -233,6 +234,7 @@ clear_single_step(struct task_struct *ta
 		regs->msr &= ~MSR_SE;
 #endif
 	}
+	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 #endif /* CONFIG_PPC32 */
 
