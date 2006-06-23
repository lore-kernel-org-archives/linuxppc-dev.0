Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:13 +1000
Subject: [PATCH 5/8] Setup RTAS values earlier, to enable rtas_call() earlier
Message-Id: <20060623082012.8D9D767B23@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Althought RTAS is instantiated when we enter the kernel, we can't actually
call into it until we know its entry point address. Currently we grab that
in rtas_initialize(), however that's quite late in the boot sequence.

To enable rtas_call() earlier, we can grab the RTAS entry etc. values while
we're scanning the flattened device tree. There's existing code to retrieve
the values from /chosen, however we don't store them there anymore, so remove
that code.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/prom.c |   23 +++++------------------
 arch/powerpc/kernel/rtas.c |   22 ++++++++++++++++++++++
 include/asm-powerpc/rtas.h |    3 +++
 3 files changed, 30 insertions(+), 18 deletions(-)

Index: to-merge/arch/powerpc/kernel/prom.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom.c
+++ to-merge/arch/powerpc/kernel/prom.c
@@ -1125,24 +1125,6 @@ static int __init early_init_dt_scan_cho
  		tce_alloc_end = *lprop;
 #endif
 
-#ifdef CONFIG_PPC_RTAS
-	/* To help early debugging via the front panel, we retrieve a minimal
-	 * set of RTAS infos now if available
-	 */
-	{
-		u64 *basep, *entryp, *sizep;
-
-		basep = of_get_flat_dt_prop(node, "linux,rtas-base", NULL);
-		entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
-		sizep = of_get_flat_dt_prop(node, "linux,rtas-size", NULL);
-		if (basep && entryp && sizep) {
-			rtas.base = *basep;
-			rtas.entry = *entryp;
-			rtas.size = *sizep;
-		}
-	}
-#endif /* CONFIG_PPC_RTAS */
-
 #ifdef CONFIG_KEXEC
        lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
        if (lprop)
@@ -1327,6 +1309,11 @@ void __init early_init_devtree(void *par
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;
 
+#ifdef CONFIG_PPC_RTAS
+	/* Some machines might need RTAS info for debugging, grab it now. */
+	of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
+#endif
+
 	/* Retrieve various informations from the /chosen node of the
 	 * device-tree, including the platform type, initrd location and
 	 * size, TCE reserve, and more ...
Index: to-merge/arch/powerpc/kernel/rtas.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/rtas.c
+++ to-merge/arch/powerpc/kernel/rtas.c
@@ -801,3 +801,25 @@ void __init rtas_initialize(void)
 	rtas_last_error_token = rtas_token("rtas-last-error");
 #endif
 }
+
+int __init early_init_dt_scan_rtas(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	u32 *basep, *entryp, *sizep;
+
+	if (depth != 1 || strcmp(uname, "rtas") != 0)
+		return 0;
+
+	basep  = of_get_flat_dt_prop(node, "linux,rtas-base", NULL);
+	entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
+	sizep  = of_get_flat_dt_prop(node, "rtas-size", NULL);
+
+	if (basep && entryp && sizep) {
+		rtas.base = *basep;
+		rtas.entry = *entryp;
+		rtas.size = *sizep;
+	}
+
+	/* break now */
+	return 1;
+}
Index: to-merge/include/asm-powerpc/rtas.h
===================================================================
--- to-merge.orig/include/asm-powerpc/rtas.h
+++ to-merge/include/asm-powerpc/rtas.h
@@ -181,6 +181,9 @@ extern int rtas_set_rtc_time(struct rtc_
 extern unsigned int rtas_busy_delay_time(int status);
 extern unsigned int rtas_busy_delay(int status);
 
+extern int early_init_dt_scan_rtas(unsigned long node,
+		const char *uname, int depth, void *data);
+
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
 /* Error types logged.  */
