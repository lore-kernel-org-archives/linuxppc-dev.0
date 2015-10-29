Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36DAA1A0D0B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:06:57 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/19] powerpc: clean up asm/switch_to.h
Date: Thu, 29 Oct 2015 11:44:11 +1100
Message-Id: <1446079451-8774-20-git-send-email-anton@samba.org>
In-Reply-To: <1446079451-8774-1-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove a bunch of unnecessary fallback functions and group
things in a more logical way.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/switch_to.h | 35 ++++++++++-------------------------
 arch/powerpc/kernel/process.c        |  2 +-
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 81d46a4..5b268b6 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -14,23 +14,18 @@ extern struct task_struct *__switch_to(struct task_struct *,
 	struct task_struct *);
 #define switch_to(prev, next, last)	((last) = __switch_to((prev), (next)))
 
-struct thread_struct;
 extern struct task_struct *_switch(struct thread_struct *prev,
 				   struct thread_struct *next);
 
-extern void enable_kernel_fp(void);
-extern void enable_kernel_altivec(void);
-extern void enable_kernel_vsx(void);
+extern void switch_booke_debug_regs(struct debug_reg *new_debug);
+
 extern int emulate_altivec(struct pt_regs *);
-extern void __giveup_vsx(struct task_struct *);
-extern void giveup_vsx(struct task_struct *);
-extern void enable_kernel_spe(void);
-extern void load_up_spe(struct task_struct *);
-extern void giveup_all(struct task_struct *);
+
 extern void flush_all_to_thread(struct task_struct *);
-extern void switch_booke_debug_regs(struct debug_reg *new_debug);
+extern void giveup_all(struct task_struct *);
 
 #ifdef CONFIG_PPC_FPU
+extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void giveup_fpu(struct task_struct *);
 extern void __giveup_fpu(struct task_struct *);
@@ -38,14 +33,12 @@ static inline void disable_kernel_fp(void)
 {
 	msr_check_and_clear(MSR_FP);
 }
-
 #else
 static inline void flush_fp_to_thread(struct task_struct *t) { }
-static inline void giveup_fpu(struct task_struct *t) { }
-static inline void __giveup_fpu(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_ALTIVEC
+extern void enable_kernel_altivec(void);
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
 extern void __giveup_altivec(struct task_struct *);
@@ -53,25 +46,21 @@ static inline void disable_kernel_altivec(void)
 {
 	msr_check_and_clear(MSR_VEC);
 }
-#else
-static inline void flush_altivec_to_thread(struct task_struct *t) { }
-static inline void giveup_altivec(struct task_struct *t) { }
-static inline void __giveup_altivec(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_VSX
+extern void enable_kernel_vsx(void);
 extern void flush_vsx_to_thread(struct task_struct *);
+extern void giveup_vsx(struct task_struct *);
+extern void __giveup_vsx(struct task_struct *);
 static inline void disable_kernel_vsx(void)
 {
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
-#else
-static inline void flush_vsx_to_thread(struct task_struct *t)
-{
-}
 #endif
 
 #ifdef CONFIG_SPE
+extern void enable_kernel_spe(void);
 extern void flush_spe_to_thread(struct task_struct *);
 extern void giveup_spe(struct task_struct *);
 extern void __giveup_spe(struct task_struct *);
@@ -79,10 +68,6 @@ static inline void disable_kernel_spe(void)
 {
 	msr_check_and_clear(MSR_SPE);
 }
-#else
-static inline void flush_spe_to_thread(struct task_struct *t) { }
-static inline void giveup_spe(struct task_struct *t) { }
-static inline void __giveup_spe(struct task_struct *t) { }
 #endif
 
 static inline void clear_task_ebb(struct task_struct *t)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b34e1e5..1841b59 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -174,7 +174,6 @@ void flush_fp_to_thread(struct task_struct *tsk)
 	}
 }
 EXPORT_SYMBOL_GPL(flush_fp_to_thread);
-#endif /* CONFIG_PPC_FPU */
 
 void enable_kernel_fp(void)
 {
@@ -186,6 +185,7 @@ void enable_kernel_fp(void)
 		__giveup_fpu(current);
 }
 EXPORT_SYMBOL(enable_kernel_fp);
+#endif /* CONFIG_PPC_FPU */
 
 #ifdef CONFIG_ALTIVEC
 void giveup_altivec(struct task_struct *tsk)
-- 
2.5.0
