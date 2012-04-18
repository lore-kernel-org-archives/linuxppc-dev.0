Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 15:36:21 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Remove old powerpc specific ptrace getregs/setregs
 calls
Message-ID: <20120418153621.20fefbdc@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


PowerPC has non standard getregs calls that only dump the GPRs or
FPRs and have their arguments reversed. commit e17666ba48f7 (ptrace
updates & new, better requests) in 2.6.3 deprecated them and introduced
more standard versions.

It's been about 5 years and I know of no users of the old calls so
lets remove them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/ptrace.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/ptrace.h	2012-04-12 11:36:25.784215556 +1000
+++ linux-build/arch/powerpc/include/asm/ptrace.h	2012-04-12 11:36:48.000619966 +1000
@@ -354,12 +354,6 @@ static inline unsigned long regs_get_ker
 #define PTRACE_GETREGS64	  22
 #define PTRACE_SETREGS64	  23
 
-/* (old) PTRACE requests with inverted arguments */
-#define PPC_PTRACE_GETREGS	0x99	/* Get GPRs 0 - 31 */
-#define PPC_PTRACE_SETREGS	0x98	/* Set GPRs 0 - 31 */
-#define PPC_PTRACE_GETFPREGS	0x97	/* Get FPRs 0 - 31 */
-#define PPC_PTRACE_SETFPREGS	0x96	/* Set FPRs 0 - 31 */
-
 /* Calls to trace a 64bit program from a 32bit program */
 #define PPC_PTRACE_PEEKTEXT_3264 0x95
 #define PPC_PTRACE_PEEKDATA_3264 0x94
Index: linux-build/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/ptrace.c	2012-04-12 11:36:25.796215776 +1000
+++ linux-build/arch/powerpc/kernel/ptrace.c	2012-04-12 11:36:48.004620039 +1000
@@ -1432,40 +1432,6 @@ static long ppc_del_hwdebug(struct task_
 #endif
 }
 
-/*
- * Here are the old "legacy" powerpc specific getregs/setregs ptrace calls,
- * we mark them as obsolete now, they will be removed in a future version
- */
-static long arch_ptrace_old(struct task_struct *child, long request,
-			    unsigned long addr, unsigned long data)
-{
-	void __user *datavp = (void __user *) data;
-
-	switch (request) {
-	case PPC_PTRACE_GETREGS:	/* Get GPRs 0 - 31. */
-		return copy_regset_to_user(child, &user_ppc_native_view,
-					   REGSET_GPR, 0, 32 * sizeof(long),
-					   datavp);
-
-	case PPC_PTRACE_SETREGS:	/* Set GPRs 0 - 31. */
-		return copy_regset_from_user(child, &user_ppc_native_view,
-					     REGSET_GPR, 0, 32 * sizeof(long),
-					     datavp);
-
-	case PPC_PTRACE_GETFPREGS:	/* Get FPRs 0 - 31. */
-		return copy_regset_to_user(child, &user_ppc_native_view,
-					   REGSET_FPR, 0, 32 * sizeof(double),
-					   datavp);
-
-	case PPC_PTRACE_SETFPREGS:	/* Set FPRs 0 - 31. */
-		return copy_regset_from_user(child, &user_ppc_native_view,
-					     REGSET_FPR, 0, 32 * sizeof(double),
-					     datavp);
-	}
-
-	return -EPERM;
-}
-
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
@@ -1687,14 +1653,6 @@ long arch_ptrace(struct task_struct *chi
 					     datavp);
 #endif
 
-	/* Old reverse args ptrace callss */
-	case PPC_PTRACE_GETREGS: /* Get GPRs 0 - 31. */
-	case PPC_PTRACE_SETREGS: /* Set GPRs 0 - 31. */
-	case PPC_PTRACE_GETFPREGS: /* Get FPRs 0 - 31. */
-	case PPC_PTRACE_SETFPREGS: /* Get FPRs 0 - 31. */
-		ret = arch_ptrace_old(child, request, addr, data);
-		break;
-
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
Index: linux-build/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/ptrace32.c	2012-04-12 11:36:25.816216138 +1000
+++ linux-build/arch/powerpc/kernel/ptrace32.c	2012-04-12 11:37:33.725452160 +1000
@@ -39,30 +39,6 @@
  * in exit.c or in signal.c.
  */
 
-/*
- * Here are the old "legacy" powerpc specific getregs/setregs ptrace calls,
- * we mark them as obsolete now, they will be removed in a future version
- */
-static long compat_ptrace_old(struct task_struct *child, long request,
-			      long addr, long data)
-{
-	switch (request) {
-	case PPC_PTRACE_GETREGS:	/* Get GPRs 0 - 31. */
-		return copy_regset_to_user(child,
-					   task_user_regset_view(current), 0,
-					   0, 32 * sizeof(compat_long_t),
-					   compat_ptr(data));
-
-	case PPC_PTRACE_SETREGS:	/* Set GPRs 0 - 31. */
-		return copy_regset_from_user(child,
-					     task_user_regset_view(current), 0,
-					     0, 32 * sizeof(compat_long_t),
-					     compat_ptr(data));
-	}
-
-	return -EPERM;
-}
-
 /* Macros to workout the correct index for the FPR in the thread struct */
 #define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
 #define FPRHALF(i) (((i) - PT_FPR0) & 1)
@@ -308,8 +284,6 @@ long compat_arch_ptrace(struct task_stru
 	case PTRACE_SETVSRREGS:
 	case PTRACE_GETREGS64:
 	case PTRACE_SETREGS64:
-	case PPC_PTRACE_GETFPREGS:
-	case PPC_PTRACE_SETFPREGS:
 	case PTRACE_KILL:
 	case PTRACE_SINGLESTEP:
 	case PTRACE_DETACH:
@@ -322,12 +296,6 @@ long compat_arch_ptrace(struct task_stru
 		ret = arch_ptrace(child, request, addr, data);
 		break;
 
-	/* Old reverse args ptrace callss */
-	case PPC_PTRACE_GETREGS: /* Get GPRs 0 - 31. */
-	case PPC_PTRACE_SETREGS: /* Set GPRs 0 - 31. */
-		ret = compat_ptrace_old(child, request, addr, data);
-		break;
-
 	default:
 		ret = compat_ptrace_request(child, request, addr, data);
 		break;
