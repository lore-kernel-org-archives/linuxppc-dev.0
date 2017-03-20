Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmlhw51l3zDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:02:24 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id r137so11830874pfr.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 23:02:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 5/7] powerpc/64s: idle expand core idle state bits
Date: Mon, 20 Mar 2017 16:01:50 +1000
Message-Id: <20170320060152.1016-6-npiggin@gmail.com>
In-Reply-To: <20170320060152.1016-1-npiggin@gmail.com>
References: <20170320060152.1016-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for adding more bits to the core idle state word,
move the lock bit up, and unlock by flipping the lock bit rather
than masking off all but the thread bits.

Add branch hints for atomic operations while we're here.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cpuidle.h |  4 ++--
 arch/powerpc/kernel/idle_book3s.S  | 33 +++++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 155731557c9b..b9d9f960dffd 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -7,8 +7,8 @@
 #define PNV_THREAD_NAP                  1
 #define PNV_THREAD_SLEEP                2
 #define PNV_THREAD_WINKLE               3
-#define PNV_CORE_IDLE_LOCK_BIT          0x100
-#define PNV_CORE_IDLE_THREAD_BITS       0x0FF
+#define PNV_CORE_IDLE_LOCK_BIT          0x10000000
+#define PNV_CORE_IDLE_THREAD_BITS       0x000000FF
 
 /*
  * ============================ NOTE =================================
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 819e64104469..d3cc6c3e97bc 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -95,12 +95,12 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 core_idle_lock_held:
 	HMT_LOW
 3:	lwz	r15,0(r14)
-	andi.   r15,r15,PNV_CORE_IDLE_LOCK_BIT
+	andis.	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	bne	3b
 	HMT_MEDIUM
 	lwarx	r15,0,r14
-	andi.	r9,r15,PNV_CORE_IDLE_LOCK_BIT
-	bne	core_idle_lock_held
+	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	bne-	core_idle_lock_held
 	blr
 
 /*
@@ -213,8 +213,8 @@ pnv_enter_arch207_idle_mode:
 lwarx_loop1:
 	lwarx	r15,0,r14
 
-	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
-	bnel	core_idle_lock_held
+	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	bnel-	core_idle_lock_held
 
 	andc	r15,r15,r7			/* Clear thread bit */
 
@@ -241,7 +241,7 @@ common_enter: /* common code for all the threads entering sleep or winkle */
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 
 fastsleep_workaround_at_entry:
-	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
+	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	stwcx.	r15,0,r14
 	bne-	lwarx_loop1
 	isync
@@ -251,10 +251,10 @@ fastsleep_workaround_at_entry:
 	li	r4,1
 	bl	opal_config_cpu_idle_state
 
-	/* Clear Lock bit */
-	li	r0,0
+	/* Unlock */
+	xoris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	lwsync
-	stw	r0,0(r14)
+	stw	r15,0(r14)
 	b	common_enter
 
 enter_winkle:
@@ -302,8 +302,8 @@ power_enter_stop:
 
 lwarx_loop_stop:
 	lwarx   r15,0,r14
-	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
-	bnel    core_idle_lock_held
+	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	bnel-	core_idle_lock_held
 	andc    r15,r15,r7                      /* Clear thread bit */
 
 	stwcx.  r15,0,r14
@@ -504,7 +504,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
 lwarx_loop2:
 	lwarx	r15,0,r14
-	andi.	r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	/*
 	 * Lock bit is set in one of the 2 cases-
 	 * a. In the sleep/winkle enter path, the last thread is executing
@@ -513,9 +513,10 @@ lwarx_loop2:
 	 * workaround undo code or resyncing timebase or restoring context
 	 * In either case loop until the lock bit is cleared.
 	 */
-	bnel	core_idle_lock_held
+	bnel-	core_idle_lock_held
 
-	cmpwi	cr2,r15,0
+	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
+	cmpwi	cr2,r9,0
 
 	/*
 	 * At this stage
@@ -524,7 +525,7 @@ lwarx_loop2:
 	 * cr4 - gt or eq if waking up from complete hypervisor state loss.
 	 */
 
-	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
+	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	stwcx.	r15,0,r14
 	bne-	lwarx_loop2
 	isync
@@ -614,7 +615,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_WORC,r4
 
 clear_lock:
-	andi.	r15,r15,PNV_CORE_IDLE_THREAD_BITS
+	xoris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	lwsync
 	stw	r15,0(r14)
 
-- 
2.11.0
