Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXMHw0hrxzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 13:01:16 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id j5so3023290pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 18:01:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/64s: POWER9 machine check handler
Date: Tue, 28 Feb 2017 12:00:48 +1000
Message-Id: <20170228020048.8862-4-npiggin@gmail.com>
In-Reply-To: <20170228020048.8862-1-npiggin@gmail.com>
References: <20170228020048.8862-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add POWER9 machine check handler. There are several new types of errors
added, so logging messages for those are also added.

This doesn't attempt to reuse any of the P7/8 defines or functions,
because that becomes too complex. The better option in future is to use
a table driven approach.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/bitops.h |   4 +
 arch/powerpc/include/asm/mce.h    | 105 +++++++++++++++++
 arch/powerpc/kernel/cputable.c    |   3 +
 arch/powerpc/kernel/mce.c         |  83 ++++++++++++++
 arch/powerpc/kernel/mce_power.c   | 231 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 426 insertions(+)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 59abc620f8e8..5f057c74bf21 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -51,6 +51,10 @@
 #define PPC_BIT(bit)		(1UL << PPC_BITLSHIFT(bit))
 #define PPC_BITMASK(bs, be)	((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
 
+/* Put a PPC bit into a "normal" bit position */
+#define PPC_BITEXTRACT(bits, ppc_bit, dst_bit)			\
+	((((bits) >> PPC_BITLSHIFT(ppc_bit)) & 1) << (dst_bit))
+
 #include <asm/barrier.h>
 
 /* Macro for generating the ***_bits() functions */
diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index b2a5865ccd87..ed62efe01e49 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -66,6 +66,55 @@
 
 #define P8_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_SLB_ERRORS | \
 					 P8_DSISR_MC_ERAT_MULTIHIT_SEC)
+
+/*
+ * Machine Check bits on power9
+ */
+#define P9_SRR1_MC_LOADSTORE(srr1)	(((srr1) >> PPC_BITLSHIFT(42)) & 1)
+
+#define P9_SRR1_MC_IFETCH(srr1)	(	\
+	PPC_BITEXTRACT(srr1, 45, 0) |	\
+	PPC_BITEXTRACT(srr1, 44, 1) |	\
+	PPC_BITEXTRACT(srr1, 43, 2) |	\
+	PPC_BITEXTRACT(srr1, 36, 3) )
+
+/* 0 is reserved */
+#define P9_SRR1_MC_IFETCH_UE				1
+#define P9_SRR1_MC_IFETCH_SLB_PARITY			2
+#define P9_SRR1_MC_IFETCH_SLB_MULTIHIT			3
+#define P9_SRR1_MC_IFETCH_ERAT_MULTIHIT			4
+#define P9_SRR1_MC_IFETCH_TLB_MULTIHIT			5
+#define P9_SRR1_MC_IFETCH_UE_TLB_RELOAD			6
+/* 7 is reserved */
+#define P9_SRR1_MC_IFETCH_LINK_TIMEOUT			8
+#define P9_SRR1_MC_IFETCH_LINK_TABLEWALK_TIMEOUT	9
+/* 10 ? */
+#define P9_SRR1_MC_IFETCH_RA			11
+#define P9_SRR1_MC_IFETCH_RA_TABLEWALK		12
+#define P9_SRR1_MC_IFETCH_RA_ASYNC_STORE		13
+#define P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT	14
+#define P9_SRR1_MC_IFETCH_RA_TABLEWALK_FOREIGN	15
+
+/* DSISR bits for machine check (On Power9) */
+#define P9_DSISR_MC_UE					(PPC_BIT(48))
+#define P9_DSISR_MC_UE_TABLEWALK			(PPC_BIT(49))
+#define P9_DSISR_MC_LINK_LOAD_TIMEOUT			(PPC_BIT(50))
+#define P9_DSISR_MC_LINK_TABLEWALK_TIMEOUT		(PPC_BIT(51))
+#define P9_DSISR_MC_ERAT_MULTIHIT			(PPC_BIT(52))
+#define P9_DSISR_MC_TLB_MULTIHIT_MFTLB			(PPC_BIT(53))
+#define P9_DSISR_MC_USER_TLBIE				(PPC_BIT(54))
+#define P9_DSISR_MC_SLB_PARITY_MFSLB			(PPC_BIT(55))
+#define P9_DSISR_MC_SLB_MULTIHIT_MFSLB			(PPC_BIT(56))
+#define P9_DSISR_MC_RA_LOAD				(PPC_BIT(57))
+#define P9_DSISR_MC_RA_TABLEWALK			(PPC_BIT(58))
+#define P9_DSISR_MC_RA_TABLEWALK_FOREIGN		(PPC_BIT(59))
+#define P9_DSISR_MC_RA_FOREIGN				(PPC_BIT(60))
+
+/* SLB error bits */
+#define P9_DSISR_MC_SLB_ERRORS		(P9_DSISR_MC_ERAT_MULTIHIT | \
+					 P9_DSISR_MC_SLB_PARITY_MFSLB | \
+					 P9_DSISR_MC_SLB_MULTIHIT_MFSLB)
+
 enum MCE_Version {
 	MCE_V1 = 1,
 };
@@ -93,6 +142,9 @@ enum MCE_ErrorType {
 	MCE_ERROR_TYPE_SLB = 2,
 	MCE_ERROR_TYPE_ERAT = 3,
 	MCE_ERROR_TYPE_TLB = 4,
+	MCE_ERROR_TYPE_USER = 5,
+	MCE_ERROR_TYPE_RA = 6,
+	MCE_ERROR_TYPE_LINK = 7,
 };
 
 enum MCE_UeErrorType {
@@ -121,6 +173,32 @@ enum MCE_TlbErrorType {
 	MCE_TLB_ERROR_MULTIHIT = 2,
 };
 
+enum MCE_UserErrorType {
+	MCE_USER_ERROR_INDETERMINATE = 0,
+	MCE_USER_ERROR_TLBIE = 1,
+};
+
+enum MCE_RaErrorType {
+	MCE_RA_ERROR_INDETERMINATE = 0,
+	MCE_RA_ERROR_IFETCH = 1,
+	MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH = 2,
+	MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN = 3,
+	MCE_RA_ERROR_LOAD = 4,
+	MCE_RA_ERROR_STORE = 5,
+	MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 6,
+	MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN = 7,
+	MCE_RA_ERROR_LOAD_STORE_FOREIGN = 8,
+};
+
+enum MCE_LinkErrorType {
+	MCE_LINK_ERROR_INDETERMINATE = 0,
+	MCE_LINK_ERROR_IFETCH_TIMEOUT = 1,
+	MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT = 2,
+	MCE_LINK_ERROR_LOAD_TIMEOUT = 3,
+	MCE_LINK_ERROR_STORE_TIMEOUT = 4,
+	MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT = 5,
+};
+
 struct machine_check_event {
 	enum MCE_Version	version:8;	/* 0x00 */
 	uint8_t			in_use;		/* 0x01 */
@@ -166,6 +244,30 @@ struct machine_check_event {
 			uint64_t	effective_address;
 			uint8_t		reserved_2[16];
 		} tlb_error;
+
+		struct {
+			enum MCE_UserErrorType user_error_type:8;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} user_error;
+
+		struct {
+			enum MCE_RaErrorType ra_error_type:8;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} ra_error;
+
+		struct {
+			enum MCE_LinkErrorType link_error_type:8;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} link_error;
 	} u;
 };
 
@@ -176,6 +278,9 @@ struct mce_error_info {
 		enum MCE_SlbErrorType slb_error_type:8;
 		enum MCE_EratErrorType erat_error_type:8;
 		enum MCE_TlbErrorType tlb_error_type:8;
+		enum MCE_UserErrorType user_error_type:8;
+		enum MCE_RaErrorType ra_error_type:8;
+		enum MCE_LinkErrorType link_error_type:8;
 	} u;
 	enum MCE_Severity	severity:8;
 	enum MCE_Initiator	initiator:8;
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6a82ef039c50..5feefdacaea8 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -77,6 +77,7 @@ extern void __flush_tlb_power8(unsigned int action);
 extern void __flush_tlb_power9(unsigned int action);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
+extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
@@ -523,6 +524,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
 		.flush_tlb		= __flush_tlb_power9,
+		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
 	{	/* Power9 */
@@ -542,6 +544,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
 		.flush_tlb		= __flush_tlb_power9,
+		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
 	{	/* Cell Broadband Engine */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 949507277436..a1475e6aef3a 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -58,6 +58,15 @@ static void mce_set_error_info(struct machine_check_event *mce,
 	case MCE_ERROR_TYPE_TLB:
 		mce->u.tlb_error.tlb_error_type = mce_err->u.tlb_error_type;
 		break;
+	case MCE_ERROR_TYPE_USER:
+		mce->u.user_error.user_error_type = mce_err->u.user_error_type;
+		break;
+	case MCE_ERROR_TYPE_RA:
+		mce->u.ra_error.ra_error_type = mce_err->u.ra_error_type;
+		break;
+	case MCE_ERROR_TYPE_LINK:
+		mce->u.link_error.link_error_type = mce_err->u.link_error_type;
+		break;
 	case MCE_ERROR_TYPE_UNKNOWN:
 	default:
 		break;
@@ -116,6 +125,15 @@ void save_mce_event(struct pt_regs *regs, long handled,
 	} else if (mce->error_type == MCE_ERROR_TYPE_ERAT) {
 		mce->u.erat_error.effective_address_provided = true;
 		mce->u.erat_error.effective_address = addr;
+	} else if (mce->error_type == MCE_ERROR_TYPE_USER) {
+		mce->u.user_error.effective_address_provided = true;
+		mce->u.user_error.effective_address = addr;
+	} else if (mce->error_type == MCE_ERROR_TYPE_RA) {
+		mce->u.ra_error.effective_address_provided = true;
+		mce->u.ra_error.effective_address = addr;
+	} else if (mce->error_type == MCE_ERROR_TYPE_LINK) {
+		mce->u.link_error.effective_address_provided = true;
+		mce->u.link_error.effective_address = addr;
 	} else if (mce->error_type == MCE_ERROR_TYPE_UE) {
 		mce->u.ue_error.effective_address_provided = true;
 		mce->u.ue_error.effective_address = addr;
@@ -240,6 +258,29 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 		"Parity",
 		"Multihit",
 	};
+	static const char *mc_user_types[] = {
+		"Indeterminate",
+		"tlbie(l) invalid",
+	};
+	static const char *mc_ra_types[] = {
+		"Indeterminate",
+		"Instruction fetch (bad)",
+		"Page table walk ifetch (bad)",
+		"Page table walk ifetch (foreign)",
+		"Load (bad)",
+		"Store (bad)",
+		"Page table walk Load/Store (bad)",
+		"Page table walk Load/Store (foreign)",
+		"Load/Store (foreign)",
+	};
+	static const char *mc_link_types[] = {
+		"Indeterminate",
+		"Instruction fetch (timeout)",
+		"Page table walk ifetch (timeout)",
+		"Load (timeout)",
+		"Store (timeout)",
+		"Page table walk Load/Store (timeout)",
+	};
 
 	/* Print things out */
 	if (evt->version != MCE_V1) {
@@ -316,6 +357,36 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 			printk("%s    Effective address: %016llx\n",
 			       level, evt->u.tlb_error.effective_address);
 		break;
+	case MCE_ERROR_TYPE_USER:
+		subtype = evt->u.user_error.user_error_type <
+			ARRAY_SIZE(mc_user_types) ?
+			mc_user_types[evt->u.user_error.user_error_type]
+			: "Unknown";
+		printk("%s  Error type: User [%s]\n", level, subtype);
+		if (evt->u.user_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.user_error.effective_address);
+		break;
+	case MCE_ERROR_TYPE_RA:
+		subtype = evt->u.ra_error.ra_error_type <
+			ARRAY_SIZE(mc_ra_types) ?
+			mc_ra_types[evt->u.ra_error.ra_error_type]
+			: "Unknown";
+		printk("%s  Error type: Real address [%s]\n", level, subtype);
+		if (evt->u.ra_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.ra_error.effective_address);
+		break;
+	case MCE_ERROR_TYPE_LINK:
+		subtype = evt->u.link_error.link_error_type <
+			ARRAY_SIZE(mc_link_types) ?
+			mc_link_types[evt->u.link_error.link_error_type]
+			: "Unknown";
+		printk("%s  Error type: Link [%s]\n", level, subtype);
+		if (evt->u.link_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.link_error.effective_address);
+		break;
 	default:
 	case MCE_ERROR_TYPE_UNKNOWN:
 		printk("%s  Error type: Unknown\n", level);
@@ -342,6 +413,18 @@ uint64_t get_mce_fault_addr(struct machine_check_event *evt)
 		if (evt->u.tlb_error.effective_address_provided)
 			return evt->u.tlb_error.effective_address;
 		break;
+	case MCE_ERROR_TYPE_USER:
+		if (evt->u.user_error.effective_address_provided)
+			return evt->u.user_error.effective_address;
+		break;
+	case MCE_ERROR_TYPE_RA:
+		if (evt->u.ra_error.effective_address_provided)
+			return evt->u.ra_error.effective_address;
+		break;
+	case MCE_ERROR_TYPE_LINK:
+		if (evt->u.link_error.effective_address_provided)
+			return evt->u.link_error.effective_address;
+		break;
 	default:
 	case MCE_ERROR_TYPE_UNKNOWN:
 		break;
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index c37fc5fdd433..763d6f58caa8 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -116,6 +116,51 @@ static void flush_and_reload_slb(void)
 }
 #endif
 
+static void flush_erat(void)
+{
+	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
+}
+
+#define MCE_FLUSH_SLB 1
+#define MCE_FLUSH_TLB 2
+#define MCE_FLUSH_ERAT 3
+
+static int mce_flush(int what)
+{
+#ifdef CONFIG_PPC_STD_MMU_64
+	if (what == MCE_FLUSH_SLB) {
+		flush_and_reload_slb();
+		return 1;
+	}
+#endif
+	if (what == MCE_FLUSH_ERAT) {
+		flush_erat();
+		return 1;
+	}
+	if (what == MCE_FLUSH_TLB) {
+		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
+			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int mce_handle_flush_derrors(uint64_t dsisr, uint64_t slb, uint64_t tlb, uint64_t erat)
+{
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
+}
+
 static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 {
 	long handled = 1;
@@ -378,3 +423,189 @@ long __machine_check_early_realmode_p8(struct pt_regs *regs)
 	save_mce_event(regs, handled, &mce_error_info, nip, addr);
 	return handled;
 }
+
+static int mce_handle_derror_p9(struct pt_regs *regs)
+{
+	uint64_t dsisr = regs->dsisr;
+
+	return mce_handle_flush_derrors(dsisr,
+			P9_DSISR_MC_SLB_PARITY_MFSLB |
+			P9_DSISR_MC_SLB_MULTIHIT_MFSLB,
+
+			P9_DSISR_MC_TLB_MULTIHIT_MFTLB,
+
+			P9_DSISR_MC_ERAT_MULTIHIT);
+}
+
+static int mce_handle_ierror_p9(struct pt_regs *regs)
+{
+	uint64_t srr1 = regs->msr;
+
+	switch (P9_SRR1_MC_IFETCH(srr1)) {
+	case P9_SRR1_MC_IFETCH_SLB_PARITY:
+	case P9_SRR1_MC_IFETCH_SLB_MULTIHIT:
+		return mce_flush(MCE_FLUSH_SLB);
+	case P9_SRR1_MC_IFETCH_TLB_MULTIHIT:
+		return mce_flush(MCE_FLUSH_TLB);
+	case P9_SRR1_MC_IFETCH_ERAT_MULTIHIT:
+		return mce_flush(MCE_FLUSH_ERAT);
+	default:
+		return 0;
+	}
+}
+
+static void mce_get_derror_p9(struct pt_regs *regs,
+		struct mce_error_info *mce_err, uint64_t *addr)
+{
+	uint64_t dsisr = regs->dsisr;
+
+	mce_err->severity = MCE_SEV_ERROR_SYNC;
+	mce_err->initiator = MCE_INITIATOR_CPU;
+
+	if (dsisr & P9_DSISR_MC_USER_TLBIE)
+		*addr = regs->nip;
+	else
+		*addr = regs->dar;
+
+	if (dsisr & P9_DSISR_MC_UE) {
+		mce_err->error_type = MCE_ERROR_TYPE_UE;
+		mce_err->u.ue_error_type = MCE_UE_ERROR_LOAD_STORE;
+	} else if (dsisr & P9_DSISR_MC_UE_TABLEWALK) {
+		mce_err->error_type = MCE_ERROR_TYPE_UE;
+		mce_err->u.ue_error_type = MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE;
+	} else if (dsisr & P9_DSISR_MC_LINK_LOAD_TIMEOUT) {
+		mce_err->error_type = MCE_ERROR_TYPE_LINK;
+		mce_err->u.link_error_type = MCE_LINK_ERROR_LOAD_TIMEOUT;
+	} else if (dsisr & P9_DSISR_MC_LINK_TABLEWALK_TIMEOUT) {
+		mce_err->error_type = MCE_ERROR_TYPE_LINK;
+		mce_err->u.link_error_type = MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT;
+	} else if (dsisr & P9_DSISR_MC_ERAT_MULTIHIT) {
+		mce_err->error_type = MCE_ERROR_TYPE_ERAT;
+		mce_err->u.erat_error_type = MCE_ERAT_ERROR_MULTIHIT;
+	} else if (dsisr & P9_DSISR_MC_TLB_MULTIHIT_MFTLB) {
+		mce_err->error_type = MCE_ERROR_TYPE_TLB;
+		mce_err->u.tlb_error_type = MCE_TLB_ERROR_MULTIHIT;
+	} else if (dsisr & P9_DSISR_MC_USER_TLBIE) {
+		mce_err->error_type = MCE_ERROR_TYPE_USER;
+		mce_err->u.user_error_type = MCE_USER_ERROR_TLBIE;
+	} else if (dsisr & P9_DSISR_MC_SLB_PARITY_MFSLB) {
+		mce_err->error_type = MCE_ERROR_TYPE_SLB;
+		mce_err->u.slb_error_type = MCE_SLB_ERROR_PARITY;
+	} else if (dsisr & P9_DSISR_MC_SLB_MULTIHIT_MFSLB) {
+		mce_err->error_type = MCE_ERROR_TYPE_SLB;
+		mce_err->u.slb_error_type = MCE_SLB_ERROR_MULTIHIT;
+	} else if (dsisr & P9_DSISR_MC_RA_LOAD) {
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_LOAD;
+	} else if (dsisr & P9_DSISR_MC_RA_TABLEWALK) {
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE;
+	} else if (dsisr & P9_DSISR_MC_RA_TABLEWALK_FOREIGN) {
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN;
+	} else if (dsisr & P9_DSISR_MC_RA_FOREIGN) {
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_LOAD_STORE_FOREIGN;
+	}
+}
+
+static void mce_get_ierror_p9(struct pt_regs *regs,
+		struct mce_error_info *mce_err, uint64_t *addr)
+{
+	uint64_t srr1 = regs->msr;
+
+	switch (P9_SRR1_MC_IFETCH(srr1)) {
+	case P9_SRR1_MC_IFETCH_RA_ASYNC_STORE:
+	case P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT:
+		mce_err->severity = MCE_SEV_FATAL;
+		break;
+	default:
+		mce_err->severity = MCE_SEV_ERROR_SYNC;
+		break;
+	}
+
+	mce_err->initiator = MCE_INITIATOR_CPU;
+
+	*addr = regs->nip;
+
+	switch (P9_SRR1_MC_IFETCH(srr1)) {
+	case P9_SRR1_MC_IFETCH_UE:
+		mce_err->error_type = MCE_ERROR_TYPE_UE;
+		mce_err->u.ue_error_type = MCE_UE_ERROR_IFETCH;
+		break;
+	case P9_SRR1_MC_IFETCH_SLB_PARITY:
+		mce_err->error_type = MCE_ERROR_TYPE_SLB;
+		mce_err->u.slb_error_type = MCE_SLB_ERROR_PARITY;
+		break;
+	case P9_SRR1_MC_IFETCH_SLB_MULTIHIT:
+		mce_err->error_type = MCE_ERROR_TYPE_SLB;
+		mce_err->u.slb_error_type = MCE_SLB_ERROR_MULTIHIT;
+		break;
+	case P9_SRR1_MC_IFETCH_ERAT_MULTIHIT:
+		mce_err->error_type = MCE_ERROR_TYPE_ERAT;
+		mce_err->u.erat_error_type = MCE_ERAT_ERROR_MULTIHIT;
+		break;
+	case P9_SRR1_MC_IFETCH_TLB_MULTIHIT:
+		mce_err->error_type = MCE_ERROR_TYPE_TLB;
+		mce_err->u.tlb_error_type = MCE_TLB_ERROR_MULTIHIT;
+		break;
+	case P9_SRR1_MC_IFETCH_UE_TLB_RELOAD:
+		mce_err->error_type = MCE_ERROR_TYPE_UE;
+		mce_err->u.ue_error_type = MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH;
+		break;
+	case P9_SRR1_MC_IFETCH_LINK_TIMEOUT:
+		mce_err->error_type = MCE_ERROR_TYPE_LINK;
+		mce_err->u.link_error_type = MCE_LINK_ERROR_IFETCH_TIMEOUT;
+		break;
+	case P9_SRR1_MC_IFETCH_LINK_TABLEWALK_TIMEOUT:
+		mce_err->error_type = MCE_ERROR_TYPE_LINK;
+		mce_err->u.link_error_type = MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT;
+		break;
+	case P9_SRR1_MC_IFETCH_RA:
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_IFETCH;
+		break;
+	case P9_SRR1_MC_IFETCH_RA_TABLEWALK:
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH;
+		break;
+	case P9_SRR1_MC_IFETCH_RA_ASYNC_STORE:
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_STORE;
+		break;
+	case P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT:
+		mce_err->error_type = MCE_ERROR_TYPE_LINK;
+		mce_err->u.link_error_type = MCE_LINK_ERROR_STORE_TIMEOUT;
+		break;
+	case P9_SRR1_MC_IFETCH_RA_TABLEWALK_FOREIGN:
+		mce_err->error_type = MCE_ERROR_TYPE_RA;
+		mce_err->u.ra_error_type = MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN;
+		break;
+	default:
+		break;
+	}
+}
+
+long __machine_check_early_realmode_p9(struct pt_regs *regs)
+{
+	uint64_t nip, addr;
+	long handled;
+	struct mce_error_info mce_error_info = { 0 };
+
+	nip = regs->nip;
+
+	if (P9_SRR1_MC_LOADSTORE(regs->msr)) {
+		handled = mce_handle_derror_p9(regs);
+		mce_get_derror_p9(regs, &mce_error_info, &addr);
+	} else {
+		handled = mce_handle_ierror_p9(regs);
+		mce_get_ierror_p9(regs, &mce_error_info, &addr);
+	}
+
+	/* Handle UE error. */
+	if (mce_error_info.error_type == MCE_ERROR_TYPE_UE)
+		handled = mce_handle_ue_error(regs);
+
+	save_mce_event(regs, handled, &mce_error_info, nip, addr);
+	return handled;
+}
-- 
2.11.0
