Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 3/4] powerpc: Save the TAR register earlier
Date: Thu,  8 Aug 2013 12:33:56 +1000
Message-Id: <1375929237-19944-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1375929237-19944-1-git-send-email-mikey@neuling.org>
References: <1375929237-19944-1-git-send-email-mikey@neuling.org>
In-Reply-To: <25550.1375872955@ale.ozlabs.ibm.com>
References: <25550.1375872955@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves us to use the save_tar() function to save the Target Address
Register (TAR) a lot earlier in __switch_to.

We need to save the TAR earlier as we may overwrite it in the transactional
memory reclaim/recheckpoint path.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org>
---
 arch/powerpc/kernel/entry_64.S | 9 ---------
 arch/powerpc/kernel/process.c  | 5 +++++
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index cfb6de4..08f2e2e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -448,15 +448,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
 
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
index c517dbe..4ef77df 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -600,6 +600,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	struct ppc64_tlb_batch *batch;
 #endif
 
+	/* Save the tar before we do treclaim/trecheckpoint as these
+	 * will change the TAR
+	 */
+	save_tar(&prev->thread);
+
 	__switch_to_tm(prev);
 
 #ifdef CONFIG_SMP
-- 
1.8.1.2
