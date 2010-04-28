Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 29 Apr 2010 09:39:41 +1000
Subject: [PATCH 1/2] powerpc: make query_cpu_stopped callable outside hotplug
	cpu
Message-Id: <20100428233941.36227CBAFC@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, ankita@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves query_cpu_stopped() out of the hotplug cpu code and into
smp.c so it can called in other places and renames it to
smp_query_cpu_stopped().

It also cleans up the return values by adding some #defines

Cc: <stable@kernel.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   30 +++---------------------
 arch/powerpc/platforms/pseries/plpar_wrappers.h |    8 ++++++
 arch/powerpc/platforms/pseries/smp.c            |   22 +++++++++++++++++
 3 files changed, 34 insertions(+), 26 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -154,30 +154,6 @@ static void pseries_mach_cpu_die(void)
 	for(;;);
 }
 
-static int qcss_tok;	/* query-cpu-stopped-state token */
-
-/* Get state of physical CPU.
- * Return codes:
- *	0	- The processor is in the RTAS stopped state
- *	1	- stop-self is in progress
- *	2	- The processor is not in the RTAS stopped state
- *	-1	- Hardware Error
- *	-2	- Hardware Busy, Try again later.
- */
-static int query_cpu_stopped(unsigned int pcpu)
-{
-	int cpu_status, status;
-
-	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
-	if (status != 0) {
-		printk(KERN_ERR
-		       "RTAS query-cpu-stopped-state failed: %i\n", status);
-		return status;
-	}
-
-	return cpu_status;
-}
-
 static int pseries_cpu_disable(void)
 {
 	int cpu = smp_processor_id();
@@ -224,8 +200,9 @@ static void pseries_cpu_die(unsigned int
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
 
 		for (tries = 0; tries < 25; tries++) {
-			cpu_status = query_cpu_stopped(pcpu);
-			if (cpu_status == 0 || cpu_status == -1)
+			cpu_status = smp_query_cpu_stopped(pcpu);
+			if (cpu_status == QCSS_STOPPED ||
+			    cpu_status == QCSS_HARDWARE_ERROR)
 				break;
 			cpu_relax();
 		}
@@ -388,6 +365,7 @@ static int __init pseries_cpu_hotplug_in
 	struct device_node *np;
 	const char *typep;
 	int cpu;
+	int qcss_tok;
 
 	for_each_node_by_name(np, "interrupt-controller") {
 		typep = of_get_property(np, "compatible", NULL);
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -4,6 +4,14 @@
 #include <asm/hvcall.h>
 #include <asm/page.h>
 
+/* Get state of physical CPU from query_cpu_stopped */
+int smp_query_cpu_stopped(unsigned int pcpu);
+#define QCSS_STOPPED 0
+#define QCSS_STOPPING 1
+#define QCSS_NOT_STOPPED 2
+#define QCSS_HARDWARE_ERROR -1
+#define QCSS_HARDWARE_BUSY -2
+
 static inline long poll_pending(void)
 {
 	return plpar_hcall_norets(H_POLL_PENDING);
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/smp.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/smp.c
@@ -57,6 +57,28 @@
  */
 static cpumask_t of_spin_map;
 
+/* Query where a cpu is now.  Return codes #defined in plpar_wrappers.h */
+int smp_query_cpu_stopped(unsigned int pcpu)
+{
+	int cpu_status, status;
+	int qcss_tok = rtas_token("query-cpu-stopped-state");
+
+	if (qcss_tok == RTAS_UNKNOWN_SERVICE) {
+		printk(KERN_INFO "Firmware doesn't support "
+				"query-cpu-stopped-state\n");
+		return QCSS_HARDWARE_ERROR;
+	}
+
+	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
+	if (status != 0) {
+		printk(KERN_ERR
+		       "RTAS query-cpu-stopped-state failed: %i\n", status);
+		return status;
+	}
+
+	return cpu_status;
+}
+
 /**
  * smp_startup_cpu() - start the given cpu
  *
