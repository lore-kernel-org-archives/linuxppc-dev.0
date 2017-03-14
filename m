Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDl768P0zDr8S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:37:07 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 77so24220249pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:37:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/6] powerpc/64s: clean up machine check recovery flushing
Date: Tue, 14 Mar 2017 22:36:44 +1000
Message-Id: <20170314123648.26068-3-npiggin@gmail.com>
In-Reply-To: <20170314123648.26068-1-npiggin@gmail.com>
References: <20170314123648.26068-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the flush function introduced with the POWER9 machine check handler
for POWER7 and 8, rather than open coding it multiple times in callers.

There is a specific ERAT flush type introduced for POWER9, but the
POWER7-8 ERAT errors continue to do SLB flushing (which also flushes
ERAT), so as not to introduce functional changes with this cleanup
patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 97 ++++++++++-------------------------------
 1 file changed, 23 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 763d6f58caa8..0f35a88e3655 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -161,81 +161,27 @@ static int mce_handle_flush_derrors(uint64_t dsisr, uint64_t slb, uint64_t tlb,
 	return 1;
 }
 
-static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
-{
-	long handled = 1;
-
-	/*
-	 * flush and reload SLBs for SLB errors and flush TLBs for TLB errors.
-	 * reset the error bits whenever we handle them so that at the end
-	 * we can check whether we handled all of them or not.
-	 * */
-#ifdef CONFIG_PPC_STD_MMU_64
-	if (dsisr & slb_error_bits) {
-		flush_and_reload_slb();
-		/* reset error bits */
-		dsisr &= ~(slb_error_bits);
-	}
-	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
-		/* reset error bits */
-		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
-	}
-#endif
-	/* Any other errors we don't understand? */
-	if (dsisr & 0xffffffffUL)
-		handled = 0;
-
-	return handled;
-}
-
 static long mce_handle_derror_p7(uint64_t dsisr)
 {
-	return mce_handle_derror(dsisr, P7_DSISR_MC_SLB_ERRORS);
+	return mce_handle_flush_derrors(dsisr,
+			P7_DSISR_MC_SLB_ERRORS,
+			P7_DSISR_MC_TLB_MULTIHIT_MFTLB,
+			0);
 }
 
-static long mce_handle_common_ierror(uint64_t srr1)
+static long mce_handle_ierror_p7(uint64_t srr1)
 {
-	long handled = 0;
-
 	switch (P7_SRR1_MC_IFETCH(srr1)) {
-	case 0:
-		break;
-#ifdef CONFIG_PPC_STD_MMU_64
 	case P7_SRR1_MC_IFETCH_SLB_PARITY:
 	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
-		/* flush and reload SLBs for SLB errors. */
-		flush_and_reload_slb();
-		handled = 1;
-		break;
+	case P7_SRR1_MC_IFETCH_SLB_BOTH:
+		return mce_flush(MCE_FLUSH_SLB);
+
 	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
-			handled = 1;
-		}
-		break;
-#endif
+		return mce_flush(MCE_FLUSH_TLB);
 	default:
-		break;
-	}
-
-	return handled;
-}
-
-static long mce_handle_ierror_p7(uint64_t srr1)
-{
-	long handled = 0;
-
-	handled = mce_handle_common_ierror(srr1);
-
-#ifdef CONFIG_PPC_STD_MMU_64
-	if (P7_SRR1_MC_IFETCH(srr1) == P7_SRR1_MC_IFETCH_SLB_BOTH) {
-		flush_and_reload_slb();
-		handled = 1;
+		return 0;
 	}
-#endif
-	return handled;
 }
 
 static void mce_get_common_ierror(struct mce_error_info *mce_err, uint64_t srr1)
@@ -376,22 +322,25 @@ static void mce_get_derror_p8(struct mce_error_info *mce_err, uint64_t dsisr)
 
 static long mce_handle_ierror_p8(uint64_t srr1)
 {
-	long handled = 0;
-
-	handled = mce_handle_common_ierror(srr1);
+	switch (P7_SRR1_MC_IFETCH(srr1)) {
+	case P7_SRR1_MC_IFETCH_SLB_PARITY:
+	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
+	case P8_SRR1_MC_IFETCH_ERAT_MULTIHIT:
+		return mce_flush(MCE_FLUSH_SLB);
 
-#ifdef CONFIG_PPC_STD_MMU_64
-	if (P7_SRR1_MC_IFETCH(srr1) == P8_SRR1_MC_IFETCH_ERAT_MULTIHIT) {
-		flush_and_reload_slb();
-		handled = 1;
+	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
+		return mce_flush(MCE_FLUSH_TLB);
+	default:
+		return 0;
 	}
-#endif
-	return handled;
 }
 
 static long mce_handle_derror_p8(uint64_t dsisr)
 {
-	return mce_handle_derror(dsisr, P8_DSISR_MC_SLB_ERRORS);
+	return mce_handle_flush_derrors(dsisr,
+			P8_DSISR_MC_SLB_ERRORS,
+			P7_DSISR_MC_TLB_MULTIHIT_MFTLB,
+			0);
 }
 
 long __machine_check_early_realmode_p8(struct pt_regs *regs)
-- 
2.11.0
