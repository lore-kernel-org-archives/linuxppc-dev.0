Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jpgx06YszF3Fn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 01:55:24 +1000 (AEST)
Message-Id: <c54cb44c749308a6714ea158d0a8b6acac189e45.1537802981.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537802981.git.christophe.leroy@c-s.fr>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 9/9] powerpc/64: Modify CURRENT_THREAD_INFO()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Sep 2018 15:52:37 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CURRENT_THREAD_INFO() now uses the PACA to retrieve 'current' pointer,
it doesn't use 'sp' anymore.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/exception-64s.h       |  4 ++--
 arch/powerpc/include/asm/thread_info.h         |  2 +-
 arch/powerpc/kernel/entry_64.S                 | 10 +++++-----
 arch/powerpc/kernel/exceptions-64e.S           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +++---
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 47578b79f0fb..e38d84c267b8 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -672,7 +672,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define RUNLATCH_ON				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r3, r1);		\
+	CURRENT_THREAD_INFO(r3);		\
 	ld	r4,TI_LOCAL_FLAGS(r3);		\
 	andi.	r0,r4,_TLF_RUNLATCH;		\
 	beql	ppc64_runlatch_on_trampoline;	\
@@ -722,7 +722,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 #ifdef CONFIG_PPC_970_NAP
 #define FINISH_NAP				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r11, r1);		\
+	CURRENT_THREAD_INFO(r11);		\
 	ld	r9,TI_LOCAL_FLAGS(r11);		\
 	andi.	r10,r9,_TLF_NAPPING;		\
 	bnel	power4_fixup_nap;		\
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1c42df627bf3..a339de87806b 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -18,7 +18,7 @@
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
 #ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(ld dest, PACACURRENT(r13))
+#define CURRENT_THREAD_INFO(dest)	stringify_in_c(ld dest, PACACURRENT(r13))
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 697406572592..331b9e9b6d78 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -158,7 +158,7 @@ system_call:			/* label this so stack traces look sane */
 	li	r10,IRQS_ENABLED
 	std	r10,SOFTE(r1)
 
-	CURRENT_THREAD_INFO(r11, r1)
+	CURRENT_THREAD_INFO(r11)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
@@ -205,7 +205,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r3,RESULT(r1)
 #endif
 
-	CURRENT_THREAD_INFO(r12, r1)
+	CURRENT_THREAD_INFO(r12)
 
 	ld	r8,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3S
@@ -336,7 +336,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	/* Repopulate r9 and r10 for the syscall path */
 	addi	r9,r1,STACK_FRAME_OVERHEAD
-	CURRENT_THREAD_INFO(r10, r1)
+	CURRENT_THREAD_INFO(r10)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
@@ -731,7 +731,7 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
-	CURRENT_THREAD_INFO(r9, r1)
+	CURRENT_THREAD_INFO(r9)
 	ld	r3,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3E
 	ld	r10,PACACURRENT(r13)
@@ -845,7 +845,7 @@ resume_kernel:
 1:	bl	preempt_schedule_irq
 
 	/* Re-test flags and eventually loop */
-	CURRENT_THREAD_INFO(r9, r1)
+	CURRENT_THREAD_INFO(r9)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 231d066b4a3d..f48d9aa07a73 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -469,7 +469,7 @@ exc_##n##_bad_stack:							    \
  * interrupts happen before the wait instruction.
  */
 #define CHECK_NAPPING()							\
-	CURRENT_THREAD_INFO(r11, r1);					\
+	CURRENT_THREAD_INFO(r11);					\
 	ld	r10,TI_LOCAL_FLAGS(r11);				\
 	andi.	r9,r10,_TLF_NAPPING;					\
 	beq+	1f;							\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 89d32bb79d5e..07701063d36e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1620,7 +1620,7 @@ do_hash_page:
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
 	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
-	CURRENT_THREAD_INFO(r11, r1)
+	CURRENT_THREAD_INFO(r11)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 4e0d94d02030..23f3d927ea4f 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -63,7 +63,7 @@ _GLOBAL(\name)
 1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
 	 * to the right spot
 	*/
-	CURRENT_THREAD_INFO(r11, r1)
+	CURRENT_THREAD_INFO(r11)
 	ld	r10,TI_LOCAL_FLAGS(r11)
 	ori	r10,r10,_TLF_NAPPING
 	std	r10,TI_LOCAL_FLAGS(r11)
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index a09b3c7ca176..80e09f4ec056 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -68,7 +68,7 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	CURRENT_THREAD_INFO(r9, r1)
+	CURRENT_THREAD_INFO(r9)
 	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 32476a6e4e9c..5ba39ec48cdd 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -229,7 +229,7 @@ ftrace_call:
 	 *  - r0, r11 & r12 are free
 	 */
 livepatch_handler:
-	CURRENT_THREAD_INFO(r12, r1)
+	CURRENT_THREAD_INFO(r12)
 
 	/* Allocate 3 x 8 bytes */
 	ld	r11, TI_livepatch_sp(r12)
@@ -256,7 +256,7 @@ livepatch_handler:
 	 * restore it.
 	 */
 
-	CURRENT_THREAD_INFO(r12, r1)
+	CURRENT_THREAD_INFO(r12)
 
 	ld	r11, TI_livepatch_sp(r12)
 
@@ -273,7 +273,7 @@ livepatch_handler:
 	ld	r2,  -24(r11)
 
 	/* Pop livepatch stack frame */
-	CURRENT_THREAD_INFO(r12, r1)
+	CURRENT_THREAD_INFO(r12)
 	subi	r11, r11, 24
 	std	r11, TI_livepatch_sp(r12)
 
-- 
2.13.3
