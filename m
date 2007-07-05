Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CF10DDDF5D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170239.160818000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:54 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 21/35] Use MSR_PMM to disable profiling of the idle loop
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use MSR_PMM to disable performance monitor counting while in idle,
instead of using the CTRL register like on the IBM implementation.

This needs further cleanup. It should be possible to switch over the
default behaviour to MSR_PMM on IBM hardware too.

Index: 2.6.21/arch/powerpc/kernel/process.c
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/process.c
+++ 2.6.21/arch/powerpc/kernel/process.c
@@ -972,13 +972,18 @@ void ppc64_runlatch_on(void)
 {
 	unsigned long ctrl;
 
-	if (cpu_has_feature(CPU_FTR_CTRL) && !test_thread_flag(TIF_RUNLATCH)) {
+//	if (cpu_has_feature(CPU_FTR_CTRL) && !test_thread_flag(TIF_RUNLATCH)) {
+	if (!test_thread_flag(TIF_RUNLATCH)) {
 		HMT_medium();
 
 		ctrl = mfspr(SPRN_CTRLF);
 		ctrl |= CTRL_RUNLATCH;
 		mtspr(SPRN_CTRLT, ctrl);
 
+		ctrl = mfmsr();
+		ctrl &= ~MSR_PMM;
+		mtmsrd(ctrl);
+
 		set_thread_flag(TIF_RUNLATCH);
 	}
 }
@@ -987,7 +992,8 @@ void ppc64_runlatch_off(void)
 {
 	unsigned long ctrl;
 
-	if (cpu_has_feature(CPU_FTR_CTRL) && test_thread_flag(TIF_RUNLATCH)) {
+//	if (cpu_has_feature(CPU_FTR_CTRL) && test_thread_flag(TIF_RUNLATCH)) {
+	if (test_thread_flag(TIF_RUNLATCH)) {
 		HMT_medium();
 
 		clear_thread_flag(TIF_RUNLATCH);
@@ -995,6 +1001,10 @@ void ppc64_runlatch_off(void)
 		ctrl = mfspr(SPRN_CTRLF);
 		ctrl &= ~CTRL_RUNLATCH;
 		mtspr(SPRN_CTRLT, ctrl);
+
+		ctrl = mfmsr();
+		ctrl |= MSR_PMM;
+		mtmsrd(ctrl);
 	}
 }
 #endif
Index: 2.6.21/arch/powerpc/oprofile/op_model_pa6t.c
===================================================================
--- 2.6.21.orig/arch/powerpc/oprofile/op_model_pa6t.c
+++ 2.6.21/arch/powerpc/oprofile/op_model_pa6t.c
@@ -109,6 +109,8 @@ static void pa6t_reg_setup(struct op_cou
 			pr_debug("turned off counter %u\n", pmc);
 		}
 
+	sys->mmcr0 |= PA6T_MMCR0_FCM1;
+
 	if (sys->enable_kernel)
 		sys->mmcr0 |= PA6T_MMCR0_SUPEN | PA6T_MMCR0_HYPEN;
 	else

--
