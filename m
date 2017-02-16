Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPQ193ykNzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 05:39:25 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 19so2163888pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:39:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/5] powerpc/64s: consolidate pnv_restore_hyp_resource into
 pnv_powersave_wakeup
Date: Fri, 17 Feb 2017 04:39:00 +1000
Message-Id: <20170216183901.28611-5-npiggin@gmail.com>
In-Reply-To: <20170216183901.28611-1-npiggin@gmail.com>
References: <20170216183901.28611-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is only one caller, so this reduces spaghetti of subsequent
callees returning into the caller.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 66 +++++++++++++++------------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index ab15dee371c9..58364a834f87 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -372,33 +372,6 @@ _GLOBAL(power9_idle_stop)
  */
 .global pnv_powersave_wakeup
 pnv_powersave_wakeup:
-	bl	pnv_restore_hyp_resource
-
-	li	r0,PNV_THREAD_RUNNING
-	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
-
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	li	r0,KVM_HWTHREAD_IN_KERNEL
-	stb	r0,HSTATE_HWTHREAD_STATE(r13)
-	/* Order setting hwthread_state vs. testing hwthread_req */
-	sync
-	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
-	cmpwi	r0,0
-	beq	1f
-	b	kvm_start_guest
-1:
-#endif
-
-	/* Return SRR1 from power7_nap() */
-	mfspr	r3,SPRN_SRR1
-	blt	cr3,pnv_wakeup_noloss
-	b	pnv_wakeup_loss
-
-/*
- * Check whether we have woken up with hypervisor state loss. If yes,
- * restore hypervisor state and return back to reset vector.
- */
-pnv_restore_hyp_resource:
 	ld	r2,PACATOC(r13);
 
 BEGIN_FTR_SECTION
@@ -416,7 +389,7 @@ BEGIN_FTR_SECTION
 	 */
 	rldicl  r5,r5,4,60
 	cmpd	cr4,r5,r4
-	bge	cr4,pnv_wakeup_tb_loss
+	bgel	cr4,pnv_wakeup_tb_loss
 
 FTR_SECTION_ELSE
 
@@ -425,23 +398,36 @@ FTR_SECTION_ELSE
 	 * Check if we slept with winkle.
 	 */
 	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi   cr2,r0,PNV_THREAD_NAP
-	cmpwi   cr4,r0,PNV_THREAD_WINKLE
-	bgt     cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
+	cmpwi	cr2,r0,PNV_THREAD_NAP
+	cmpwi	cr4,r0,PNV_THREAD_WINKLE
+	bgtl	cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
 
-	/*
-	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
-	 * up from nap. At this stage CR3 shouldn't contains 'gt' since that
-	 * indicates we are waking with hypervisor state loss from nap.
-	 */
-	bgt	cr3,.
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
 	/*
-	 * Waking up without hypervisor state loss. Return to
-	 * reset vector
+	 * Waking up without hypervisor state loss, or continuing after
+	 * hypervisor state has been restored.
 	 */
-	blr
+
+	li	r0,PNV_THREAD_RUNNING
+	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	li	r0,KVM_HWTHREAD_IN_KERNEL
+	stb	r0,HSTATE_HWTHREAD_STATE(r13)
+	/* Order setting hwthread_state vs. testing hwthread_req */
+	sync
+	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
+	cmpwi	r0,0
+	beq	1f
+	b	kvm_start_guest
+1:
+#endif
+
+	/* Return SRR1 from power7_nap() */
+	mfspr	r3,SPRN_SRR1
+	blt	cr3,pnv_wakeup_noloss
+	b	pnv_wakeup_loss
 
 /*
  * Called if waking up from idle state which can cause either partial or
-- 
2.11.0
