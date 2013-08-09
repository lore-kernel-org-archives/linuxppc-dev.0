Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/tm: Fix context switching TAR, PPR and DSCR SPRs
Date: Fri,  9 Aug 2013 17:29:31 +1000
Message-Id: <1376033371-28713-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1376033371-28713-1-git-send-email-mikey@neuling.org>
References: <1376033371-28713-1-git-send-email-mikey@neuling.org>
In-Reply-To: <25550.1375872955@ale.ozlabs.ibm.com>
References: <25550.1375872955@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a transaction is rolled back, the Target Address Register (TAR), Processor
Priority Register (PPR) and Data Stream Control Register (DSCR) should be
restored to the checkpointed values before the transaction began.  Any changes
to these SPRs inside the transaction should not be visible in the abort
handler.

Currently Linux doesn't save or restore the checkpointed TAR, PPR or DSCR.  If
we preempt a processes inside a transaction which has modified any of these, on
process restore, that same transaction may be aborted we but we won't see the
checkpointed versions of these SPRs.

This adds checkpointed versions of these SPRs to the thread_struct and adds the
save/restore of these three SPRs to the treclaim/trechkpt code.

Without this if any of these SPRs are modified during a transaction, users may
incorrectly see a speculated SPR value even if the transaction is aborted.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> [v3.10]
---
 arch/powerpc/include/asm/processor.h |  4 ++++
 arch/powerpc/kernel/asm-offsets.c    |  3 +++
 arch/powerpc/kernel/tm.S             | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 47a35b0..e378ccc 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -247,6 +247,10 @@ struct thread_struct {
 	unsigned long	tm_orig_msr;	/* Thread's MSR on ctx switch */
 	struct pt_regs	ckpt_regs;	/* Checkpointed registers */
 
+	unsigned long	tm_tar;
+	unsigned long	tm_ppr;
+	unsigned long	tm_dscr;
+
 	/*
 	 * Transactional FP and VSX 0-31 register set.
 	 * NOTE: the sense of these is the opposite of the integer ckpt_regs!
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index c7e8afc..8207459 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -138,6 +138,9 @@ int main(void)
 	DEFINE(THREAD_TM_TFHAR, offsetof(struct thread_struct, tm_tfhar));
 	DEFINE(THREAD_TM_TEXASR, offsetof(struct thread_struct, tm_texasr));
 	DEFINE(THREAD_TM_TFIAR, offsetof(struct thread_struct, tm_tfiar));
+	DEFINE(THREAD_TM_TAR, offsetof(struct thread_struct, tm_tar));
+	DEFINE(THREAD_TM_PPR, offsetof(struct thread_struct, tm_ppr));
+	DEFINE(THREAD_TM_DSCR, offsetof(struct thread_struct, tm_dscr));
 	DEFINE(PT_CKPT_REGS, offsetof(struct thread_struct, ckpt_regs));
 	DEFINE(THREAD_TRANSACT_VR0, offsetof(struct thread_struct,
 					 transact_vr[0]));
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 51be8fb..0554d1f 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -233,6 +233,16 @@ dont_backup_fp:
 	std	r5, _CCR(r7)
 	std	r6, _XER(r7)
 
+
+	/* ******************** TAR, PPR, DSCR ********** */
+	mfspr	r3, SPRN_TAR
+	mfspr	r4, SPRN_PPR
+	mfspr	r5, SPRN_DSCR
+
+	std	r3, THREAD_TM_TAR(r12)
+	std	r4, THREAD_TM_PPR(r12)
+	std	r5, THREAD_TM_DSCR(r12)
+
 	/* MSR and flags:  We don't change CRs, and we don't need to alter
 	 * MSR.
 	 */
@@ -347,6 +357,16 @@ dont_restore_fp:
 	mtmsr	r6				/* FP/Vec off again! */
 
 restore_gprs:
+
+	/* ******************** TAR, PPR, DSCR ********** */
+	ld	r4, THREAD_TM_TAR(r3)
+	ld	r5, THREAD_TM_PPR(r3)
+	ld	r6, THREAD_TM_DSCR(r3)
+
+	mtspr	SPRN_TAR,	r4
+	mtspr	SPRN_PPR,	r5
+	mtspr	SPRN_DSCR,	r6
+
 	/* ******************** CR,LR,CCR,MSR ********** */
 	ld	r3, _CTR(r7)
 	ld	r4, _LINK(r7)
-- 
1.8.1.2
