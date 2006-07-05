Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 05 Jul 2006 14:39:42 +1000
Subject: [RFC/PATCH 1/2] Move some kexec logic into machine_kexec.c
Message-Id: <1152074382.592260.383409859049.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We're missing a few functions for kexec to compile on 32-bit. There's
nothing really 64-bit specific about the 64-bit versions, so make them
generic rather than adding empty definitions for 32-bit.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/machine_kexec.c    |   56 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c |   56 ---------------------------------
 2 files changed, 56 insertions(+), 56 deletions(-)

Index: to-merge/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/machine_kexec.c
+++ to-merge/arch/powerpc/kernel/machine_kexec.c
@@ -13,6 +13,7 @@
 #include <linux/reboot.h>
 #include <linux/threads.h>
 #include <asm/machdep.h>
+#include <asm/lmb.h>
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
@@ -59,3 +60,58 @@ NORET_TYPE void machine_kexec(struct kim
 	}
 	for(;;);
 }
+
+static int __init early_parse_crashk(char *p)
+{
+	unsigned long size;
+
+	if (!p)
+		return 1;
+
+	size = memparse(p, &p);
+
+	if (*p == '@')
+		crashk_res.start = memparse(p + 1, &p);
+	else
+		crashk_res.start = KDUMP_KERNELBASE;
+
+	crashk_res.end = crashk_res.start + size - 1;
+
+	return 0;
+}
+early_param("crashkernel", early_parse_crashk);
+
+void __init reserve_crashkernel(void)
+{
+	unsigned long size;
+
+	if (crashk_res.start == 0)
+		return;
+
+	/* We might have got these values via the command line or the
+	 * device tree, either way sanitise them now. */
+
+	size = crashk_res.end - crashk_res.start + 1;
+
+	if (crashk_res.start != KDUMP_KERNELBASE)
+		printk("Crash kernel location must be 0x%x\n",
+				KDUMP_KERNELBASE);
+
+	crashk_res.start = KDUMP_KERNELBASE;
+	size = PAGE_ALIGN(size);
+	crashk_res.end = crashk_res.start + size - 1;
+
+	/* Crash kernel trumps memory limit */
+	if (memory_limit && memory_limit <= crashk_res.end) {
+		memory_limit = crashk_res.end + 1;
+		printk("Adjusted memory limit for crashkernel, now 0x%lx\n",
+				memory_limit);
+	}
+
+	lmb_reserve(crashk_res.start, size);
+}
+
+int overlaps_crashkernel(unsigned long start, unsigned long size)
+{
+	return (start + size) > crashk_res.start && start <= crashk_res.end;
+}
Index: to-merge/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ to-merge/arch/powerpc/kernel/machine_kexec_64.c
@@ -21,7 +21,6 @@
 #include <asm/machdep.h>
 #include <asm/cacheflush.h>
 #include <asm/paca.h>
-#include <asm/lmb.h>
 #include <asm/mmu.h>
 #include <asm/sections.h>	/* _end */
 #include <asm/prom.h>
@@ -385,58 +384,3 @@ static int __init kexec_setup(void)
 	return 0;
 }
 __initcall(kexec_setup);
-
-static int __init early_parse_crashk(char *p)
-{
-	unsigned long size;
-
-	if (!p)
-		return 1;
-
-	size = memparse(p, &p);
-
-	if (*p == '@')
-		crashk_res.start = memparse(p + 1, &p);
-	else
-		crashk_res.start = KDUMP_KERNELBASE;
-
-	crashk_res.end = crashk_res.start + size - 1;
-
-	return 0;
-}
-early_param("crashkernel", early_parse_crashk);
-
-void __init reserve_crashkernel(void)
-{
-	unsigned long size;
-
-	if (crashk_res.start == 0)
-		return;
-
-	/* We might have got these values via the command line or the
-	 * device tree, either way sanitise them now. */
-
-	size = crashk_res.end - crashk_res.start + 1;
-
-	if (crashk_res.start != KDUMP_KERNELBASE)
-		printk("Crash kernel location must be 0x%x\n",
-				KDUMP_KERNELBASE);
-
-	crashk_res.start = KDUMP_KERNELBASE;
-	size = PAGE_ALIGN(size);
-	crashk_res.end = crashk_res.start + size - 1;
-
-	/* Crash kernel trumps memory limit */
-	if (memory_limit && memory_limit <= crashk_res.end) {
-		memory_limit = crashk_res.end + 1;
-		printk("Adjusted memory limit for crashkernel, now 0x%lx\n",
-				memory_limit);
-	}
-
-	lmb_reserve(crashk_res.start, size);
-}
-
-int overlaps_crashkernel(unsigned long start, unsigned long size)
-{
-	return (start + size) > crashk_res.start && start <= crashk_res.end;
-}
