Return-Path: <anton@samba.org>
Date: Mon, 16 Apr 2012 16:54:59 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/2] powerpc: Remove empty giveup_altivec function on book3e
 CPUs
Message-ID: <20120416165459.6da18f9c@kryten>
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


Use an empty inline instead of an empty function to implement
giveup_altivec on book3e CPUs, similar to flush_altivec_to_thread.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/switch_to.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/switch_to.h	2012-04-16 12:56:11.000000000 +1000
+++ linux-build/arch/powerpc/include/asm/switch_to.h	2012-04-16 12:56:45.149313158 +1000
@@ -21,7 +21,6 @@ extern void disable_kernel_fp(void);
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void enable_kernel_altivec(void);
-extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
 extern void __giveup_vsx(struct task_struct *);
@@ -40,10 +39,14 @@ static inline void discard_lazy_cpu_stat
 
 #ifdef CONFIG_ALTIVEC
 extern void flush_altivec_to_thread(struct task_struct *);
+extern void giveup_altivec(struct task_struct *);
 #else
 static inline void flush_altivec_to_thread(struct task_struct *t)
 {
 }
+static inline void giveup_altivec(struct task_struct *t)
+{
+}
 #endif
 
 #ifdef CONFIG_VSX
Index: linux-build/arch/powerpc/kernel/head_44x.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/head_44x.S	2012-04-16 12:56:11.976708702 +1000
+++ linux-build/arch/powerpc/kernel/head_44x.S	2012-04-16 12:56:45.153313231 +1000
@@ -778,14 +778,6 @@ _GLOBAL(__fixup_440A_mcheck)
 	blr
 
 /*
- * extern void giveup_altivec(struct task_struct *prev)
- *
- * The 44x core does not have an AltiVec unit.
- */
-_GLOBAL(giveup_altivec)
-	blr
-
-/*
  * extern void giveup_fpu(struct task_struct *prev)
  *
  * The 44x core does not have an FPU.
Index: linux-build/arch/powerpc/kernel/head_fsl_booke.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/head_fsl_booke.S	2012-04-16 12:56:11.940708046 +1000
+++ linux-build/arch/powerpc/kernel/head_fsl_booke.S	2012-04-16 12:56:45.153313231 +1000
@@ -874,14 +874,6 @@ _GLOBAL(__setup_e500mc_ivors)
 	sync
 	blr
 
-/*
- * extern void giveup_altivec(struct task_struct *prev)
- *
- * The e500 core does not have an AltiVec unit.
- */
-_GLOBAL(giveup_altivec)
-	blr
-
 #ifdef CONFIG_SPE
 /*
  * extern void giveup_spe(struct task_struct *prev)
