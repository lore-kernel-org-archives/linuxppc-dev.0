Return-Path: <srs0=i+vg=25=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmmJ6dCPzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:24 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vmmmJ56dnz8wHb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:24 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vmmmH1sgFz9s2x
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2017 17:50:23 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 11/12] powerpc: Fixup LPCR:PECE and HEIC setting on POWER9
Date: Mon, 20 Mar 2017 17:49:13 +1100
Message-Id: <20170320064914.4437-11-benh@kernel.crashing.org>
In-Reply-To: <20170320064914.4437-1-benh@kernel.crashing.org>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to set LPES in order for normal external interrupts (0x500)
to be directed to the guest while running in guest state.

We also need HEIC set to prevent them to be sent to the host while
in host state.

With XIVE the host never gets one of these and wouldn't know how to
handle it. All host external interrupts come in via the new
hypervisor virtualization interrupts vector.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg.h        |  1 +
 arch/powerpc/kernel/cpu_setup_power.S | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index fc879fd..d0b332b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -365,6 +365,7 @@
 #define   LPCR_MER_SH		11
 #define	  LPCR_GTSE		ASM_CONST(0x0000000000000400)  	/* Guest Translation Shootdown Enable */
 #define   LPCR_TC		ASM_CONST(0x0000000000000200)	/* Translation control */
+#define   LPCR_HEIC		ASM_CONST(0x0000000000000010)   /* Hypervisor External Interrupt Control */
 #define   LPCR_LPES		0x0000000c
 #define   LPCR_LPES0		ASM_CONST(0x0000000000000008)      /* LPAR Env selector 0 */
 #define   LPCR_LPES1		ASM_CONST(0x0000000000000004)      /* LPAR Env selector 1 */
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 7fe8c79..7013ae3 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -29,6 +29,7 @@ _GLOBAL(__setup_cpu_power7)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
+	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR
 	bl	__init_tlb_power7
 	mtlr	r11
@@ -42,6 +43,7 @@ _GLOBAL(__restore_cpu_power7)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
+	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR
 	bl	__init_tlb_power7
 	mtlr	r11
@@ -59,6 +61,7 @@ _GLOBAL(__setup_cpu_power8)
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
+	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
@@ -80,6 +83,7 @@ _GLOBAL(__restore_cpu_power8)
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
+	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
@@ -99,10 +103,11 @@ _GLOBAL(__setup_cpu_power9)
 	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
-	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
+	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE  | LPCR_HEIC)
 	or	r3, r3, r4
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
+	li	r4,(LPCR_LPES0 >> LPCR_LPES_SH)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
@@ -122,10 +127,11 @@ _GLOBAL(__restore_cpu_power9)
 	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
-	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
+	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE | LPCR_HEIC)
 	or	r3, r3, r4
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
+	li	r4,(LPCR_LPES0 >> LPCR_LPES_SH)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
@@ -146,7 +152,7 @@ __init_hvmode_206:
 
 __init_LPCR:
 	/* Setup a sane LPCR:
-	 *   Called with initial LPCR in R3
+	 *   Called with initial LPCR in R3 and desired LPES 2-bit value in R4
 	 *
 	 *   LPES = 0b01 (HSRR0/1 used for 0x500)
 	 *   PECE = 0b111
@@ -157,8 +163,7 @@ __init_LPCR:
 	 *
 	 * Other bits untouched for now
 	 */
-	li	r5,1
-	rldimi	r3,r5, LPCR_LPES_SH, 64-LPCR_LPES_SH-2
+	rldimi	r3,r4, LPCR_LPES_SH, 64-LPCR_LPES_SH-2
 	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
 	li	r5,4
 	rldimi	r3,r5, LPCR_DPFD_SH, 64-LPCR_DPFD_SH-3
-- 
2.9.3
