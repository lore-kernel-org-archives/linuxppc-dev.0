Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/tm: Add checkpointed versions of some SPRs to
 thread_struct
Date: Wed,  7 Aug 2013 16:11:55 +1000
Message-Id: <1375855918-3625-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Transactional memory will restore the TAR, PPR and DSCR on transaction failure.

Add these to the thread_struct for use in the future

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org>
---
 arch/powerpc/include/asm/processor.h | 4 ++++
 arch/powerpc/kernel/asm-offsets.c    | 3 +++
 2 files changed, 7 insertions(+)

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
-- 
1.8.1.2
