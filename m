Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53D7C2BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 10:06:27 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 10:05:52 +1100
Message-Id: <1100991952.3796.23.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Fix an IRQ issue with cpufreq
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

The ppc32 PowerMac cpufreq code, when using the PMU to switch the frequency,
would eventually lose interrupts. The solution is to raise the CPU priority
at the controller level. It's also unnecessary to call the full PIC
suspend/resume code in this case as the IO chip isn't reset, unlike the
sleep code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc/open_pic.h
===================================================================
--- linux-work.orig/include/asm-ppc/open_pic.h	2004-11-09 14:03:51.000000000 +1100
+++ linux-work/include/asm-ppc/open_pic.h	2004-11-21 10:05:17.885389728 +1100
@@ -55,6 +55,7 @@
 extern void smp_openpic_message_pass(int target, int msg, unsigned long data,
 				     int wait);
 extern void openpic_set_k2_cascade(int irq);
+extern void openpic_set_priority(u_int pri);
 
 extern inline int openpic_to_irq(int irq)
 {
Index: linux-work/arch/ppc/syslib/open_pic.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/open_pic.c	2004-11-09 14:03:50.000000000 +1100
+++ linux-work/arch/ppc/syslib/open_pic.c	2004-11-21 10:05:17.888389272 +1100
@@ -53,7 +53,6 @@
 
 /* Global Operations */
 static void openpic_disable_8259_pass_through(void);
-static void openpic_set_priority(u_int pri);
 static void openpic_set_spurious(u_int vector);
 
 #ifdef CONFIG_SMP
@@ -477,7 +476,7 @@
 }
 #endif /* notused */
 
-static void __init openpic_set_priority(u_int pri)
+void openpic_set_priority(u_int pri)
 {
 	DECL_THIS_CPU;
 
@@ -955,6 +954,8 @@
 		return 0;
 	}
 
+ 	openpic_set_priority(0xf);
+
 	open_pic.enable = openpic_cached_enable_irq;
 	open_pic.disable = openpic_cached_disable_irq;
 
@@ -1028,6 +1029,8 @@
 	open_pic.enable = openpic_enable_irq;
 	open_pic.disable = openpic_disable_irq;
 
+ 	openpic_set_priority(0);
+
 	spin_unlock_irqrestore(&openpic_setup_lock, flags);
 
 	return 0;
Index: linux-work/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cpufreq.c	2004-10-23 08:45:23.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_cpufreq.c	2004-11-21 10:05:17.889389120 +1100
@@ -33,6 +33,8 @@
 #include <asm/sections.h>
 #include <asm/cputable.h>
 #include <asm/time.h>
+#include <asm/system.h>
+#include <asm/open_pic.h>
 
 /* WARNING !!! This will cause calibrate_delay() to be called,
  * but this is an __init function ! So you MUST go edit
@@ -51,10 +53,6 @@
 extern void low_choose_7447a_dfs(int dfs);
 extern void low_choose_750fx_pll(int pll);
 extern void low_sleep_handler(void);
-extern void openpic_suspend(struct sys_device *sysdev, u32 state);
-extern void openpic_resume(struct sys_device *sysdev);
-extern void enable_kernel_altivec(void);
-extern void enable_kernel_fp(void);
 
 /*
  * Currently, PowerMac cpufreq supports only high & low frequencies
@@ -208,7 +206,7 @@
 	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
 #endif
 	/* Disable all interrupt sources on openpic */
-	openpic_suspend(NULL, 1);
+ 	openpic_set_priority(0xf);
 
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
@@ -275,7 +273,7 @@
 	wakeup_decrementer();
 
 	/* Restore interrupts */
-	openpic_resume(NULL);
+ 	openpic_set_priority(0);
 
 	/* Let interrupts flow again ... */
 	local_irq_enable();
