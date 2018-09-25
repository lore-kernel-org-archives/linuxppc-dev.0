Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KKfD4Q5DzF3Dv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:10:44 +1000 (AEST)
Message-Id: <d2b189784d54b51237bff9b2c9522aa6fcb5fae3.1537877134.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537877134.git.christophe.leroy@c-s.fr>
References: <cover.1537877134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 2/9] powerpc: change name THREAD_INFO to TASK_STACK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 12:10:39 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the time being, the thread_info struct is located in the beginning
of the stack. There is an asm const called THREAD_INFO which is the
offset of the stack pointer in the task_struct.

In preparation of moving thread_info into task_struct, this patch
renames the THREAD_INFO const to TASK_STACK.

It also makes it available to PPC64, as it will also be needed
there to get the stack pointer from current.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/asm-offsets.c    | 2 +-
 arch/powerpc/kernel/entry_32.S       | 2 +-
 arch/powerpc/kernel/head_32.S        | 2 +-
 arch/powerpc/kernel/head_40x.S       | 4 ++--
 arch/powerpc/kernel/head_8xx.S       | 2 +-
 arch/powerpc/kernel/head_booke.h     | 4 ++--
 arch/powerpc/kernel/head_fsl_booke.S | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ba9d0fc98730..d1f161e48945 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -85,10 +85,10 @@ int main(void)
 	DEFINE(NMI_MASK, NMI_MASK);
 	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
 #else
-	OFFSET(THREAD_INFO, task_struct, stack);
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
+	OFFSET(TASK_STACK, task_struct, stack);
 
 #ifdef CONFIG_LIVEPATCH
 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e58c3f467db5..12c0721f65ea 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1166,7 +1166,7 @@ ret_from_debug_exc:
 	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
-	lwz	r9,THREAD_INFO-THREAD(r9)
+	lwz	r9,TASK_STACK-THREAD(r9)
 	CURRENT_THREAD_INFO(r10, r1)
 	lwz	r10,TI_PREEMPT(r10)
 	stw	r10,TI_PREEMPT(r9)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 61ca27929355..dbb096c32332 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -261,7 +261,7 @@ __secondary_hold_acknowledge:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b19d78410511..3088c9f29f5e 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -115,7 +115,7 @@ _ENTRY(saved_ksp_limit)
 	andi.	r11,r11,MSR_PR;						     \
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
+	lwz	r1,TASK_STACK-THREAD(r1); /* this thread's kernel stack   */\
 	addi	r1,r1,THREAD_SIZE;					     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	tophys(r11,r1);							     \
@@ -158,7 +158,7 @@ _ENTRY(saved_ksp_limit)
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
 1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc an excpt frm  */\
 	tophys(r11,r11);						     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6582f824d620..e56e36aa2b3d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -124,7 +124,7 @@ turn_on_mmu:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index d0862a100d29..20fe0c93a0bd 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -44,7 +44,7 @@
 	mr	r11, r1;						     \
 	beq	1f;							     \
 	/* if from user, start at top of this thread's kernel stack */       \
-	lwz	r11, THREAD_INFO-THREAD(r10);				     \
+	lwz	r11, TASK_STACK-THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
 1 :	subi	r11, r11, INT_FRAME_SIZE; /* Allocate exception frame */     \
 	stw	r13, _CCR(r11);		/* save various registers */	     \
@@ -130,7 +130,7 @@
 	DO_KVM	BOOKE_INTERRUPT_##intno exc_level_srr1;		             \
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index e2750b856c8f..35d35067acf7 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -702,7 +702,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r12, THREAD_INFO-THREAD(r12)
+	lwz	r12, TASK_STACK-THREAD(r12)
 	lwz	r15, TI_CPU(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
-- 
2.13.3
