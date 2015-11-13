Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E133A1A072B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 15:57:45 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH 3/5] powerpc/tm: Block signal return setting invalid MSR state
Date: Fri, 13 Nov 2015 15:57:30 +1100
Message-Id: <1447390652-28355-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1447390652-28355-1-git-send-email-mikey@neuling.org>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we allow both the MSR T and S bits to be set by userspace on
a signal return.  Unfortunately this is a reserved configuration and
will cause a TM Bad Thing exception if attempted (via rfid).

This patch checks for this case in both the 32 and 64bit signals code.
If these are both set, we clear them and trigger the bad stack frame
handling.

Found using a syscall fuzzer.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/include/asm/reg.h  |  1 +
 arch/powerpc/kernel/signal_32.c | 16 ++++++++++------
 arch/powerpc/kernel/signal_64.c |  6 ++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a908ada..2220f7a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -108,6 +108,7 @@
 #define MSR_TS_T	__MASK(MSR_TS_T_LG)	/*  Transaction Transactional */
 #define MSR_TS_MASK	(MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
 #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
+#define MSR_TM_RESV(x) (((x) & MSR_TS_MASK) == MSR_TS_MASK) /* Reserved */
 #define MSR_TM_TRANSACTIONAL(x)	(((x) & MSR_TS_MASK) == MSR_TS_T)
 #define MSR_TM_SUSPENDED(x)	(((x) & MSR_TS_MASK) == MSR_TS_S)
 
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0dbee46..5b519c7 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -874,7 +874,16 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		       + ELF_NEVRREG))
 		return 1;
 #endif /* CONFIG_SPE */
-
+	/* Get the top half of the MSR */
+	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
+		return 1;
+	/* Pull in MSR TM from user context */
+	regs->msr = (regs->msr & ~MSR_TS_MASK) | ((msr_hi<<32) & MSR_TS_MASK);
+	/* Don't let the user set both TM bits */
+	if (MSR_TM_RESV(regs->msr)) {
+		regs->msr &= ~MSR_TS_MASK;
+		return 1;
+	}
 	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
 	 * registers, including FP and V[S]Rs.  After recheckpointing, the
 	 * transactional versions should be loaded.
@@ -884,11 +893,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	current->thread.tm_texasr |= TEXASR_FS;
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&current->thread, msr);
-	/* Get the top half of the MSR */
-	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
-		return 1;
-	/* Pull in MSR TM from user context */
-	regs->msr = (regs->msr & ~MSR_TS_MASK) | ((msr_hi<<32) & MSR_TS_MASK);
 
 	/* This loads the speculative FP/VEC state, if used */
 	if (msr & MSR_FP) {
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 20756df..b320689 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -438,6 +438,12 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 
 	/* get MSR separately, transfer the LE bit if doing signal return */
 	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
+	/* Don't allow reserved mode. */
+	if (MSR_TM_RESV(msr)) {
+		msr &= ~MSR_TS_MASK;
+		return -EINVAL;
+	}
+
 	/* pull in MSR TM from user context */
 	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
 
-- 
2.5.0
