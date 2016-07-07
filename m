Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rldlF6fQszDqrm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 23:29:45 +1000 (AEST)
Message-ID: <1467898167.27157.47.camel@kernel.crashing.org>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Simon Guo <wei.guo.simon@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>, Rashmica
 Gupta <rashmicy@gmail.com>
Date: Thu, 07 Jul 2016 23:29:27 +1000
In-Reply-To: <1467897678.27157.45.camel@kernel.crashing.org>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-07 at 23:21 +1000, Benjamin Herrenschmidt wrote:
> 
> I think the right fix is that if a restore_sigcontext() has the MSR
> bits set,
> it should set the corresponding used_* flag.

Something like this:

(totally untested)

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
