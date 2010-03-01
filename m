Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 05:13:23 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100301191323.20987.13284.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
Subject: [RFC: PATCH 04/13] powerpc/476: add machine check handler for 47x core
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: add machine check handler for 47x core

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

The 47x core's MCSR varies from 44x, so it needs it's own machine check
handler.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/cputable.h  |    1 +
 arch/powerpc/include/asm/reg_booke.h |    2 +-
 arch/powerpc/kernel/cputable.c       |    1 +
 arch/powerpc/kernel/traps.c          |   38 ++++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 75b774e..9fff628 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -72,6 +72,7 @@ extern int machine_check_4xx(struct pt_regs *regs);
 extern int machine_check_440A(struct pt_regs *regs);
 extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
+extern int machine_check_47x(struct pt_regs *regs);
 
 /* NOTE WELL: Update identify_cpu() if fields are added or removed! */
 struct cpu_spec {
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index ee61a9d..a9245b9 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -194,7 +194,7 @@
 #ifdef CONFIG_PPC_47x
 #define PPC47x_MCSR_GPR	0x01000000 /* GPR parity error */
 #define PPC47x_MCSR_FPR	0x00800000 /* FPR parity error */
-#define PPC47x_MCSR_IPR	0x00400000 /* Imprecise Machine Check Exception */
+#define PPC47x_MCSR_IMP	0x00400000 /* Imprecise Machine Check Exception */
 #endif
 
 #ifdef CONFIG_E500
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 338ac47..7b2a67c 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1712,6 +1712,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 128,
+		.machine_check		= machine_check_47x,
 		.platform		= "ppc470",
 	},
 	{	/* default match */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d069ff8..66617b6 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -376,6 +376,44 @@ int machine_check_440A(struct pt_regs *regs)
 	}
 	return 0;
 }
+
+int machine_check_47x(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
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
+		if (mcsr & PPC47x_MCSR_GPR)
+			printk("GPR Parity Error\n");
+		if (mcsr & PPC47x_MCSR_FPR)
+			printk("FPR Parity Error\n");
+		if (mcsr & PPC47x_MCSR_IMP)
+			printk("Machine Check exception is imprecise\n");
+
+		/* Clear MCSR */
+		mtspr(SPRN_MCSR, mcsr);
+	}
+	return 0;
+}
 #elif defined(CONFIG_E500)
 int machine_check_e500(struct pt_regs *regs)
 {

-- 
Dave Kleikamp
IBM Linux Technology Center
