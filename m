Date: Sun, 19 Aug 2001 01:04:59 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: wait_on_irq race condition? (and solution??)
Message-ID: <20010819010458.T22585@altus.drgw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ni93GHxFvA+th69W"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've run into problems with 'wait_on_irq' where global_irq_count was 1,
but neither had anything in local_irq_count.

I think the race condition that Linus found that we ignore might actually
matter..

Anway, I made our irq.c look more like x86's, and it seems to have solved
the problem on my MTX so far.

Should I commit this to 2_4_devel?

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wait_on_irq.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.323   -> 1.324
#	arch/ppc/kernel/irq.c	1.34    -> 1.35
#	arch/ppc/kernel/ppc_ksyms.c	1.53    -> 1.54
#	include/asm-ppc/hardirq.h	1.13    -> 1.14
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 01/08/19	hozer@narn.(none)	1.324
# Fix what seems to be a subtle race in wait_on_irq
# --------------------------------------------
#
diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	Sun Aug 19 00:55:33 2001
+++ b/arch/ppc/kernel/irq.c	Sun Aug 19 00:55:33 2001
@@ -592,7 +592,6 @@
 #ifdef CONFIG_SMP
 unsigned char global_irq_holder = NO_PROC_ID;
 unsigned volatile long global_irq_lock; /* pendantic :long for set_bit--RR*/
-atomic_t global_irq_count;

 atomic_t global_bh_count;

@@ -603,8 +602,7 @@
 	int cpu = smp_processor_id();

 	printk("\n%s, CPU %d:\n", str, cpu);
-	printk("irq:  %d [%d %d]\n",
-	       atomic_read(&global_irq_count),
+	printk("irq:  [%d %d]\n",
 	       local_irq_count(0),
 	       local_irq_count(1));
 	printk("bh:   %d [%d %d]\n",
@@ -644,11 +642,9 @@
 		 * for bottom half handlers unless we're
 		 * already executing in one..
 		 */
-		if (!atomic_read(&global_irq_count)) {
-			if (local_bh_count(cpu)
-			    || !atomic_read(&global_bh_count))
-				break;
-		}
+		if (!irqs_running())
+			if (local_bh_count(cpu) || !spin_is_locked(&global_bh_lock))
+					break;

 		/* Duh, we have to loop. Release the lock to avoid deadlocks */
 		clear_bit(0,&global_irq_lock);
@@ -656,19 +652,18 @@
 		for (;;) {
 			if (!--count) {
 				show("wait_on_irq");
-				count = ~0;
+				count = MAXCOUNT;
+				xmon(0);
 			}
 			__sti();
-			/* don't worry about the lock race Linus found
-			 * on intel here. -- Cort
-			 */
+			/* We have to allow irqs to arrive between __sti and __cli */
+			__asm__ __volatile__ ("nop")
 			__cli();
-			if (atomic_read(&global_irq_count))
+			if (irqs_running())
 				continue;
 			if (global_irq_lock)
 				continue;
-			if (!local_bh_count(cpu)
-			    && atomic_read(&global_bh_count))
+			if (!local_bh_count(cpu) && spin_is_locked(&global_bh_lock))
 				continue;
 			if (!test_and_set_bit(0,&global_irq_lock))
 				break;
@@ -699,7 +694,7 @@
  */
 void synchronize_irq(void)
 {
-	if (atomic_read(&global_irq_count)) {
+	if (irqs_running()) {
 		/* Stupid approach */
 		cli();
 		sti();
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Sun Aug 19 00:55:33 2001
+++ b/arch/ppc/kernel/ppc_ksyms.c	Sun Aug 19 00:55:33 2001
@@ -1,5 +1,5 @@
 /*
- * BK Id: %F% %I% %G% %U% %#%
+ * BK Id: SCCS/s.ppc_ksyms.c 1.53 08/17/01 12:19:59 trini
  */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -193,7 +193,6 @@
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(global_irq_lock);
-EXPORT_SYMBOL(global_irq_count);
 EXPORT_SYMBOL(global_irq_holder);
 EXPORT_SYMBOL(__global_cli);
 EXPORT_SYMBOL(__global_sti);
@@ -204,10 +203,10 @@
 EXPORT_SYMBOL(_spin_unlock);
 EXPORT_SYMBOL(spin_trylock);
 #endif
-EXPORT_SYMBOL(_read_lock);
-EXPORT_SYMBOL(_read_unlock);
-EXPORT_SYMBOL(_write_lock);
-EXPORT_SYMBOL(_write_unlock);
+EXPORT_SYMBOL(read_lock);
+EXPORT_SYMBOL(read_unlock);
+EXPORT_SYMBOL(write_lock);
+EXPORT_SYMBOL(write_unlock);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_hw_index);
 EXPORT_SYMBOL(smp_num_cpus);
diff -Nru a/include/asm-ppc/hardirq.h b/include/asm-ppc/hardirq.h
--- a/include/asm-ppc/hardirq.h	Sun Aug 19 00:55:33 2001
+++ b/include/asm-ppc/hardirq.h	Sun Aug 19 00:55:33 2001
@@ -1,5 +1,5 @@
 /*
- * BK Id: %F% %I% %G% %U% %#%
+ * BK Id: SCCS/s.hardirq.h 1.13 07/18/01 20:18:42 %#%
  */
 #ifdef __KERNEL__
 #ifndef __ASM_HARDIRQ_H
@@ -52,6 +52,16 @@
 extern unsigned char global_irq_holder;
 extern unsigned volatile long global_irq_lock;
 extern atomic_t global_irq_count;
+
+static inline int irqs_running (void)
+{
+	int i;
+
+	for (i = 0; i < smp_num_cpus; i++)
+		if (local_irq_count(i))
+			return 1;
+		return 0;
+}

 static inline void release_irqlock(int cpu)
 {

--ni93GHxFvA+th69W--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
