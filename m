Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPrp0BBxzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:39:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9] powerpc/traps: Inline get_mc_reason()
Date: Tue,  8 Aug 2017 16:39:22 +1000
Message-Id: <1502174365-8293-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
References: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_mc_reason() no longer provides (if it ever really did) any
meaningful abstraction, so remove it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c1ecc4193c3f..a4f6ddae526e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -397,11 +397,6 @@ static inline int check_io_access(struct pt_regs *regs)
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
 #define get_reason(regs)	((regs)->dsisr)
-#ifndef CONFIG_FSL_BOOKE
-#define get_mc_reason(regs)	((regs)->dsisr)
-#else
-#define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
-#endif
 #define REASON_FP		ESR_FP
 #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
 #define REASON_PRIVILEGED	ESR_PPR
@@ -415,7 +410,6 @@ static inline int check_io_access(struct pt_regs *regs)
 /* On non-4xx, the reason for the machine check or program
    exception is in the MSR. */
 #define get_reason(regs)	((regs)->msr)
-#define get_mc_reason(regs)	((regs)->msr)
 #define REASON_TM		0x200000
 #define REASON_FP		0x100000
 #define REASON_ILLEGAL		0x80000
@@ -528,7 +522,7 @@ int machine_check_e500mc(struct pt_regs *regs)
 
 int machine_check_e500(struct pt_regs *regs)
 {
-	unsigned long reason = get_mc_reason(regs);
+	unsigned long reason = mfspr(SPRN_MCSR);
 
 	if (reason & MCSR_BUS_RBERR) {
 		if (fsl_rio_mcheck_exception(regs))
@@ -575,7 +569,7 @@ int machine_check_generic(struct pt_regs *regs)
 #elif defined(CONFIG_E200)
 int machine_check_e200(struct pt_regs *regs)
 {
-	unsigned long reason = get_mc_reason(regs);
+	unsigned long reason = mfspr(SPRN_MCSR);
 
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
@@ -600,7 +594,7 @@ int machine_check_e200(struct pt_regs *regs)
 #elif defined(CONFIG_PPC_8xx)
 int machine_check_8xx(struct pt_regs *regs)
 {
-	unsigned long reason = get_mc_reason(regs);
+	unsigned long reason = regs->msr;
 
 	pr_err("Machine check in kernel mode.\n");
 	pr_err("Caused by (from SRR1=%lx): ", reason);
@@ -625,7 +619,7 @@ int machine_check_8xx(struct pt_regs *regs)
 #else
 int machine_check_generic(struct pt_regs *regs)
 {
-	unsigned long reason = get_mc_reason(regs);
+	unsigned long reason = regs->msr;
 
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", reason);
-- 
2.7.4
