Return-Path: <anton@ozlabs.org>
Date: Tue, 5 Jan 2010 12:26:33 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/pseries: Fix xics interrupt affinity
Message-ID: <20100105012633.GA8869@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Commit 57b150cce8e004ddd36330490a68bfb59b7271e9 (irq: only update affinity if
->set_affinity() is sucessfull) broke xics irq affinity.

We need to use the cpumask passed in, instead of accessing ->affinity directly.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

This code needs a rework and a conversion to the new cpumask API,
but I will leave that for subsequent patches.

Index: linux-cpumask/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/xics.c	2010-01-05 11:06:55.658914849 +1100
+++ linux-cpumask/arch/powerpc/platforms/pseries/xics.c	2010-01-05 11:58:42.288311829 +1100
@@ -163,14 +163,13 @@ static inline void lpar_qirr_info(int n_
 /* Interface to generic irq subsystem */
 
 #ifdef CONFIG_SMP
-static int get_irq_server(unsigned int virq, unsigned int strict_check)
+static int get_irq_server(unsigned int virq, cpumask_t cpumask,
+			  unsigned int strict_check)
 {
 	int server;
 	/* For the moment only implement delivery to all cpus or one cpu */
-	cpumask_t cpumask;
 	cpumask_t tmp = CPU_MASK_NONE;
 
-	cpumask_copy(&cpumask, irq_to_desc(virq)->affinity);
 	if (!distribute_irqs)
 		return default_server;
 
@@ -192,7 +191,8 @@ static int get_irq_server(unsigned int v
 	return default_server;
 }
 #else
-static int get_irq_server(unsigned int virq, unsigned int strict_check)
+static int get_irq_server(unsigned int virq, cpumask_t cpumask,
+			  unsigned int strict_check)
 {
 	return default_server;
 }
@@ -211,7 +211,7 @@ static void xics_unmask_irq(unsigned int
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq, 0);
+	server = get_irq_server(virq, *(irq_to_desc(virq)->affinity), 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -405,7 +405,7 @@ static int xics_set_affinity(unsigned in
 	 * For the moment only implement delivery to all cpus or one cpu.
 	 * Get current irq_server for the given irq
 	 */
-	irq_server = get_irq_server(virq, 1);
+	irq_server = get_irq_server(virq, *cpumask, 1);
 	if (irq_server == -1) {
 		char cpulist[128];
 		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
