Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:17:32 +1000
Subject: [PATCH] Make kexec_setup() a regular initcall
Message-Id: <20060623081730.0864067BC3@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no reason kexec_setup() needs to be called explicitly from
setup_system(), it can just be a regular initcall.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/machine_kexec_64.c |    4 +++-
 arch/powerpc/kernel/setup_64.c         |    4 ----
 include/asm-powerpc/kexec.h            |    1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

Index: to-merge/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ to-merge/arch/powerpc/kernel/machine_kexec_64.c
@@ -378,11 +378,13 @@ static void __init export_crashk_values(
 	of_node_put(node);
 }
 
-void __init kexec_setup(void)
+static int __init kexec_setup(void)
 {
 	export_htab_values();
 	export_crashk_values();
+	return 0;
 }
+__initcall(kexec_setup);
 
 static int __init early_parse_crashk(char *p)
 {
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -350,10 +350,6 @@ void __init setup_system(void)
 	 */
 	unflatten_device_tree();
 
-#ifdef CONFIG_KEXEC
-	kexec_setup();	/* requires unflattened device tree. */
-#endif
-
 	/*
 	 * Fill the ppc64_caches & systemcfg structures with informations
 	 * retrieved from the device-tree. Need to be called before
Index: to-merge/include/asm-powerpc/kexec.h
===================================================================
--- to-merge.orig/include/asm-powerpc/kexec.h
+++ to-merge/include/asm-powerpc/kexec.h
@@ -112,7 +112,6 @@ static inline void crash_setup_regs(stru
 #ifdef __powerpc64__
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
-extern void __init kexec_setup(void);
 extern int crashing_cpu;
 extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
 #endif /* __powerpc64 __ */
