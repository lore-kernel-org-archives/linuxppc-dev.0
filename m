Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v26df3wZjzDqRV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 20:00:37 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RFC] powerpc/32: fix handling of stack protector with recent
 GCC
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Christian Kujau <lists@nerdbynature.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170116090031.4843668B50@localhost.localdomain>
Date: Mon, 16 Jan 2017 10:00:31 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since 2005, powerpc GCC doesn't manage anymore __stack_chk_guard as
a global variable but as some value located at -0x7008(r2)

In the Linux kernel, r2 is used as a pointer to current task struct.

This patch changes the meaning of r2 when stack protector
is activated:
- current is taken from thread_info and not kept in r2 anymore
- r2 is set to current + offset of stack canary + 0x7008 so
that -0x7008(r2) directly points to current->stack_canary

current could have been more efficiently calculated from r2
but some circular inclusion prevent inserting struct task_struct
into arch/powerpc/include/asm/current.h so it is not possible
to get offset of stack_canary within current task_struct from there.

fixes: 6533b7c16ee57 ("powerpc: Initial stack protector
(-fstack-protector) support")
Reported-by: Christian Kujau <lists@nerdbynature.de>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Christian, can you test it ?

 arch/powerpc/include/asm/current.h        | 12 +++++++++++-
 arch/powerpc/include/asm/stackprotector.h | 13 +++++++++----
 arch/powerpc/kernel/entry_32.S            | 19 +++++++++++++++----
 arch/powerpc/kernel/head_32.S             |  7 +++++++
 arch/powerpc/kernel/head_40x.S            |  4 ++++
 arch/powerpc/kernel/head_44x.S            |  4 ++++
 arch/powerpc/kernel/head_8xx.S            |  4 ++++
 arch/powerpc/kernel/head_fsl_booke.S      |  7 +++++++
 arch/powerpc/kernel/process.c             |  6 ------
 9 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/current.h
index e2c7f06..2f67f02 100644
--- a/arch/powerpc/include/asm/current.h
+++ b/arch/powerpc/include/asm/current.h
@@ -27,8 +27,16 @@ static inline struct task_struct *get_current(void)
 }
 #define current	get_current()
 
-#else
+#else /* __powerpc64__ */
+#if defined(CONFIG_CC_STACKPROTECTOR)
+#include <linux/thread_info.h>
 
+static inline struct task_struct *get_current(void)
+{
+	return current_thread_info()->task;
+}
+#define current	get_current()
+#else
 /*
  * We keep `current' in r2 for speed.
  */
@@ -36,5 +44,7 @@ register struct task_struct *current asm ("r2");
 
 #endif
 
+#endif /* __powerpc64__ */
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CURRENT_H */
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
index 6720190..bf30509 100644
--- a/arch/powerpc/include/asm/stackprotector.h
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -12,12 +12,18 @@
 #ifndef _ASM_STACKPROTECTOR_H
 #define _ASM_STACKPROTECTOR_H
 
+#ifdef CONFIG_PPC64
+#define SSP_OFFSET	0x7010
+#else
+#define SSP_OFFSET	0x7008
+#endif
+
+#ifndef __ASSEMBLY__
+
 #include <linux/random.h>
 #include <linux/version.h>
 #include <asm/reg.h>
 
-extern unsigned long __stack_chk_guard;
-
 /*
  * Initialize the stackprotector canary value.
  *
@@ -34,7 +40,6 @@ static __always_inline void boot_init_stack_canary(void)
 	canary ^= LINUX_VERSION_CODE;
 
 	current->stack_canary = canary;
-	__stack_chk_guard = current->stack_canary;
 }
-
+#endif /* __ASSEMBLY__ */
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 5742dbd..b3a363c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -34,6 +34,7 @@
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/stackprotector.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
@@ -149,6 +150,9 @@ transfer_to_handler:
 	mfspr	r12,SPRN_SPRG_THREAD
 	addi	r2,r12,-THREAD
 	tovirt(r2,r2)			/* set r2 to current */
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 	beq	2f			/* if from user, fix up THREAD.regs */
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
@@ -385,6 +389,9 @@ syscall_exit_cont:
 	lwz	r3,GPR3(r1)
 1:
 #endif /* CONFIG_TRACE_IRQFLAGS */
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	subi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	/* If the process has its own DBCR0 value, load it up.  The internal
 	   debug mode bit tells us that dbcr0 should be loaded. */
@@ -617,6 +624,9 @@ _GLOBAL(_switch)
 	stwu	r1,-INT_FRAME_SIZE(r1)
 	mflr	r0
 	stw	r0,INT_FRAME_SIZE+4(r1)
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	subi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 	/* r3-r12 are caller saved -- Cort */
 	SAVE_NVGPRS(r1)
 	stw	r0,_NIP(r1)	/* Return to switch caller */
@@ -674,10 +684,8 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
 END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 #endif /* CONFIG_SPE */
-#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	lwz	r0,TSK_STACK_CANARY(r2)
-	lis	r4,__stack_chk_guard@ha
-	stw	r0,__stack_chk_guard@l(r4)
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
 #endif
 	lwz	r0,_CCR(r1)
 	mtcrf	0xFF,r0
@@ -779,6 +787,9 @@ user_exc_return:		/* r10 contains MSR_KERNEL here */
 	bne	do_work
 
 restore_user:
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	subi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	/* Check whether this process has its own DBCR0 value.  The internal
 	   debug mode bit tells us that dbcr0 should be loaded. */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 9d96354..bae9b83 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -35,6 +35,7 @@
 #include <asm/bug.h>
 #include <asm/kvm_book3s_asm.h>
 #include <asm/export.h>
+#include <asm/stackprotector.h>
 
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
@@ -864,6 +865,9 @@ __secondary_start:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* phys address of our thread_struct */
 	mtspr	SPRN_SPRG_THREAD,r4
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 	li	r3,0
 	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
 
@@ -950,6 +954,9 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 	li	r3,0
 	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
 
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 41374a4..20b1c31 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -42,6 +42,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/stackprotector.h>
 
 /* As with the other PowerPC ports, it is expected that when code
  * execution begins here, the following registers contain valid, yet
@@ -835,6 +836,9 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 
 	/* stack */
 	lis	r1,init_thread_union@ha
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 37e4a7c..753e2bf 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -40,6 +40,7 @@
 #include <asm/ptrace.h>
 #include <asm/synch.h>
 #include <asm/export.h>
+#include <asm/stackprotector.h>
 #include "head_booke.h"
 
 
@@ -107,6 +108,9 @@ _ENTRY(_start);
 	/* ptr to current thread */
 	addi	r4,r2,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 
 	/* stack */
 	lis	r1,init_thread_union@h
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1a9c99d..49f9ce1 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -32,6 +32,7 @@
 #include <asm/ptrace.h>
 #include <asm/fixmap.h>
 #include <asm/export.h>
+#include <asm/stackprotector.h>
 
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
@@ -820,6 +821,9 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 
 	/* stack */
 	lis	r1,init_thread_union@ha
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index bf4c602..9634ac7 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -43,6 +43,7 @@
 #include <asm/cache.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/stackprotector.h>
 #include "head_booke.h"
 
 /* As with the other PowerPC ports, it is expected that when code
@@ -235,6 +236,9 @@ set_ivor:
 	/* ptr to current thread */
 	addi	r4,r2,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 
 	/* stack */
 	lis	r1,init_thread_union@h
@@ -1086,6 +1090,9 @@ __secondary_start:
 	/* ptr to current thread */
 	addi	r4,r2,THREAD	/* address of our thread_struct */
 	mtspr	SPRN_SPRG_THREAD,r4
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	addi	r2,r2,TSK_STACK_CANARY+SSP_OFFSET
+#endif
 
 	/* Setup the defaults for TLB entries */
 	li	r4,(MAS4_TSIZED(BOOK3E_PAGESZ_4K))@l
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 04885ce..5dd056d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -64,12 +64,6 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
-#ifdef CONFIG_CC_STACKPROTECTOR
-#include <linux/stackprotector.h>
-unsigned long __stack_chk_guard __read_mostly;
-EXPORT_SYMBOL(__stack_chk_guard);
-#endif
-
 /* Transactional Memory debug */
 #ifdef TM_DEBUG_SW
 #define TM_DEBUG(x...) printk(KERN_INFO x)
-- 
2.10.1
