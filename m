Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC4061A1051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 13:57:08 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyril.bur@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove mtmsrd(), use existing mtmsr()
Date: Tue,  7 Jul 2015 13:56:59 +1000
Message-Id: <1436241419-11153-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mtmsr() does the right thing on 32bit and 64bit, so use it everywhere.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/reg.h          | 3 +--
 arch/powerpc/oprofile/op_model_power4.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index af56b5c..bb27588 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1193,8 +1193,7 @@
 #ifdef CONFIG_PPC_BOOK3S_64
 #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
 				     : : "r" (v) : "memory")
-#define mtmsrd(v)	__mtmsrd((v), 0)
-#define mtmsr(v)	mtmsrd(v)
+#define mtmsr(v)	__mtmsrd((v), 0)
 #else
 #define mtmsr(v)	asm volatile("mtmsr %0" : \
 				     : "r" ((unsigned long)(v)) \
diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
index 962fe7b..4b32e94 100644
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -207,7 +207,7 @@ static int power4_start(struct op_counter_config *ctr)
 	unsigned int mmcr0;
 
 	/* set the PMM bit (see comment below) */
-	mtmsrd(mfmsr() | MSR_PMM);
+	mtmsr(mfmsr() | MSR_PMM);
 
 	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
 		if (ctr[i].enabled) {
@@ -377,7 +377,7 @@ static void power4_handle_interrupt(struct pt_regs *regs,
 	is_kernel = get_kernel(pc, mmcra);
 
 	/* set the PMM bit (see comment below) */
-	mtmsrd(mfmsr() | MSR_PMM);
+	mtmsr(mfmsr() | MSR_PMM);
 
 	/* Check that the SIAR  valid bit in MMCRA is set to 1. */
 	if ((mmcra & MMCRA_SIAR_VALID_MASK) == MMCRA_SIAR_VALID_MASK)
-- 
2.1.4
