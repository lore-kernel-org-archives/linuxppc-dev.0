Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDlH080LzDr9L
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:37:15 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 77so24220983pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:37:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/6] powerpc/64s: data driven machine check evaluation
Date: Tue, 14 Mar 2017 22:36:46 +1000
Message-Id: <20170314123648.26068-5-npiggin@gmail.com>
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

Have machine types define i-side and d-side tables to describe their
machine check encodings, and match entries to evaluate (for reporting)
machine checks.

Functionality is mostly unchanged (tested with a userspace harness), but
it does make a change in that it no longer records DAR as the effective
address for those errors where it is specified to be invalid (which is a
reporting change only).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 571 +++++++++++++++++++++++-----------------
 1 file changed, 328 insertions(+), 243 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 9b3bcd1213bf..1b38fabdd2a0 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -253,91 +253,304 @@ static int mce_handle_flush_derrors(uint64_t dsisr, uint64_t slb, uint64_t tlb,
 					 P9_DSISR_MC_SLB_PARITY_MFSLB | \
 					 P9_DSISR_MC_SLB_MULTIHIT_MFSLB)
 
-static long mce_handle_derror_p7(uint64_t dsisr)
-{
-	return mce_handle_flush_derrors(dsisr,
-			P7_DSISR_MC_SLB_ERRORS,
-			P7_DSISR_MC_TLB_MULTIHIT_MFTLB,
-			0);
-}
-
-static long mce_handle_ierror_p7(uint64_t srr1)
+struct mce_ierror_table {
+	unsigned long srr1_mask;
+	unsigned long srr1_value;
+	bool nip_valid; /* nip is a valid indicator of faulting address */
+	unsigned int error_type;
+	unsigned int error_subtype;
+	unsigned int initiator;
+	unsigned int severity;
+};
+
+static const struct mce_ierror_table mce_p7_ierror_table[] = {
+{ 0x00000000001c0000, 0x0000000000040000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000080000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x00000000000c0000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000100000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000140000, true,
+  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000180000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x00000000001c0000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0, 0, 0, 0, 0, 0 } };
+
+static const struct mce_ierror_table mce_p8_ierror_table[] = {
+{ 0x00000000001c0000, 0x0000000000040000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000080000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x00000000000c0000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000100000, true,
+  MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000140000, true,
+  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x0000000000180000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x00000000001c0000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0, 0, 0, 0, 0, 0 } };
+
+static const struct mce_ierror_table mce_p9_ierror_table[] = {
+{ 0x00000000081c0000, 0x0000000000040000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000080000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x00000000000c0000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000100000, true,
+  MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000140000, true,
+  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000180000, true,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000008000000, true,
+  MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_IFETCH_TIMEOUT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000008040000, true,
+  MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x00000000080c0000, true,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000008100000, true,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000008140000, false,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_STORE,
+  MCE_INITIATOR_CPU,  MCE_SEV_FATAL, }, /* ASYNC is fatal */
+{ 0x00000000081c0000, 0x0000000008180000, false,
+  MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_STORE_TIMEOUT,
+  MCE_INITIATOR_CPU,  MCE_SEV_FATAL, }, /* ASYNC is fatal */
+{ 0x00000000081c0000, 0x00000000081c0000, true,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0, 0, 0, 0, 0, 0 } };
+
+struct mce_derror_table {
+	unsigned long dsisr_value;
+	bool dar_valid; /* dar is a valid indicator of faulting address */
+	unsigned int error_type;
+	unsigned int error_subtype;
+	unsigned int initiator;
+	unsigned int severity;
+};
+
+static const struct mce_derror_table mce_p7_derror_table[] = {
+{ 0x00008000, false,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00004000, true,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000800, true,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000400, true,
+  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000100, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000080, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000040, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0, false, 0, 0, 0, 0 } };
+
+static const struct mce_derror_table mce_p8_derror_table[] = {
+{ 0x00008000, false,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00004000, true,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000800, true,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000400, true,
+  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000200, true,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, /* SECONDARY ERAT */
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000100, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000080, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0, false, 0, 0, 0, 0 } };
+
+static const struct mce_derror_table mce_p9_derror_table[] = {
+{ 0x00008000, false,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00004000, true,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00002000, true,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00001000, true,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000800, true,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000400, true,
+  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000200, false,
+  MCE_ERROR_TYPE_USER, MCE_USER_ERROR_TLBIE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000100, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000080, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000040, true,
+  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000020, false,
+  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000010, false,
+  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000008, false,
+  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD_STORE_FOREIGN,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0, false, 0, 0, 0, 0 } };
+
+static void mce_get_ierror(struct pt_regs *regs,
+		const struct mce_ierror_table table[],
+		struct mce_error_info *mce_err, uint64_t *addr)
 {
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
+	uint64_t srr1 = regs->msr;
+	int i;
+
+	*addr = 0;
+
+	for (i = 0; table[i].srr1_mask; i++) {
+		if ((srr1 & table[i].srr1_mask) != table[i].srr1_value)
+			continue;
+
+		mce_err->error_type = table[i].error_type;
+		switch (table[i].error_type) {
+		case MCE_ERROR_TYPE_UE:
+			mce_err->u.ue_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_SLB:
+			mce_err->u.slb_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_ERAT:
+			mce_err->u.erat_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_TLB:
+			mce_err->u.tlb_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_USER:
+			mce_err->u.user_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_RA:
+			mce_err->u.ra_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_LINK:
+			mce_err->u.link_error_type = table[i].error_subtype;
+			break;
+		}
+		mce_err->severity = table[i].severity;
+		mce_err->initiator = table[i].initiator;
+		if (table[i].nip_valid)
+			*addr = regs->nip;
+		return;
 	}
-}
 
-static void mce_get_common_ierror(struct mce_error_info *mce_err, uint64_t srr1)
-{
-	switch (P7_SRR1_MC_IFETCH(srr1)) {
-	case P7_SRR1_MC_IFETCH_SLB_PARITY:
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_PARITY;
-		break;
-	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_MULTIHIT;
-		break;
-	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
-		mce_err->error_type = MCE_ERROR_TYPE_TLB;
-		mce_err->u.tlb_error_type = MCE_TLB_ERROR_MULTIHIT;
-		break;
-	case P7_SRR1_MC_IFETCH_UE:
-	case P7_SRR1_MC_IFETCH_UE_IFU_INTERNAL:
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type = MCE_UE_ERROR_IFETCH;
-		break;
-	case P7_SRR1_MC_IFETCH_UE_TLB_RELOAD:
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type =
-				MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH;
-		break;
-	}
+	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
+	mce_err->severity = MCE_SEV_ERROR_SYNC;
+	mce_err->initiator = MCE_INITIATOR_CPU;
 }
 
-static void mce_get_ierror_p7(struct mce_error_info *mce_err, uint64_t srr1)
+static void mce_get_derror(struct pt_regs *regs,
+		const struct mce_derror_table table[],
+		struct mce_error_info *mce_err, uint64_t *addr)
 {
-	mce_get_common_ierror(mce_err, srr1);
-	if (P7_SRR1_MC_IFETCH(srr1) == P7_SRR1_MC_IFETCH_SLB_BOTH) {
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_INDETERMINATE;
-	}
-}
+	uint64_t dsisr = regs->dsisr;
+	int i;
+
+	*addr = 0;
+
+	for (i = 0; table[i].dsisr_value; i++) {
+		if (!(dsisr & table[i].dsisr_value))
+			continue;
+
+		mce_err->error_type = table[i].error_type;
+		switch (table[i].error_type) {
+		case MCE_ERROR_TYPE_UE:
+			mce_err->u.ue_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_SLB:
+			mce_err->u.slb_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_ERAT:
+			mce_err->u.erat_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_TLB:
+			mce_err->u.tlb_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_USER:
+			mce_err->u.user_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_RA:
+			mce_err->u.ra_error_type = table[i].error_subtype;
+			break;
+		case MCE_ERROR_TYPE_LINK:
+			mce_err->u.link_error_type = table[i].error_subtype;
+			break;
+		}
+		mce_err->severity = table[i].severity;
+		mce_err->initiator = table[i].initiator;
+		if (table[i].dar_valid)
+			*addr = regs->dar;
+		else
+			*addr = regs->nip;
 
-static void mce_get_derror_p7(struct mce_error_info *mce_err, uint64_t dsisr)
-{
-	if (dsisr & P7_DSISR_MC_UE) {
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type = MCE_UE_ERROR_LOAD_STORE;
-	} else if (dsisr & P7_DSISR_MC_UE_TABLEWALK) {
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type =
-				MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE;
-	} else if (dsisr & P7_DSISR_MC_ERAT_MULTIHIT) {
-		mce_err->error_type = MCE_ERROR_TYPE_ERAT;
-		mce_err->u.erat_error_type = MCE_ERAT_ERROR_MULTIHIT;
-	} else if (dsisr & P7_DSISR_MC_SLB_MULTIHIT) {
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_MULTIHIT;
-	} else if (dsisr & P7_DSISR_MC_SLB_PARITY_MFSLB) {
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_PARITY;
-	} else if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
-		mce_err->error_type = MCE_ERROR_TYPE_TLB;
-		mce_err->u.tlb_error_type = MCE_TLB_ERROR_MULTIHIT;
-	} else if (dsisr & P7_DSISR_MC_SLB_MULTIHIT_PARITY) {
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_INDETERMINATE;
+		return;
 	}
+
+	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
+	mce_err->severity = MCE_SEV_ERROR_SYNC;
+	mce_err->initiator = MCE_INITIATOR_CPU;
 }
 
 static long mce_handle_ue_error(struct pt_regs *regs)
@@ -358,18 +571,41 @@ static long mce_handle_ue_error(struct pt_regs *regs)
 	return handled;
 }
 
+static long mce_handle_derror_p7(uint64_t dsisr)
+{
+	return mce_handle_flush_derrors(dsisr,
+			P7_DSISR_MC_SLB_ERRORS,
+			P7_DSISR_MC_TLB_MULTIHIT_MFTLB,
+			0);
+}
+
+static long mce_handle_ierror_p7(uint64_t srr1)
+{
+	switch (P7_SRR1_MC_IFETCH(srr1)) {
+	case P7_SRR1_MC_IFETCH_SLB_PARITY:
+	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
+	case P7_SRR1_MC_IFETCH_SLB_BOTH:
+		return mce_flush(MCE_FLUSH_SLB);
+
+	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
+		return mce_flush(MCE_FLUSH_TLB);
+	default:
+		return 0;
+	}
+}
+
 long __machine_check_early_realmode_p7(struct pt_regs *regs)
 {
 	uint64_t srr1, nip, addr;
 	long handled = 1;
 	struct mce_error_info mce_error_info = { 0 };
 
-	mce_error_info.severity = MCE_SEV_ERROR_SYNC;
-	mce_error_info.initiator = MCE_INITIATOR_CPU;
-
 	srr1 = regs->msr;
 	nip = regs->nip;
 
+	/* P7 DD1 leaves top bits of DSISR undefined */
+	regs->dsisr &= 0x0000ffff;
+
 	/*
 	 * Handle memory errors depending whether this was a load/store or
 	 * ifetch exception. Also, populate the mce error_type and
@@ -378,12 +614,12 @@ long __machine_check_early_realmode_p7(struct pt_regs *regs)
 	 */
 	if (P7_SRR1_MC_LOADSTORE(srr1)) {
 		handled = mce_handle_derror_p7(regs->dsisr);
-		mce_get_derror_p7(&mce_error_info, regs->dsisr);
-		addr = regs->dar;
+		mce_get_derror(regs, mce_p7_derror_table,
+				&mce_error_info, &addr);
 	} else {
 		handled = mce_handle_ierror_p7(srr1);
-		mce_get_ierror_p7(&mce_error_info, srr1);
-		addr = regs->nip;
+		mce_get_ierror(regs, mce_p7_ierror_table,
+				&mce_error_info, &addr);
 	}
 
 	/* Handle UE error. */
@@ -394,24 +630,6 @@ long __machine_check_early_realmode_p7(struct pt_regs *regs)
 	return handled;
 }
 
-static void mce_get_ierror_p8(struct mce_error_info *mce_err, uint64_t srr1)
-{
-	mce_get_common_ierror(mce_err, srr1);
-	if (P7_SRR1_MC_IFETCH(srr1) == P8_SRR1_MC_IFETCH_ERAT_MULTIHIT) {
-		mce_err->error_type = MCE_ERROR_TYPE_ERAT;
-		mce_err->u.erat_error_type = MCE_ERAT_ERROR_MULTIHIT;
-	}
-}
-
-static void mce_get_derror_p8(struct mce_error_info *mce_err, uint64_t dsisr)
-{
-	mce_get_derror_p7(mce_err, dsisr);
-	if (dsisr & P8_DSISR_MC_ERAT_MULTIHIT_SEC) {
-		mce_err->error_type = MCE_ERROR_TYPE_ERAT;
-		mce_err->u.erat_error_type = MCE_ERAT_ERROR_MULTIHIT;
-	}
-}
-
 static long mce_handle_ierror_p8(uint64_t srr1)
 {
 	switch (P7_SRR1_MC_IFETCH(srr1)) {
@@ -441,20 +659,17 @@ long __machine_check_early_realmode_p8(struct pt_regs *regs)
 	long handled = 1;
 	struct mce_error_info mce_error_info = { 0 };
 
-	mce_error_info.severity = MCE_SEV_ERROR_SYNC;
-	mce_error_info.initiator = MCE_INITIATOR_CPU;
-
 	srr1 = regs->msr;
 	nip = regs->nip;
 
 	if (P7_SRR1_MC_LOADSTORE(srr1)) {
 		handled = mce_handle_derror_p8(regs->dsisr);
-		mce_get_derror_p8(&mce_error_info, regs->dsisr);
-		addr = regs->dar;
+		mce_get_derror(regs, mce_p8_derror_table,
+				&mce_error_info, &addr);
 	} else {
 		handled = mce_handle_ierror_p8(srr1);
-		mce_get_ierror_p8(&mce_error_info, srr1);
-		addr = regs->nip;
+		mce_get_ierror(regs, mce_p8_ierror_table,
+				&mce_error_info, &addr);
 	}
 
 	/* Handle UE error. */
@@ -495,138 +710,6 @@ static int mce_handle_ierror_p9(struct pt_regs *regs)
 	}
 }
 
-static void mce_get_derror_p9(struct pt_regs *regs,
-		struct mce_error_info *mce_err, uint64_t *addr)
-{
-	uint64_t dsisr = regs->dsisr;
-
-	mce_err->severity = MCE_SEV_ERROR_SYNC;
-	mce_err->initiator = MCE_INITIATOR_CPU;
-
-	if (dsisr & P9_DSISR_MC_USER_TLBIE)
-		*addr = regs->nip;
-	else
-		*addr = regs->dar;
-
-	if (dsisr & P9_DSISR_MC_UE) {
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type = MCE_UE_ERROR_LOAD_STORE;
-	} else if (dsisr & P9_DSISR_MC_UE_TABLEWALK) {
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type = MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE;
-	} else if (dsisr & P9_DSISR_MC_LINK_LOAD_TIMEOUT) {
-		mce_err->error_type = MCE_ERROR_TYPE_LINK;
-		mce_err->u.link_error_type = MCE_LINK_ERROR_LOAD_TIMEOUT;
-	} else if (dsisr & P9_DSISR_MC_LINK_TABLEWALK_TIMEOUT) {
-		mce_err->error_type = MCE_ERROR_TYPE_LINK;
-		mce_err->u.link_error_type = MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT;
-	} else if (dsisr & P9_DSISR_MC_ERAT_MULTIHIT) {
-		mce_err->error_type = MCE_ERROR_TYPE_ERAT;
-		mce_err->u.erat_error_type = MCE_ERAT_ERROR_MULTIHIT;
-	} else if (dsisr & P9_DSISR_MC_TLB_MULTIHIT_MFTLB) {
-		mce_err->error_type = MCE_ERROR_TYPE_TLB;
-		mce_err->u.tlb_error_type = MCE_TLB_ERROR_MULTIHIT;
-	} else if (dsisr & P9_DSISR_MC_USER_TLBIE) {
-		mce_err->error_type = MCE_ERROR_TYPE_USER;
-		mce_err->u.user_error_type = MCE_USER_ERROR_TLBIE;
-	} else if (dsisr & P9_DSISR_MC_SLB_PARITY_MFSLB) {
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_PARITY;
-	} else if (dsisr & P9_DSISR_MC_SLB_MULTIHIT_MFSLB) {
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_MULTIHIT;
-	} else if (dsisr & P9_DSISR_MC_RA_LOAD) {
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_LOAD;
-	} else if (dsisr & P9_DSISR_MC_RA_TABLEWALK) {
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE;
-	} else if (dsisr & P9_DSISR_MC_RA_TABLEWALK_FOREIGN) {
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN;
-	} else if (dsisr & P9_DSISR_MC_RA_FOREIGN) {
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_LOAD_STORE_FOREIGN;
-	}
-}
-
-static void mce_get_ierror_p9(struct pt_regs *regs,
-		struct mce_error_info *mce_err, uint64_t *addr)
-{
-	uint64_t srr1 = regs->msr;
-
-	switch (P9_SRR1_MC_IFETCH(srr1)) {
-	case P9_SRR1_MC_IFETCH_RA_ASYNC_STORE:
-	case P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT:
-		mce_err->severity = MCE_SEV_FATAL;
-		break;
-	default:
-		mce_err->severity = MCE_SEV_ERROR_SYNC;
-		break;
-	}
-
-	mce_err->initiator = MCE_INITIATOR_CPU;
-
-	*addr = regs->nip;
-
-	switch (P9_SRR1_MC_IFETCH(srr1)) {
-	case P9_SRR1_MC_IFETCH_UE:
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type = MCE_UE_ERROR_IFETCH;
-		break;
-	case P9_SRR1_MC_IFETCH_SLB_PARITY:
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_PARITY;
-		break;
-	case P9_SRR1_MC_IFETCH_SLB_MULTIHIT:
-		mce_err->error_type = MCE_ERROR_TYPE_SLB;
-		mce_err->u.slb_error_type = MCE_SLB_ERROR_MULTIHIT;
-		break;
-	case P9_SRR1_MC_IFETCH_ERAT_MULTIHIT:
-		mce_err->error_type = MCE_ERROR_TYPE_ERAT;
-		mce_err->u.erat_error_type = MCE_ERAT_ERROR_MULTIHIT;
-		break;
-	case P9_SRR1_MC_IFETCH_TLB_MULTIHIT:
-		mce_err->error_type = MCE_ERROR_TYPE_TLB;
-		mce_err->u.tlb_error_type = MCE_TLB_ERROR_MULTIHIT;
-		break;
-	case P9_SRR1_MC_IFETCH_UE_TLB_RELOAD:
-		mce_err->error_type = MCE_ERROR_TYPE_UE;
-		mce_err->u.ue_error_type = MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH;
-		break;
-	case P9_SRR1_MC_IFETCH_LINK_TIMEOUT:
-		mce_err->error_type = MCE_ERROR_TYPE_LINK;
-		mce_err->u.link_error_type = MCE_LINK_ERROR_IFETCH_TIMEOUT;
-		break;
-	case P9_SRR1_MC_IFETCH_LINK_TABLEWALK_TIMEOUT:
-		mce_err->error_type = MCE_ERROR_TYPE_LINK;
-		mce_err->u.link_error_type = MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT;
-		break;
-	case P9_SRR1_MC_IFETCH_RA:
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_IFETCH;
-		break;
-	case P9_SRR1_MC_IFETCH_RA_TABLEWALK:
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH;
-		break;
-	case P9_SRR1_MC_IFETCH_RA_ASYNC_STORE:
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_STORE;
-		break;
-	case P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT:
-		mce_err->error_type = MCE_ERROR_TYPE_LINK;
-		mce_err->u.link_error_type = MCE_LINK_ERROR_STORE_TIMEOUT;
-		break;
-	case P9_SRR1_MC_IFETCH_RA_TABLEWALK_FOREIGN:
-		mce_err->error_type = MCE_ERROR_TYPE_RA;
-		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN;
-		break;
-	default:
-		break;
-	}
-}
-
 long __machine_check_early_realmode_p9(struct pt_regs *regs)
 {
 	uint64_t nip, addr;
@@ -637,10 +720,12 @@ long __machine_check_early_realmode_p9(struct pt_regs *regs)
 
 	if (P9_SRR1_MC_LOADSTORE(regs->msr)) {
 		handled = mce_handle_derror_p9(regs);
-		mce_get_derror_p9(regs, &mce_error_info, &addr);
+		mce_get_derror(regs, mce_p9_derror_table,
+				&mce_error_info, &addr);
 	} else {
 		handled = mce_handle_ierror_p9(regs);
-		mce_get_ierror_p9(regs, &mce_error_info, &addr);
+		mce_get_ierror(regs, mce_p9_ierror_table,
+				&mce_error_info, &addr);
 	}
 
 	/* Handle UE error. */
-- 
2.11.0
