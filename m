Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 997EA2C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 19:07:33 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc: make flush_fp_to_thread() nop when
 CONFIG_PPC_FPU is disabled
Date: Sun, 14 Jul 2013 17:02:05 +0800
Message-ID: <1373792526-16241-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373792526-16241-1-git-send-email-haokexin@gmail.com>
References: <1373792526-16241-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current kernel, the function flush_fp_to_thread() is not
dependent on CONFIG_PPC_FPU. So most invocations of this function
is not wrapped by CONFIG_PPC_FPU. Even through we don't really
save the FPRs to the thread struct if CONFIG_PPC_FPU is not enabled,
but there does have some runtime overhead such as the check for
tsk->thread.regs and preempt disable and enable. It really make
no sense to do that. So make it a nop when CONFIG_PPC_FPU is
disabled. Also remove the wrapped #ifdef CONFIG_PPC_FPU
when invoking this function.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h | 7 ++++++-
 arch/powerpc/kernel/process.c        | 2 ++
 arch/powerpc/math-emu/math.c         | 3 +--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 33e1cd8..39cf0f6 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -19,7 +19,6 @@ extern struct task_struct *_switch(struct thread_struct *prev,
 extern void giveup_fpu(struct task_struct *);
 extern void load_up_fpu(void);
 extern void enable_kernel_fp(void);
-extern void flush_fp_to_thread(struct task_struct *);
 extern void enable_kernel_altivec(void);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
@@ -37,6 +36,12 @@ static inline void discard_lazy_cpu_state(void)
 }
 #endif
 
+#ifdef CONFIG_PPC_FPU
+extern void flush_fp_to_thread(struct task_struct *);
+#else
+static inline void flush_fp_to_thread(struct task_struct *t) { }
+#endif
+
 #ifdef CONFIG_ALTIVEC
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c517dbe..0ec255a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -74,6 +74,7 @@ struct task_struct *last_task_used_vsx = NULL;
 struct task_struct *last_task_used_spe = NULL;
 #endif
 
+#ifdef CONFIG_PPC_FPU
 /*
  * Make sure the floating-point register state in the
  * the thread_struct is up to date for task tsk.
@@ -107,6 +108,7 @@ void flush_fp_to_thread(struct task_struct *tsk)
 	}
 }
 EXPORT_SYMBOL_GPL(flush_fp_to_thread);
+#endif
 
 void enable_kernel_fp(void)
 {
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index f9ef347..d1ebac7 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -7,6 +7,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/reg.h>
+#include <asm/switch_to.h>
 
 #include <asm/sfp-machine.h>
 #include <math-emu/double.h>
@@ -425,9 +426,7 @@ do_mathemu(struct pt_regs *regs)
 	 * is flushed into the thread_struct before attempting
 	 * emulation
 	 */
-#ifdef CONFIG_PPC_FPU
 	flush_fp_to_thread(current);
-#endif
 
 	eflag = func(op0, op1, op2, op3);
 
-- 
1.8.1.4
