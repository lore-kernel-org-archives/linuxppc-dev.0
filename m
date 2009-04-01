Return-Path: <anton@ozlabs.org>
Date: Wed, 1 Apr 2009 17:12:44 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: Add dispatch diversion statistics
Message-ID: <20090401061244.GC27084@kryten>
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


PHYP tells us how often a shared processor dispatch changed physical cpus.
This can highlight performance problems caused by the hypervisor.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/include/asm/lppaca.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/lppaca.h	2009-02-28 18:37:02.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/lppaca.h	2009-02-28 18:37:07.000000000 +1100
@@ -125,7 +125,7 @@
 	// NOTE: This value will ALWAYS be zero for dedicated processors and
 	// will NEVER be zero for shared processors (ie, initialized to a 1).
 	volatile u32 yield_count;	// PLIC increments each dispatchx00-x03
-	u32 reserved6;
+	volatile u32 dispersion_count;	// dispatch changed phys cpu    x04-x07
 	volatile u64 cmo_faults;	// CMO page fault count         x08-x0F
 	volatile u64 cmo_fault_time;	// CMO page fault time          x10-x17
 	u8	reserved7[104];		// Reserved                     x18-x7F
Index: linux-2.6/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/lparcfg.c	2009-02-28 18:37:02.000000000 +1100
+++ linux-2.6/arch/powerpc/kernel/lparcfg.c	2009-02-28 18:38:50.000000000 +1100
@@ -434,6 +434,21 @@
 	seq_printf(m, "cmo_page_size=%lu\n", cmo_get_page_size());
 }
 
+static void splpar_dispatch_data(struct seq_file *m)
+{
+	int cpu;
+	unsigned long dispatches = 0;
+	unsigned long dispatch_dispersions = 0;
+
+	for_each_possible_cpu(cpu) {
+		dispatches += lppaca[cpu].yield_count;
+		dispatch_dispersions += lppaca[cpu].dispersion_count;
+	}
+
+	seq_printf(m, "dispatches=%lu\n", dispatches);
+	seq_printf(m, "dispatch_dispersions=%lu\n", dispatch_dispersions);
+}
+
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
 {
 	int partition_potential_processors;
@@ -460,6 +475,7 @@
 		parse_ppp_data(m);
 		parse_mpp_data(m);
 		pseries_cmo_data(m);
+		splpar_dispatch_data(m);
 
 		seq_printf(m, "purr=%ld\n", get_purr());
 	} else {		/* non SPLPAR case */
