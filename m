Message-ID: <3B842E9A.21372A5A@nortelnetworks.com>
Date: Wed, 22 Aug 2001 18:13:46 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: adding support for irq-based entropy addition (comments requested)
Content-Type: multipart/mixed;
 boundary="------------2C41B73ABBEE7A5C39823FCC"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------2C41B73ABBEE7A5C39823FCC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Currently in the 2.2 kernel there is no support for collecting entropy based on
interrupts, and the entropy measurement that we do have for ppc is based on
jiffies.

I've included two patches against the stock kernel.org 2.2.19, with are related
but independent (although the second one would really be best if the first is
also applied).

The first patch adds support for higher precision timing using the timebase
register on machines where CONFIG_6xx is defined.  Since the PPC601 doesn't
support this, I've added a flag to let us know if the timebase registers are
present.  If this flag already exists somewhere I'd love to know so that I can
get rid of this addition. This patch affects all existing measurements of
entropy.

The second patch adds support for collecting entropy from the timing of irqs
that have set the SA_SAMPLE_RANDOM flag.  This could be useful for headless
devices, as it enables the collection of entropy from network traffic.  There is
currently a discussion as to the safety of this on the lkml, but in some cases
there is little other choice.

Any comments are welcome.

Chris

--
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
--------------2C41B73ABBEE7A5C39823FCC
Content-Type: text/plain; charset=us-ascii;
 name="randomprecision.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="randomprecision.patch"

diff -ru linux-2.2.19-clean/arch/ppc/kernel/setup.c linux-2.2.19/arch/ppc/kernel/setup.c
--- linux-2.2.19-clean/arch/ppc/kernel/setup.c	Sun Mar 25 11:31:49 2001
+++ linux-2.2.19/arch/ppc/kernel/setup.c	Wed Aug 22 16:34:51 2001
@@ -103,6 +103,14 @@
 unsigned long vgacon_remap_base;
 #endif

+/* the PPC601 chip does not support timebase registers,
+ * so this is used to keep track of whether or not we
+ * support them
+ */
+#ifdef CONFIG_6xx
+int have_timebase = 1;
+#endif /* CONFIG_6xx */
+
 /* copy of the residual data */
 #ifndef CONFIG_MBX
 unsigned char __res[sizeof(RESIDUAL)] __prepdata = {0,};
@@ -243,6 +251,7 @@
 		{
 		case 1:
 			len += sprintf(len+buffer, "601\n");
+			have_timebase = 0;
 			break;
 		case 3:
 			len += sprintf(len+buffer, "603\n");
diff -ru linux-2.2.19-clean/drivers/char/random.c linux-2.2.19/drivers/char/random.c
--- linux-2.2.19-clean/drivers/char/random.c	Sun Mar 25 11:31:25 2001
+++ linux-2.2.19/drivers/char/random.c	Wed Aug 22 16:35:34 2001
@@ -699,6 +699,7 @@
  * are used for a high-resolution timer.
  *
  */
+
 static void add_timer_randomness(struct random_bucket *r,
 				 struct timer_rand_state *state, unsigned num)
 {
@@ -715,6 +716,16 @@
 			:"=a" (time), "=d" (high));
 		num ^= high;
 	} else {
+		time = jiffies;
+	}
+#elif defined (CONFIG_6xx)
+	if (have_timebase) {
+		__u32 high;
+		__asm__ __volatile__("mftbu %0" : "=r" (high) : );
+		__asm__ __volatile__("mftb %0" : "=r" (time) : );
+		num ^= high;
+	}
+	else {
 		time = jiffies;
 	}
 #else
diff -ru linux-2.2.19-clean/include/asm-ppc/processor.h linux-2.2.19/include/asm-ppc/processor.h
--- linux-2.2.19-clean/include/asm-ppc/processor.h	Sun Mar 25 11:31:08 2001
+++ linux-2.2.19/include/asm-ppc/processor.h	Wed Aug 22 16:34:51 2001
@@ -216,6 +216,14 @@
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
 void release_thread(struct task_struct *);

+/* the PPC601 chip does not support timebase registers,
+ * so this is used to keep track of whether or not we
+ * support them
+ */
+#ifdef CONFIG_6xx
+extern int have_timebase;
+#endif /* CONFIG_6xx */
+
 /*
  * Create a new kernel thread.
  */

--------------2C41B73ABBEE7A5C39823FCC
Content-Type: text/plain; charset=us-ascii;
 name="irqrandom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irqrandom.patch"

--- linux-2.2.19-clean/arch/ppc/kernel/irq.c	Sun Mar 25 11:31:48 2001
+++ linux-2.2.19/arch/ppc/kernel/irq.c	Wed Aug 22 17:13:01 2001
@@ -161,6 +161,10 @@
 	if (!action)
 		return -ENOMEM;

+	/* This function might sleep, we want to call it before disabling interrupts */
+	if (irqflags & SA_SAMPLE_RANDOM)
+		rand_initialize_irq(irq);
+
 	save_flags(flags);
 	cli();

@@ -274,6 +278,8 @@
 			action->handler(irq, action->dev_id, regs);
 			action = action->next;
 		} while ( action );
+		if (status & SA_SAMPLE_RANDOM)
+			add_interrupt_randomness(irq);
 		__cli();
 		unmask_irq(irq);
 	} else {

--------------2C41B73ABBEE7A5C39823FCC--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
