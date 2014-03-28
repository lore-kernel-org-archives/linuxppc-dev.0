Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D3B2A1400B0
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:45 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 28 Mar 2014 12:36:45 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 77A1E357805C
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:41 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2S2GBX610748162
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:16:11 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2S2aebJ010201
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:40 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] powerpc/ppc64: Do not turn AIL (reloc-on interrupts) too
 early
Date: Fri, 28 Mar 2014 13:36:30 +1100
Message-Id: <1395974192-820-5-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
References: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Turn them on at the same time as we allow MSR_IR/DR in the paca
kernel MSR, ie, after the MMU has been setup enough to be able
to handle relocated access to the linear mapping.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/cpu_setup_power.S |  2 --
 arch/powerpc/kernel/setup_64.c        | 18 +++++++++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 37d1bb0..1557e7c 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -56,7 +56,6 @@ _GLOBAL(__setup_cpu_power8)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
-	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
@@ -75,7 +74,6 @@ _GLOBAL(__restore_cpu_power8)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
-	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 1d33e81..3d7a50a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -195,6 +195,18 @@ static void fixup_boot_paca(void)
 	get_paca()->data_offset = 0;
 }
 
+static void cpu_ready_for_interrupts(void)
+{
+	/* Set IR and DR in PACA MSR */
+	get_paca()->kernel_msr = MSR_KERNEL;
+
+	/* Enable AIL if supported */
+	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		unsigned long lpcr = mfspr(SPRN_LPCR);
+		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
+	}
+}
+
 /*
  * Early initialization entry point. This is called by head.S
  * with MMU translation disabled. We rely on the "feature" of
@@ -264,9 +276,9 @@ void __init early_setup(unsigned long dt_ptr)
 	/*
 	 * At this point, we can let interrupts switch to virtual mode
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
-	 * have IR and DR set.
+	 * have IR and DR set and enable AIL if it exists
 	 */
-	get_paca()->kernel_msr = MSR_KERNEL;
+	cpu_ready_for_interrupts();
 
 	/* Reserve large chunks of memory for use by CMA for KVM */
 	kvm_cma_reserve();
@@ -307,7 +319,7 @@ void early_setup_secondary(void)
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
 	 * have IR and DR set.
 	 */
-	get_paca()->kernel_msr = MSR_KERNEL;
+	cpu_ready_for_interrupts();
 }
 
 #endif /* CONFIG_SMP */
-- 
1.8.3.2
