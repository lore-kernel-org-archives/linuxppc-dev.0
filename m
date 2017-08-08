Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPrm3K4hzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:39:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/9] powerpc/44x: Move 44x machine check handlers into
 platforms/44x
Date: Tue,  8 Aug 2017 16:39:19 +1000
Message-Id: <1502174365-8293-3-git-send-email-mpe@ellerman.id.au>
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

We have several 44x machine check handlers defined in traps.c. It would
be preferable if they were split out with the platforms that use them.
Do that.

In the process, drop get_mc_reason() and instead just open code the
lookup of reason from regs->dsisr. This avoids a pointless layer of
abstraction.

We know to use regs->dsisr because 44x enables BOOKE which enables
PPC_ADV_DEBUG_REGS, and FSL_BOOKE is not enabled on 44x builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c                | 74 ------------------------
 arch/powerpc/platforms/44x/Makefile        |  2 +-
 arch/powerpc/platforms/44x/machine_check.c | 90 ++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 75 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/machine_check.c

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bfcfd9ef09f2..84f228aefb84 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -441,81 +441,7 @@ int machine_check_4xx(struct pt_regs *regs)
 	return 0;
 }
 
-int machine_check_440A(struct pt_regs *regs)
-{
-	unsigned long reason = get_mc_reason(regs);
-
-	printk("Machine check in kernel mode.\n");
-	if (reason & ESR_IMCP){
-		printk("Instruction Synchronous Machine Check exception\n");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	}
-	else {
-		u32 mcsr = mfspr(SPRN_MCSR);
-		if (mcsr & MCSR_IB)
-			printk("Instruction Read PLB Error\n");
-		if (mcsr & MCSR_DRB)
-			printk("Data Read PLB Error\n");
-		if (mcsr & MCSR_DWB)
-			printk("Data Write PLB Error\n");
-		if (mcsr & MCSR_TLBP)
-			printk("TLB Parity Error\n");
-		if (mcsr & MCSR_ICP){
-			flush_instruction_cache();
-			printk("I-Cache Parity Error\n");
-		}
-		if (mcsr & MCSR_DCSP)
-			printk("D-Cache Search Parity Error\n");
-		if (mcsr & MCSR_DCFP)
-			printk("D-Cache Flush Parity Error\n");
-		if (mcsr & MCSR_IMPE)
-			printk("Machine Check exception is imprecise\n");
-
-		/* Clear MCSR */
-		mtspr(SPRN_MCSR, mcsr);
-	}
-	return 0;
-}
-
-int machine_check_47x(struct pt_regs *regs)
-{
-	unsigned long reason = get_mc_reason(regs);
-	u32 mcsr;
 
-	printk(KERN_ERR "Machine check in kernel mode.\n");
-	if (reason & ESR_IMCP) {
-		printk(KERN_ERR
-		       "Instruction Synchronous Machine Check exception\n");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-		return 0;
-	}
-	mcsr = mfspr(SPRN_MCSR);
-	if (mcsr & MCSR_IB)
-		printk(KERN_ERR "Instruction Read PLB Error\n");
-	if (mcsr & MCSR_DRB)
-		printk(KERN_ERR "Data Read PLB Error\n");
-	if (mcsr & MCSR_DWB)
-		printk(KERN_ERR "Data Write PLB Error\n");
-	if (mcsr & MCSR_TLBP)
-		printk(KERN_ERR "TLB Parity Error\n");
-	if (mcsr & MCSR_ICP) {
-		flush_instruction_cache();
-		printk(KERN_ERR "I-Cache Parity Error\n");
-	}
-	if (mcsr & MCSR_DCSP)
-		printk(KERN_ERR "D-Cache Search Parity Error\n");
-	if (mcsr & PPC47x_MCSR_GPR)
-		printk(KERN_ERR "GPR Parity Error\n");
-	if (mcsr & PPC47x_MCSR_FPR)
-		printk(KERN_ERR "FPR Parity Error\n");
-	if (mcsr & PPC47x_MCSR_IPR)
-		printk(KERN_ERR "Machine Check exception is imprecise\n");
-
-	/* Clear MCSR */
-	mtspr(SPRN_MCSR, mcsr);
-
-	return 0;
-}
 #elif defined(CONFIG_E500)
 int machine_check_e500mc(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 71a7fccef675..2c5651992369 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,4 +1,4 @@
-obj-y	+= misc_44x.o
+obj-y	+= misc_44x.o machine_check.o
 ifneq ($(CONFIG_PPC4xx_CPM),y)
 obj-y	+= idle.o
 endif
diff --git a/arch/powerpc/platforms/44x/machine_check.c b/arch/powerpc/platforms/44x/machine_check.c
new file mode 100644
index 000000000000..439766a8fcbd
--- /dev/null
+++ b/arch/powerpc/platforms/44x/machine_check.c
@@ -0,0 +1,90 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/ptrace.h>
+
+#include <asm/reg.h>
+
+int machine_check_440A(struct pt_regs *regs)
+{
+	unsigned long reason = regs->dsisr;
+
+	printk("Machine check in kernel mode.\n");
+	if (reason & ESR_IMCP){
+		printk("Instruction Synchronous Machine Check exception\n");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	}
+	else {
+		u32 mcsr = mfspr(SPRN_MCSR);
+		if (mcsr & MCSR_IB)
+			printk("Instruction Read PLB Error\n");
+		if (mcsr & MCSR_DRB)
+			printk("Data Read PLB Error\n");
+		if (mcsr & MCSR_DWB)
+			printk("Data Write PLB Error\n");
+		if (mcsr & MCSR_TLBP)
+			printk("TLB Parity Error\n");
+		if (mcsr & MCSR_ICP){
+			flush_instruction_cache();
+			printk("I-Cache Parity Error\n");
+		}
+		if (mcsr & MCSR_DCSP)
+			printk("D-Cache Search Parity Error\n");
+		if (mcsr & MCSR_DCFP)
+			printk("D-Cache Flush Parity Error\n");
+		if (mcsr & MCSR_IMPE)
+			printk("Machine Check exception is imprecise\n");
+
+		/* Clear MCSR */
+		mtspr(SPRN_MCSR, mcsr);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PPC_47x
+int machine_check_47x(struct pt_regs *regs)
+{
+	unsigned long reason = regs->dsisr;
+	u32 mcsr;
+
+	printk(KERN_ERR "Machine check in kernel mode.\n");
+	if (reason & ESR_IMCP) {
+		printk(KERN_ERR
+		       "Instruction Synchronous Machine Check exception\n");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+		return 0;
+	}
+	mcsr = mfspr(SPRN_MCSR);
+	if (mcsr & MCSR_IB)
+		printk(KERN_ERR "Instruction Read PLB Error\n");
+	if (mcsr & MCSR_DRB)
+		printk(KERN_ERR "Data Read PLB Error\n");
+	if (mcsr & MCSR_DWB)
+		printk(KERN_ERR "Data Write PLB Error\n");
+	if (mcsr & MCSR_TLBP)
+		printk(KERN_ERR "TLB Parity Error\n");
+	if (mcsr & MCSR_ICP) {
+		flush_instruction_cache();
+		printk(KERN_ERR "I-Cache Parity Error\n");
+	}
+	if (mcsr & MCSR_DCSP)
+		printk(KERN_ERR "D-Cache Search Parity Error\n");
+	if (mcsr & PPC47x_MCSR_GPR)
+		printk(KERN_ERR "GPR Parity Error\n");
+	if (mcsr & PPC47x_MCSR_FPR)
+		printk(KERN_ERR "FPR Parity Error\n");
+	if (mcsr & PPC47x_MCSR_IPR)
+		printk(KERN_ERR "Machine Check exception is imprecise\n");
+
+	/* Clear MCSR */
+	mtspr(SPRN_MCSR, mcsr);
+
+	return 0;
+}
+#endif /* CONFIG_PPC_47x */
-- 
2.7.4
