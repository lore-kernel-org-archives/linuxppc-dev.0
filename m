Date: Sun, 18 Aug 2002 23:19:01 -0500 (CDT)
Message-Id: <200208190419.g7J4J1e25498@sullivan.realtime.net>
To: Tom Rini <trini@kernel.crashing.org>, paulus@samba.org,
	Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] fix percpu heartbeats
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The changeset of Cort's patch that Troy checked in is broken in several ways:

1) The slave cpus no longer call heartbeats at all because there was a
previous continue in the loop. (reordered and used remembered cpu number)

2) The rtas call rate is per-minute not per-second.  (correct the rate)

3) All the rtas calls will occur at the same time, modulo the contended
rtas lock.  (wait to divide the rate until smp_kick_cpus).

4) It added NRCPUS*3 words to ppc_md.  It also pointed out we were modifing
this structre repeatedly at runtime.  [moved the counts to the cache hot
and dirty per-cpu irqstat and allow only one choice of function, just per
cpu countdown and period.  The count is always decremented, but only when
it reaches zero do we decide to call the function by checking the reset
value for non-zero.  The period is reset after the call, so aperiodic
users (like 4xx watchdog maybe?) could clear the count during their callback.]

I know there are other alternatives, but the cost to non-users is minimal
(an extra branch and compare every 2*32 jiffies), and the the periodic
call usage is set it up and forget it.


I'll read comments through the lists, so no need to cc me.

milton

===== arch/ppc/kernel/ppc4xx_setup.c 1.46 vs 1.47 =====
--- 1.46/arch/ppc/kernel/ppc4xx_setup.c	Fri Aug  2 11:30:01 2002
+++ 1.47/arch/ppc/kernel/ppc4xx_setup.c	Sun Aug 18 21:03:03 2002
@@ -383,6 +383,8 @@
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
 	}
 #if defined(CONFIG_PPC405_WDT)
+	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
+
 /* Look for wdt= option on command line */
 	if (strstr(cmd_line, "wdt=")) {
 		int valid_wdt = 0;
@@ -396,6 +398,26 @@
 			++q;
 		}
 		wdt_enable = valid_wdt;
+
+		/* XXX why is the wdt functoin modifing count and not
+		 * using reset ??  If this code wants kernel heartbeat
+		 * calls then:
+		 *
+		 * #include <asm/hwirq.h>
+		 * heartbeat_reset(cpu) = period_in_jiffies;
+		 * heartbeat_count(cpu) = period_in_jiffies;
+		 *
+		 * The function will be called from the timer interrupt
+		 * when the counts reaches 0, afterwards the count will
+		 * be set to the heartbeat_reset(cpu) value (which
+		 * could be cleard during call for one-shot mode).
+		 *
+		 * If the code doesn't want the count manageed it
+		 * should not use the kernel callbacks (or set reset
+		 * to 1 and use its own counters).
+		 */
+#error sanitize wdt and kernel heartbeat interactions
+
 	}
 #endif

@@ -411,11 +433,6 @@
 	ppc_md.halt = ppc4xx_halt;

 	ppc_md.calibrate_decr = ppc4xx_calibrate_decr;
-
-#ifdef CONFIG_PPC405_WDT
-	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
-#endif
-	ppc_md.heartbeat_count = 0;

 	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
 	ppc_md.setup_io_mappings = m4xx_map_io;
===== arch/ppc/kernel/time.c 1.43 vs 1.44 =====
--- 1.43/arch/ppc/kernel/time.c	Sat Aug 17 21:55:14 2002
+++ 1.44/arch/ppc/kernel/time.c	Sun Aug 18 21:42:02 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.time.c 1.43 08/18/02 12:55:14 paulus
+ * BK Id: SCCS/s.time.c 1.44 08/18/02 21:42:02 miltonm
  */
 /*
  * Common time routines among all ppc machines.
@@ -164,7 +164,12 @@
 		jiffy_stamp += tb_ticks_per_jiffy;
 		if (!user_mode(regs))
 			ppc_do_profile(instruction_pointer(regs));
-	  	if (smp_processor_id())
+		if ( unlikely(!heartbeat_count(cpu)--)
+				&& heartbeat_reset(cpu) ) {
+			ppc_md.heartbeat();
+			heartbeat_count(cpu) = heartbeat_reset(cpu);
+		}
+	  	if (cpu)
 			continue;

 		/* We are in an interrupt, no need to save/restore flags */
@@ -200,18 +205,9 @@
 		}
 		write_unlock(&xtime_lock);

-		/*
-		 * We need to make sure we catch up with lost interrupts
-		 * so we do it in this loop rather than after this
-		 * loop like we used to do.
-		 *     -- Cort <cort@fsmlabs.com>
-		 */
-		if ( ppc_md.heartbeat[smp_processor_id()] &&
-		     !ppc_md.heartbeat_count[smp_processor_id()]-- )
-			ppc_md.heartbeat[smp_processor_id()]();

 	}
-	if ( !disarm_decr[smp_processor_id()] )
+	if ( !disarm_decr[cpu] )
 		set_dec(next_dec);
 	last_jiffy_stamp(cpu) = jiffy_stamp;

===== arch/ppc/platforms/chrp_setup.c 1.65 vs 1.66 =====
--- 1.65/arch/ppc/platforms/chrp_setup.c	Sat Aug 17 21:55:14 2002
+++ 1.66/arch/ppc/platforms/chrp_setup.c	Sun Aug 18 22:51:24 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.chrp_setup.c 1.65 08/18/02 12:55:14 paulus
+ * BK Id: SCCS/s.chrp_setup.c 1.66 08/18/02 22:51:24 miltonm
  */
 /*
  *  arch/ppc/platforms/setup.c
@@ -225,8 +225,6 @@
 chrp_setup_arch(void)
 {
 	struct device_node *device;
-	int i;
-	extern unsigned long smp_chrp_cpu_nr;

 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000/HZ;
@@ -268,54 +266,34 @@
 	/* Get the event scan rate for the rtas so we know how
 	 * often it expects a heartbeat. -- Cort
 	 */
-	if ( rtas_data )
-	{
+	if ( rtas_data ) {
 		struct property *p;
+		unsigned long rate, count;
 		device = find_devices("rtas");
 		for ( p = device->properties;
 		      p && strncmp(p->name, "rtas-event-scan-rate", 20);
 		      p = p->next )
 			/* nothing */ ;
-		if ( p && *(unsigned long *)p->value )
-		{
-
+		if ( p && ( rate = *(unsigned long *)p->value ) > 0) {
 			/*
-			 * The CHRP RTAS note on multiprocessor systems:
-			 * "In a multiprocessor system, each processor should
-			 * call event-scan periodically, not always the same
-			 * one.  The event-scan function needs to be called a
-			 * total of rtas-event-scan-rate times a minute"
-			 *
-			 * My interpretation of the Chrp docs on the
-			 * scan rate is that not every CPU has to do
-			 * the event scan.  It seems to suggest that
-			 * occasionally a different CPU should scan
-			 * RTAS but this is so vague I think the authors
-			 * considered it unimportant.
-			 *
-			 * Paul disagrees, so I run the event scan on each
-			 * CPU.  This is probably safe since it won't hurt
-			 * and will only slow things down a bit.
+			 * The value is the number of times per minute.
+			 * For now assign the full workload here to cpu 0.
 			 *
-			 * -- Cort <cort@fsmlabs.com>
+			 * We now split the rate and spread the heartbeats
+			 * when we kick secondary cpus so we can spread
+			 * the calls evenly.
 			 */
-			int rate;
+			ppc_md.heartbeat = chrp_event_scan;
+
+			count = (60*HZ) / rate;
+			if (!count)        /* XXX insane */
+				count = 1;
+
+			heartbeat_reset(0) = count;
+			heartbeat_count(0) = 1;

-			/* avoid div 0 problems */
-			if ( smp_chrp_cpu_nr )
-				rate = *(ulong *)p->value / smp_chrp_cpu_nr;
-			else
-				rate = *(ulong *)p->value;
-
-			for ( i = 0; i < smp_chrp_cpu_nr ; i++ )
-			{
-				ppc_md.heartbeat[i] = chrp_event_scan;
-				ppc_md.heartbeat_reset[i] = (HZ/rate)-1;
-				ppc_md.heartbeat_count[i] = 1;
-			}
 			printk("RTAS Event Scan Rate: %lu calls/minute "
-			       "(%lu jiffies/cpu)\n",
-			       *(unsigned long *)p->value, rate );
+			       "(every %lu jiffies)\n", rate, count );
 		}
 	}

@@ -330,8 +308,6 @@
 	/* XXX: we should loop until the hardware says no more error logs -- Cort */
 	call_rtas( "event-scan", 4, 1, &ret, 0xffffffff, 0,
 		   __pa(log), 1024 );
-	ppc_md.heartbeat_count[smp_processor_id()] =
-		ppc_md.heartbeat_reset[smp_processor_id()];
 }

 void __chrp
===== arch/ppc/platforms/chrp_smp.c 1.8 vs 1.9 =====
--- 1.8/arch/ppc/platforms/chrp_smp.c	Tue Aug 13 06:52:54 2002
+++ 1.9/arch/ppc/platforms/chrp_smp.c	Sun Aug 18 22:32:11 2002
@@ -41,6 +41,35 @@

 extern unsigned long smp_chrp_cpu_nr;

+/*
+ * The CHRP RTAS note on multiprocessor systems:
+ * "In a multiprocessor system, each processor should
+ * call event-scan periodically, not always the same
+ * one.  The event-scan function needs to be called a
+ * total of rtas-event-scan-rate times a minute"
+ *
+ * We must call on each cpu in on a regular basis
+ * so that firmware can watch for cpu unique errors.
+ */
+static void spread_heartbeat(void)
+{
+	unsigned count = heartbeat_count(0);
+	unsigned offset = count;
+	int i;
+
+	if ( !count || smp_chrp_cpu_nr < 2)
+		return;
+
+	count *=  smp_chrp_cpu_nr;
+
+	for ( i = 0; i < smp_chrp_cpu_nr ; i++ )
+	{
+		heartbeat_reset(i) = count;
+		heartbeat_count(i) = i * offset;
+	}
+	printk("RTAS Event Scan now every %u jiffes on each cpu\n", count);
+}
+
 static int __init
 smp_chrp_probe(void)
 {
@@ -96,6 +125,8 @@

 	if (OpenPIC_Addr)
 		do_openpic_setup_cpu();
+
+	spread_heartbeat();
 }

 /* CHRP with openpic */
===== arch/ppc/platforms/ev64260_setup.c 1.15 vs 1.16 =====
--- 1.15/arch/ppc/platforms/ev64260_setup.c	Wed Aug  7 14:18:05 2002
+++ 1.16/arch/ppc/platforms/ev64260_setup.c	Sun Aug 18 21:03:03 2002
@@ -523,10 +523,6 @@
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;

-	ppc_md.heartbeat = NULL;
-	ppc_md.heartbeat_reset = 0;
-	ppc_md.heartbeat_count = 0;
-
 #ifdef	CONFIG_SERIAL_TEXT_DEBUG
 	ev64260_set_bat();
 #ifdef	CONFIG_GT64260_CONSOLE
===== arch/ppc/platforms/gemini_setup.c 1.33 vs 1.34 =====
--- 1.33/arch/ppc/platforms/gemini_setup.c	Sat Aug 17 21:55:15 2002
+++ 1.34/arch/ppc/platforms/gemini_setup.c	Sun Aug 18 21:03:03 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.gemini_setup.c 1.33 08/18/02 12:55:15 paulus
+ * BK Id: SCCS/s.gemini_setup.c 1.34 08/18/02 21:03:03 miltonm
  */
 /*
  *  arch/ppc/platforms/setup.c
@@ -37,6 +37,7 @@
 #include <asm/time.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
+#include <asm/hardirq.h> /* for heartbeat */

 void gemini_find_bridges(void);
 static int gemini_get_clock_speed(void);
@@ -151,17 +152,22 @@
 	static unsigned long led = GEMINI_LEDBASE+(4*8);
 	static char direction = 8;

-
+#if 1
 	/* We only want to do this on 1 CPU */
-	if (smp_processor_id())
+	if (smp_processor_id()) {
+		static short ratelimit;
+		if (!ratelimit++)
+			printk(KERN_ERR "%s: unexpected heartbeat on cpu %d\n",
+					__FUNCTION__, smp_processor_id());
 		return;
+		}
+#endif
 	*(char *)led = 0;
 	if ( (led + direction) > (GEMINI_LEDBASE+(7*8)) ||
 	     (led + direction) < (GEMINI_LEDBASE+(4*8)) )
 		direction *= -1;
 	led += direction;
 	*(char *)led = 0xff;
-	ppc_md.heartbeat_count[0] = ppc_md.heartbeat_reset[0];
 }

 void __init gemini_setup_arch(void)
@@ -184,9 +190,10 @@

 	printk("Boot arguments: %s\n", cmd_line);

-	ppc_md.heartbeat[0] = gemini_heartbeat;
-	ppc_md.heartbeat_reset[0] = HZ/8;
-	ppc_md.heartbeat_count[0] = 1;
+	ppc_md.heartbeat = gemini_heartbeat;
+	/* only run on cpu 0 */
+	heartbeat_reset(0) = HZ/8;
+	heartbeat_count(0) = 1;

 	/* Lookup PCI hosts */
 	gemini_find_bridges();
===== arch/ppc/platforms/mcpn765_setup.c 1.26 vs 1.27 =====
--- 1.26/arch/ppc/platforms/mcpn765_setup.c	Wed Aug  7 14:18:06 2002
+++ 1.27/arch/ppc/platforms/mcpn765_setup.c	Sun Aug 18 21:03:03 2002
@@ -389,10 +389,6 @@
 	ppc_md.nvram_read_val = todc_m48txx_read_val;
 	ppc_md.nvram_write_val = todc_m48txx_write_val;

-	ppc_md.heartbeat = NULL;
-	ppc_md.heartbeat_reset = 0;
-	ppc_md.heartbeat_count = 0;
-
 #ifdef	CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = mcpn765_progress;
 #endif
===== arch/ppc/platforms/sandpoint_setup.c 1.27 vs 1.28 =====
--- 1.27/arch/ppc/platforms/sandpoint_setup.c	Wed Aug  7 14:18:07 2002
+++ 1.28/arch/ppc/platforms/sandpoint_setup.c	Sun Aug 18 21:03:03 2002
@@ -660,10 +660,6 @@
 	ppc_md.nvram_read_val = todc_mc146818_read_val;
 	ppc_md.nvram_write_val = todc_mc146818_write_val;

-	ppc_md.heartbeat = NULL;
-	ppc_md.heartbeat_reset = 0;
-	ppc_md.heartbeat_count = 0;
-
 #ifdef	CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = sandpoint_progress;
 #endif
===== arch/ppc/platforms/zx4500_setup.c 1.18 vs 1.19 =====
--- 1.18/arch/ppc/platforms/zx4500_setup.c	Wed Aug  7 14:18:07 2002
+++ 1.19/arch/ppc/platforms/zx4500_setup.c	Sun Aug 18 21:03:03 2002
@@ -346,10 +346,6 @@

 	ppc_md.calibrate_decr = zx4500_calibrate_decr;

-	ppc_md.heartbeat = NULL;
-	ppc_md.heartbeat_reset = 0;
-	ppc_md.heartbeat_count = 0;
-
 #ifdef	CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = zx4500_progress;
 #else	/* !CONFIG_SERIAL_TEXT_DEBUG */
===== include/asm-ppc/hardirq.h 1.16 vs 1.17 =====
--- 1.16/include/asm-ppc/hardirq.h	Tue Nov 27 20:29:57 2001
+++ 1.17/include/asm-ppc/hardirq.h	Sun Aug 18 21:03:03 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.hardirq.h 1.16 11/28/01 13:29:57 paulus
+ * BK Id: SCCS/s.hardirq.h 1.17 08/18/02 21:03:03 miltonm
  */
 #ifdef __KERNEL__
 #ifndef __ASM_HARDIRQ_H
@@ -21,11 +21,15 @@
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task;
 	unsigned int __last_jiffy_stamp;
+	unsigned int __heartbeat_count;
+	unsigned int __heartbeat_reset;
 } ____cacheline_aligned irq_cpustat_t;

 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */

 #define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
+#define heartbeat_count(cpu) __IRQ_STAT((cpu), __heartbeat_count)
+#define heartbeat_reset(cpu) __IRQ_STAT((cpu), __heartbeat_reset)
 /*
  * Are we in an interrupt context? Either doing bottom half
  * or hardware interrupt processing?
===== include/asm-ppc/machdep.h 1.43 vs 1.44 =====
--- 1.43/include/asm-ppc/machdep.h	Sat Aug 17 21:55:15 2002
+++ 1.44/include/asm-ppc/machdep.h	Sun Aug 18 21:03:03 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.machdep.h 1.43 08/18/02 12:55:15 paulus
+ * BK Id: SCCS/s.machdep.h 1.44 08/18/02 21:03:03 miltonm
  */
 #ifdef __KERNEL__
 #ifndef _PPC_MACHDEP_H
@@ -44,10 +44,7 @@
 	int		(*set_rtc_time)(unsigned long nowtime);
 	unsigned long	(*get_rtc_time)(void);
 	void		(*calibrate_decr)(void);
-
-	void		(*heartbeat[NR_CPUS])(void);
-	unsigned long	heartbeat_reset[NR_CPUS];
-	unsigned long	heartbeat_count[NR_CPUS];
+	void		(*heartbeat)(void);

 	unsigned long	(*find_end_of_memory)(void);
 	void		(*setup_io_mappings)(void);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
