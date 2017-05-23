Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXXGv46vbzDqbf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 09:46:15 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w69so30583339pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 16:46:15 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au,
	anton@samba.org
Subject: [PATCH] powerpc/lib: Split xor_vmx file to guarantee instruction
 ordering
Date: Wed, 24 May 2017 09:45:59 +1000
Message-Id: <20170523234559.28080-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The xor_vmx.c file is used for the RAID5 xor operations. In these functions
altivec is enabled to run the operation and then disabled. However due to
compiler instruction reordering, altivec instructions are being run before
enable_altivec() and after disable_altivec().

This patch splits the non-altivec code into xor_vmx_glue.c which calls the
altivec functions in xor_vmx.c. By compiling xor_vmx_glue.c without
-maltivec we can guarantee that altivec instruction will not be reordered
outside of the enable/disable block.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/lib/Makefile       |  2 +-
 arch/powerpc/lib/xor_vmx.c      | 53 ++++++++---------------------------
 arch/powerpc/lib/xor_vmx.h      | 20 +++++++++++++
 arch/powerpc/lib/xor_vmx_glue.c | 62 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 43 deletions(-)
 create mode 100644 arch/powerpc/lib/xor_vmx.h
 create mode 100644 arch/powerpc/lib/xor_vmx_glue.c

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 309361e8..a448464 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -31,7 +31,7 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
-obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
+obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
 CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/arch/powerpc/lib/xor_vmx.c b/arch/powerpc/lib/xor_vmx.c
index f9de69a..4df240a 100644
--- a/arch/powerpc/lib/xor_vmx.c
+++ b/arch/powerpc/lib/xor_vmx.c
@@ -29,10 +29,7 @@
 #define vector __attribute__((vector_size(16)))
 #endif
 
-#include <linux/preempt.h>
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <asm/switch_to.h>
+#include "xor_vmx.h"
 
 typedef vector signed char unative_t;
 
@@ -64,16 +61,13 @@ typedef vector signed char unative_t;
 		V1##_3 = vec_xor(V1##_3, V2##_3);	\
 	} while (0)
 
-void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in)
+void __xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+		     unsigned long *v2_in)
 {
 	DEFINE(v1);
 	DEFINE(v2);
 	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
 
-	preempt_disable();
-	enable_kernel_altivec();
-
 	do {
 		LOAD(v1);
 		LOAD(v2);
@@ -83,23 +77,16 @@ void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
 		v1 += 4;
 		v2 += 4;
 	} while (--lines > 0);
-
-	disable_kernel_altivec();
-	preempt_enable();
 }
-EXPORT_SYMBOL(xor_altivec_2);
 
-void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in, unsigned long *v3_in)
+void __xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
+		     unsigned long *v2_in, unsigned long *v3_in)
 {
 	DEFINE(v1);
 	DEFINE(v2);
 	DEFINE(v3);
 	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
 
-	preempt_disable();
-	enable_kernel_altivec();
-
 	do {
 		LOAD(v1);
 		LOAD(v2);
@@ -112,15 +99,11 @@ void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
 		v2 += 4;
 		v3 += 4;
 	} while (--lines > 0);
-
-	disable_kernel_altivec();
-	preempt_enable();
 }
-EXPORT_SYMBOL(xor_altivec_3);
 
-void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in, unsigned long *v3_in,
-		   unsigned long *v4_in)
+void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
+		     unsigned long *v2_in, unsigned long *v3_in,
+		     unsigned long *v4_in)
 {
 	DEFINE(v1);
 	DEFINE(v2);
@@ -128,9 +111,6 @@ void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
 	DEFINE(v4);
 	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
 
-	preempt_disable();
-	enable_kernel_altivec();
-
 	do {
 		LOAD(v1);
 		LOAD(v2);
@@ -146,15 +126,11 @@ void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
 		v3 += 4;
 		v4 += 4;
 	} while (--lines > 0);
-
-	disable_kernel_altivec();
-	preempt_enable();
 }
-EXPORT_SYMBOL(xor_altivec_4);
 
-void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in, unsigned long *v3_in,
-		   unsigned long *v4_in, unsigned long *v5_in)
+void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
+		     unsigned long *v2_in, unsigned long *v3_in,
+		     unsigned long *v4_in, unsigned long *v5_in)
 {
 	DEFINE(v1);
 	DEFINE(v2);
@@ -163,9 +139,6 @@ void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
 	DEFINE(v5);
 	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
 
-	preempt_disable();
-	enable_kernel_altivec();
-
 	do {
 		LOAD(v1);
 		LOAD(v2);
@@ -184,8 +157,4 @@ void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
 		v4 += 4;
 		v5 += 4;
 	} while (--lines > 0);
-
-	disable_kernel_altivec();
-	preempt_enable();
 }
-EXPORT_SYMBOL(xor_altivec_5);
diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
new file mode 100644
index 0000000..4414a24
--- /dev/null
+++ b/arch/powerpc/lib/xor_vmx.h
@@ -0,0 +1,20 @@
+/*
+ * Simple interface to link xor_vmx.c and xor_vmx_glue.c
+ *
+ * Seperating these file ensures that no altivec instructions are run 
+ * outside of the enable/disable altivec block.
+ */
+
+void __xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in);
+
+void __xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in);
+
+void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in,
+			     unsigned long *v4_in);
+
+void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in,
+			     unsigned long *v4_in, unsigned long *v5_in);
diff --git a/arch/powerpc/lib/xor_vmx_glue.c b/arch/powerpc/lib/xor_vmx_glue.c
new file mode 100644
index 0000000..6521fe5
--- /dev/null
+++ b/arch/powerpc/lib/xor_vmx_glue.c
@@ -0,0 +1,62 @@
+/*
+ * Altivec XOR operations
+ *
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/preempt.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <asm/switch_to.h>
+#include "xor_vmx.h"
+
+void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_2(bytes, v1_in, v2_in);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_2);
+
+void xor_altivec_3(unsigned long bytes,  unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_3(bytes, v1_in, v2_in, v3_in);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_3);
+
+void xor_altivec_4(unsigned long bytes,  unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_4(bytes, v1_in, v2_in, v3_in, v4_in);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_4);
+
+void xor_altivec_5(unsigned long bytes,  unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in, unsigned long *v5_in)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_5(bytes, v1_in, v2_in, v3_in, v4_in, v5_in);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_5);
-- 
2.9.3
