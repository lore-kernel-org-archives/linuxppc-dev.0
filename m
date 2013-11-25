Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/signals: Improved mark VSX not saved with small
 contexts fix
Date: Mon, 25 Nov 2013 11:12:20 +1100
Message-Id: <1385338340-6044-1-git-send-email-mikey@neuling.org>
Cc: Carlos O'Donell <carlos@redhat.com>, Steve Best <sbest@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Haren Myneni <haren@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a recent patch:
  commit c13f20ac48328b05cd3b8c19e31ed6c132b44b42
  Author: Michael Neuling <mikey@neuling.org>
  powerpc/signals: Mark VSX not saved with small contexts

We fixed an issue but an improved solution was later discussed after the patch
was merged.

Firstly, this patch doesn't handle the 64bit signals case, which could also hit
this issue (but has never been reported).

Secondly, the original patch isn't clear what MSR VSX should be set to.  The
new approach below always clears the MSR VSX bit (to indicate no VSX is in the
context) and sets it only in the specific case where VSX is available (ie. when
VSX has been used and the signal context passed has space to provide the
state).

This reverts the original patch and replaces it with the improved solution.  It
also adds a 64 bit version.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/signal_32.c | 16 +++++++---------
 arch/powerpc/kernel/signal_64.c |  6 ++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 1844298..68027bf 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -445,6 +445,12 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 #endif /* CONFIG_ALTIVEC */
 	if (copy_fpr_to_user(&frame->mc_fregs, current))
 		return 1;
+
+	/*
+	 * Clear the MSR VSX bit to indicate there is no valid state attached
+	 * to this context, except in the specific case below where we set it.
+	 */
+	msr &= ~MSR_VSX;
 #ifdef CONFIG_VSX
 	/*
 	 * Copy VSR 0-31 upper half from thread_struct to local
@@ -457,15 +463,7 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		msr |= MSR_VSX;
-	} else if (!ctx_has_vsx_region)
-		/*
-		 * With a small context structure we can't hold the VSX
-		 * registers, hence clear the MSR value to indicate the state
-		 * was not saved.
-		 */
-		msr &= ~MSR_VSX;
-
-
+	}
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* save spe registers */
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index e66f67b..4299104 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -122,6 +122,12 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	flush_fp_to_thread(current);
 	/* copy fpr regs and fpscr */
 	err |= copy_fpr_to_user(&sc->fp_regs, current);
+
+	/*
+	 * Clear the MSR VSX bit to indicate there is no valid state attached
+	 * to this context, except in the specific case below where we set it.
+	 */
+	msr &= ~MSR_VSX;
 #ifdef CONFIG_VSX
 	/*
 	 * Copy VSX low doubleword to local buffer for formatting,
-- 
1.8.3.2
