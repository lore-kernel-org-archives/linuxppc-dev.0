Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzBql29PrzDrKH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 18:58:43 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i6so13538409pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 01:58:43 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Amanieu d'Antras" <amanieu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: set used_vsr/used_vr/used_spe in sigreturn path when
 MSR bits are active
Date: Tue, 26 Jul 2016 16:06:01 +0800
Message-Id: <1469520361-9035-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Normally, when MSR[VSX/VR/SPE] bits = 1, the used_vsr/used_vr/used_spe
bit have already been set. However signal frame locates at user space
and it is controlled by user application. It is up to kernel to make
sure used_vsr/used_vr/used_spe(in kernel)=1 and consistent with MSR
bits.

For example, CRIU application, who utilizes sigreturn to restore
checkpointed process, will lead to the case where MSR[VSX] bit is
active in signal frame, but used_vsx bit is not set. (the same applies
to VR/SPE).

This patch will reinforce this at kernel by always setting used_* bit
when MSR related bits are active in signal frame and we are doing
sigreturn.

This patch is based on Ben's Proposal.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Amanieu d'Antras" <amanieu@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kernel/signal_32.c |  6 ++++++
 arch/powerpc/kernel/signal_64.c | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index b6aa378..1bf074e 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -698,6 +698,7 @@ static long restore_user_regs(struct pt_regs *regs,
 		if (__copy_from_user(&current->thread.vr_state, &sr->mc_vregs,
 				     sizeof(sr->mc_vregs)))
 			return 1;
+		current->thread.used_vr = true;
 	} else if (current->thread.used_vr)
 		memset(&current->thread.vr_state, 0,
 		       ELF_NVRREG * sizeof(vector128));
@@ -724,6 +725,7 @@ static long restore_user_regs(struct pt_regs *regs,
 		 */
 		if (copy_vsx_from_user(current, &sr->mc_vsregs))
 			return 1;
+		current->thread.used_vsr = true;
 	} else if (current->thread.used_vsr)
 		for (i = 0; i < 32 ; i++)
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
@@ -743,6 +745,7 @@ static long restore_user_regs(struct pt_regs *regs,
 		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
 				     ELF_NEVRREG * sizeof(u32)))
 			return 1;
+		current->thread.used_spe = true;
 	} else if (current->thread.used_spe)
 		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
 
@@ -799,6 +802,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 				     &tm_sr->mc_vregs,
 				     sizeof(sr->mc_vregs)))
 			return 1;
+		current->thread.used_vr = true;
 	} else if (current->thread.used_vr) {
 		memset(&current->thread.vr_state, 0,
 		       ELF_NVRREG * sizeof(vector128));
@@ -832,6 +836,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		if (copy_vsx_from_user(current, &sr->mc_vsregs) ||
 		    copy_transact_vsx_from_user(current, &tm_sr->mc_vsregs))
 			return 1;
+		current->thread.used_vsr = true;
 	} else if (current->thread.used_vsr)
 		for (i = 0; i < 32 ; i++) {
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
@@ -848,6 +853,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
 				     ELF_NEVRREG * sizeof(u32)))
 			return 1;
+		current->thread.used_spe = true;
 	} else if (current->thread.used_spe)
 		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 2552079..8704269 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -363,9 +363,11 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	if (v_regs && !access_ok(VERIFY_READ, v_regs, 34 * sizeof(vector128)))
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
-	if (v_regs != NULL && (msr & MSR_VEC) != 0)
+	if (v_regs != NULL && (msr & MSR_VEC) != 0) {
 		err |= __copy_from_user(&current->thread.vr_state, v_regs,
 					33 * sizeof(vector128));
+		current->thread.used_vr = true;
+	}
 	else if (current->thread.used_vr)
 		memset(&current->thread.vr_state, 0, 33 * sizeof(vector128));
 	/* Always get VRSAVE back */
@@ -385,9 +387,10 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	 * buffer for formatting, then into the taskstruct.
 	 */
 	v_regs += ELF_NVRREG;
-	if ((msr & MSR_VSX) != 0)
+	if ((msr & MSR_VSX) != 0) {
 		err |= copy_vsx_from_user(current, v_regs);
-	else
+		current->thread.used_vsr = true;
+	} else
 		for (i = 0; i < 32 ; i++)
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 #endif
@@ -482,6 +485,7 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 					33 * sizeof(vector128));
 		err |= __copy_from_user(&current->thread.transact_vr, tm_v_regs,
 					33 * sizeof(vector128));
+		current->thread.used_vr = true;
 	}
 	else if (current->thread.used_vr) {
 		memset(&current->thread.vr_state, 0, 33 * sizeof(vector128));
@@ -515,6 +519,7 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		tm_v_regs += ELF_NVRREG;
 		err |= copy_vsx_from_user(current, v_regs);
 		err |= copy_transact_vsx_from_user(current, tm_v_regs);
+		current->thread.used_vsr = true;
 	} else {
 		for (i = 0; i < 32 ; i++) {
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
-- 
1.8.3.1
