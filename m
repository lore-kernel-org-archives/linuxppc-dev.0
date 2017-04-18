Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6vsS0nPVzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 05:12:44 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 34so337299pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 12:12:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/4] powerpc/64s: POWER9 no LPCR VRMASD bits
Date: Wed, 19 Apr 2017 05:12:17 +1000
Message-Id: <20170418191220.3166-3-npiggin@gmail.com>
In-Reply-To: <20170418191220.3166-1-npiggin@gmail.com>
References: <20170418191220.3166-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9/ISAv3 has no VRMASD field in LPCR. Don't set reserved bits.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/cpu_setup_power.S | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 1fce4ddd2e6c..10cb2896b2ae 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -30,7 +30,7 @@ _GLOBAL(__setup_cpu_power7)
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_tlb_power7
 	mtlr	r11
 	blr
@@ -44,7 +44,7 @@ _GLOBAL(__restore_cpu_power7)
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_tlb_power7
 	mtlr	r11
 	blr
@@ -62,7 +62,7 @@ _GLOBAL(__setup_cpu_power8)
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	li	r4,0 /* LPES = 0 */
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
@@ -84,7 +84,7 @@ _GLOBAL(__restore_cpu_power8)
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	li	r4,0 /* LPES = 0 */
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
@@ -108,7 +108,7 @@ _GLOBAL(__setup_cpu_power9)
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
 	li	r4,0 /* LPES = 0 */
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA300
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
 	bl	__init_PMU_HV
@@ -132,7 +132,7 @@ _GLOBAL(__restore_cpu_power9)
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
 	li	r4,0 /* LPES = 0 */
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA300
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
 	bl	__init_PMU_HV
@@ -150,7 +150,7 @@ __init_hvmode_206:
 	std	r5,CPU_SPEC_FEATURES(r4)
 	blr
 
-__init_LPCR:
+__init_LPCR_ISA206:
 	/* Setup a sane LPCR:
 	 *   Called with initial LPCR in R3 and desired LPES 2-bit value in R4
 	 *
@@ -163,6 +163,11 @@ __init_LPCR:
 	 *
 	 * Other bits untouched for now
 	 */
+	li	r5,0x10
+	rldimi	r3,r5, LPCR_VRMASD_SH, 64-LPCR_VRMASD_SH-5
+
+	/* POWER9 has no VRMASD */
+__init_LPCR_ISA300:
 	rldimi	r3,r4, LPCR_LPES_SH, 64-LPCR_LPES_SH-2
 	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
 	li	r5,4
@@ -170,8 +175,6 @@ __init_LPCR:
 	clrrdi	r3,r3,1		/* clear HDICE */
 	li	r5,4
 	rldimi	r3,r5, LPCR_VC_SH, 0
-	li	r5,0x10
-	rldimi	r3,r5, LPCR_VRMASD_SH, 64-LPCR_VRMASD_SH-5
 	mtspr	SPRN_LPCR,r3
 	isync
 	blr
-- 
2.11.0
