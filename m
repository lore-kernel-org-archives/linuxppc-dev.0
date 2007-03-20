Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Mar 2007 10:08:33 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove last_syscall
Message-ID: <20070320150833.GI31173@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove last_syscall from 32bit powerpc, its been gone in 64bit for years.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/asm-offsets.c	2007-03-07 14:27:11.000000000 -0600
+++ linux-2.6/arch/powerpc/kernel/asm-offsets.c	2007-03-07 14:27:13.000000000 -0600
@@ -77,7 +77,6 @@
 	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
 #else /* CONFIG_PPC64 */
 	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
-	DEFINE(LAST_SYSCALL, offsetof(struct thread_struct, last_syscall));
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, dbcr0));
 	DEFINE(PT_PTRACED, PT_PTRACED);
Index: linux-2.6/arch/powerpc/kernel/entry_32.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/entry_32.S	2007-03-07 14:27:11.000000000 -0600
+++ linux-2.6/arch/powerpc/kernel/entry_32.S	2007-03-07 14:27:13.000000000 -0600
@@ -191,7 +191,6 @@
 0:
 
 _GLOBAL(DoSyscall)
-	stw	r0,THREAD+LAST_SYSCALL(r2)
 	stw	r3,ORIG_GPR3(r1)
 	li	r12,0
 	stw	r12,RESULT(r1)
Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2007-03-07 14:27:11.000000000 -0600
+++ linux-2.6/arch/powerpc/kernel/process.c	2007-03-07 14:27:57.000000000 -0600
@@ -567,7 +567,6 @@
 	kregs->nip = *((unsigned long *)ret_from_fork);
 #else
 	kregs->nip = (unsigned long)ret_from_fork;
-	p->thread.last_syscall = -1;
 #endif
 
 	return 0;
Index: linux-2.6/include/asm-powerpc/processor.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/processor.h	2007-03-07 14:27:11.000000000 -0600
+++ linux-2.6/include/asm-powerpc/processor.h	2007-03-07 14:27:13.000000000 -0600
@@ -133,7 +133,6 @@
 	mm_segment_t	fs;		/* for get_fs() validation */
 #ifdef CONFIG_PPC32
 	void		*pgdir;		/* root of page-table tree */
-	signed long	last_syscall;
 #endif
 #if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
 	unsigned long	dbcr0;		/* debug control register values */
Index: linux-2.6/arch/ppc/kernel/asm-offsets.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/asm-offsets.c	2007-03-07 14:27:11.000000000 -0600
+++ linux-2.6/arch/ppc/kernel/asm-offsets.c	2007-03-07 14:27:13.000000000 -0600
@@ -40,7 +40,6 @@
 	DEFINE(PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
 	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
-	DEFINE(LAST_SYSCALL, offsetof(struct thread_struct, last_syscall));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
Index: linux-2.6/arch/ppc/kernel/entry.S
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/entry.S	2007-03-07 14:27:11.000000000 -0600
+++ linux-2.6/arch/ppc/kernel/entry.S	2007-03-07 14:27:13.000000000 -0600
@@ -191,7 +191,6 @@
 0:
 
 _GLOBAL(DoSyscall)
-	stw	r0,THREAD+LAST_SYSCALL(r2)
 	stw	r3,ORIG_GPR3(r1)
 	li	r12,0
 	stw	r12,RESULT(r1)
