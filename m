Return-Path: <ananth@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D45AD1A0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 15:41:20 +1000 (AEST)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C818140295
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2015 15:41:19 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Mon, 24 Aug 2015 23:41:18 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D873719D8026
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2015 23:32:09 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t7P5cNSs42729496
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2015 22:38:23 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7P5fDmu019020
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2015 23:41:13 -0600
Date: Tue, 25 Aug 2015 11:11:10 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add user-return-notifier support
Message-ID: <20150825054110.GD3815@in.ibm.com>
Reply-To: ananth@in.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add user return notifier support for powerpc. Similar to x86, this feature
keys off of the KVM Kconfig.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 Documentation/features/debug/user-ret-profiler/arch-support.txt |    2 +-
 arch/powerpc/Kconfig                                            |    1 +
 arch/powerpc/include/asm/thread_info.h                          |    2 ++
 arch/powerpc/kernel/process.c                                   |    4 ++++
 arch/powerpc/kernel/signal.c                                    |    4 ++++
 arch/powerpc/kvm/Kconfig                                        |    1 +
 6 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-4.2-rc6/Documentation/features/debug/user-ret-profiler/arch-support.txt
===================================================================
--- linux-4.2-rc6.orig/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ linux-4.2-rc6/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -27,7 +27,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
Index: linux-4.2-rc6/arch/powerpc/Kconfig
===================================================================
--- linux-4.2-rc6.orig/arch/powerpc/Kconfig
+++ linux-4.2-rc6/arch/powerpc/Kconfig
@@ -106,6 +106,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_ATTRS
Index: linux-4.2-rc6/arch/powerpc/include/asm/thread_info.h
===================================================================
--- linux-4.2-rc6.orig/arch/powerpc/include/asm/thread_info.h
+++ linux-4.2-rc6/arch/powerpc/include/asm/thread_info.h
@@ -86,6 +86,7 @@ static inline struct thread_info *curren
 					   TIF_NEED_RESCHED */
 #define TIF_32BIT		4	/* 32 bit binary */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
+#define TIF_USER_RETURN_NOTIFY	6	/* notify kernel of userspace return */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
 #define TIF_NOHZ		9	/* in adaptive nohz mode */
@@ -109,6 +110,7 @@ static inline struct thread_info *curren
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
+#define _TIF_USER_RETURN_NOTIFY	(1<<TIF_USER_RETURN_NOTIFY)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
Index: linux-4.2-rc6/arch/powerpc/kernel/process.c
===================================================================
--- linux-4.2-rc6.orig/arch/powerpc/kernel/process.c
+++ linux-4.2-rc6/arch/powerpc/kernel/process.c
@@ -38,6 +38,7 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/uaccess.h>
+#include <linux/user-return-notifier.h>
 
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -894,6 +895,9 @@ struct task_struct *__switch_to(struct t
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+	if (unlikely(task_thread_info(prev)->flags & _TIF_USER_RETURN_NOTIFY))
+		propagate_user_return_notify(prev, new);
+
 	return last;
 }
 
Index: linux-4.2-rc6/arch/powerpc/kernel/signal.c
===================================================================
--- linux-4.2-rc6.orig/arch/powerpc/kernel/signal.c
+++ linux-4.2-rc6/arch/powerpc/kernel/signal.c
@@ -14,6 +14,7 @@
 #include <linux/uprobes.h>
 #include <linux/key.h>
 #include <linux/context_tracking.h>
+#include <linux/user-return-notifier.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -159,6 +160,9 @@ void do_notify_resume(struct pt_regs *re
 		tracehook_notify_resume(regs);
 	}
 
+	if (thread_info_flags & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+
 	user_enter();
 }
 
Index: linux-4.2-rc6/arch/powerpc/kvm/Kconfig
===================================================================
--- linux-4.2-rc6.orig/arch/powerpc/kvm/Kconfig
+++ linux-4.2-rc6/arch/powerpc/kvm/Kconfig
@@ -22,6 +22,7 @@ config KVM
 	select ANON_INODES
 	select HAVE_KVM_EVENTFD
 	select SRCU
+	select USER_RETURN_NOTIFIER
 
 config KVM_BOOK3S_HANDLER
 	bool
