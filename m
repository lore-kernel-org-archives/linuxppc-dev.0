Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013431.686335776@samba.org>
Date: Tue, 27 Apr 2010 11:32:33 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 02/15] powerpc: cpumask: Convert rtasd to new cpumask API
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use cpumask_first, cpumask_next in rtasd code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/kernel/rtasd.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/rtasd.c	2010-04-08 19:46:04.419206665 +1000
+++ linux-cpumask/arch/powerpc/kernel/rtasd.c	2010-04-22 13:03:10.035445948 +1000
@@ -411,9 +411,9 @@ static void rtas_event_scan(struct work_
 
 	get_online_cpus();
 
-	cpu = next_cpu(smp_processor_id(), cpu_online_map);
-	if (cpu == NR_CPUS) {
-		cpu = first_cpu(cpu_online_map);
+	cpu = cpumask_next(smp_processor_id(), cpu_online_mask);
+        if (cpu >= nr_cpu_ids) {
+		cpu = cpumask_first(cpu_online_mask);
 
 		if (first_pass) {
 			first_pass = 0;
@@ -466,8 +466,8 @@ static void start_event_scan(void)
 	/* Retreive errors from nvram if any */
 	retreive_nvram_error_log();
 
-	schedule_delayed_work_on(first_cpu(cpu_online_map), &event_scan_work,
-				 event_scan_delay);
+	schedule_delayed_work_on(cpumask_first(cpu_online_mask),
+				 &event_scan_work, event_scan_delay);
 }
 
 static int __init rtas_init(void)
