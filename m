Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 16678DDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 16:18:29 +1000 (EST)
Date: Fri, 27 Jun 2008 16:18:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: excplictly copy elements of pt_regs
Message-Id: <20080627161827.4647186f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gcc 4.3 produced this warning:

arch/powerpc/kernel/signal_64.c: In function 'restore_sigcontext':
arch/powerpc/kernel/signal_64.c:161: warning: array subscript is above array bounds

This is caused by us copying to aliases of elements of the pt_regs
structure.  Make those explicit.

This adds one extra __get_user and unrolls a loop.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/signal_64.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

This has been build tested for ppc64_defconfig.

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index da7c058..8af35c5 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -137,29 +137,29 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 #endif
 	unsigned long err = 0;
 	unsigned long save_r13 = 0;
-	elf_greg_t *gregs = (elf_greg_t *)regs;
 	unsigned long msr;
-	int i;
 
 	/* If this is not a signal return, we preserve the TLS in r13 */
 	if (!sig)
 		save_r13 = regs->gpr[13];
 
-	/* copy everything before MSR */
-	err |= __copy_from_user(regs, &sc->gp_regs,
-				PT_MSR*sizeof(unsigned long));
-
+	/* copy the GPRs */
+	err |= __copy_from_user(regs->gpr, sc->gp_regs, sizeof(regs->gpr));
+	err |= __get_user(regs->nip, &sc->gp_regs[PT_NIP]);
 	/* get MSR separately, transfer the LE bit if doing signal return */
 	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
 	if (sig)
 		regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
-
+	err |= __get_user(regs->orig_gpr3, &sc->gp_regs[PT_ORIG_R3]);
+	err |= __get_user(regs->ctr, &sc->gp_regs[PT_CTR]);
+	err |= __get_user(regs->link, &sc->gp_regs[PT_LNK]);
+	err |= __get_user(regs->xer, &sc->gp_regs[PT_XER]);
+	err |= __get_user(regs->ccr, &sc->gp_regs[PT_CCR]);
 	/* skip SOFTE */
-	for (i = PT_MSR+1; i <= PT_RESULT; i++) {
-		if (i == PT_SOFTE)
-			continue;
-		err |= __get_user(gregs[i], &sc->gp_regs[i]);
-	}
+	err |= __get_user(regs->trap, &sc->gp_regs[PT_TRAP]);
+	err |= __get_user(regs->dar, &sc->gp_regs[PT_DAR]);
+	err |= __get_user(regs->dsisr, &sc->gp_regs[PT_DSISR]);
+	err |= __get_user(regs->result, &sc->gp_regs[PT_RESULT]);
 
 	if (!sig)
 		regs->gpr[13] = save_r13;
-- 
1.5.6


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
