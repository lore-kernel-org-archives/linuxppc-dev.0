Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 09/14] powerpc: Setup relocation on exceptions for bare metal
 systems
Date: Fri,  9 Nov 2012 17:19:07 +1100
Message-Id: <1352441953-29096-10-git-send-email-mikey@neuling.org>
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

This turns on MMU on execptions via AIL field in the LPCR.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h        |    2 ++
 arch/powerpc/kernel/cpu_setup_power.S |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7b44a6e..886ab8e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -249,6 +249,8 @@
 #define   LPCR_RMLS    0x1C000000      /* impl dependent rmo limit sel */
 #define	  LPCR_RMLS_SH	(63-37)
 #define   LPCR_ILE     0x02000000      /* !HV irqs set MSR:LE */
+#define   LPCR_AIL_0	0x00000000	/* MMU off IRQ location 0x0 */
+#define   LPCR_AIL_3	0x01800000	/* MMU on IRQ location 0xc00...4xxx */
 #define   LPCR_PECE	0x00007000	/* powersave exit cause enable */
 #define     LPCR_PECE0	0x00004000	/* ext. exceptions can cause exit */
 #define     LPCR_PECE1	0x00002000	/* decrementer can cause exit */
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 52dd033..57cf140 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -54,6 +54,7 @@ _GLOBAL(__setup_cpu_power8)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
+	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
 	bl	__init_TLB
 	mtlr	r11
@@ -67,6 +68,7 @@ _GLOBAL(__restore_cpu_power8)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
+	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
 	bl	__init_TLB
 	mtlr	r11
-- 
1.7.9.5
