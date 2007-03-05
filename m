Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 15/15] Add support for reset on Ebony
In-Reply-To: <20070305032307.GB31417@localhost.localdomain>
Message-Id: <20070305032453.8CA47DDF18@ozlabs.org>
Date: Mon,  5 Mar 2007 14:24:53 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements the appropriate hooks to allow both the kernel
and the zImage wrapper to reboot an Ebony.  In the process we move the
low-level abort() function from head_44x.S to misc_44x.S and rename it
something clearer.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/ebony.c             |   17 +++++++++++++++++
 arch/powerpc/kernel/head_44x.S        |   10 ----------
 arch/powerpc/platforms/4xx/44x.h      |    1 +
 arch/powerpc/platforms/4xx/ebony.c    |    2 ++
 arch/powerpc/platforms/4xx/misc_44x.S |   10 ++++++++++
 5 files changed, 30 insertions(+), 10 deletions(-)

Index: working-2.6/arch/powerpc/kernel/head_44x.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-03-02 17:19:37.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-03-02 17:19:38.000000000 +1100
@@ -701,16 +701,6 @@ _GLOBAL(giveup_fpu)
 	blr
 #endif
 
-/*
- * extern void abort(void)
- *
- * At present, this routine just applies a system reset.
- */
-_GLOBAL(abort)
-        mfspr   r13,SPRN_DBCR0
-        oris    r13,r13,DBCR0_RST_SYSTEM@h
-        mtspr   SPRN_DBCR0,r13
-
 _GLOBAL(set_context)
 
 #ifdef CONFIG_BDI_SWITCH
Index: working-2.6/arch/powerpc/platforms/4xx/misc_44x.S
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/misc_44x.S	2007-03-02 17:19:37.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/4xx/misc_44x.S	2007-03-02 17:19:38.000000000 +1100
@@ -44,3 +44,13 @@ _GLOBAL(as1_writeb)
 	sync
 	isync
 	blr
+
+/*
+ * void ppc44x_reset_system(char *cmd)
+ *
+ * At present, this routine just applies a system reset.
+ */
+_GLOBAL(ppc44x_reset_system)
+        mfspr   r13,SPRN_DBCR0
+        oris    r13,r13,DBCR0_RST_SYSTEM@h
+        mtspr   SPRN_DBCR0,r13
Index: working-2.6/arch/powerpc/platforms/4xx/44x.h
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/44x.h	2007-03-02 17:19:37.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/4xx/44x.h	2007-03-02 17:19:38.000000000 +1100
@@ -3,6 +3,7 @@
 
 extern u8 as1_readb(volatile u8 __iomem  *addr);
 extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
+extern void ppc44x_reset_system(char *cmd);
 
 #endif /* __POWERPC_PLATFORMS_4XX_44X_H */
 
Index: working-2.6/arch/powerpc/platforms/4xx/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/ebony.c	2007-03-02 17:19:37.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/4xx/ebony.c	2007-03-02 17:19:38.000000000 +1100
@@ -23,6 +23,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/of_platform.h>
+#include "44x.h"
 
 static struct of_device_id ebony_of_bus[] = {
 	{ .type = "ibm,plb", },
@@ -65,5 +66,6 @@ define_machine(ebony) {
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
+	.restart		= ppc44x_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2007-03-02 17:19:39.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-03-02 17:30:23.000000000 +1100
@@ -177,11 +177,28 @@ static void ebony_fixups(void)
 		  mac1, 6);
 }
 
+#define SPRN_DBCR0		0x134
+#define   DBCR0_RST_SYSTEM	0x30000000
+
+static void ebony_exit(void)
+{
+	unsigned long tmp;
+
+	asm volatile (
+		"mfspr	%0,%1\n"
+		"oris	%0,%0,%2@h\n"
+		"mtspr	%1,%0"
+		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
+		);
+
+}
+
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
 {
 	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */
 
 	platform_ops.fixups = ebony_fixups;
+	platform_ops.exit = ebony_exit;
 	simple_alloc_init(_end, heapsize, 32, 64);
 	ft_init(_dtb_start, 0, 32);
 	serial_console_init();
