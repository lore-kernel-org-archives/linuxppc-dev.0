Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t85JN4dMCzDt3Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 22:21:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc/oops: Move printing of SOFTE before CFAR
Date: Wed,  2 Nov 2016 22:20:49 +1100
Message-Id: <1478085650-23618-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1478085650-23618-1-git-send-email-mpe@ellerman.id.au>
References: <1478085650-23618-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that KERN_CONT is required to do continuation lines properly, our
oops output is messed up.

But as the code is currently written we can't actually use pr_cont()
correctly, because some of the output may or may not be a continuation
line, depending on what was printed previously.

So move the printing of SOFTE up, so that we always have a line to
continue (at least on 64-bit). While we're at it, pull the CFAR logic
inside the #ifdef PPC64, CFAR is 64-bit only.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3898e381556f..84d334527fcd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1346,17 +1346,17 @@ void show_regs(struct pt_regs * regs)
 	print_msr_bits(regs->msr);
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
+#ifdef CONFIG_PPC64
+	printk("SOFTE: %ld ", regs->softe);
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
 		printk("CFAR: "REG" ", regs->orig_gpr3);
+#endif
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 		printk("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
 #else
 		printk("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
 #endif
-#ifdef CONFIG_PPC64
-	printk("SOFTE: %ld ", regs->softe);
-#endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (MSR_TM_ACTIVE(regs->msr))
 		printk("\nPACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
-- 
2.7.4
