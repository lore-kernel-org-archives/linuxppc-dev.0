Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE36CB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 06:59:34 +1100 (EST)
Date: Mon, 28 Mar 2011 14:59:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [PATCH v2 1/4] powerpc/e500v2: Save SPEFCSR in flush_spe_to_thread()
Message-ID: <20110328195923.GA25659@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: yu liu <yu.liu@freescale.com>

giveup_spe() saves the SPE state which is protected by MSR[SPE].
However, modifying SPEFSCR does not trap when MSR[SPE]=0.
And since SPEFSCR is already saved/restored in _switch(),
not all the callers want to save SPEFSCR again.
Thus, saving SPEFSCR should not belong to giveup_spe().

This patch moves SPEFSCR saving to flush_spe_to_thread(),
and cleans up the caller that needs to save SPEFSCR accordingly.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: added kvm-ppc (sorry for the resend)

Kumar, could you ack this to go via the KVM tree, since the KVM
SPE save/restore patches depend on it?

 arch/powerpc/kernel/head_fsl_booke.S |    2 --
 arch/powerpc/kernel/process.c        |    1 +
 arch/powerpc/kernel/traps.c          |    5 +----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 3e02710..b84fc5e 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -792,8 +792,6 @@ _GLOBAL(giveup_spe)
 	evmwumiaa evr6, evr6, evr6	/* evr6 <- ACC = 0 * 0 + ACC */
 	li	r4,THREAD_ACC
 	evstddx	evr6, r4, r3		/* save off accumulator */
-	mfspr	r6,SPRN_SPEFSCR
-	stw	r6,THREAD_SPEFSCR(r3)	/* save spefscr register value */
 	beq	1f
 	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	lis	r3,MSR_SPE@h
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f74f355..138e7dd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -213,6 +213,7 @@ void flush_spe_to_thread(struct task_struct *tsk)
 #ifdef CONFIG_SMP
 			BUG_ON(tsk != current);
 #endif
+			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
 			giveup_spe(tsk);
 		}
 		preempt_enable();
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bd74fac..0ed23d1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1356,10 +1356,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	int code = 0;
 	int err;
 
-	preempt_disable();
-	if (regs->msr & MSR_SPE)
-		giveup_spe(current);
-	preempt_enable();
+	flush_spe_to_thread(current);
 
 	spefscr = current->thread.spefscr;
 	fpexc_mode = current->thread.fpexc_mode;
-- 
1.7.1
