Return-Path: <paubert@iram.es>
Received: from ltgp.iram.es (ltgp.iram.es [150.214.224.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 912232BDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Nov 2004 23:00:07 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 15 Nov 2004 12:55:37 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041115115537.GA2664@iram.es>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston>
	<4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston> <20041029101017.GA28149@iram.es>
	<1099090806.29689.140.camel@gaston> <20041103123050.GA5057@iram.es>
	<1099519901.900.49.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099519901.900.49.camel@gaston>
Cc: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


	Hi Ben,

back to an old subject.


On Thu, Nov 04, 2004 at 09:11:41AM +1100, Benjamin Herrenschmidt wrote:
> Ah... so that would explain why newer machines don't show it ? the
> openpic is faster or such ? I'll test you theory by adding a small delay
> after reading the ack (just to test)...

Well, the new irq consolidation code has rendered my test patch 
absolutely useless. I just send you what I have now, it's not
but is minimally invasive in the generic code.

The nested_irq_enable function is not really nice: you'll get
a link time error if you want to use it more than once. But
the only workaround would be very ugly macros.

	Regards,
	Gabriel

===== arch/ppc/kernel/irq.c 1.47 vs edited =====
--- 1.47/arch/ppc/kernel/irq.c	2004-10-22 04:41:23 +02:00
+++ edited/arch/ppc/kernel/irq.c	2004-11-15 00:51:49 +01:00
@@ -76,6 +76,9 @@
 extern int tau_interrupts(int);
 #endif
 
+int hardirq_shadow_ticks=0;
+extern unsigned long __hardirq_shadow_nip;
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
@@ -138,6 +141,9 @@
 void do_IRQ(struct pt_regs *regs)
 {
 	int irq, first = 1;
+	static int prev_irq=-3, prev_prev_irq=-4;
+	static unsigned spurious_jiffies;
+	static int prev_spurious;
         irq_enter();
 
 	/*
@@ -151,10 +157,28 @@
 	while ((irq = ppc_md.get_irq(regs)) >= 0) {
 		__do_IRQ(irq, regs);
 		first = 0;
+		prev_prev_irq = prev_irq;
+		prev_irq = irq;
 	}
-	if (irq != -2 && first)
+	if (irq != -2 && first) {
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
+		if (jiffies-spurious_jiffies>HZ) {
+			if ((ppc_spurious_interrupts-prev_spurious) > 2 &&
+			    (regs->nip - (unsigned long)&__hardirq_shadow_nip)
+			    <=4) {
+				printk("Interrupt hardirq_shadow_ticks "
+				       "set to %d.\n",
+				       ++hardirq_shadow_ticks);
+			}
+			prev_spurious = ppc_spurious_interrupts;
+			spurious_jiffies=jiffies;
+			printk(KERN_NOTICE
+			       "Spurious interrupt, last vectors %d:%d, "
+			       "NIP=0x%lx\n",
+			       prev_prev_irq, prev_irq, regs->nip);
+		}
+	}
         irq_exit();
 }
 
===== include/asm-ppc/hw_irq.h 1.10 vs edited =====
--- 1.10/include/asm-ppc/hw_irq.h	2004-10-19 07:26:40 +02:00
+++ edited/include/asm-ppc/hw_irq.h	2004-11-15 11:38:45 +01:00
@@ -32,6 +32,29 @@
 	mtmsr(msr | MSR_EE);
 }
 
+#define ARCH_SHADOW_IRQS
+
+static inline void nested_irq_enable(void)
+{
+	extern int hardirq_shadow_ticks;
+	int start, now;
+	asm volatile(	"	mftb %0\n"
+			"1:	mftb %1\n"
+			"	sub %1,%1,%0\n"
+			"	cmplw %1,%2\n"
+			"	blt 1b\n"
+			"	isync\n"
+			"	mfmsr %0\n"
+			"	ori %0,%0,0x8000\n"
+			"	mtmsr %0\n"
+			"	.globl __hardirq_shadow_nip\n"
+			"__hardirq_shadow_nip: isync\n"
+			: "=&r" (start), "=&r" (now)
+			: "r" (hardirq_shadow_ticks)
+			: "cr0");
+	__asm__ __volatile__("": : :"memory");
+}
+
 static inline void local_irq_save_ptr(unsigned long *flags)
 {
 	unsigned long msr;
===== kernel/irq/handle.c 1.3 vs edited =====
--- 1.3/kernel/irq/handle.c	2004-11-04 20:13:19 +01:00
+++ edited/kernel/irq/handle.c	2004-11-15 11:37:48 +01:00
@@ -35,6 +35,12 @@
 	}
 };
 
+#ifndef ARCH_SHADOW_IRQS
+#define nested_irq_enable local_irq_enable
+#endif
+
+
+
 /*
  * Generic 'no controller' code
  */
@@ -91,9 +97,9 @@
 {
 	int ret, retval = 0, status = 0;
 
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
+	if (!(action->flags & SA_INTERRUPT)) {
+		nested_irq_enable();
+	}
 	do {
 		ret = action->handler(irq, action->dev_id, regs);
 		if (ret == IRQ_HANDLED)
