Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc: Add POWER8 setup code
Date: Wed, 31 Oct 2012 16:34:14 +1100
Message-Id: <1351661656-6986-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1351661656-6986-1-git-send-email-mikey@neuling.org>
References: <1351661656-6986-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just a copy of POWER7 for now.  Will update with new code later.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cpu_setup_power.S |   24 ++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c        |    2 ++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 76797c5..a92101d 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -44,6 +44,30 @@ _GLOBAL(__restore_cpu_power7)
 	mtlr	r11
 	blr
 
+_GLOBAL(__setup_cpu_power8)
+	mflr	r11
+	bl	__init_hvmode_206
+	mtlr	r11
+	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
+	bl	__init_LPCR
+	bl	__init_TLB
+	mtlr	r11
+	blr
+
+_GLOBAL(__restore_cpu_power8)
+	mflr	r11
+	mfmsr	r3
+	rldicl.	r0,r3,4,63
+	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
+	bl	__init_LPCR
+	bl	__init_TLB
+	mtlr	r11
+	blr
+
 __init_hvmode_206:
 	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
 	mfmsr	r3
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 0514c21..361f6d9 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -68,6 +68,8 @@ extern void __restore_cpu_pa6t(void);
 extern void __restore_cpu_ppc970(void);
 extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power7(void);
+extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_power8(void);
 extern void __restore_cpu_a2(void);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
-- 
1.7.9.5
