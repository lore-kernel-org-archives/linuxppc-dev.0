Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/17] powerpc: Add additional state needed for transactional
 memory to thread struct
Date: Wed, 13 Feb 2013 15:31:21 +1100
Message-Id: <1360729895-304-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1360729895-304-1-git-send-email-mikey@neuling.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Set of new archtected state for saving away on context switch.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/processor.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 42ac53c..fc41ab3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -246,6 +246,34 @@ struct thread_struct {
 	unsigned long	spefscr;	/* SPE & eFP status */
 	int		used_spe;	/* set if process has used spe */
 #endif /* CONFIG_SPE */
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	u64		tm_tfhar;	/* Transaction fail handler addr */
+	u64		tm_texasr;	/* Transaction exception & summary */
+	u64		tm_tfiar;	/* Transaction fail instr address reg */
+	unsigned long	tm_orig_msr;	/* Thread's MSR on ctx switch */
+	struct pt_regs	ckpt_regs;	/* Checkpointed registers */
+
+	/*
+	 * Transactional FP and VSX 0-31 register set.
+	 * NOTE: the sense of these is the opposite of the integer ckpt_regs!
+	 *
+	 * When a transaction is active/signalled/scheduled etc., *regs is the
+	 * most recent set of/speculated GPRs with ckpt_regs being the older
+	 * checkpointed regs to which we roll back if transaction aborts.
+	 *
+	 * However, fpr[] is the checkpointed 'base state' of FP regs, and
+	 * transact_fpr[] is the new set of transactional values.
+	 * VRs work the same way.
+	 */
+	double		transact_fpr[32][TS_FPRWIDTH];
+	struct {
+		unsigned int pad;
+		unsigned int val;	/* Floating point status */
+	} transact_fpscr;
+	vector128	transact_vr[32] __attribute__((aligned(16)));
+	vector128	transact_vscr __attribute__((aligned(16)));
+	unsigned long	transact_vrsave;
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
 #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
-- 
1.7.10.4
