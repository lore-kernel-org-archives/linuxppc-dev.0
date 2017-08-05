Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqr46nqwzDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:32 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t86so4852295pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 11/13] powerpc/64s: idle POWER9 can execute stop without
 ptesync
Date: Sun,  6 Aug 2017 03:02:39 +1000
Message-Id: <20170805170241.22966-12-npiggin@gmail.com>
In-Reply-To: <20170805170241.22966-1-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S       |  7 ++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 3ab73f9223e4..75746111e2c4 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -249,7 +249,7 @@ power_enter_stop:
 	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
 	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
 	bne	 .Lhandle_esl_ec_set
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	PPC_STOP
 	li	r3,0  /* Since we didn't lose state, return 0 */
 
 	/*
@@ -282,7 +282,8 @@ power_enter_stop:
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 	cmpd	r3,r4
 	bge	.Lhandle_deep_stop
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
+	PPC_STOP	/* Does not return (system reset interrupt) */
+
 .Lhandle_deep_stop:
 /*
  * Entering deep idle state.
@@ -304,7 +305,7 @@ lwarx_loop_stop:
 
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
+	PPC_STOP	/* Does not return (system reset interrupt) */
 
 /*
  * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 3e024fd71fe8..edb47738a686 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2527,7 +2527,17 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
 kvm_nap_sequence:		/* desired LPCR value in r5 */
-BEGIN_FTR_SECTION
+BEGIN_FTR_SECTION	/* nap sequence */
+	mtspr	SPRN_LPCR,r5
+	isync
+	li	r0, 0
+	std	r0, HSTATE_SCRATCH0(r13)
+	ptesync
+	ld	r0, HSTATE_SCRATCH0(r13)
+1:	cmpd	r0, r0
+	bne	1b
+	nap
+FTR_SECTION_ELSE	/* stop sequence */
 	/*
 	 * PSSCR bits:	exit criterion = 1 (wakeup based on LPCR at sreset)
 	 *		enable state loss = 1 (allow SMT mode switch)
@@ -2539,18 +2549,8 @@ BEGIN_FTR_SECTION
 	li	r4, LPCR_PECE_HVEE@higher
 	sldi	r4, r4, 32
 	or	r5, r5, r4
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPCR,r5
-	isync
-	li	r0, 0
-	std	r0, HSTATE_SCRATCH0(r13)
-	ptesync
-	ld	r0, HSTATE_SCRATCH0(r13)
-1:	cmpd	r0, r0
-	bne	1b
-BEGIN_FTR_SECTION
-	nap
-FTR_SECTION_ELSE
+
 	PPC_STOP
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	b	.
-- 
2.11.0
