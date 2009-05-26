Return-Path: <anton@ozlabs.org>
Date: Tue, 26 May 2009 16:25:49 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Convert RTAS event scan from kernel thread to
	workqueue
Message-ID: <20090526062549.GH19728@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


RTAS event scan has to run across all cpus. Right now we use a kernel
thread and set_cpus_allowed but in doing so we wake up the previous cpu
unnecessarily.

Some ftrace output shows this:

previous cpu (2):
[002]  7.022331: sched_switch: task swapper:0 [140] ==> rtasd:194 [120]
[002]  7.022338: sched_switch: task rtasd:194 [120] ==> migration/2:9 [0]
[002]  7.022344: sched_switch: task migration/2:9 [0] ==> swapper:0 [140]

next cpu (3):
[003]  7.022345: sched_switch: task swapper:0 [140] ==> rtasd:194 [120]
[003]  7.022371: sched_switch: task rtasd:194 [120] ==> swapper:0 [140]

We can use schedule_delayed_work_on and avoid the unnecessary wakeup. 

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/rtasd.c	2009-03-15 17:03:45.000000000 +1100
+++ linux-2.6/arch/powerpc/platforms/pseries/rtasd.c	2009-05-26 16:02:39.000000000 +1000
@@ -19,7 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/spinlock.h>
 #include <linux/cpu.h>
-#include <linux/delay.h>
+#include <linux/workqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -387,36 +387,51 @@
 	} while(error == 0);
 }
 
-static void do_event_scan_all_cpus(long delay)
+static void rtas_event_scan(struct work_struct *w);
+DECLARE_DELAYED_WORK(event_scan_work, rtas_event_scan);
+
+/*
+ * Delay should be at least one second since some machines have problems if
+ * we call event-scan too quickly.
+ */
+static unsigned long event_scan_delay = 1*HZ;
+static int first_pass = 1;
+
+static void rtas_event_scan(struct work_struct *w)
 {
-	int cpu;
+	unsigned int cpu;
+
+	do_event_scan();
 
 	get_online_cpus();
-	cpu = first_cpu(cpu_online_map);
-	for (;;) {
-		set_cpus_allowed(current, cpumask_of_cpu(cpu));
-		do_event_scan();
-		set_cpus_allowed(current, CPU_MASK_ALL);
-
-		/* Drop hotplug lock, and sleep for the specified delay */
-		put_online_cpus();
-		msleep_interruptible(delay);
-		get_online_cpus();
 
-		cpu = next_cpu(cpu, cpu_online_map);
-		if (cpu == NR_CPUS)
-			break;
+	cpu = next_cpu(smp_processor_id(), cpu_online_map);
+	if (cpu == NR_CPUS) {
+		cpu = first_cpu(cpu_online_map);
+
+		if (first_pass) {
+			first_pass = 0;
+			event_scan_delay = 30*HZ/rtas_event_scan_rate;
+
+			if (surveillance_timeout != -1) {
+				pr_debug("rtasd: enabling surveillance\n");
+				enable_surveillance(surveillance_timeout);
+				pr_debug("rtasd: surveillance enabled\n");
+			}
+		}
 	}
+
+	schedule_delayed_work_on(cpu, &event_scan_work,
+		__round_jiffies_relative(event_scan_delay, cpu));
+
 	put_online_cpus();
 }
 
-static int rtasd(void *unused)
+static void start_event_scan(void)
 {
 	unsigned int err_type;
 	int rc;
 
-	daemonize("rtasd");
-
 	printk(KERN_DEBUG "RTAS daemon started\n");
 	pr_debug("rtasd: will sleep for %d milliseconds\n",
 		 (30000 / rtas_event_scan_rate));
@@ -434,22 +449,8 @@
 		}
 	}
 
-	/* First pass. */
-	do_event_scan_all_cpus(1000);
-
-	if (surveillance_timeout != -1) {
-		pr_debug("rtasd: enabling surveillance\n");
-		enable_surveillance(surveillance_timeout);
-		pr_debug("rtasd: surveillance enabled\n");
-	}
-
-	/* Delay should be at least one second since some
-	 * machines have problems if we call event-scan too
-	 * quickly. */
-	for (;;)
-		do_event_scan_all_cpus(30000/rtas_event_scan_rate);
-
-	return -EINVAL;
+	schedule_delayed_work_on(first_cpu(cpu_online_map), &event_scan_work,
+				 event_scan_delay);
 }
 
 static int __init rtas_init(void)
@@ -487,8 +488,7 @@
 	if (!entry)
 		printk(KERN_ERR "Failed to create error_log proc entry\n");
 
-	if (kernel_thread(rtasd, NULL, CLONE_FS) < 0)
-		printk(KERN_ERR "Failed to start RTAS daemon\n");
+	start_event_scan();
 
 	return 0;
 }
