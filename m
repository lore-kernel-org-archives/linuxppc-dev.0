Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 754ABDDEBD
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 18:00:18 +1000 (EST)
Received: from [172.17.0.11] (helo=iron.emcraft.com)
	by ocean.emcraft.com with esmtp (Exim 4.43) id 1IiPWk-00030H-9Y
	for linuxppc-dev@ozlabs.org; Thu, 18 Oct 2007 11:10:44 +0400
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Thu, 18 Oct 2007 11:08:19 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710181108.19413.yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hello,

 The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
built using the modified version of binutils, where the MAXPAGESIZE 
definition is set to 0x40000 (as opposite to standard 0x10000).

 Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>
 Acked-by: Yuri Tikhonov <yur@emcraft.com>

--

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index c590b18..0ee372d 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1223,6 +1223,9 @@ config PPC_PAGE_16K
 
 config PPC_PAGE_64K
 	bool "64 KB" if 44x
+
+config PPC_PAGE_256K
+	bool "256 KB" if 44x
 endchoice
 
 endmenu
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index fba7ca1..2140341 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -200,7 +200,7 @@ _GLOBAL(DoSyscall)
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
-	rlwinm	r10,r1,0,0,18	/* current_thread_info() */
+	rlwinm	r10,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
 	lwz	r11,TI_FLAGS(r10)
 	andi.	r11,r11,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
@@ -221,7 +221,7 @@ ret_from_syscall:
 	bl	do_show_syscall_exit
 #endif
 	mr	r6,r3
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
 	/* disable interrupts so current_thread_info()->flags can't change */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
@@ -639,7 +639,7 @@ ret_from_except:
 
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
-	rlwinm	r9,r1,0,0,18
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK|_TIF_NEED_RESCHED)
 	bne	do_work
@@ -659,7 +659,7 @@ restore_user:
 /* N.B. the only way to get here is from the beq following ret_from_except. 
*/
 resume_kernel:
 	/* check current_thread_info->preempt_count */
-	rlwinm	r9,r1,0,0,18
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r0,TI_PREEMPT(r9)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
@@ -669,7 +669,7 @@ resume_kernel:
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
 1:	bl	preempt_schedule_irq
-	rlwinm	r9,r1,0,0,18
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r3,TI_FLAGS(r9)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
@@ -875,7 +875,7 @@ recheck:
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	rlwinm	r9,r1,0,0,18
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
index f3d274c..db4eeee 100644
--- a/arch/ppc/kernel/head_booke.h
+++ b/arch/ppc/kernel/head_booke.h
@@ -20,7 +20,9 @@
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
-	addi	r1,r1,THREAD_SIZE;					     \
+	lis	r11,THREAD_SIZE@h;                                           \
+	ori	r11,r11,THREAD_SIZE@l;					     \
+	add     r1,r1,r11;						     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	mr	r11,r1;							     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
@@ -106,7 +108,9 @@
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
-	addi	r11,r11,THREAD_SIZE;					     \
+	lis     r11,THREAD_SIZE@h;					     \
+	ori     r11,r11,THREAD_SIZE@l;					     \
+	add     r1,r1,r11;						     \
 1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
diff --git a/include/asm-powerpc/thread_info.h 
b/include/asm-powerpc/thread_info.h
index 3f32ca8..0a564ce 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -15,7 +15,11 @@
 #ifdef CONFIG_PPC64
 #define THREAD_SHIFT		14
 #else
-#define THREAD_SHIFT		13
+#if defined(CONFIG_PPC_PAGE_256K)
+#define THREAD_SHIFT		15
+#else
+#define THREAD_SHIFT		13
+#endif
 #endif
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
@@ -81,11 +85,26 @@ struct thread_info {
 #else /* THREAD_SHIFT < PAGE_SHIFT */
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)	kzalloc(THREAD_SIZE, GFP_KERNEL)
+#if defined(CONFIG_PPC_PAGE_256K)
+#define alloc_thread_info(tsk)	\
+	((struct thread_info *)__get_free_pages(GFP_KERNEL |	\
+			__GFP_ZERO, 0))
 #else
-#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk) kzalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
+#else /* CONFIG_DEBUG_STACK_USAGE */
+#if defined(CONFIG_PPC_PAGE_256K)
+#define alloc_thread_info(tsk)	\
+	((struct thread_info *)__get_free_pages(GFP_KERNEL, 0))
+#else
+#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
+#endif
+#endif /* CONFIG_DEBUG_STACK_USAGE */
+#if defined(CONFIG_PPC_PAGE_256K)
+#define free_thread_info(ti)	free_pages((unsigned long)ti, 0)
+#else
 #define free_thread_info(ti)	kfree(ti)
+#endif
 
 #endif /* THREAD_SHIFT < PAGE_SHIFT */
 
diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index cb4a484..726823b 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -10,6 +10,8 @@
 #define PAGE_SHIFT	14
 #elif defined(CONFIG_PPC_PAGE_64K)
 #define PAGE_SHIFT	16
+#elif defined(CONFIG_PPC_PAGE_256K)
+#define PAGE_SHIFT	18
 #endif
 #define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
 
@@ -34,7 +36,11 @@
  */
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
+#if defined(CONFIG_PPC_PAGE_256K)
+#define PTE_SHIFT	(PAGE_SHIFT - 7)
+#else
 #define PTE_SHIFT	(PAGE_SHIFT - 3)	/* PAGE_SIZE/8 ptes per page */
+#endif
 #define PTE_FMT		"%16Lx"
 #else
 typedef unsigned long pte_basic_t;
diff --git a/include/asm-ppc/ppc_page_asm.h b/include/asm-ppc/ppc_page_asm.h
index 1dbfd3b..924463c 100644
--- a/include/asm-ppc/ppc_page_asm.h
+++ b/include/asm-ppc/ppc_page_asm.h
@@ -55,6 +55,19 @@
 #define PPC44x_PTE_ADD_SH	19 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
 #define PPC44x_PTE_ADD_M1	16 /*32 - 3 - PTE_SHIFT*/
 #define PPC44x_RPN_M2		15 /*31 - PAGE_SHIFT*/
+#elif (PAGE_SHIFT == 18)
+/*
+ * PAGE_SIZE  256K
+ * PAGE_SHIFT 18
+ * PTE_SHIFT  11
+ * PMD_SHIFT  29
+ */
+#define PPC44x_TLB_SIZE	PPC44x_TLB_256K
+#define PPC44x_PGD_OFF_SH	5  /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	27 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	17 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	18 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		13 /*31 - PAGE_SHIFT*/
 #else
 #error "Unsupported PAGE_SIZE"
 #endif
diff --git a/arch/ppc/kernel/vmlinux.lds.S b/arch/ppc/kernel/vmlinux.lds.S
index 930fe30..3ba570b 100644
--- a/arch/ppc/kernel/vmlinux.lds.S
+++ b/arch/ppc/kernel/vmlinux.lds.S
@@ -3,6 +3,11 @@
 
 OUTPUT_ARCH(powerpc:common)
 jiffies = jiffies_64 + 4;
+PHDRS
+{
+ text PT_LOAD FILEHDR PHDRS FLAGS (7);
+ data PT_LOAD FLAGS (7);
+}
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
@@ -30,6 +35,7 @@ SECTIONS
   .rela.plt      : { *(.rela.plt)		}
 /*  .init          : { *(.init)	} =0*/
   .plt : { *(.plt) }
+  . = ALIGN(PAGE_SIZE);
   .text      :
   {
     _text = .;
@@ -41,7 +47,7 @@ SECTIONS
     __got2_start = .;
     *(.got2)
     __got2_end = .;
-  }
+  } :text
   _etext = .;
   PROVIDE (etext = .);
 
@@ -75,7 +81,7 @@ SECTIONS
     *(.got.plt) *(.got)
     *(.dynamic)
     CONSTRUCTORS
-  }
+  } :data
 
   . = ALIGN(PAGE_SIZE);
   __nosave_begin = .;
@@ -89,7 +95,7 @@ SECTIONS
   _edata  =  .;
   PROVIDE (edata = .);
 
-  . = ALIGN(8192);
+  . = ALIGN(PAGE_SIZE << 1);
   .data.init_task : { *(.data.init_task) }
 
   . = ALIGN(PAGE_SIZE);

 
-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
