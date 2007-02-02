Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E775DDDDF4
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:16 +1100 (EST)
Message-Id: <20070202045508.119282000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:51 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [3/9] pasemi: Machine check handler
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Print out decoded machine check information on PA6T.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -156,6 +156,48 @@ static void __init pas_progress(char *s,
 }
 
 
+static int pas_machine_check_handler(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	unsigned long srr0, srr1, dsisr;
+
+	srr0 = regs->nip;
+	srr1 = regs->msr;
+	dsisr = mfspr(SPRN_DSISR);
+	printk(KERN_ERR "Machine Check on CPU %d\n", cpu);
+	printk(KERN_ERR "SRR0 0x%016lx SRR1 0x%016lx\n", srr0, srr1);
+	printk(KERN_ERR "DSISR 0x%016lx DAR 0x%016lx\n", dsisr, regs->dar);
+	printk(KERN_ERR "Cause:\n");
+
+	if (srr1 & 0x200000)
+		printk(KERN_ERR "Signalled by SDC\n");
+	if (srr1 & 0x100000) {
+		printk(KERN_ERR "Load/Store detected error:\n");
+		if (dsisr & 0x8000)
+			printk(KERN_ERR "D-cache ECC double-bit error or bus error\n");
+		if (dsisr & 0x4000)
+			printk(KERN_ERR "LSU snoop response error\n");
+		if (dsisr & 0x2000)
+			printk(KERN_ERR "MMU SLB multi-hit or invalid B field\n");
+		if (dsisr & 0x1000)
+			printk(KERN_ERR "Recoverable Duptags\n");
+		if (dsisr & 0x800)
+			printk(KERN_ERR "Recoverable D-cache parity error count overflow\n");
+		if (dsisr & 0x400)
+			printk(KERN_ERR "TLB parity error count overflow\n");
+	}
+	if (srr1 & 0x80000)
+		printk(KERN_ERR "Bus Error\n");
+	if (srr1 & 0x40000)
+		printk(KERN_ERR "I-side SLB multiple hit\n");
+	if (srr1 & 0x20000)
+		printk(KERN_ERR "I-cache parity error hit\n");
+
+	/* SRR1[62] is from MSR[62] if recoverable, so pass that back */
+	return !!(srr1 & 0x2);
+}
+
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -184,4 +226,5 @@ define_machine(pas) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.check_legacy_ioport    = pas_check_legacy_ioport,
 	.progress		= pas_progress,
+	.machine_check_exception = pas_machine_check_handler,
 };

--
