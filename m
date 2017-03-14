Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDlL0tytzDr8W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:37:18 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 25so24278332pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:37:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/6] powerpc/64s: data driven machine check handling
Date: Tue, 14 Mar 2017 22:36:47 +1000
Message-Id: <20170314123648.26068-6-npiggin@gmail.com>
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

Move the handling (corrective action) of machine checks to the table
based evaluation.

This changes P7 and P8 ERAT flushing from using SLB flush to using ERAT
flush.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 328 +++++++++-------------------------------
 1 file changed, 74 insertions(+), 254 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 1b38fabdd2a0..95ed9d85ebcf 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -147,111 +147,7 @@ static int mce_flush(int what)
 	return 0;
 }
 
-static int mce_handle_flush_derrors(uint64_t dsisr, uint64_t slb, uint64_t tlb, uint64_t erat)
-{
-	if ((dsisr & slb) && mce_flush(MCE_FLUSH_SLB))
-		dsisr &= ~slb;
-	if ((dsisr & erat) && mce_flush(MCE_FLUSH_ERAT))
-		dsisr &= ~erat;
-	if ((dsisr & tlb) && mce_flush(MCE_FLUSH_TLB))
-		dsisr &= ~tlb;
-	/* Any other errors we don't understand? */
-	if (dsisr)
-		return 0;
-	return 1;
-}
-
-
-/*
- * Machine Check bits on power7 and power8
- */
-#define P7_SRR1_MC_LOADSTORE(srr1)	((srr1) & PPC_BIT(42)) /* P8 too */
-
-/* SRR1 bits for machine check (On Power7 and Power8) */
-#define P7_SRR1_MC_IFETCH(srr1)	((srr1) & PPC_BITMASK(43, 45)) /* P8 too */
-
-#define P7_SRR1_MC_IFETCH_UE		(0x1 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_SLB_PARITY	(0x2 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_SLB_MULTIHIT	(0x3 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_SLB_BOTH	(0x4 << PPC_BITLSHIFT(45))
-#define P7_SRR1_MC_IFETCH_TLB_MULTIHIT	(0x5 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_UE_TLB_RELOAD	(0x6 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_UE_IFU_INTERNAL	(0x7 << PPC_BITLSHIFT(45))
-
-/* SRR1 bits for machine check (On Power8) */
-#define P8_SRR1_MC_IFETCH_ERAT_MULTIHIT	(0x4 << PPC_BITLSHIFT(45))
-
-/* DSISR bits for machine check (On Power7 and Power8) */
-#define P7_DSISR_MC_UE			(PPC_BIT(48))	/* P8 too */
-#define P7_DSISR_MC_UE_TABLEWALK	(PPC_BIT(49))	/* P8 too */
-#define P7_DSISR_MC_ERAT_MULTIHIT	(PPC_BIT(52))	/* P8 too */
-#define P7_DSISR_MC_TLB_MULTIHIT_MFTLB	(PPC_BIT(53))	/* P8 too */
-#define P7_DSISR_MC_SLB_PARITY_MFSLB	(PPC_BIT(55))	/* P8 too */
-#define P7_DSISR_MC_SLB_MULTIHIT	(PPC_BIT(56))	/* P8 too */
-#define P7_DSISR_MC_SLB_MULTIHIT_PARITY	(PPC_BIT(57))	/* P8 too */
-
-/*
- * DSISR bits for machine check (Power8) in addition to above.
- * Secondary DERAT Multihit
- */
-#define P8_DSISR_MC_ERAT_MULTIHIT_SEC	(PPC_BIT(54))
-
-/* SLB error bits */
-#define P7_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_ERAT_MULTIHIT | \
-					 P7_DSISR_MC_SLB_PARITY_MFSLB | \
-					 P7_DSISR_MC_SLB_MULTIHIT | \
-					 P7_DSISR_MC_SLB_MULTIHIT_PARITY)
-
-#define P8_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_SLB_ERRORS | \
-					 P8_DSISR_MC_ERAT_MULTIHIT_SEC)
-
-/*
- * Machine Check bits on power9
- */
-#define P9_SRR1_MC_LOADSTORE(srr1)	(((srr1) >> PPC_BITLSHIFT(42)) & 1)
-
-#define P9_SRR1_MC_IFETCH(srr1)	(	\
-	PPC_BITEXTRACT(srr1, 45, 0) |	\
-	PPC_BITEXTRACT(srr1, 44, 1) |	\
-	PPC_BITEXTRACT(srr1, 43, 2) |	\
-	PPC_BITEXTRACT(srr1, 36, 3) )
-
-/* 0 is reserved */
-#define P9_SRR1_MC_IFETCH_UE				1
-#define P9_SRR1_MC_IFETCH_SLB_PARITY			2
-#define P9_SRR1_MC_IFETCH_SLB_MULTIHIT			3
-#define P9_SRR1_MC_IFETCH_ERAT_MULTIHIT			4
-#define P9_SRR1_MC_IFETCH_TLB_MULTIHIT			5
-#define P9_SRR1_MC_IFETCH_UE_TLB_RELOAD			6
-/* 7 is reserved */
-#define P9_SRR1_MC_IFETCH_LINK_TIMEOUT			8
-#define P9_SRR1_MC_IFETCH_LINK_TABLEWALK_TIMEOUT	9
-/* 10 ? */
-#define P9_SRR1_MC_IFETCH_RA			11
-#define P9_SRR1_MC_IFETCH_RA_TABLEWALK		12
-#define P9_SRR1_MC_IFETCH_RA_ASYNC_STORE		13
-#define P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT	14
-#define P9_SRR1_MC_IFETCH_RA_TABLEWALK_FOREIGN	15
-
-/* DSISR bits for machine check (On Power9) */
-#define P9_DSISR_MC_UE					(PPC_BIT(48))
-#define P9_DSISR_MC_UE_TABLEWALK			(PPC_BIT(49))
-#define P9_DSISR_MC_LINK_LOAD_TIMEOUT			(PPC_BIT(50))
-#define P9_DSISR_MC_LINK_TABLEWALK_TIMEOUT		(PPC_BIT(51))
-#define P9_DSISR_MC_ERAT_MULTIHIT			(PPC_BIT(52))
-#define P9_DSISR_MC_TLB_MULTIHIT_MFTLB			(PPC_BIT(53))
-#define P9_DSISR_MC_USER_TLBIE				(PPC_BIT(54))
-#define P9_DSISR_MC_SLB_PARITY_MFSLB			(PPC_BIT(55))
-#define P9_DSISR_MC_SLB_MULTIHIT_MFSLB			(PPC_BIT(56))
-#define P9_DSISR_MC_RA_LOAD				(PPC_BIT(57))
-#define P9_DSISR_MC_RA_TABLEWALK			(PPC_BIT(58))
-#define P9_DSISR_MC_RA_TABLEWALK_FOREIGN		(PPC_BIT(59))
-#define P9_DSISR_MC_RA_FOREIGN				(PPC_BIT(60))
-
-/* SLB error bits */
-#define P9_DSISR_MC_SLB_ERRORS		(P9_DSISR_MC_ERAT_MULTIHIT | \
-					 P9_DSISR_MC_SLB_PARITY_MFSLB | \
-					 P9_DSISR_MC_SLB_MULTIHIT_MFSLB)
+#define SRR1_MC_LOADSTORE(srr1)	((srr1) & PPC_BIT(42))
 
 struct mce_ierror_table {
 	unsigned long srr1_mask;
@@ -452,11 +348,12 @@ static const struct mce_derror_table mce_p9_derror_table[] = {
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0, false, 0, 0, 0, 0 } };
 
-static void mce_get_ierror(struct pt_regs *regs,
+static int mce_handle_ierror(struct pt_regs *regs,
 		const struct mce_ierror_table table[],
 		struct mce_error_info *mce_err, uint64_t *addr)
 {
 	uint64_t srr1 = regs->msr;
+	int handled = 0;
 	int i;
 
 	*addr = 0;
@@ -465,6 +362,20 @@ static void mce_get_ierror(struct pt_regs *regs,
 		if ((srr1 & table[i].srr1_mask) != table[i].srr1_value)
 			continue;
 
+		/* attempt to correct the error */
+		switch (table[i].error_type) {
+		case MCE_ERROR_TYPE_SLB:
+			handled = mce_flush(MCE_FLUSH_SLB);
+			break;
+		case MCE_ERROR_TYPE_ERAT:
+			handled = mce_flush(MCE_FLUSH_ERAT);
+			break;
+		case MCE_ERROR_TYPE_TLB:
+			handled = mce_flush(MCE_FLUSH_TLB);
+			break;
+		}
+
+		/* now fill in mce_error_info */
 		mce_err->error_type = table[i].error_type;
 		switch (table[i].error_type) {
 		case MCE_ERROR_TYPE_UE:
@@ -493,19 +404,23 @@ static void mce_get_ierror(struct pt_regs *regs,
 		mce_err->initiator = table[i].initiator;
 		if (table[i].nip_valid)
 			*addr = regs->nip;
-		return;
+		return handled;
 	}
 
 	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
 	mce_err->severity = MCE_SEV_ERROR_SYNC;
 	mce_err->initiator = MCE_INITIATOR_CPU;
+
+	return 0;
 }
 
-static void mce_get_derror(struct pt_regs *regs,
+static int mce_handle_derror(struct pt_regs *regs,
 		const struct mce_derror_table table[],
 		struct mce_error_info *mce_err, uint64_t *addr)
 {
 	uint64_t dsisr = regs->dsisr;
+	int handled = 0;
+	int found = 0;
 	int i;
 
 	*addr = 0;
@@ -514,6 +429,31 @@ static void mce_get_derror(struct pt_regs *regs,
 		if (!(dsisr & table[i].dsisr_value))
 			continue;
 
+		/* attempt to correct the error */
+		switch (table[i].error_type) {
+		case MCE_ERROR_TYPE_SLB:
+			if (mce_flush(MCE_FLUSH_SLB))
+				handled = 1;
+			break;
+		case MCE_ERROR_TYPE_ERAT:
+			if (mce_flush(MCE_FLUSH_ERAT))
+				handled = 1;
+			break;
+		case MCE_ERROR_TYPE_TLB:
+			if (mce_flush(MCE_FLUSH_TLB))
+				handled = 1;
+			break;
+		}
+
+		/*
+		 * Attempt to handle multiple conditions, but only return
+		 * one. Ensure uncorrectable errors are first in the table
+		 * to match.
+		 */
+		if (found)
+			continue;
+
+		/* now fill in mce_error_info */
 		mce_err->error_type = table[i].error_type;
 		switch (table[i].error_type) {
 		case MCE_ERROR_TYPE_UE:
@@ -545,12 +485,17 @@ static void mce_get_derror(struct pt_regs *regs,
 		else
 			*addr = regs->nip;
 
-		return;
+		found = 1;
 	}
 
+	if (found)
+		return handled;
+
 	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
 	mce_err->severity = MCE_SEV_ERROR_SYNC;
 	mce_err->initiator = MCE_INITIATOR_CPU;
+
+	return 0;
 }
 
 static long mce_handle_ue_error(struct pt_regs *regs)
@@ -571,167 +516,42 @@ static long mce_handle_ue_error(struct pt_regs *regs)
 	return handled;
 }
 
-static long mce_handle_derror_p7(uint64_t dsisr)
-{
-	return mce_handle_flush_derrors(dsisr,
-			P7_DSISR_MC_SLB_ERRORS,
-			P7_DSISR_MC_TLB_MULTIHIT_MFTLB,
-			0);
-}
-
-static long mce_handle_ierror_p7(uint64_t srr1)
-{
-	switch (P7_SRR1_MC_IFETCH(srr1)) {
-	case P7_SRR1_MC_IFETCH_SLB_PARITY:
-	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
-	case P7_SRR1_MC_IFETCH_SLB_BOTH:
-		return mce_flush(MCE_FLUSH_SLB);
-
-	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
-		return mce_flush(MCE_FLUSH_TLB);
-	default:
-		return 0;
-	}
-}
-
-long __machine_check_early_realmode_p7(struct pt_regs *regs)
+static long mce_handle_error(struct pt_regs *regs,
+		const struct mce_derror_table dtable[],
+		const struct mce_ierror_table itable[])
 {
-	uint64_t srr1, nip, addr;
-	long handled = 1;
-	struct mce_error_info mce_error_info = { 0 };
-
-	srr1 = regs->msr;
-	nip = regs->nip;
+	struct mce_error_info mce_err = { 0 };
+	uint64_t addr;
+	uint64_t srr1 = regs->msr;
+	long handled;
 
-	/* P7 DD1 leaves top bits of DSISR undefined */
-	regs->dsisr &= 0x0000ffff;
+	if (SRR1_MC_LOADSTORE(srr1))
+		handled = mce_handle_derror(regs, dtable, &mce_err, &addr);
+	else
+		handled = mce_handle_ierror(regs, itable, &mce_err, &addr);
 
-	/*
-	 * Handle memory errors depending whether this was a load/store or
-	 * ifetch exception. Also, populate the mce error_type and
-	 * type-specific error_type from either SRR1 or DSISR, depending
-	 * whether this was a load/store or ifetch exception
-	 */
-	if (P7_SRR1_MC_LOADSTORE(srr1)) {
-		handled = mce_handle_derror_p7(regs->dsisr);
-		mce_get_derror(regs, mce_p7_derror_table,
-				&mce_error_info, &addr);
-	} else {
-		handled = mce_handle_ierror_p7(srr1);
-		mce_get_ierror(regs, mce_p7_ierror_table,
-				&mce_error_info, &addr);
-	}
-
-	/* Handle UE error. */
-	if (mce_error_info.error_type == MCE_ERROR_TYPE_UE)
+	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
 		handled = mce_handle_ue_error(regs);
 
-	save_mce_event(regs, handled, &mce_error_info, nip, addr);
-	return handled;
-}
-
-static long mce_handle_ierror_p8(uint64_t srr1)
-{
-	switch (P7_SRR1_MC_IFETCH(srr1)) {
-	case P7_SRR1_MC_IFETCH_SLB_PARITY:
-	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
-	case P8_SRR1_MC_IFETCH_ERAT_MULTIHIT:
-		return mce_flush(MCE_FLUSH_SLB);
-
-	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
-		return mce_flush(MCE_FLUSH_TLB);
-	default:
-		return 0;
-	}
-}
-
-static long mce_handle_derror_p8(uint64_t dsisr)
-{
-	return mce_handle_flush_derrors(dsisr,
-			P8_DSISR_MC_SLB_ERRORS,
-			P7_DSISR_MC_TLB_MULTIHIT_MFTLB,
-			0);
-}
-
-long __machine_check_early_realmode_p8(struct pt_regs *regs)
-{
-	uint64_t srr1, nip, addr;
-	long handled = 1;
-	struct mce_error_info mce_error_info = { 0 };
-
-	srr1 = regs->msr;
-	nip = regs->nip;
-
-	if (P7_SRR1_MC_LOADSTORE(srr1)) {
-		handled = mce_handle_derror_p8(regs->dsisr);
-		mce_get_derror(regs, mce_p8_derror_table,
-				&mce_error_info, &addr);
-	} else {
-		handled = mce_handle_ierror_p8(srr1);
-		mce_get_ierror(regs, mce_p8_ierror_table,
-				&mce_error_info, &addr);
-	}
-
-	/* Handle UE error. */
-	if (mce_error_info.error_type == MCE_ERROR_TYPE_UE)
-		handled = mce_handle_ue_error(regs);
+	save_mce_event(regs, handled, &mce_err, regs->nip, addr);
 
-	save_mce_event(regs, handled, &mce_error_info, nip, addr);
 	return handled;
 }
 
-static int mce_handle_derror_p9(struct pt_regs *regs)
+long __machine_check_early_realmode_p7(struct pt_regs *regs)
 {
-	uint64_t dsisr = regs->dsisr;
-
-	return mce_handle_flush_derrors(dsisr,
-			P9_DSISR_MC_SLB_PARITY_MFSLB |
-			P9_DSISR_MC_SLB_MULTIHIT_MFSLB,
-
-			P9_DSISR_MC_TLB_MULTIHIT_MFTLB,
+	/* P7 DD1 leaves top bits of DSISR undefined */
+	regs->dsisr &= 0x0000ffff;
 
-			P9_DSISR_MC_ERAT_MULTIHIT);
+	return mce_handle_error(regs, mce_p7_derror_table, mce_p7_ierror_table);
 }
 
-static int mce_handle_ierror_p9(struct pt_regs *regs)
+long __machine_check_early_realmode_p8(struct pt_regs *regs)
 {
-	uint64_t srr1 = regs->msr;
-
-	switch (P9_SRR1_MC_IFETCH(srr1)) {
-	case P9_SRR1_MC_IFETCH_SLB_PARITY:
-	case P9_SRR1_MC_IFETCH_SLB_MULTIHIT:
-		return mce_flush(MCE_FLUSH_SLB);
-	case P9_SRR1_MC_IFETCH_TLB_MULTIHIT:
-		return mce_flush(MCE_FLUSH_TLB);
-	case P9_SRR1_MC_IFETCH_ERAT_MULTIHIT:
-		return mce_flush(MCE_FLUSH_ERAT);
-	default:
-		return 0;
-	}
+	return mce_handle_error(regs, mce_p8_derror_table, mce_p8_ierror_table);
 }
 
 long __machine_check_early_realmode_p9(struct pt_regs *regs)
 {
-	uint64_t nip, addr;
-	long handled;
-	struct mce_error_info mce_error_info = { 0 };
-
-	nip = regs->nip;
-
-	if (P9_SRR1_MC_LOADSTORE(regs->msr)) {
-		handled = mce_handle_derror_p9(regs);
-		mce_get_derror(regs, mce_p9_derror_table,
-				&mce_error_info, &addr);
-	} else {
-		handled = mce_handle_ierror_p9(regs);
-		mce_get_ierror(regs, mce_p9_ierror_table,
-				&mce_error_info, &addr);
-	}
-
-	/* Handle UE error. */
-	if (mce_error_info.error_type == MCE_ERROR_TYPE_UE)
-		handled = mce_handle_ue_error(regs);
-
-	save_mce_event(regs, handled, &mce_error_info, nip, addr);
-	return handled;
+	return mce_handle_error(regs, mce_p9_derror_table, mce_p9_ierror_table);
 }
-- 
2.11.0
