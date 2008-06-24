Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <9fec814475d493f620af7ea7d5208eaa0180b6d9.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 09/14] powerpc: Consolidate CPU and firmware feature fixup
	macros
Date: Tue, 24 Jun 2008 11:32:39 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The CPU and firmware feature fixup macros are currently spread across
three files, firmware.h, cputable.h and asm-compat.h. Consolidate them
into their own file, feature-fixups.h

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/asm-powerpc/asm-compat.h     |   51 -----------------
 include/asm-powerpc/cputable.h       |   14 +----
 include/asm-powerpc/feature-fixups.h |  102 ++++++++++++++++++++++++++++++++++
 include/asm-powerpc/firmware.h       |   13 +----
 4 files changed, 104 insertions(+), 76 deletions(-)

diff --git a/include/asm-powerpc/asm-compat.h b/include/asm-powerpc/asm-compat.h
index c19e736..8ec2e1d 100644
--- a/include/asm-powerpc/asm-compat.h
+++ b/include/asm-powerpc/asm-compat.h
@@ -15,57 +15,6 @@
 #endif
 
 
-/*
- * Feature section common macros
- *
- * Note that the entries now contain offsets between the table entry
- * and the code rather than absolute code pointers in order to be
- * useable with the vdso shared library. There is also an assumption
- * that values will be negative, that is, the fixup table has to be
- * located after the code it fixes up.
- */
-#ifdef CONFIG_PPC64
-#ifdef __powerpc64__
-/* 64 bits kernel, 64 bits code */
-#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
-99:							\
-	.section sect,"a";				\
-	.align 3;					\
-98:						       	\
-	.llong msk;					\
-	.llong val;					\
-	.llong label##b-98b;				\
-	.llong 99b-98b;		 			\
-	.previous
-#else /* __powerpc64__ */
-/* 64 bits kernel, 32 bits code (ie. vdso32) */
-#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
-99:							\
-	.section sect,"a";				\
-	.align 3;					\
-98:						       	\
-	.llong msk;					\
-	.llong val;					\
-	.long 0xffffffff;      				\
-	.long label##b-98b;				\
-	.long 0xffffffff;	       			\
-	.long 99b-98b;		 			\
-	.previous
-#endif /* !__powerpc64__ */
-#else /* CONFIG_PPC64 */
-/* 32 bits kernel, 32 bits code */
-#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
-99:						       	\
-	.section sect,"a";			       	\
-	.align 2;				       	\
-98:						       	\
-	.long msk;				       	\
-	.long val;				       	\
-	.long label##b-98b;			       	\
-	.long 99b-98b;				       	\
-	.previous
-#endif /* !CONFIG_PPC64 */
-
 #ifdef __powerpc64__
 
 /* operations for longs and pointers */
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 1e79673..388b7de 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -2,6 +2,7 @@
 #define __ASM_POWERPC_CPUTABLE_H
 
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 #define PPC_FEATURE_32			0x80000000
 #define PPC_FEATURE_64			0x40000000
@@ -477,18 +478,5 @@ static inline int cpu_has_feature(unsigned long feature)
 
 #endif /* !__ASSEMBLY__ */
 
-#ifdef __ASSEMBLY__
-
-#define BEGIN_FTR_SECTION_NESTED(label)	label:
-#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(97)
-#define END_FTR_SECTION_NESTED(msk, val, label) \
-	MAKE_FTR_SECTION_ENTRY(msk, val, label, __ftr_fixup)
-#define END_FTR_SECTION(msk, val)		\
-	END_FTR_SECTION_NESTED(msk, val, 97)
-
-#define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
-#define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
-#endif /* __ASSEMBLY__ */
-
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_CPUTABLE_H */
diff --git a/include/asm-powerpc/feature-fixups.h b/include/asm-powerpc/feature-fixups.h
new file mode 100644
index 0000000..8597212
--- /dev/null
+++ b/include/asm-powerpc/feature-fixups.h
@@ -0,0 +1,102 @@
+#ifndef __ASM_POWERPC_FEATURE_FIXUPS_H
+#define __ASM_POWERPC_FEATURE_FIXUPS_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __ASSEMBLY__
+
+/*
+ * Feature section common macros
+ *
+ * Note that the entries now contain offsets between the table entry
+ * and the code rather than absolute code pointers in order to be
+ * useable with the vdso shared library. There is also an assumption
+ * that values will be negative, that is, the fixup table has to be
+ * located after the code it fixes up.
+ */
+#ifdef CONFIG_PPC64
+
+#ifdef __powerpc64__
+
+/* 64 bits kernel, 64 bits code */
+#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
+99:							\
+	.section sect,"a";				\
+	.align 3;					\
+98:						       	\
+	.llong msk;					\
+	.llong val;					\
+	.llong label##b-98b;				\
+	.llong 99b-98b;		 			\
+	.previous
+
+#else /* __powerpc64__ */
+
+/* 64 bits kernel, 32 bits code (ie. vdso32) */
+#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
+99:							\
+	.section sect,"a";				\
+	.align 3;					\
+98:						       	\
+	.llong msk;					\
+	.llong val;					\
+	.long 0xffffffff;      				\
+	.long label##b-98b;				\
+	.long 0xffffffff;	       			\
+	.long 99b-98b;		 			\
+	.previous
+
+#endif /* !__powerpc64__ */
+
+#else /* CONFIG_PPC64 */
+
+/* 32 bits kernel, 32 bits code */
+#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
+99:						       	\
+	.section sect,"a";			       	\
+	.align 2;				       	\
+98:						       	\
+	.long msk;				       	\
+	.long val;				       	\
+	.long label##b-98b;			       	\
+	.long 99b-98b;				       	\
+	.previous
+
+#endif /* !CONFIG_PPC64 */
+
+
+/* CPU feature dependent sections */
+#define BEGIN_FTR_SECTION_NESTED(label)	label:
+#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(97)
+
+#define END_FTR_SECTION_NESTED(msk, val, label) \
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __ftr_fixup)
+
+#define END_FTR_SECTION(msk, val)		\
+	END_FTR_SECTION_NESTED(msk, val, 97)
+
+#define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
+#define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
+
+
+/* Firmware feature dependent sections */
+#define BEGIN_FW_FTR_SECTION_NESTED(label)	label:
+#define BEGIN_FW_FTR_SECTION			BEGIN_FW_FTR_SECTION_NESTED(97)
+
+#define END_FW_FTR_SECTION_NESTED(msk, val, label) \
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __fw_ftr_fixup)
+
+#define END_FW_FTR_SECTION(msk, val)		\
+	END_FW_FTR_SECTION_NESTED(msk, val, 97)
+
+#define END_FW_FTR_SECTION_IFSET(msk)	END_FW_FTR_SECTION((msk), (msk))
+#define END_FW_FTR_SECTION_IFCLR(msk)	END_FW_FTR_SECTION((msk), 0)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_POWERPC_FEATURE_FIXUPS_H */
diff --git a/include/asm-powerpc/firmware.h b/include/asm-powerpc/firmware.h
index 1e41bd1..ef32899 100644
--- a/include/asm-powerpc/firmware.h
+++ b/include/asm-powerpc/firmware.h
@@ -15,6 +15,7 @@
 #ifdef __KERNEL__
 
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 /* firmware feature bitmask values */
 #define FIRMWARE_MAX_FEATURES 63
@@ -125,18 +126,6 @@ extern int fwnmi_active;
 
 extern unsigned int __start___fw_ftr_fixup, __stop___fw_ftr_fixup;
 
-#else /* __ASSEMBLY__ */
-
-#define BEGIN_FW_FTR_SECTION_NESTED(label)	label:
-#define BEGIN_FW_FTR_SECTION			BEGIN_FW_FTR_SECTION_NESTED(97)
-#define END_FW_FTR_SECTION_NESTED(msk, val, label) \
-	MAKE_FTR_SECTION_ENTRY(msk, val, label, __fw_ftr_fixup)
-#define END_FW_FTR_SECTION(msk, val)		\
-	END_FW_FTR_SECTION_NESTED(msk, val, 97)
-
-#define END_FW_FTR_SECTION_IFSET(msk)	END_FW_FTR_SECTION((msk), (msk))
-#define END_FW_FTR_SECTION_IFCLR(msk)	END_FW_FTR_SECTION((msk), 0)
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_FIRMWARE_H */
-- 
1.5.5
