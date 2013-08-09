Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/5] powerpc: Save the TAR register earlier
Date: Fri,  9 Aug 2013 17:29:30 +1000
Message-Id: <1376033371-28713-4-git-send-email-mikey@neuling.org>
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

This moves us to save the Target Address Register (TAR) a earlier in
__switch_to.  It introduces a new function save_tar() to do this.

We need to save the TAR earlier as we will overwrite it in the transactional
memory reclaim/recheckpoint path.  We are going to do this in a subsequent
patch which will fix saving the TAR register when it's modified inside a
transaction.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> [v3.10]
---
 arch/powerpc/include/asm/switch_to.h |  9 +++++++++
 arch/powerpc/kernel/entry_64.S       |  9 ---------
 arch/powerpc/kernel/process.c        | 10 ++++++++++
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 49a13e0..294c2ce 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -15,6 +15,15 @@ extern struct task_struct *__switch_to(struct task_struct *,
 struct thread_struct;
 extern struct task_struct *_switch(struct thread_struct *prev,
 				   struct thread_struct *next);
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline void save_tar(struct thread_struct *prev)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		prev->tar = mfspr(SPRN_TAR);
+}
+#else
+static inline void save_tar(struct thread_struct *prev) {}
+#endif
 
 extern void giveup_fpu(struct task_struct *);
 extern void load_up_fpu(void);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 4674fe6..2bd0b88 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -449,15 +449,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 BEGIN_FTR_SECTION
-	/*
-	 * Back up the TAR across context switches.  Note that the TAR is not
-	 * available for use in the kernel.  (To provide this, the TAR should
-	 * be backed up/restored on exception entry/exit instead, and be in
-	 * pt_regs.  FIXME, this should be in pt_regs anyway (for debug).)
-	 */
-	mfspr	r0,SPRN_TAR
-	std	r0,THREAD_TAR(r3)
-
 	/* Event based branch registers */
 	mfspr	r0, SPRN_BESCR
 	std	r0, THREAD_BESCR(r3)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c517dbe..8083be2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -600,6 +600,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	struct ppc64_tlb_batch *batch;
 #endif
 
+	/* Back up the TAR across context switches.
+	 * Note that the TAR is not available for use in the kernel.  (To
+	 * provide this, the TAR should be backed up/restored on exception
+	 * entry/exit instead, and be in pt_regs.  FIXME, this should be in
+	 * pt_regs anyway (for debug).)
+	 * Save the TAR here before we do treclaim/trecheckpoint as these
+	 * will change the TAR.
+	 */
+	save_tar(&prev->thread);
+
 	__switch_to_tm(prev);
 
 #ifdef CONFIG_SMP
-- 
1.8.1.2
