Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 08/14] powerpc: Move initial mfspr LPCR out of __init_LPCR
Date: Fri,  9 Nov 2012 17:19:06 +1100
Message-Id: <1352441953-29096-9-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to change what's initially set in the LPCR, so start by taking the move
from LPCR out of the function and into the caller.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cpu_setup_power.S |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index a92101d..52dd033 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -27,6 +27,7 @@ _GLOBAL(__setup_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_TLB
 	mtlr	r11
@@ -39,6 +40,7 @@ _GLOBAL(__restore_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_TLB
 	mtlr	r11
@@ -51,6 +53,7 @@ _GLOBAL(__setup_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_TLB
 	mtlr	r11
@@ -63,6 +66,7 @@ _GLOBAL(__restore_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mfspr   r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_TLB
 	mtlr	r11
@@ -81,6 +85,7 @@ __init_hvmode_206:
 
 __init_LPCR:
 	/* Setup a sane LPCR:
+	 *   Called with initial LPCR in R3
 	 *
 	 *   LPES = 0b01 (HSRR0/1 used for 0x500)
 	 *   PECE = 0b111
@@ -91,7 +96,6 @@ __init_LPCR:
 	 *
 	 * Other bits untouched for now
 	 */
-	mfspr	r3,SPRN_LPCR
 	li	r5,1
 	rldimi	r3,r5, LPCR_LPES_SH, 64-LPCR_LPES_SH-2
 	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
-- 
1.7.9.5
