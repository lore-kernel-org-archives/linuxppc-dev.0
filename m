Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj8Sm0ds2zDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:24:24 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id b5so23281441pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 02:24:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 5/8] powerpc/64s: use PACA_THREAD_IDLE_STATE only in POWER8
Date: Tue, 14 Mar 2017 19:23:46 +1000
Message-Id: <20170314092349.10981-6-npiggin@gmail.com>
In-Reply-To: <20170314092349.10981-1-npiggin@gmail.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 does not use this field, so it should be moved into the POWER8
code. Update the documentation in the paca struct too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paca.h   | 12 ++++++++++--
 arch/powerpc/kernel/idle_book3s.S | 13 +++++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 708c3e592eeb..bbb59e226a9f 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -165,11 +165,19 @@ struct paca_struct {
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
+	/* CPU idle fields */
+
+	/*
+	 * Per-core word used to synchronize between threads. See
+	 * asm/cpuidle.h, PNV_CORE_IDLE_*
+	 */
 	u32 *core_idle_state_ptr;
-	u8 thread_idle_state;		/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
 	/* Mask to indicate thread id in core */
 	u8 thread_mask;
+
+	/* POWER8 specific fields */
+	/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
+	u8 thread_idle_state;
 	/* Mask to denote subcore sibling threads */
 	u8 subcore_sibling_mask;
 #endif
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 9284ea0762b1..9bdfba75a5e7 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -389,9 +389,6 @@ FTR_SECTION_ELSE
 	bl	pnv_restore_hyp_resource_arch207
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
-	li	r0,PNV_THREAD_RUNNING
-	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
-
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	li	r0,KVM_HWTHREAD_IN_KERNEL
 	stb	r0,HSTATE_HWTHREAD_STATE(r13)
@@ -445,9 +442,13 @@ pnv_restore_hyp_resource_arch207:
 	ld	r2,PACATOC(r13);
 
 	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi   cr2,r0,PNV_THREAD_NAP
-	cmpwi   cr4,r0,PNV_THREAD_WINKLE
-	bgt     cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
+	cmpwi	cr2,r0,PNV_THREAD_NAP
+	cmpwi	cr4,r0,PNV_THREAD_WINKLE
+	li	r0,PNV_THREAD_RUNNING
+	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
+
+	bgt	cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
+
 
 	/*
 	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
-- 
2.11.0
