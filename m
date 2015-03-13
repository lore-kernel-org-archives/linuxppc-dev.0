Return-Path: <alexinbeijing@gmail.com>
Received: from mail-we0-x234.google.com (mail-we0-x234.google.com
 [IPv6:2a00:1450:400c:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FBFD1A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 05:16:06 +1100 (AEDT)
Received: by wesw55 with SMTP id w55so25051901wes.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 11:16:02 -0700 (PDT)
From: Alex Dowad <alexinbeijing@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 23/32] powerpc: copy_thread(): rename 'arg' argument to
 'kthread_arg'
Date: Fri, 13 Mar 2015 20:14:46 +0200
Message-Id: <1426270496-26362-13-git-send-email-alexinbeijing@gmail.com>
In-Reply-To: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Vineeth Vijayan <vvijayan@mvista.com>, Christoph Lameter <cl@linux.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 'arg' argument to copy_thread() is only ever used when forking a new
kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
with do_fork() and other arch-specific implementations of copy_thread()).

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/powerpc/kernel/process.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b4cc7be..febb50d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1114,8 +1114,11 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
  */
 extern unsigned long dscr_default; /* defined in arch/powerpc/kernel/sysfs.c */
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
@@ -1127,6 +1130,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
 		struct thread_info *ti = (void *)task_stack_page(p);
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
@@ -1137,11 +1141,12 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		clear_tsk_thread_flag(p, TIF_32BIT);
 		childregs->softe = 1;
 #endif
-		childregs->gpr[15] = arg;
+		childregs->gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
 		ti->flags |= _TIF_RESTOREALL;
 		f = ret_from_kernel_thread;
 	} else {
+		/* user thread */
 		struct pt_regs *regs = current_pt_regs();
 		CHECK_FULL_REGS(regs);
 		*childregs = *regs;
-- 
2.0.0.GIT
