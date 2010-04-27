Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.378682127@samba.org>
Date: Tue, 27 Apr 2010 11:32:40 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 09/15] powerpc: cpumask: Convert /proc/cpuinfo to new cpumask
	API
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

Use new cpumask API in /proc/cpuinfo code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/setup-common.c	2010-04-22 13:03:19.866696740 +1000
+++ linux-cpumask/arch/powerpc/kernel/setup-common.c	2010-04-22 13:03:21.075446071 +1000
@@ -200,11 +200,6 @@ static int show_cpuinfo(struct seq_file 
 	unsigned short maj;
 	unsigned short min;
 
-	if (cpu_id == NR_CPUS) {
-		show_cpuinfo_summary(m);
-		return 0;
-	}
-
 	/* We only show online cpus: disable preempt (overzealous, I
 	 * knew) to prevent cpu going down. */
 	preempt_disable();
@@ -312,19 +307,28 @@ static int show_cpuinfo(struct seq_file 
 #endif
 
 	preempt_enable();
+
+	/* If this is the last cpu, print the summary */
+	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
+		show_cpuinfo_summary(m);
+
 	return 0;
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	unsigned long i = *pos;
-
-	return i <= NR_CPUS ? (void *)(i + 1) : NULL;
+	if (*pos == 0)	/* just in case, cpu 0 is not the first */
+		*pos = cpumask_first(cpu_online_mask);
+	else
+		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	if ((*pos) < nr_cpu_ids)
+		return (void *)(*pos + 1);
+	return NULL;
 }
 
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	++*pos;
+	(*pos)++;
 	return c_start(m, pos);
 }
 
