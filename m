Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHmxN3vzlzF0cZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:32:40 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc: Use the TRAP macro whenever comparing a trap
 number
Date: Fri, 12 Jan 2018 13:28:49 +1100
Message-Id: <20180112022849.30899-5-benh@kernel.crashing.org>
In-Reply-To: <20180112022849.30899-1-benh@kernel.crashing.org>
References: <20180112022849.30899-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Trap numbers can have extra bits at the bottom that need to
be filtered out. There are a few cases where we don't do that.

It's possible that we got lucky but better safe than sorry.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 arch/powerpc/kernel/traps.c   | 2 +-
 arch/powerpc/mm/fault.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 72be0c32e902..397d6e64e3df 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1409,7 +1409,7 @@ void show_regs(struct pt_regs * regs)
 	print_msr_bits(regs->msr);
 	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
-	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
+	if ((TRAP(regs) != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
 		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f3eb61be0d30..d61989be28e1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1564,7 +1564,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	u8 status;
 	bool hv;
 
-	hv = (regs->trap == 0xf80);
+	hv = (TRAP(regs) == 0xf80);
 	if (hv)
 		value = mfspr(SPRN_HFSCR);
 	else
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 6e1e39035380..7b15fe2ac986 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -576,7 +576,7 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 
 	/* kernel has accessed a bad area */
 
-	switch (regs->trap) {
+	switch (TRAP(regs)) {
 	case 0x300:
 	case 0x380:
 		printk(KERN_ALERT "Unable to handle kernel paging request for "
-- 
2.14.3
