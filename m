Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 17 May 2006 18:00:41 +1000
Subject: [PATCH 1/5] powerpc: Make early xmon logic immune to location of
	early parsing
Message-Id: <1147852841.148164.91320074069.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently early_xmon() calls directly into debugger() if xmon=early is passed.
This ties the invocation of early xmon to the location of parse_early_param(),
which might change.

Tested on P5 LPAR and F50.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/setup-common.c |    3 ++-
 arch/powerpc/kernel/setup.h        |    1 +
 arch/powerpc/kernel/setup_32.c     |    3 +++
 arch/powerpc/kernel/setup_64.c     |    3 +++
 4 files changed, 9 insertions(+), 1 deletion(-)

Index: to-merge/arch/powerpc/kernel/setup-common.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup-common.c
+++ to-merge/arch/powerpc/kernel/setup-common.c
@@ -443,6 +443,7 @@ void __init smp_setup_cpu_maps(void)
 }
 #endif /* CONFIG_SMP */
 
+int __initdata do_early_xmon;
 #ifdef CONFIG_XMON
 static int __init early_xmon(char *p)
 {
@@ -456,7 +457,7 @@ static int __init early_xmon(char *p)
 			return 0;
 	}
 	xmon_init(1);
-	debugger(NULL);
+	do_early_xmon = 1;
 
 	return 0;
 }
Index: to-merge/arch/powerpc/kernel/setup.h
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup.h
+++ to-merge/arch/powerpc/kernel/setup.h
@@ -2,5 +2,6 @@
 #define _POWERPC_KERNEL_SETUP_H
 
 void check_for_initrd(void);
+extern int do_early_xmon;
 
 #endif /* _POWERPC_KERNEL_SETUP_H */
Index: to-merge/arch/powerpc/kernel/setup_32.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_32.c
+++ to-merge/arch/powerpc/kernel/setup_32.c
@@ -296,6 +296,9 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	if (do_early_xmon)
+		debugger(NULL);
+
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -425,6 +425,9 @@ void __init setup_system(void)
 
 	parse_early_param();
 
+	if (do_early_xmon)
+		debugger(NULL);
+
 	check_smt_enabled();
 	smp_setup_cpu_maps();
 
