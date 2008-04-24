Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F425DDF1C
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 15:41:52 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3O5fkB8020727
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 00:41:47 -0500
Date: Thu, 24 Apr 2008 00:37:50 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][WIP][PATCH] Add IRQSTACKS to ppc32
Message-ID: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Posting this to get any review and suggestions on the functionality of the
patch.

Questions/issues:
* what to do about the stack_ovf check in entry_32.S
* do we really have any constraints on ppc32 (beyond being in lowmem) on
the locations of the stacks [see irqstack_early_init()]

- k

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index a86d8d8..2cf72d2 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -118,7 +118,6 @@ config XMON_DISASSEMBLY

 config IRQSTACKS
 	bool "Use separate kernel stacks when processing interrupts"
-	depends on PPC64
 	help
 	  If you say Y here the kernel will use separate kernel stacks
 	  for handling hard and soft interrupts.  This can help avoid
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 425616f..ad40eb4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -352,7 +352,7 @@ void __init init_IRQ(void)
 {
 	if (ppc_md.init_IRQ)
 		ppc_md.init_IRQ();
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_IRQSTACKS
 	irq_ctx_init();
 #endif
 }
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 92ccc6f..89aaaa6 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -32,6 +32,31 @@

 	.text

+#ifdef CONFIG_IRQSTACKS
+_GLOBAL(call_do_softirq)
+	mflr	r0
+	stw	r0,4(r1)
+	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
+	mr	r1,r3
+	bl	__do_softirq
+	lwz	r1,0(r1)
+	lwz	r0,4(r1)
+	mtlr	r0
+	blr
+
+_GLOBAL(call_handle_irq)
+	mflr	r0
+	stw	r0,4(r1)
+	mtctr	r6
+	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r5)
+	mr	r1,r5
+	bctrl
+	lwz	r1,0(r1)
+	lwz	r0,4(r1)
+	mtlr	r0
+	blr
+#endif /* CONFIG_IRQSTACKS */
+
 /*
  * This returns the high 64 bits of the product of two 64-bit numbers.
  */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 36f6779..ebd1b1d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -16,6 +16,7 @@
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/console.h>
+#include <linux/lmb.h>

 #include <asm/io.h>
 #include <asm/prom.h>
@@ -229,6 +230,28 @@ int __init ppc_init(void)

 arch_initcall(ppc_init);

+#ifdef CONFIG_IRQSTACKS
+static void __init irqstack_early_init(void)
+{
+	unsigned int i;
+
+	/*
+	 * interrupt stacks must be under 256MB, we cannot afford to take
+	 * SLB misses on them.
+	 */
+	for_each_possible_cpu(i) {
+		softirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc_base(THREAD_SIZE,
+					    THREAD_SIZE, 0x10000000));
+		hardirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc_base(THREAD_SIZE,
+					    THREAD_SIZE, 0x10000000));
+	}
+}
+#else
+#define irqstack_early_init()
+#endif
+
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
@@ -286,6 +309,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;

+	irqstack_early_init();
+
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
