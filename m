Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2005 23:21:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050919232115.3347bcad.sfr@canb.auug.org.au>
In-Reply-To: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
References: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/6] powerpc: merge oprofile headers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Merge include/asm-ppc64/oprofile_ipml.h and arch/ppc/oprofile/op_impl.h
into include/asm-powerpc/oprofile_ipml.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ppc/oprofile/common.c             |    3 -
 arch/ppc/oprofile/op_impl.h            |   45 ------------
 arch/ppc/oprofile/op_model_fsl_booke.c |    3 -
 include/asm-powerpc/oprofile_impl.h    |  123 ++++++++++++++++++++++++++++++++
 include/asm-ppc64/oprofile_impl.h      |  111 -----------------------------
 5 files changed, 125 insertions(+), 160 deletions(-)
 delete mode 100644 arch/ppc/oprofile/op_impl.h
 create mode 100644 include/asm-powerpc/oprofile_impl.h
 delete mode 100644 include/asm-ppc64/oprofile_impl.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

9f08e21e6ba1a97e62f77066ac8c915149908223
diff --git a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
--- a/arch/ppc/oprofile/common.c
+++ b/arch/ppc/oprofile/common.c
@@ -22,8 +22,7 @@
 #include <asm/system.h>
 #include <asm/perfmon.h>
 #include <asm/cputable.h>
-
-#include "op_impl.h"
+#include <asm/oprofile_impl.h>
 
 static struct op_powerpc_model *model;
 
diff --git a/arch/ppc/oprofile/op_impl.h b/arch/ppc/oprofile/op_impl.h
deleted file mode 100644
--- a/arch/ppc/oprofile/op_impl.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * Based on alpha version.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef OP_IMPL_H
-#define OP_IMPL_H 1
-
-#define OP_MAX_COUNTER 8
-
-/* Per-counter configuration as set via oprofilefs.  */
-struct op_counter_config {
-	unsigned long enabled;
-	unsigned long event;
-	unsigned long count;
-	unsigned long kernel;
-	unsigned long user;
-	unsigned long unit_mask;
-};
-
-/* System-wide configuration as set via oprofilefs.  */
-struct op_system_config {
-	unsigned long enable_kernel;
-	unsigned long enable_user;
-};
-
-/* Per-arch configuration */
-struct op_powerpc_model {
-	void (*reg_setup) (struct op_counter_config *,
-			   struct op_system_config *,
-			   int num_counters);
-	void (*start) (struct op_counter_config *);
-	void (*stop) (void);
-	void (*handle_interrupt) (struct pt_regs *,
-				  struct op_counter_config *);
-	int num_counters;
-};
-
-#endif /* OP_IMPL_H */
diff --git a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
--- a/arch/ppc/oprofile/op_model_fsl_booke.c
+++ b/arch/ppc/oprofile/op_model_fsl_booke.c
@@ -25,8 +25,7 @@
 #include <asm/reg_booke.h>
 #include <asm/page.h>
 #include <asm/perfmon.h>
-
-#include "op_impl.h"
+#include <asm/oprofile_impl.h>
 
 static unsigned long reset_value[OP_MAX_COUNTER];
 
diff --git a/include/asm-powerpc/oprofile_impl.h b/include/asm-powerpc/oprofile_impl.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/oprofile_impl.h
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * Based on alpha version.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_OPROFILE_IMPL_H
+#define _ASM_POWERPC_OPROFILE_IMPL_H
+
+#define OP_MAX_COUNTER 8
+
+/* Per-counter configuration as set via oprofilefs.  */
+struct op_counter_config {
+#ifdef __powerpc64__
+	unsigned long valid;
+#endif
+	unsigned long enabled;
+	unsigned long event;
+	unsigned long count;
+	unsigned long kernel;
+#ifdef __powerpc64__
+	/* We dont support per counter user/kernel selection */
+#endif
+	unsigned long user;
+	unsigned long unit_mask;
+};
+
+/* System-wide configuration as set via oprofilefs.  */
+struct op_system_config {
+#ifdef __powerpc64__
+	unsigned long mmcr0;
+	unsigned long mmcr1;
+	unsigned long mmcra;
+#endif
+	unsigned long enable_kernel;
+	unsigned long enable_user;
+#ifdef __powerpc64__
+	unsigned long backtrace_spinlocks;
+#endif
+};
+
+/* Per-arch configuration */
+struct op_powerpc_model {
+	void (*reg_setup) (struct op_counter_config *,
+			   struct op_system_config *,
+			   int num_counters);
+#ifdef __powerpc64__
+	void (*cpu_setup) (void *);
+#endif
+	void (*start) (struct op_counter_config *);
+	void (*stop) (void);
+	void (*handle_interrupt) (struct pt_regs *,
+				  struct op_counter_config *);
+	int num_counters;
+};
+
+#ifdef __powerpc64__
+extern struct op_powerpc_model op_model_rs64;
+extern struct op_powerpc_model op_model_power4;
+
+static inline unsigned int ctr_read(unsigned int i)
+{
+	switch(i) {
+	case 0:
+		return mfspr(SPRN_PMC1);
+	case 1:
+		return mfspr(SPRN_PMC2);
+	case 2:
+		return mfspr(SPRN_PMC3);
+	case 3:
+		return mfspr(SPRN_PMC4);
+	case 4:
+		return mfspr(SPRN_PMC5);
+	case 5:
+		return mfspr(SPRN_PMC6);
+	case 6:
+		return mfspr(SPRN_PMC7);
+	case 7:
+		return mfspr(SPRN_PMC8);
+	default:
+		return 0;
+	}
+}
+
+static inline void ctr_write(unsigned int i, unsigned int val)
+{
+	switch(i) {
+	case 0:
+		mtspr(SPRN_PMC1, val);
+		break;
+	case 1:
+		mtspr(SPRN_PMC2, val);
+		break;
+	case 2:
+		mtspr(SPRN_PMC3, val);
+		break;
+	case 3:
+		mtspr(SPRN_PMC4, val);
+		break;
+	case 4:
+		mtspr(SPRN_PMC5, val);
+		break;
+	case 5:
+		mtspr(SPRN_PMC6, val);
+		break;
+	case 6:
+		mtspr(SPRN_PMC7, val);
+		break;
+	case 7:
+		mtspr(SPRN_PMC8, val);
+		break;
+	default:
+		break;
+	}
+}
+#endif /* __powerpc64__ */
+
+#endif /* _ASM_POWERPC_OPROFILE_IMPL_H */
diff --git a/include/asm-ppc64/oprofile_impl.h b/include/asm-ppc64/oprofile_impl.h
deleted file mode 100644
--- a/include/asm-ppc64/oprofile_impl.h
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * Based on alpha version.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef OP_IMPL_H
-#define OP_IMPL_H 1
-
-#define OP_MAX_COUNTER 8
-
-/* Per-counter configuration as set via oprofilefs.  */
-struct op_counter_config {
-	unsigned long valid;
-	unsigned long enabled;
-	unsigned long event;
-	unsigned long count;
-	unsigned long kernel;
-	/* We dont support per counter user/kernel selection */
-	unsigned long user;
-	unsigned long unit_mask;
-};
-
-/* System-wide configuration as set via oprofilefs.  */
-struct op_system_config {
-	unsigned long mmcr0;
-	unsigned long mmcr1;
-	unsigned long mmcra;
-	unsigned long enable_kernel;
-	unsigned long enable_user;
-	unsigned long backtrace_spinlocks;
-};
-
-/* Per-arch configuration */
-struct op_powerpc_model {
-	void (*reg_setup) (struct op_counter_config *,
-			   struct op_system_config *,
-			   int num_counters);
-	void (*cpu_setup) (void *);
-	void (*start) (struct op_counter_config *);
-	void (*stop) (void);
-	void (*handle_interrupt) (struct pt_regs *,
-				  struct op_counter_config *);
-	int num_counters;
-};
-
-extern struct op_powerpc_model op_model_rs64;
-extern struct op_powerpc_model op_model_power4;
-
-static inline unsigned int ctr_read(unsigned int i)
-{
-	switch(i) {
-	case 0:
-		return mfspr(SPRN_PMC1);
-	case 1:
-		return mfspr(SPRN_PMC2);
-	case 2:
-		return mfspr(SPRN_PMC3);
-	case 3:
-		return mfspr(SPRN_PMC4);
-	case 4:
-		return mfspr(SPRN_PMC5);
-	case 5:
-		return mfspr(SPRN_PMC6);
-	case 6:
-		return mfspr(SPRN_PMC7);
-	case 7:
-		return mfspr(SPRN_PMC8);
-	default:
-		return 0;
-	}
-}
-
-static inline void ctr_write(unsigned int i, unsigned int val)
-{
-	switch(i) {
-	case 0:
-		mtspr(SPRN_PMC1, val);
-		break;
-	case 1:
-		mtspr(SPRN_PMC2, val);
-		break;
-	case 2:
-		mtspr(SPRN_PMC3, val);
-		break;
-	case 3:
-		mtspr(SPRN_PMC4, val);
-		break;
-	case 4:
-		mtspr(SPRN_PMC5, val);
-		break;
-	case 5:
-		mtspr(SPRN_PMC6, val);
-		break;
-	case 6:
-		mtspr(SPRN_PMC7, val);
-		break;
-	case 7:
-		mtspr(SPRN_PMC8, val);
-		break;
-	default:
-		break;
-	}
-}
-
-#endif
