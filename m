Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 05 Dec 2006 17:52:38 +1100
Subject: [PATCH 4/5] Only enable cpu hotplug via RTAS if the required firmware
	support is found
In-Reply-To: <1165301556.843426.760217571714.qpush@cradle>
Message-Id: <20061205065236.A77FA67BC1@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To support cpu hotplug on pseries we require two RTAS tokens, the cpu
hotplug machinery should only be wired up if these tokens are found in
the device tree.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/hotplug-cpu.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -64,6 +64,8 @@ static void pSeries_mach_cpu_die(void)
 	for(;;);
 }
 
+static int qcss_tok;	/* query-cpu-stopped-state token */
+
 /* Get state of physical CPU.
  * Return codes:
  *	0	- The processor is in the RTAS stopped state
@@ -74,12 +76,8 @@ static void pSeries_mach_cpu_die(void)
  */
 static int query_cpu_stopped(unsigned int pcpu)
 {
-	int cpu_status;
-	int status, qcss_tok;
+	int cpu_status, status;
 
-	qcss_tok = rtas_token("query-cpu-stopped-state");
-	if (qcss_tok == RTAS_UNKNOWN_SERVICE)
-		return -1;
 	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
 	if (status != 0) {
 		printk(KERN_ERR
@@ -254,9 +252,16 @@ static struct notifier_block pSeries_smp
 static int __init pseries_cpu_hotplug_init(void)
 {
 	rtas_stop_self_args.token = rtas_token("stop-self");
+	qcss_tok = rtas_token("query-cpu-stopped-state");
 
-	ppc_md.cpu_die = pSeries_mach_cpu_die;
+	if (rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE ||
+			qcss_tok == RTAS_UNKNOWN_SERVICE) {
+		printk(KERN_INFO "CPU Hotplug not supported by firmware "
+				"- disabling.\n");
+		return 0;
+	}
 
+	ppc_md.cpu_die = pSeries_mach_cpu_die;
 	smp_ops->cpu_disable = pSeries_cpu_disable;
 	smp_ops->cpu_die = pSeries_cpu_die;
 
