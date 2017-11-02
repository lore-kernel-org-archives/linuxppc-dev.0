Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS7Tg5sb4zDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 12:55:51 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id b79so3382007pfk.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 18:55:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/2] powerpc/64s: idle skip POWER9 DD1 and DD2.0 specific
 workarounds on DD2.1
Date: Thu,  2 Nov 2017 12:55:35 +1100
Message-Id: <20171102015535.30843-3-npiggin@gmail.com>
In-Reply-To: <20171102015535.30843-1-npiggin@gmail.com>
References: <20171102015535.30843-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DD2.1 does not have to flush the ERAT after a state-loss idle. It also
does not have to save and restore MMCR0 (although it does have to save
restore in deep idle states, like other PMU registers).

Performance testing was done on a DD2.1 using only the stop0 idle state
(the shallowest state which supports state loss), using context_switch
selftest configured to ping-poing between two threads on the same core
and two different cores.

Performance improvement for same core is 7.0%, different cores is 14.8%.

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 175d49f468af..59657783d1d5 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -112,12 +112,14 @@ power9_save_additional_sprs:
 	std	r4, STOP_HFSCR(r13)
 
 	mfspr	r3, SPRN_MMCRA
-	mfspr	r4, SPRN_MMCR1
+	mfspr	r4, SPRN_MMCR0
 	std	r3, STOP_MMCRA(r13)
-	std	r4, STOP_MMCR1(r13)
+	std	r4, _MMCR0(r1)
 
-	mfspr	r3, SPRN_MMCR2
-	std	r3, STOP_MMCR2(r13)
+	mfspr	r3, SPRN_MMCR1
+	mfspr	r4, SPRN_MMCR2
+	std	r3, STOP_MMCR1(r13)
+	std	r4, STOP_MMCR2(r13)
 	blr
 
 power9_restore_additional_sprs:
@@ -135,11 +137,14 @@ power9_restore_additional_sprs:
 	ld	r4, STOP_MMCRA(r13)
 	mtspr	SPRN_HFSCR, r3
 	mtspr	SPRN_MMCRA, r4
-	/* We have already restored PACA_MMCR0 */
-	ld	r3, STOP_MMCR1(r13)
-	ld	r4, STOP_MMCR2(r13)
-	mtspr	SPRN_MMCR1, r3
-	mtspr	SPRN_MMCR2, r4
+
+	ld	r3, _MMCR0(r1)
+	ld	r4, STOP_MMCR1(r13)
+	mtspr	SPRN_MMCR0, r3
+	mtspr	SPRN_MMCR1, r4
+
+	ld	r3, STOP_MMCR2(r13)
+	mtspr	SPRN_MMCR2, r3
 	blr
 
 /*
@@ -350,6 +355,7 @@ power_enter_stop:
 	b 	pnv_wakeup_noloss
 
 .Lhandle_esl_ec_set:
+BEGIN_FTR_SECTION
 	/*
 	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
 	 * state-loss idle. Saving and restoring MMCR0 over idle is a
@@ -357,6 +363,7 @@ power_enter_stop:
 	 */
 	mfspr	r4,SPRN_MMCR0
 	std	r4,_MMCR0(r1)
+END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1 | CPU_FTR_POWER9_DD20)
 
 /*
  * Check if the requested state is a deep idle state.
@@ -542,15 +549,17 @@ pnv_restore_hyp_resource_arch300:
 	 * then clear bit 60 in MMCRA to ensure the PMU starts running.
 	 */
 	blt	cr3,1f
+BEGIN_FTR_SECTION
 	PPC_INVALIDATE_ERAT
 	ld	r1,PACAR1(r13)
+	ld	r4,_MMCR0(r1)
+	mtspr	SPRN_MMCR0,r4
+END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1 | CPU_FTR_POWER9_DD20)
 	mfspr	r4,SPRN_MMCRA
 	ori	r4,r4,(1 << (63-60))
 	mtspr	SPRN_MMCRA,r4
 	xori	r4,r4,(1 << (63-60))
 	mtspr	SPRN_MMCRA,r4
-	ld	r4,_MMCR0(r1)
-	mtspr	SPRN_MMCR0,r4
 1:
 	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
-- 
2.15.0
