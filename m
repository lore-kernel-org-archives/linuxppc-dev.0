Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 03 Oct 2006 14:12:08 +1000
Subject: [PATCH 2/2] Fix xmon=off and cleanup xmon initialisation
In-Reply-To: <1159848727.955823.82109451606.qpush@concordia>
Message-Id: <20061003041209.2D34967C2A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My patch to make the early xmon logic work with earlier early param
parsing (480f6f35a149802a94ad5c1a2673ed6ec8d2c158) breaks xmon=off.

No one does this obviously as xmon rocks, but it should really work
as documented.

While fixing that it struck me that we could move the xmon param
handling into xmon.c, and also consolidate the
xmon_init()/do_early_xmon logic into xmon_setup(). This means
xmon=early drops into xmon a little earlier on 32-bit, but it
seems to work just fine.

Tested on PSERIES and CLASSIC32.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/setup-common.c |   25 -------------------------
 arch/powerpc/kernel/setup_32.c     |    8 ++------
 arch/powerpc/kernel/setup_64.c     |   12 ++++--------
 arch/powerpc/xmon/xmon.c           |   33 +++++++++++++++++++++++++++++++++
 include/asm-powerpc/xmon.h         |    6 +++++-
 5 files changed, 44 insertions(+), 40 deletions(-)

Index: to-merge/arch/powerpc/kernel/setup-common.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup-common.c
+++ to-merge/arch/powerpc/kernel/setup-common.c
@@ -442,31 +442,6 @@ void __init smp_setup_cpu_maps(void)
 }
 #endif /* CONFIG_SMP */
 
-int __initdata do_early_xmon;
-#ifdef CONFIG_XMON
-extern int xmon_no_auto_backtrace;
-
-static int __init early_xmon(char *p)
-{
-	/* ensure xmon is enabled */
-	if (p) {
-		if (strncmp(p, "on", 2) == 0)
-			xmon_init(1);
-		if (strncmp(p, "off", 3) == 0)
-			xmon_init(0);
-		if (strncmp(p, "nobt", 4) == 0)
-			xmon_no_auto_backtrace = 1;
-		if (strncmp(p, "early", 5) != 0)
-			return 0;
-	}
-	xmon_init(1);
-	do_early_xmon = 1;
-
-	return 0;
-}
-early_param("xmon", early_xmon);
-#endif
-
 static __init int add_pcspkr(void)
 {
 	struct device_node *np;
Index: to-merge/arch/powerpc/kernel/setup_32.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_32.c
+++ to-merge/arch/powerpc/kernel/setup_32.c
@@ -242,12 +242,11 @@ void __init setup_arch(char **cmdline_p)
 
 	smp_setup_cpu_maps();
 
-#ifdef CONFIG_XMON_DEFAULT
-	xmon_init(1);
-#endif
 	/* Register early console */
 	register_early_udbg_console();
 
+	xmon_setup();
+
 #if defined(CONFIG_KGDB)
 	if (ppc_md.kgdb_map_scc)
 		ppc_md.kgdb_map_scc();
@@ -284,9 +283,6 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
 
-	if (do_early_xmon)
-		debugger(NULL);
-
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -396,18 +396,14 @@ void __init setup_system(void)
 	find_legacy_serial_ports();
 
 	/*
-	 * Initialize xmon
-	 */
-#ifdef CONFIG_XMON_DEFAULT
-	xmon_init(1);
-#endif
-	/*
 	 * Register early console
 	 */
 	register_early_udbg_console();
 
-	if (do_early_xmon)
-		debugger(NULL);
+	/*
+	 * Initialize xmon
+	 */
+	xmon_setup();
 
 	check_smt_enabled();
 	smp_setup_cpu_maps();
Index: to-merge/arch/powerpc/xmon/xmon.c
===================================================================
--- to-merge.orig/arch/powerpc/xmon/xmon.c
+++ to-merge/arch/powerpc/xmon/xmon.c
@@ -2,6 +2,8 @@
  * Routines providing a simple monitor for use on the PowerMac.
  *
  * Copyright (C) 1996-2005 Paul Mackerras.
+ * Copyright (C) 2001 PPC64 Team, IBM Corp
+ * Copyrignt (C) 2006 Michael Ellerman, IBM Corp
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -2597,3 +2599,34 @@ static int __init setup_xmon_sysrq(void)
 }
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
+
+int __initdata xmon_early, xmon_off;
+
+static int __init early_parse_xmon(char *p)
+{
+	if (!p || strncmp(p, "early", 5) == 0) {
+		/* just "xmon" is equivalent to "xmon=early" */
+		xmon_init(1);
+		xmon_early = 1;
+	} else if (strncmp(p, "on", 2) == 0)
+		xmon_init(1);
+	else if (strncmp(p, "off", 3) == 0)
+		xmon_off = 1;
+	else if (strncmp(p, "nobt", 4) == 0)
+		xmon_no_auto_backtrace = 1;
+	else
+		return 1;
+
+	return 0;
+}
+early_param("xmon", early_parse_xmon);
+
+void __init xmon_setup(void)
+{
+#ifdef CONFIG_XMON_DEFAULT
+	if (!xmon_off)
+		xmon_init(1);
+#endif
+	if (xmon_early)
+		debugger(NULL);
+}
Index: to-merge/include/asm-powerpc/xmon.h
===================================================================
--- to-merge.orig/include/asm-powerpc/xmon.h
+++ to-merge/include/asm-powerpc/xmon.h
@@ -12,7 +12,11 @@
 
 #ifdef __KERNEL__
 
-extern void xmon_init(int);
+#ifdef CONFIG_XMON
+extern void xmon_setup(void);
+#else
+static inline void xmon_setup(void) { };
+#endif
 
 #endif /* __KERNEL __ */
 #endif /* __ASM_POWERPC_XMON_H */
