Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcpr5117vzDqh1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 23:56:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc/oops: Print CR/XER on same line as MSR
Date: Wed, 23 Aug 2017 23:56:23 +1000
Message-Id: <1503496584-21970-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
References: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Somehow we missed this when the pr_cont() changes went in. Fix CR/XER
to go on the same line as MSR, as they have historically, eg:

  MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 4804408a  XER: 20000000

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 34bd94b090e2..91f9819cb51b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1386,7 +1386,7 @@ void show_regs(struct pt_regs * regs)
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
 	printk("MSR: "REG" ", regs->msr);
 	print_msr_bits(regs->msr);
-	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
+	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
 		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
-- 
2.7.4
