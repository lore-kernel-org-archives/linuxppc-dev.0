Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id ECCE6DDF31
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:49 +1000 (EST)
Message-Id: <20070705170238.613319000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:52 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 19/35] Improve machine check output
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The name says it all. Try to provide more good info on machine checks.


Index: 2.6.21/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/setup.c
+++ 2.6.21/arch/powerpc/platforms/pasemi/setup.c
@@ -40,6 +40,7 @@
 #include "pasemi.h"
 
 static void __iomem *reset_reg;
+void __iomem *mem_errsta0, *mem_errsta1;
 
 DEFINE_SPINLOCK(lbi_lock);
 
@@ -102,6 +103,9 @@ void __init pas_setup_arch(void)
 	reset_reg = ioremap(0xfc101100, 4);
 
 	pasemi_idle_init();
+
+	mem_errsta0 = ioremap(0xe0020730, 4);
+	mem_errsta1 = ioremap(0xe0028730, 4);
 }
 
 static __init void pas_init_IRQ(void)
@@ -164,6 +168,8 @@ static int pas_machine_check_handler(str
 {
 	int cpu = smp_processor_id();
 	unsigned long srr0, srr1, dsisr;
+	int dump_slb = 0;
+	int dump_memsta = 0;
 
 	srr0 = regs->nip;
 	srr1 = regs->msr;
@@ -177,25 +183,57 @@ static int pas_machine_check_handler(str
 		printk(KERN_ERR "Signalled by SDC\n");
 	if (srr1 & 0x100000) {
 		printk(KERN_ERR "Load/Store detected error:\n");
-		if (dsisr & 0x8000)
+		if (dsisr & 0x8000) {
 			printk(KERN_ERR "D-cache ECC double-bit error or bus error\n");
+			dump_memsta = 1;
+		}
 		if (dsisr & 0x4000)
 			printk(KERN_ERR "LSU snoop response error\n");
-		if (dsisr & 0x2000)
+		if (dsisr & 0x2000) {
 			printk(KERN_ERR "MMU SLB multi-hit or invalid B field\n");
+			dump_slb = 1;
+		}
 		if (dsisr & 0x1000)
 			printk(KERN_ERR "Recoverable Duptags\n");
-		if (dsisr & 0x800)
+		if (dsisr & 0x800) {
 			printk(KERN_ERR "Recoverable D-cache parity error count overflow\n");
+			dump_memsta = 1;
+		}
 		if (dsisr & 0x400)
 			printk(KERN_ERR "TLB parity error count overflow\n");
 	}
 	if (srr1 & 0x80000)
 		printk(KERN_ERR "Bus Error\n");
-	if (srr1 & 0x40000)
+	if (srr1 & 0x40000) {
 		printk(KERN_ERR "I-side SLB multiple hit\n");
-	if (srr1 & 0x20000)
+		dump_slb = 1;
+	}
+	if (srr1 & 0x20000) {
 		printk(KERN_ERR "I-cache parity error hit\n");
+		dump_memsta = 1;
+	}
+
+	if (dump_memsta) {
+		unsigned int errsta;
+		errsta = in_le32(mem_errsta0);
+		printk("mc0_mcdebug_errsta: 0x%08x (MER %d SER %d)\n",
+			errsta, !!(errsta & 0x2), !!(errsta & 0x1));
+		errsta = in_le32(mem_errsta1);
+		printk("mc1_mcdebug_errsta: 0x%08x (MER %d SER %d)\n",
+			errsta, !!(errsta & 0x2), !!(errsta & 0x1));
+	}
+
+	if (dump_slb) {
+		unsigned long slb_e, slb_v;
+		int i;
+		printk("slb contents:\n");
+		for (i = 0; i < SLB_NUM_ENTRIES; i++) {
+			asm volatile("slbmfee  %0,%1" : "=r" (slb_e) : "r" (i));
+			asm volatile("slbmfev  %0,%1" : "=r" (slb_v) : "r" (i));
+
+			printk("%02d %016lx %016lx\n", i, slb_e, slb_v);
+		}
+	}
 
 	/* SRR1[62] is from MSR[62] if recoverable, so pass that back */
 	return !!(srr1 & 0x2);
Index: 2.6.21/arch/powerpc/kernel/traps.c
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/traps.c
+++ 2.6.21/arch/powerpc/kernel/traps.c
@@ -378,6 +378,7 @@ void machine_check_exception(struct pt_r
 	if (check_io_access(regs))
 		return;
 
+#if defined(CONFIG_PPC32)
 #if defined(CONFIG_4xx) && !defined(CONFIG_440A)
 	if (reason & ESR_IMCP) {
 		printk("Instruction");
@@ -494,6 +495,7 @@ void machine_check_exception(struct pt_r
 		printk("Unknown values in msr\n");
 	}
 #endif /* CONFIG_4xx */
+#endif /* CONFIG_PPC32 */
 
 	/*
 	 * Optional platform-provided routine to print out
Index: 2.6.21/include/asm-powerpc/reg.h
===================================================================
--- 2.6.21.orig/include/asm-powerpc/reg.h
+++ 2.6.21/include/asm-powerpc/reg.h
@@ -532,6 +532,20 @@
 #define SPRN_PA6T_PMC4  791
 #define SPRN_PA6T_PMC5  792
 
+#define SPRN_PA6T_IER 0x3d5	/* Icache Error Register */
+#define SPRN_PA6T_DER 0x3d6	/* Dcache Error Register */
+#define SPRN_PA6T_BAR 0x35e	/* BIU Error Address Register */
+#define SPRN_PA6T_MER 0x351	/* MMU Error Register */
+
+#define SPRN_PA6T_PCCR  1019
+#define SPRN_PA6T_RPCCR 1021
+#define SPRN_PA6T_IMAAT 979
+#define SPRN_PA6T_IMA0  880
+#define SPRN_PA6T_IMA1  881
+#define SPRN_PA6T_IMA2  882
+#define SPRN_PA6T_BTCR  978
+
+
 #else /* 32-bit */
 #define SPRN_MMCR0	952	/* Monitor Mode Control Register 0 */
 #define   MMCR0_FC	0x80000000UL /* freeze counters */

--
