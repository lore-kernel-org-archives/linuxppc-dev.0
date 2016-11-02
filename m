Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t85JQ07dfzDvHZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 22:21:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc/oops: Fix remaining pr_cont() issues
Date: Wed,  2 Nov 2016 22:20:50 +1100
Message-Id: <1478085650-23618-5-git-send-email-mpe@ellerman.id.au>
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

Now that we print SOFTE first, it's clear that the rest of these lines
need to be continuations, so use pr_cont().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 84d334527fcd..ea6fe2ea4a6f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1349,17 +1349,19 @@ void show_regs(struct pt_regs * regs)
 #ifdef CONFIG_PPC64
 	printk("SOFTE: %ld ", regs->softe);
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
-		printk("CFAR: "REG" ", regs->orig_gpr3);
+		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
 #endif
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-		printk("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
+		pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
 #else
-		printk("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
+		pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(regs->msr))
-		printk("\nPACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
+	if (MSR_TM_ACTIVE(regs->msr)) {
+		pr_cont("\n");
+		printk("PACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
+	}
 #endif
 
 	for (i = 0;  i < 32;  i++) {
-- 
2.7.4
