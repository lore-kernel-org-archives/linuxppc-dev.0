Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <fc204cd230d4f00c1b5b618ecff4895157832c99.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 08/14] powerpc: Split out do_feature_fixups() from cputable.c
Date: Tue, 24 Jun 2008 11:32:36 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The logic to patch CPU feature sections lives in cputable.c, but these days
it's used for CPU features as well as firmware features. Move it into
it's own file for neatness and as preparation for some additions.

While we're moving the code, we pull the loop body logic into a separate
routine, and remove a comment which doesn't apply anymore.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c    |   36 -----------------------
 arch/powerpc/lib/Makefile         |    1 +
 arch/powerpc/lib/feature-fixups.c |   56 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 887e190..11943f0 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 
 #include <asm/oprofile_impl.h>
-#include <asm/code-patching.h>
 #include <asm/cputable.h>
 #include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
 
@@ -1588,38 +1587,3 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 	BUG();
 	return NULL;
 }
-
-void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-{
-	struct fixup_entry {
-		unsigned long	mask;
-		unsigned long	value;
-		long		start_off;
-		long		end_off;
-	} *fcur, *fend;
-
-	fcur = fixup_start;
-	fend = fixup_end;
-
-	for (; fcur < fend; fcur++) {
-		unsigned int *pstart, *pend, *p;
-
-		if ((value & fcur->mask) == fcur->value)
-			continue;
-
-		/* These PTRRELOCs will disappear once the new scheme for
-		 * modules and vdso is implemented
-		 */
-		pstart = ((unsigned int *)fcur) + (fcur->start_off / 4);
-		pend = ((unsigned int *)fcur) + (fcur->end_off / 4);
-
-		for (p = pstart; p < pend; p++) {
-			*p = PPC_NOP_INSTR;
-			asm volatile ("dcbst 0, %0" : : "r" (p));
-		}
-		asm volatile ("sync" : : : "memory");
-		for (p = pstart; p < pend; p++)
-			asm volatile ("icbi 0,%0" : : "r" (p));
-		asm volatile ("sync; isync" : : : "memory");
-	}
-}
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 305c7df..4afcf3a 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -26,3 +26,4 @@ endif
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
 obj-y			+= code-patching.o
+obj-y			+= feature-fixups.o
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
new file mode 100644
index 0000000..f6fd5d2
--- /dev/null
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -0,0 +1,56 @@
+/*
+ *  Copyright (C) 2001 Ben. Herrenschmidt (benh@kernel.crashing.org)
+ *
+ *  Modifications for ppc64:
+ *      Copyright (C) 2003 Dave Engebretsen <engebret@us.ibm.com>
+ *
+ *  Copyright 2008 Michael Ellerman, IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <asm/cputable.h>
+#include <asm/code-patching.h>
+
+
+struct fixup_entry {
+	unsigned long	mask;
+	unsigned long	value;
+	long		start_off;
+	long		end_off;
+};
+
+static void patch_feature_section(unsigned long value, struct fixup_entry *fcur)
+{
+	unsigned int *pstart, *pend, *p;
+
+	if ((value & fcur->mask) == fcur->value)
+		return;
+
+	pstart = ((unsigned int *)fcur) + (fcur->start_off / 4);
+	pend = ((unsigned int *)fcur) + (fcur->end_off / 4);
+
+	for (p = pstart; p < pend; p++) {
+		*p = PPC_NOP_INSTR;
+		asm volatile ("dcbst 0, %0" : : "r" (p));
+	}
+	asm volatile ("sync" : : : "memory");
+	for (p = pstart; p < pend; p++)
+		asm volatile ("icbi 0,%0" : : "r" (p));
+	asm volatile ("sync; isync" : : : "memory");
+}
+
+void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
+{
+	struct fixup_entry *fcur, *fend;
+
+	fcur = fixup_start;
+	fend = fixup_end;
+
+	for (; fcur < fend; fcur++)
+		patch_feature_section(value, fcur);
+}
-- 
1.5.5
