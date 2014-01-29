Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jan 2014 16:33:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix 32-bit frames for signals delivered when
 transactional
Message-ID: <20140129053356.GA12776@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d31626f70b61 ("powerpc: Don't corrupt transactional state when
using FP/VMX in kernel") introduced a bug where the uc_link and uc_regs
fields of the ucontext_t that is created to hold the transactional
values of the registers in a 32-bit signal frame didn't get set
correctly.  The reason is that we now clear the MSR_TS bits in the MSR
in save_tm_user_regs(), before the code that sets uc_link and uc_regs.
To fix this, we move the setting of uc_link and uc_regs into the same
if statement that selects whether to call save_tm_user_regs() or
save_user_regs().

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/signal_32.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 6ce69e6..a67e00a 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1022,29 +1022,24 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	tm_frame = &rt_sf->uc_transact.uc_mcontext;
 	if (MSR_TM_ACTIVE(regs->msr)) {
+		if (__put_user((unsigned long)&rt_sf->uc_transact,
+			       &rt_sf->uc.uc_link) ||
+		    __put_user((unsigned long)tm_frame,
+			       &rt_sf->uc_transact.uc_regs))
+			goto badframe;
 		if (save_tm_user_regs(regs, frame, tm_frame, sigret))
 			goto badframe;
 	}
 	else
 #endif
 	{
+		if (__put_user(0, &rt_sf->uc.uc_link))
+			goto badframe;
 		if (save_user_regs(regs, frame, tm_frame, sigret, 1))
 			goto badframe;
 	}
 	regs->link = tramp;
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(regs->msr)) {
-		if (__put_user((unsigned long)&rt_sf->uc_transact,
-			       &rt_sf->uc.uc_link)
-		    || __put_user((unsigned long)tm_frame, &rt_sf->uc_transact.uc_regs))
-			goto badframe;
-	}
-	else
-#endif
-		if (__put_user(0, &rt_sf->uc.uc_link))
-			goto badframe;
-
 	current->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
 
 	/* create a stack frame for the caller of the handler */
-- 
1.8.5.2
