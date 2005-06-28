Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id B1D4567B59
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 23:41:34 +1000 (EST)
Received: from ltnmail.xyplex.com (ltnmail.xyplex.com [140.179.176.25])
	by mailman.xyplex.com (8.9.3+Sun/8.9.3) with ESMTP id JAA18216
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 09:42:57 -0400 (EDT)
Message-ID: <42C153E1.3060004@mrv.com>
Date: Tue, 28 Jun 2005 09:42:57 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
References: <20050625145318.GA32117@logos.cnet>	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>
In-Reply-To: <1119940208.5133.204.camel@gaston>
Content-Type: multipart/mixed; boundary="------------000506000805010108030708"
Subject: [PATCH] 8xx: get_mmu_context() for (very) FEW_CONTEXTS and
 KERNEL_PREEMPT race/starvation issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000506000805010108030708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I happen to notice a race condition in the mmu_context code for the 8xx 
with very few context (16 MMU contexts) and kernel preemption enable. It 
is hard to reproduce has it shows only when many processes are 
created/destroy and the system is doing a lot of IRQ processing.

In short, one process is trying to steal a context that is in the 
process of being freed (mm->context == NO_CONTEXT) but not completely 
freed (nr_free_contexts == 0).
The steal_context() function does not do anything and the process stays 
in the loop forever.

Anyway, I got a patch that fixes this part. Does not seem to affect 
scheduling latency at all.

Comments are appreciated.

Guillaume.

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------000506000805010108030708
Content-Type: text/plain;
 name="mmu_context.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmu_context.patch"

diff -Nru --exclude=CVS linux-2.6.old/arch/ppc/mm/mmu_context.c linux-2.6/arch/ppc/mm/mmu_context.c
--- linux-2.6.old/arch/ppc/mm/mmu_context.c	2004-12-13 16:11:56.000000000 -0500
+++ linux-2.6/arch/ppc/mm/mmu_context.c	2005-06-28 09:08:13.000000000 -0400
@@ -31,9 +31,9 @@
 #include <asm/tlbflush.h>
 
 mm_context_t next_mmu_context;
+spinlock_t next_mmu_ctx_lock = SPIN_LOCK_UNLOCKED;
 unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
 #ifdef FEW_CONTEXTS
-atomic_t nr_free_contexts;
 struct mm_struct *context_mm[LAST_CONTEXT+1];
 void steal_context(void);
 #endif /* FEW_CONTEXTS */
@@ -52,9 +52,6 @@
 	 */
 	context_map[0] = (1 << FIRST_CONTEXT) - 1;
 	next_mmu_context = FIRST_CONTEXT;
-#ifdef FEW_CONTEXTS
-	atomic_set(&nr_free_contexts, LAST_CONTEXT - FIRST_CONTEXT + 1);
-#endif /* FEW_CONTEXTS */
 }
 
 #ifdef FEW_CONTEXTS
@@ -74,12 +71,21 @@
 steal_context(void)
 {
 	struct mm_struct *mm;
+	mm_context_t ctx = 0;
 
 	/* free up context `next_mmu_context' */
+	spin_lock(&next_mmu_ctx_lock);
+
 	/* if we shouldn't free context 0, don't... */
 	if (next_mmu_context < FIRST_CONTEXT)
 		next_mmu_context = FIRST_CONTEXT;
-	mm = context_mm[next_mmu_context];
+
+	ctx = next_mmu_context;
+	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
+
+	spin_unlock(&next_mmu_ctx_lock);
+
+	mm = context_mm[ctx];
 	flush_tlb_mm(mm);
 	destroy_context(mm);
 }
diff -Nru --exclude=CVS linux-2.6.old/include/asm-ppc/mmu_context.h linux-2.6/include/asm-ppc/mmu_context.h
--- linux-2.6.old/include/asm-ppc/mmu_context.h	2004-12-13 16:11:21.000000000 -0500
+++ linux-2.6/include/asm-ppc/mmu_context.h	2005-06-28 09:08:13.000000000 -0400
@@ -100,6 +100,7 @@
  * number to be free, but it usually will be.
  */
 extern mm_context_t next_mmu_context;
+extern spinlock_t next_mmu_ctx_lock;
 
 /*
  * If we don't have sufficient contexts to give one to every task
@@ -108,7 +109,6 @@
  */
 #if LAST_CONTEXT < 30000
 #define FEW_CONTEXTS	1
-extern atomic_t nr_free_contexts;
 extern struct mm_struct *context_mm[LAST_CONTEXT+1];
 extern void steal_context(void);
 #endif
@@ -119,24 +119,36 @@
 static inline void get_mmu_context(struct mm_struct *mm)
 {
 	mm_context_t ctx;
+	int flag;
 
 	if (mm->context != NO_CONTEXT)
 		return;
-#ifdef FEW_CONTEXTS
-	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
-		steal_context();
-#endif
+
 	ctx = next_mmu_context;
+	flag = 0;
+
 	while (test_and_set_bit(ctx, context_map)) {
 		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
+		if (ctx > LAST_CONTEXT) {
 			ctx = 0;
+#ifdef FEW_CONTEXTS
+			if( flag == 0 ) {
+				flag = 1;
+			} else {	
+				ctx = next_mmu_context;
+				steal_context();
+			}
+#endif
+		}
 	}
+	spin_lock(&next_mmu_ctx_lock);
 	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
 	mm->context = ctx;
 #ifdef FEW_CONTEXTS
 	context_mm[ctx] = mm;
 #endif
+	spin_unlock(&next_mmu_ctx_lock);
+
 }
 
 /*
@@ -150,11 +162,9 @@
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
-		clear_bit(mm->context, context_map);
+		mm_context_t ctx = mm->context;
 		mm->context = NO_CONTEXT;
-#ifdef FEW_CONTEXTS
-		atomic_inc(&nr_free_contexts);
-#endif
+		clear_bit(ctx, context_map);
 	}
 }
 

--------------000506000805010108030708--
