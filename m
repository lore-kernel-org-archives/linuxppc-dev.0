Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:47 +1000
Subject: [PATCH 12/21] powerpc: ptrace can set DABR on both 32 and 64 bits
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051552.73779DDEC4@ozlabs.org>
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

Allow ptrace to set dabr in the thread structure for both 32 and 64 bits,
though only 64 bits actually uses that field, it's actually defined in both.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/ptrace.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-30 16:21:12.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-30 16:21:22.000000000 +1000
@@ -286,7 +286,6 @@ static void clear_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
-#ifdef CONFIG_PPC64
 static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
@@ -305,7 +304,6 @@ static int ptrace_set_debugreg(struct ta
 	task->thread.dabr = data;
 	return 0;
 }
-#endif
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -503,7 +501,6 @@ long arch_ptrace(struct task_struct *chi
 		break;
 	}
 
-#ifdef CONFIG_PPC64
 	case PTRACE_GET_DEBUGREG: {
 		ret = -EINVAL;
 		/* We only support one DABR and no IABRS at the moment */
@@ -517,7 +514,6 @@ long arch_ptrace(struct task_struct *chi
 	case PTRACE_SET_DEBUGREG:
 		ret = ptrace_set_debugreg(child, addr, data);
 		break;
-#endif
 
 	case PTRACE_DETACH:
 		ret = ptrace_detach(child, data);
