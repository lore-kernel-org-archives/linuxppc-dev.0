Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1EBB1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 07:51:23 +1100 (AEDT)
Date: Thu, 19 Mar 2015 21:51:20 +0100
From: Torsten Duwe <duwe@lst.de>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v0 3/4] ppc64le: kgraft support
Message-ID: <20150319205120.GD19524@lst.de>
References: <20150319203522.GA19524@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150319203522.GA19524@lst.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kgraft hooks for ppc64. Just massaged a bit to
get them to compile and not interfere.
Feel free to test them if you're daring ;)

diff --git a/arch/powerpc/include/asm/kgraft.h b/arch/powerpc/include/asm/kgraft.h
new file mode 100644
index 0000000..7f8600d
--- /dev/null
+++ b/arch/powerpc/include/asm/kgraft.h
@@ -0,0 +1,33 @@
+/*
+ * kGraft Online Kernel Patching
+ *
+ *  Copyright (c) 2013-2014 SUSE
+ *   Authors: Jiri Kosina
+ *	      Vojtech Pavlik
+ *	      Jiri Slaby
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#ifndef ASM_KGR_H
+#define ASM_KGR_H
+
+#include <asm/ptrace.h>
+#include <linux/stacktrace.h>
+
+static inline void kgr_set_regs_ip(struct pt_regs *regs, unsigned long ip)
+{
+	regs->link = ip;
+}
+
+static inline bool kgr_needs_lazy_migration(struct task_struct *p)
+{
+	return true;
+}
+
+#endif
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index b034ecd..aa6a084 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -92,6 +92,7 @@ static inline struct thread_info *current_thread_info(void)
 					   TIF_NEED_RESCHED */
 #define TIF_32BIT		4	/* 32 bit binary */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
+#define TIF_KGR_IN_PROGRESS	6	/* kGraft patching in progress */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
 #define TIF_NOHZ		9	/* in adaptive nohz mode */
@@ -115,8 +117,10 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
+#define _TIF_KGR_IN_PROGRESS	(1<<TIF_KGR_IN_PROGRESS)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
+#define _TIF_NOHZ		(1<<TIF_NOHZ)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
@@ -124,7 +128,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
-#define _TIF_NOHZ		(1<<TIF_NOHZ)
+
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
 				 _TIF_NOHZ)
@@ -132,7 +136,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_RESTORE_TM)
-#define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
+
+#define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR|_TIF_KGR_IN_PROGRESS)
 
 /* Bits in local_flags */
 /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 5bbd1bc..569acd4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -151,8 +151,8 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif
 	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
-	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
-	bne	syscall_dotrace
+	andi.	r10,r10,(_TIF_SYSCALL_T_OR_A|_TIF_KGR_IN_PROGRESS)
+	bne-	syscall_precall
 .Lsyscall_dotrace_cont:
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
@@ -245,6 +245,17 @@ syscall_error:
 	neg	r3,r3
 	std	r5,_CCR(r1)
 	b	.Lsyscall_error_cont
+
+syscall_precall:
+	andi.	r10,r10,(_TIF_KGR_IN_PROGRESS)
+	beq+	syscall_dotrace
+
+	addi	r11,r11,TI_FLAGS
+1:	ldarx	r12,0,r11
+	andc	r12,r12,r10
+	stdcx.	r12,0,r11
+	bne-	1b
+	subi	r11,r11,TI_FLAGS
 	
 /* Traced system call support */
 syscall_dotrace:
