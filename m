Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E96D22C0123
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 19:07:34 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc: remove the empty giveup_fpu() function on 32bit
 kernel
Date: Sun, 14 Jul 2013 17:02:06 +0800
Message-ID: <1373792526-16241-5-git-send-email-haokexin@gmail.com>
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

Instead of implementing an empty giveup_fpu() function for each
32bit processor type, replace them with an unique empty inline
function.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  3 ++-
 arch/powerpc/kernel/head_40x.S       |  8 --------
 arch/powerpc/kernel/head_44x.S       | 10 ----------
 arch/powerpc/kernel/head_8xx.S       |  4 ----
 arch/powerpc/kernel/head_fsl_booke.S | 10 ----------
 arch/powerpc/kernel/ppc_ksyms.c      |  2 ++
 6 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 39cf0f6..2c7edde 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -16,7 +16,6 @@ struct thread_struct;
 extern struct task_struct *_switch(struct thread_struct *prev,
 				   struct thread_struct *next);
 
-extern void giveup_fpu(struct task_struct *);
 extern void load_up_fpu(void);
 extern void enable_kernel_fp(void);
 extern void enable_kernel_altivec(void);
@@ -38,8 +37,10 @@ static inline void discard_lazy_cpu_state(void)
 
 #ifdef CONFIG_PPC_FPU
 extern void flush_fp_to_thread(struct task_struct *);
+extern void giveup_fpu(struct task_struct *);
 #else
 static inline void flush_fp_to_thread(struct task_struct *t) { }
+static inline void giveup_fpu(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 8a9b6f5..67ee0d6 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -822,14 +822,6 @@ finish_tlb_load:
 	rfi			/* Should sync shadow TLBs */
 	b	.		/* prevent prefetch past rfi */
 
-/* extern void giveup_fpu(struct task_struct *prev)
- *
- * The PowerPC 4xx family of processors do not have an FPU, so this just
- * returns.
- */
-_ENTRY(giveup_fpu)
-	blr
-
 /* This is where the main kernel code starts.
  */
 start_here:
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 97e2671..c334f53 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -784,16 +784,6 @@ _GLOBAL(__fixup_440A_mcheck)
 	sync
 	blr
 
-/*
- * extern void giveup_fpu(struct task_struct *prev)
- *
- * The 44x core does not have an FPU.
- */
-#ifndef CONFIG_PPC_FPU
-_GLOBAL(giveup_fpu)
-	blr
-#endif
-
 _GLOBAL(set_context)
 
 #ifdef CONFIG_BDI_SWITCH
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index b2a5860..1b92a97 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -691,10 +691,6 @@ modified_instr:
 	b	151b
 #endif
 
-	.globl	giveup_fpu
-giveup_fpu:
-	blr
-
 /*
  * This is where the main kernel code starts.
  */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d10a7ca..289afaf 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -948,16 +948,6 @@ _GLOBAL(giveup_spe)
 #endif /* CONFIG_SPE */
 
 /*
- * extern void giveup_fpu(struct task_struct *prev)
- *
- * Not all FSL Book-E cores have an FPU
- */
-#ifndef CONFIG_PPC_FPU
-_GLOBAL(giveup_fpu)
-	blr
-#endif
-
-/*
  * extern void abort(void)
  *
  * At present, this routine just applies a system reset.
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index c296665..689ef81 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -96,7 +96,9 @@ EXPORT_SYMBOL(pci_dram_offset);
 
 EXPORT_SYMBOL(start_thread);
 
+#ifdef CONFIG_PPC_FPU
 EXPORT_SYMBOL(giveup_fpu);
+#endif
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(giveup_altivec);
 #endif /* CONFIG_ALTIVEC */
-- 
1.8.1.4
