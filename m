Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3FE621007DB
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:41 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 2/8] Rename stack-ppc64.c to stack-ppc.c
Message-ID: <20091127223339.GB21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There should be no functional changes in this patch.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/stack-ppc.c   |   62 +++++++++++++++++++++++++++++++++++++++++++++++++
 runtime/stack-ppc64.c |   62 -------------------------------------------------
 runtime/stack.c       |    2 +-
 3 files changed, 63 insertions(+), 63 deletions(-)
 create mode 100644 runtime/stack-ppc.c
 delete mode 100644 runtime/stack-ppc64.c

diff --git a/runtime/stack-ppc.c b/runtime/stack-ppc.c
new file mode 100644
index 0000000..3267194
--- /dev/null
+++ b/runtime/stack-ppc.c
@@ -0,0 +1,62 @@
+/* -*- linux-c -*-
+ * ppc64 stack tracing functions
+ *
+ * This file is part of systemtap, and is free software.  You can
+ * redistribute it and/or modify it under the terms of the GNU General
+ * Public License (GPL); either version 2, or (at your option) any
+ * later version.
+ */
+
+static void __stp_stack_print (struct pt_regs *regs, int verbose, int levels,
+                               struct task_struct *tsk)
+{
+	unsigned long ip, newsp, lr = 0;
+	int count = 0;
+	int firstframe = 1;
+	unsigned long *_sp = (unsigned long *)&REG_SP(regs);	
+	unsigned long sp = (unsigned long)_sp;
+	lr = 0;
+	do {
+		if (sp < KERNELBASE)
+			return;
+		_sp = (unsigned long *) sp;
+		newsp = _sp[0];
+		ip = _sp[2];
+		if (!firstframe || ip != lr) {
+			if (verbose) {
+				_stp_printf("[0x%016lx] [0x%016lx] ", sp, ip);
+				_stp_symbol_print(ip);
+				if (firstframe)
+					_stp_print(" (unreliable)");
+				_stp_print_char('\n');
+			}
+			else
+				_stp_printf("0x%016lx ", ip);
+		}
+		firstframe = 0;
+		/*
+		 * See if this is an exception frame.
+		 * We look for the "regshere" marker in the current frame.
+		 */
+		if ( _sp[12] == 0x7265677368657265ul) {
+			struct pt_regs *regs = (struct pt_regs *)
+				(sp + STACK_FRAME_OVERHEAD);
+			if (verbose) {
+				_stp_printf("--- Exception: %lx at ",regs->trap);
+				_stp_symbol_print(regs->nip);
+				_stp_print_char('\n');
+				lr = regs->link;
+				_stp_print("    LR =");
+				_stp_symbol_print(lr);
+				_stp_print_char('\n');
+				firstframe = 1;
+			}
+			else {
+				_stp_printf("0x%016lx ",regs->nip);
+				_stp_printf("0x%016lx ",regs->link);
+			}
+		}
+
+		sp = newsp;
+	} while (count++ < MAXBACKTRACE);
+}
diff --git a/runtime/stack-ppc64.c b/runtime/stack-ppc64.c
deleted file mode 100644
index 3267194..0000000
--- a/runtime/stack-ppc64.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/* -*- linux-c -*-
- * ppc64 stack tracing functions
- *
- * This file is part of systemtap, and is free software.  You can
- * redistribute it and/or modify it under the terms of the GNU General
- * Public License (GPL); either version 2, or (at your option) any
- * later version.
- */
-
-static void __stp_stack_print (struct pt_regs *regs, int verbose, int levels,
-                               struct task_struct *tsk)
-{
-	unsigned long ip, newsp, lr = 0;
-	int count = 0;
-	int firstframe = 1;
-	unsigned long *_sp = (unsigned long *)&REG_SP(regs);	
-	unsigned long sp = (unsigned long)_sp;
-	lr = 0;
-	do {
-		if (sp < KERNELBASE)
-			return;
-		_sp = (unsigned long *) sp;
-		newsp = _sp[0];
-		ip = _sp[2];
-		if (!firstframe || ip != lr) {
-			if (verbose) {
-				_stp_printf("[0x%016lx] [0x%016lx] ", sp, ip);
-				_stp_symbol_print(ip);
-				if (firstframe)
-					_stp_print(" (unreliable)");
-				_stp_print_char('\n');
-			}
-			else
-				_stp_printf("0x%016lx ", ip);
-		}
-		firstframe = 0;
-		/*
-		 * See if this is an exception frame.
-		 * We look for the "regshere" marker in the current frame.
-		 */
-		if ( _sp[12] == 0x7265677368657265ul) {
-			struct pt_regs *regs = (struct pt_regs *)
-				(sp + STACK_FRAME_OVERHEAD);
-			if (verbose) {
-				_stp_printf("--- Exception: %lx at ",regs->trap);
-				_stp_symbol_print(regs->nip);
-				_stp_print_char('\n');
-				lr = regs->link;
-				_stp_print("    LR =");
-				_stp_symbol_print(lr);
-				_stp_print_char('\n');
-				firstframe = 1;
-			}
-			else {
-				_stp_printf("0x%016lx ",regs->nip);
-				_stp_printf("0x%016lx ",regs->link);
-			}
-		}
-
-		sp = newsp;
-	} while (count++ < MAXBACKTRACE);
-}
diff --git a/runtime/stack.c b/runtime/stack.c
index 042f44c..ae89995 100644
--- a/runtime/stack.c
+++ b/runtime/stack.c
@@ -41,7 +41,7 @@ static void _stp_stack_print_fallback(unsigned long, int, int);
 #elif  defined (__i386__)
 #include "stack-i386.c"
 #elif defined (__powerpc64__)
-#include "stack-ppc64.c"
+#include "stack-ppc.c"
 #elif defined (__arm__)
 #include "stack-arm.c"
 #elif defined (__s390__) || defined (__s390x__)
-- 
1.6.3.3
