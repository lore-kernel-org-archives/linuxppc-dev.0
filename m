Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyljN4cvrzDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 22:37:28 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id o123so1864514pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 05:37:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/64s: POWER9 no LPCR VRMASD bits
Date: Wed,  5 Apr 2017 22:37:04 +1000
Message-Id: <20170405123706.6081-2-npiggin@gmail.com>
In-Reply-To: <20170405123706.6081-1-npiggin@gmail.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
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
index 7fe8c79e6937..3737685e1f54 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -29,7 +29,7 @@ _GLOBAL(__setup_cpu_power7)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_tlb_power7
 	mtlr	r11
 	blr
@@ -42,7 +42,7 @@ _GLOBAL(__restore_cpu_power7)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_tlb_power7
 	mtlr	r11
 	blr
@@ -59,7 +59,7 @@ _GLOBAL(__setup_cpu_power8)
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
@@ -80,7 +80,7 @@ _GLOBAL(__restore_cpu_power8)
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA206
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
@@ -103,7 +103,7 @@ _GLOBAL(__setup_cpu_power9)
 	or	r3, r3, r4
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA300
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
 	bl	__init_PMU_HV
@@ -126,7 +126,7 @@ _GLOBAL(__restore_cpu_power9)
 	or	r3, r3, r4
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
-	bl	__init_LPCR
+	bl	__init_LPCR_ISA300
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
 	bl	__init_PMU_HV
@@ -144,7 +144,7 @@ __init_hvmode_206:
 	std	r5,CPU_SPEC_FEATURES(r4)
 	blr
 
-__init_LPCR:
+__init_LPCR_ISA206:
 	/* Setup a sane LPCR:
 	 *   Called with initial LPCR in R3
 	 *
@@ -157,6 +157,11 @@ __init_LPCR:
 	 *
 	 * Other bits untouched for now
 	 */
+	li	r5,0x10
+	rldimi	r3,r5, LPCR_VRMASD_SH, 64-LPCR_VRMASD_SH-5
+
+	/* POWER9 has no VRMASD */
+__init_LPCR_ISA300:
 	li	r5,1
 	rldimi	r3,r5, LPCR_LPES_SH, 64-LPCR_LPES_SH-2
 	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
@@ -165,8 +170,6 @@ __init_LPCR:
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
