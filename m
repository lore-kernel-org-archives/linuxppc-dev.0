Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRvGz1XdkzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:44:59 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 1so6988958pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 11:44:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 3/9] powerpc/64s: clean up machine check recovery flushing
Date: Tue, 21 Feb 2017 05:44:24 +1000
Message-Id: <20170220194430.32602-4-npiggin@gmail.com>
In-Reply-To: <20170220194430.32602-1-npiggin@gmail.com>
References: <20170220194430.32602-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Put the ifdefs into a flush handler call, and have callers ask for
particular type of flushes. Also add an ERAT flush type (although
existing ERAT flushing goes to the SLB flush path).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 124 +++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index c37fc5fdd433..07af815b5ba1 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -114,83 +114,74 @@ static void flush_and_reload_slb(void)
 		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
 	}
 }
-#endif
 
-static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
+static void flush_erat(void)
 {
-	long handled = 1;
+	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
+}
+#endif
 
-	/*
-	 * flush and reload SLBs for SLB errors and flush TLBs for TLB errors.
-	 * reset the error bits whenever we handle them so that at the end
-	 * we can check whether we handled all of them or not.
-	 * */
+#define MCE_FLUSH_SLB 1
+#define MCE_FLUSH_TLB 2
+#define MCE_FLUSH_ERAT 3
+
+static int mce_flush(int what)
+{
 #ifdef CONFIG_PPC_STD_MMU_64
-	if (dsisr & slb_error_bits) {
+	if (what == MCE_FLUSH_SLB) {
 		flush_and_reload_slb();
-		/* reset error bits */
-		dsisr &= ~(slb_error_bits);
+		return 1;
 	}
-	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
-		/* reset error bits */
-		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
+	if (what == MCE_FLUSH_ERAT) {
+		flush_erat();
+		return 1;
 	}
 #endif
-	/* Any other errors we don't understand? */
-	if (dsisr & 0xffffffffUL)
-		handled = 0;
+	if (what == MCE_FLUSH_TLB) {
+		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
+			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
+			return 1;
+		}
+	}
 
-	return handled;
+	return 0;
 }
 
-static long mce_handle_derror_p7(uint64_t dsisr)
+static int mce_handle_flush_derrors(uint64_t dsisr, uint64_t slb, uint64_t tlb, uint64_t erat)
 {
-	return mce_handle_derror(dsisr, P7_DSISR_MC_SLB_ERRORS);
+	if ((dsisr & slb) && mce_flush(MCE_FLUSH_SLB))
+		dsisr &= ~slb;
+	if ((dsisr & erat) && mce_flush(MCE_FLUSH_ERAT))
+		dsisr &= ~erat;
+	if ((dsisr & tlb) && mce_flush(MCE_FLUSH_TLB))
+		dsisr &= ~tlb;
+	/* Any other errors we don't understand? */
+	if (dsisr)
+		return 0;
+	return 1;
 }
 
-static long mce_handle_common_ierror(uint64_t srr1)
+static long mce_handle_derror_p7(uint64_t dsisr)
 {
-	long handled = 0;
+	return mce_handle_flush_derrors(dsisr,
+			P7_DSISR_MC_SLB_ERRORS,
+			P7_DSISR_MC_TLB_MULTIHIT_MFTLB,
+			0);
+}
 
+static long mce_handle_ierror_p7(uint64_t srr1)
+{
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
@@ -331,22 +322,25 @@ static void mce_get_derror_p8(struct mce_error_info *mce_err, uint64_t dsisr)
 
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
