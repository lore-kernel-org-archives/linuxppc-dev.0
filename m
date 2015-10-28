Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 142381A028B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:39 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/19] powerpc: Add ppc_strict_facility_enable boot option
Date: Wed, 28 Oct 2015 11:51:02 +1100
Message-Id: <1445993467-667-14-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a boot option that strictly manages the MSR unavailable bits.
This catches kernel uses of FP/Altivec/SPE that would otherwise
corrupt user state.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 Documentation/kernel-parameters.txt  |  6 ++++++
 arch/powerpc/include/asm/reg.h       |  9 +++++++++
 arch/powerpc/include/asm/switch_to.h | 24 +++++++++++++++++++-----
 arch/powerpc/kernel/process.c        | 17 +++++++++++++++--
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22a4b68..f535a02 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2939,6 +2939,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			may be specified.
 			Format: <port>,<port>....
 
+	ppc_strict_facility_enable
+			[PPC] This option catches any kernel floating point,
+			Altivec, VSX and SPE outside of regions specifically
+			allowed (eg kernel_enable_fpu()/kernel_disable_fpu()).
+			There is some performance impact when enabling this.
+
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 987dac0..eb2986e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1214,6 +1214,15 @@ static inline void mtmsr_isync(unsigned long val)
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
 
+extern void msr_check_and_set(unsigned long bits);
+extern bool strict_msr_control;
+extern void __msr_check_and_clear(unsigned long bits);
+static inline void msr_check_and_clear(unsigned long bits)
+{
+	if (strict_msr_control)
+		__msr_check_and_clear(bits);
+}
+
 static inline unsigned long mfvtb (void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index dbc4caa..b6a4951 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -4,6 +4,8 @@
 #ifndef _ASM_POWERPC_SWITCH_TO_H
 #define _ASM_POWERPC_SWITCH_TO_H
 
+#include <asm/reg.h>
+
 struct thread_struct;
 struct task_struct;
 struct pt_regs;
@@ -27,15 +29,15 @@ extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
 extern void switch_booke_debug_regs(struct debug_reg *new_debug);
 
-static inline void disable_kernel_fp(void) { }
-static inline void disable_kernel_altivec(void) { }
-static inline void disable_kernel_spe(void) { }
-static inline void disable_kernel_vsx(void) { }
-
 #ifdef CONFIG_PPC_FPU
 extern void flush_fp_to_thread(struct task_struct *);
 extern void giveup_fpu(struct task_struct *);
 extern void __giveup_fpu(struct task_struct *);
+static inline void disable_kernel_fp(void)
+{
+	msr_check_and_clear(MSR_FP);
+}
+
 #else
 static inline void flush_fp_to_thread(struct task_struct *t) { }
 static inline void giveup_fpu(struct task_struct *t) { }
@@ -46,6 +48,10 @@ static inline void __giveup_fpu(struct task_struct *t) { }
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
 extern void __giveup_altivec(struct task_struct *);
+static inline void disable_kernel_altivec(void)
+{
+	msr_check_and_clear(MSR_VEC);
+}
 #else
 static inline void flush_altivec_to_thread(struct task_struct *t) { }
 static inline void giveup_altivec(struct task_struct *t) { }
@@ -54,6 +60,10 @@ static inline void __giveup_altivec(struct task_struct *t) { }
 
 #ifdef CONFIG_VSX
 extern void flush_vsx_to_thread(struct task_struct *);
+static inline void disable_kernel_vsx(void)
+{
+	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
+}
 #else
 static inline void flush_vsx_to_thread(struct task_struct *t)
 {
@@ -62,6 +72,10 @@ static inline void flush_vsx_to_thread(struct task_struct *t)
 
 #ifdef CONFIG_SPE
 extern void flush_spe_to_thread(struct task_struct *);
+static inline void disable_kernel_spe(void)
+{
+	msr_check_and_clear(MSR_SPE);
+}
 #else
 static inline void flush_spe_to_thread(struct task_struct *t)
 {
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5f244d0..878ea17 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -87,7 +87,19 @@ static void check_if_tm_restore_required(struct task_struct *tsk)
 static inline void check_if_tm_restore_required(struct task_struct *tsk) { }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-static void msr_check_and_set(unsigned long bits)
+bool strict_msr_control;
+EXPORT_SYMBOL(strict_msr_control);
+
+static int __init enable_strict_msr_control(char *str)
+{
+	strict_msr_control = true;
+	pr_info("Enabling strict facility control\n");
+
+	return 0;
+}
+early_param("ppc_strict_facility_enable", enable_strict_msr_control);
+
+void msr_check_and_set(unsigned long bits)
 {
 	unsigned long oldmsr = mfmsr();
 	unsigned long newmsr;
@@ -103,7 +115,7 @@ static void msr_check_and_set(unsigned long bits)
 		mtmsr_isync(newmsr);
 }
 
-static void msr_check_and_clear(unsigned long bits)
+void __msr_check_and_clear(unsigned long bits)
 {
 	unsigned long oldmsr = mfmsr();
 	unsigned long newmsr;
@@ -118,6 +130,7 @@ static void msr_check_and_clear(unsigned long bits)
 	if (oldmsr != newmsr)
 		mtmsr_isync(newmsr);
 }
+EXPORT_SYMBOL(__msr_check_and_clear);
 
 #ifdef CONFIG_PPC_FPU
 void giveup_fpu(struct task_struct *tsk)
-- 
2.5.0
