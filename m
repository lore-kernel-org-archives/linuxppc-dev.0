Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7Wdv50B0zDvMr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 00:04:19 +1100 (AEDT)
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t7Wdt6RRnz9t0q
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2016 00:04:18 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id i127so16919374oia.0
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Nov 2016 06:04:18 -0700 (PDT)
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [TRIVIAL][PATCH] Fixup OOPS output
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8a7d55d7-e436-4ca1-f5a2-f439e083ad4d@gmail.com>
Date: Wed, 2 Nov 2016 00:03:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


With recent update to printk, we get console output like below

 P           O    4.9.0-rc2-next-20161028-00003-g23bf57759-dirty #125
 c0000000ef5f4000
 0000000000010000
 P           O     (4.9.0-rc2-next-20161028-00003-g23bf57759-dirty)
 9000000010009033
 <
 SF
 ,HV
 ,EE
 ,ME
 ,IR
 ,DR
 ,RI
 ,LE
 >

and more output that is not easy to parse

Fix the OOPS output so that it is easier on the eyes again

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/process.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ce6dc61..a3193c7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1282,7 +1282,7 @@ static void print_bits(unsigned long val, struct regbit *bits, const char *sep)
 
 	for (; bits->bit; ++bits)
 		if (val & bits->bit) {
-			printk("%s%s", s, bits->name);
+			pr_cont("%s%s", s, bits->name);
 			s = sep;
 		}
 }
@@ -1305,9 +1305,9 @@ static void print_tm_bits(unsigned long val)
  *   T: Transactional	(bit 34)
  */
 	if (val & (MSR_TM | MSR_TS_S | MSR_TS_T)) {
-		printk(",TM[");
+		pr_cont(",TM[");
 		print_bits(val, msr_tm_bits, "");
-		printk("]");
+		pr_cont("]");
 	}
 }
 #else
@@ -1316,10 +1316,10 @@ static void print_tm_bits(unsigned long val) {}
 
 static void print_msr_bits(unsigned long val)
 {
-	printk("<");
+	pr_cont("<");
 	print_bits(val, msr_bits, ",");
 	print_tm_bits(val);
-	printk(">");
+	pr_cont(">");
 }
 
 #ifdef CONFIG_PPC64
@@ -1347,15 +1347,15 @@ void show_regs(struct pt_regs * regs)
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
-		printk("CFAR: "REG" ", regs->orig_gpr3);
+		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-		printk("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
+		pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
 #else
-		printk("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
+		pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
 #endif
 #ifdef CONFIG_PPC64
-	printk("SOFTE: %ld ", regs->softe);
+	pr_cont("SOFTE: %ld ", regs->softe);
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (MSR_TM_ACTIVE(regs->msr))
@@ -1364,8 +1364,8 @@ void show_regs(struct pt_regs * regs)
 
 	for (i = 0;  i < 32;  i++) {
 		if ((i % REGS_PER_LINE) == 0)
-			printk("\nGPR%02d: ", i);
-		printk(REG " ", regs->gpr[i]);
+			pr_cont("\nGPR%02d: ", i);
+		pr_cont(REG " ", regs->gpr[i]);
 		if (i == LAST_VOLATILE && !FULL_REGS(regs))
 			break;
 	}
@@ -1906,7 +1906,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			}
 #endif
 			if (firstframe)
-				printk(" (unreliable)");
+				pr_cont(" (unreliable)");
 			printk("\n");
 		}
 		firstframe = 0;
-- 
2.5.5
