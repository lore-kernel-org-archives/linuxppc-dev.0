Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40n9lr5FyzzF297
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 11:37:44 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	sam@mendozajonas.com,
	mikey@neuling.org
Subject: [PATCH] powepc: Clear PCR on boot
Date: Fri, 18 May 2018 11:37:42 +1000
Message-Id: <20180518013742.24095-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Clear the PCR on boot to ensure we are not running in a compat mode.

We've seen this cause problems when a crash (and kdump) occurs while
running compat mode guests. The kdump kernel then runs with the PCR
set and causes problems. The symptom in the kdump kernel (also seen in
petitboot after fast-reboot) is early userspace programs taking
sigills on newer instructions (seen in libc).

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org>
---
 arch/powerpc/kernel/cpu_setup_power.S | 6 ++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c     | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 3f30c994e9..458b928dbd 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -28,6 +28,7 @@ _GLOBAL(__setup_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR_ISA206
@@ -41,6 +42,7 @@ _GLOBAL(__restore_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR_ISA206
@@ -57,6 +59,7 @@ _GLOBAL(__setup_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	li	r4,0 /* LPES = 0 */
@@ -78,6 +81,7 @@ _GLOBAL(__restore_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	li	r4,0 /* LPES = 0 */
@@ -99,6 +103,7 @@ _GLOBAL(__setup_cpu_power9)
 	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
 	mtspr	SPRN_PID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE  | LPCR_HEIC)
 	or	r3, r3, r4
@@ -123,6 +128,7 @@ _GLOBAL(__restore_cpu_power9)
 	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
 	mtspr	SPRN_PID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr   r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE | LPCR_HEIC)
 	or	r3, r3, r4
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 8ab51f6ca0..c904477aba 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -101,6 +101,7 @@ static void __restore_cpu_cpufeatures(void)
 	if (hv_mode) {
 		mtspr(SPRN_LPID, 0);
 		mtspr(SPRN_HFSCR, system_registers.hfscr);
+		mtspr(SPRN_PCR, 0);
 	}
 	mtspr(SPRN_FSCR, system_registers.fscr);
 
-- 
2.14.1
